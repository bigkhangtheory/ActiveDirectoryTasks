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
#Requires -Module xPSDesiredStateConfiguration


configuration ActiveDirectorySites
{
    param 
    (
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
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc


    <#
        Ensure required Windows Features
    #>
    xWindowsFeature AddAdDomainServices
    {
        Name   = 'AD-Domain-Services'
        Ensure = 'Present'
    }
    xWindowsFeature AddRsatAdPowerShell
    {
        Name   = 'RSAT-AD-PowerShell'
        Ensure = 'Present'
    }


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
        $s.DependsOn = '[xWindowsFeature]AddAdDomainServices'

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