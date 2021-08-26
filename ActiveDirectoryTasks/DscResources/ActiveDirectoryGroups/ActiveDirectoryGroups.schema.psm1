<#
    .DESCRIPTION
        This DSC configuration manages groups and group memberships within Active Directory
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER Groups
        List of Organizational Units (OUs) within Active Directory.
    .PARAMETER Credential
        Credentials used to enact the change upon.
#>
#Requires -Module ActiveDirectoryDsc


configuration ActiveDirectoryGroups
{
    param
    (
        [Parameter(Mandatory)]
        [System.String]
        $DomainDN,

        [Parameter()]
        [System.Collections.Hashtable[]]
        $Groups,

        [Parameter()]
        [System.Management.Automation.PSCredential]
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
    $domainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'

    <#
        Wait for Active Directory domain controller to become available in the domain
    #>
    WaitForADDomain Domain
    {
        DomainName = $domainName
    }


    # aggregate dependencies
    $dependencies = @()

    <#
        Enumerate all Groupes and create DSC resource
    #>
    foreach ( $g in $Groups )
    {
        # remove case sensitivity from hashtables
        $g = @{} + $g

        # if not specified, ensure 'Present'
        if (-not $g.ContainsKey('Ensure'))
        {
            $g.Ensure = 'Present'
        }


        # if specified, add Credentials to perform the operation
        if ($PSBoundParameters.ContainsKey('Credential'))
        {
            $g.Credential = $Credential
        }

        # this resource depends on response from Active Directory
        $g.DependsOn = '[WaitForADDomain]Domain'

        # append the Domain DN to the group path
        if ( $g.GroupScope -eq 'DomainLocal' )
        {
            $dependencies += "[ADGroup]$executionName"
            $g.Path = '{0},{1}' -f $g.Path, $DomainDn
        }
        elseif ( ($g.GroupScope -eq 'Global') -or (-not [string]::IsNullOrWhiteSpace($g.Path)) )
        {
            $g.Path = '{0},{1}' -f $g.Path, $DomainDn
        }

        # create execution name for the resource
        $executionName = "$($g.GroupName -replace '[-().:\s]', '_')"

        <#
            Create DSC resource for Active Directory Groups
        #>
        $Splatting = @{
            ResourceName  = 'ADGroup'
            ExecutionName = $executionName
            Properties    = $g
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($g)
    } #end foreach
} #end configuration