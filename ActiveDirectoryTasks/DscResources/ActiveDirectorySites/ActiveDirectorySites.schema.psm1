<#
    .DESCRIPTION
        This DSC configuration manages and configures Active Directory Replication Sites, Sitelinks, and Subnets.
    .PARAMETER Sites
        Specifies a list of named Replication Sites to create within Active Directory.
    .PARAMETER Sitelinks
        Specifies a list of named Replication Site Links to create within Active Directory.
    .PARAMETER Subnets
        Specifies a list of named Site Subnets to create within Active Directory.
#>
#Requires -Module ActiveDirectoryDsc


configuration ActiveDirectorySites
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
        $Sites,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $SiteLinks,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Subnets
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
        Ensure required Windows Features
    #>
    WindowsFeature AddAdDomainServices
    {
        Name   = 'AD-Domain-Services'
        Ensure = 'Present'
    }

    WindowsFeature AddRSATADPowerShell
    {
        Name      = 'RSAT-AD-PowerShell'
        Ensure    = 'Present'
        DependsOn = '[WindowsFeature]AddAdDomainServices'
    }

    # set execution name for the resource
    $executionName = "$($myDomainName -replace '[-().:\s]', '_')"

    WaitForADDomain "$executionName"
    {
        DomainName  = $myDomainName
        WaitTimeout = 300
        DependsOn   = '[WindowsFeature]AddRSATADPowershell'
    }
    # set resource name as dependency
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    # create array to folder site resources as dependencies
    $dependsOnAdReplicationSites = New-Object -TypeName System.Collections.ArrayList

    <#
        Enumerate Active Directory Sites
    #>
    foreach ($s in $Sites)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $s = @{ } + $s

        # if not specified, ensure 'Present'
        if (-not $s.ContainsKey('Ensure'))
        {
            $s.Ensure = 'Present'
        }

        # this resource depends on Active Directory
        $s.DependsOn = '[WindowsFeature]AddAdDomainServices'

        # create execution name for the resource
        $executionName = "$($s.Name -replace '[-().:\s]', '_')"

        # create DSC resource
        $Splatting = @{
            ResourceName  = 'ADReplicationSite'
            ExecutionName = $executionName
            Properties    = $s
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($s)

        # add resource dependency for Sites
        $dependsOnAdReplicationSites.Add("[ADReplicationSite]$executionName")
    } #end foreach


    <#
        Enumerate Active Directory Site Links
    #>
    foreach ($l in $SiteLinks)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $l = @{ } + $l

        # if not specified, ensure 'Present'
        if (-not $l.ContainsKey('Ensure'))
        {
            $l.Ensure = 'Present'
        }

        # this resource depends on Active Directory Sites
        $l.DependsOn = $dependsOnAdReplicationSites

        # create execution name for the resource
        $executionName = "$($l.Name -replace '[-().:\s]', '_')"

        # create DSC resource
        $Splatting = @{
            ResourceName  = 'ADReplicationSiteLink'
            ExecutionName = $executionName
            Properties    = $l
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($l)
    } #end foreach


    <#
        Enumerate Active Directory Site Subnets
    #>
    foreach ($n in $Subnets)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $n = @{ } + $n

        # if not specified, ensure 'Present'
        if (-not $n.ContainsKey('Ensure'))
        {
            $n.Ensure = 'Present'
        }

        # this resource depends on Active Directory Sites
        $n.DependsOn = $dependsOnAdReplicationSites

        # create execution name for the resource
        $executionName = "$($n.Name -replace '[-().:/\s]', '_')"

        # create DSC resource
        $Splatting = @{
            ResourceName  = 'ADReplicationSubnet'
            ExecutionName = $executionName
            Properties    = $n
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($n)
    } #end foreach
} #end configuration