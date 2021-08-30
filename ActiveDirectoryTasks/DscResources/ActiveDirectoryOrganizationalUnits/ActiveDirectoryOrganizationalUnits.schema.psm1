<#
    .DESCRIPTION
        This DSC configuration manages Organizational Units (OUs) within Active Directory.
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER OUs
        List of Organizational Units (OUs) within Active Directory.
    .PARAMETER Credential
        Credentials used to enact the change upon.
#>
#Requires -Module ActiveDirectoryDsc


configuration ActiveDirectoryOrganizationalUnits
{
    param
    (
        [Parameter(Mandatory)]
        [ValidatePattern('^((DC=[^,]+,?)+)$')]
        [System.String]
        $DomainDN,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $OUs,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'

    <#
        Wait for Active Directory domain controller to become available in the domain
    #>

    # parameters for 'WaitForADDomain'
    $waitForADDomain = @(
        'Credential'
    )

    # store matching parameters into hashtable
    $properties = New-Object -TypeName System.Collections.Hashtable

    # enumerate parameters for matches in WaitForADDomain
    foreach ($p in ($PSBoundParameters.GetEnumerator() | Where-Object -Property Key -In $waitForADDomain))
    {
        $properties.Add($p.Key, $p.Value)
    }

    # set Domain Name
    $properties.DomainName = $myDomainName

    # set wait timeout
    $properties.WaitTimeout = 300

    # if credentials are specifed, set 'WaitForValidCredentials'
    if ($properties.ContainsKey('Credential'))
    {
        $properties.WaitForValidCredentials = $true
    }

    # set execution name for the resource
    $executionName = "$($properties.DomainName -replace '[-().:\s]', '_')"

    # create DSC resource
    $Splatting = @{
        ResourceName  = 'WaitForADDomain'
        ExecutionName = $executionName
        Properties    = $properties
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($properties)

    # set resource name as dependency
    $script:dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    # used to aggregate OU resources as recursive dependencies
    $script:ouDependencies = @()
    <#
        This function is used as a recursive call to create Organizational Units.
    #>    
    function Get-OrgUnitSplat
    {
        param
        (
            [Parameter(Mandatory)]
            [System.Object]
            $Object,

            [Parameter(Mandatory)]
            [System.String]
            $ParentPath,

            [Parameter()]
            [System.Management.Automation.PSCredential]
            $Credential,

            [Parameter()]
            [Switch]
            $SkipDepend
        )

        # set OU path as DN
        $ouPath = 'OU={0},{1}' -f $Object.Name, $ParentPath

        <#
            Recursive condition
        #>
        if ($Object.ChildOu.Count -gt 0)
        {
            foreach ($ou in $Object.ChildOu)
            {
                # splat parameters
                $Splatting = @{
                    Object     = $ou
                    ParentPath = $ouPath
                }
                
                # if specified, call passing Credentials
                if ($Credential)
                {
                    $Splatting.Credential = $Credential
                }

                Get-OrgUnitSplat @Splatting
            }
        } #end recursive condition


        $Object.Path = $ParentPath
        $script:ouDependencies += "[ADOrganizationalUnit]$($ouPath -Replace ',|=')"

        # if not specified, ensure 'Present'
        if ($null -eq $Object.Ensure)
        {
            $Object.Ensure = 'Present'
        }

        # if not specified, set ProtectFromAccidentalDeletion to $true
        if ($null -eq $Object.ProtectedFromAccidentalDeletion)
        {
            $Object.ProtectedFromAccidentalDeletion = $true
        }

        # if not specified, set RestoreFromRecycleBin to $true
        if ($null -eq $Object.RestoreFromRecycleBin)
        {
            $Object.RestoreFromRecycleBin = $false 
        }

        # set recursive resource dependencies      
        if ($SkipDepend)
        {
            $Object.DependsOn = $script:dependsOnWaitForADDomain
        }
        else
        {
            $Object.DependsOn = "[ADOrganizationalUnit]$($ParentPath -Replace ',|=')"
        } #end if

        # if specified, create resource with Credential
        if ($Credential)
        {
            <#
                Create resource using Credentials
            #>
            ADOrganizationalUnit ($ouPath -Replace ',|=')
            {
                Name                            = $Object.Name
                Path                            = $Object.Path
                Description                     = $Object.Description
                Ensure                          = $Object.Ensure
                ProtectedFromAccidentalDeletion = $Object.ProtectedFromAccidentalDeletion
                RestoreFromRecycleBin           = $Object.RestoreFromRecycleBin
                Credential                      = $Credential
                DependsOn                       = $Object.DependsOn
            }
        }
        else
        {
            <#
                Create resource with no Credentials
            #>
            ADOrganizationalUnit ($ouPath -Replace ',|=')
            {
                Name                            = $Object.Name
                Path                            = $Object.Path
                Description                     = $Object.Description
                Ensure                          = $Object.Ensure
                ProtectedFromAccidentalDeletion = $Object.ProtectedFromAccidentalDeletion
                RestoreFromRecycleBin           = $Object.RestoreFromRecycleBin
                DependsOn                       = $Object.DependsOn
            }
        } #end if 
    } #end function
    


    <#
        Enumerate all OUs and recursively create resource
    #>



    foreach ($ou in $OUs)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $ou = @{ } + $ou
        
        # if not specifed, set OU path at root of domain
        if ( [string]::IsNullOrWhitespace($ou.Path) )
        {
            $ou.Path = $DomainDN
        }

        if ($ou.Path -notmatch '(?<DomainPart>dc=\w+,dc=\w+)')
        {
            $ou.Path = "$($ou.Path),$DomainDN"
        }

        # splat parameters
        $Splatting = @{
            Object     = $ou
            ParentPath = $ou.Path
            SkipDepend = $true
        }

        if ($Credential)
        {
            $Splatting.Credential = $Credential
        }

        Get-OrgUnitSplat @Splatting 
    } #end foreach
} #end configuration