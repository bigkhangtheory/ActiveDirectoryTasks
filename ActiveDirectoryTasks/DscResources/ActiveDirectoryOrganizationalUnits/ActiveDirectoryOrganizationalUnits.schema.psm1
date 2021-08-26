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
        [System.String]
        $DomainDN,

        [Parameter()]
        [System.Collections.Hashtable[]]
        $OUs,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.Collections.Hashtable[]]
        $Groups
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
    $domainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'

    <#
        Wait for Active Directory domain controller to become available in the domain
    #>
    WaitForADDomain Domain
    {
        DomainName = $domainName
    }

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
            $Object.RestoreFromRecycleBin = $true 
        }

        # set recursive resource dependencies      
        if ($SkipDepend)
        {
            $Object.DependsOn = '[WaitForADDomain]Domain'
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