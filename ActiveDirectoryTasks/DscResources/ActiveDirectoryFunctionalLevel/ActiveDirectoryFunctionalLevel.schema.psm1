<#
    .DESCRIPTION
        This DSC configuration manages Domand and Forest Functional Levels.
    .PARAMETER ForestDN
        Specifies the distinguished name for an Active Directory forest to modify.
    .PARAMETER ForestMode
        Specifies the the functional level for the Active Directory forest.
    .PARAMETER DomainDN
        Specifies the distinguished name for an Active Directory domain to modify.
    .PARAMETER DomainMode
        Specifies the functional level for the Active Directory domain.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADForestFunctionalLevel
        https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainFunctionalLevel
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-08-30
#>
#Requires -Module ActiveDirectoryDsc


configuration ActiveDirectoryFunctionalLevel
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $ForestDN,

        [Parameter()]
        [ValidateSet('Windows2008R2Forest', 'Windows2012Forest', 'Windows2012R2Forest', 'Windows2016Forest')]
        [System.String]
        $ForestMode,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DomainDn,

        [Parameter(Mandatory)]
        [ValidateSet('Windows2008R2Domain', 'Windows2012Domain', 'Windows2012R2Domain', 'Windows2016Domain')]
        [System.String]
        $DomainMode
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    <#
        Create DSC resource for managing Domain Functional Level
    #>

    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'

    <#
        Wait for Active Directory domain controller to become available in the domain
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
    $executionName = "Domain_$($myDomainName -replace '[-().:\s]', '_')"

    WaitForADDomain "$executionName"
    {
        DomainName  = $myDomainName
        WaitTimeout = 300
        DependsOn   = '[WindowsFeature]AddRSATADPowershell'
    }
    # set resource name as dependency
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    # create DSC resource
    ADDomainFunctionalLevel "$executionName"
    {
        DomainIdentity = $DomainDN
        DomainMode     = $DomainMode
        DependsOn      = $dependsOnWaitForADDomain
    } #nd ADDomainFunctionalLevel


    <#
        If specified, create DSC resource for managing Forest Functional Level.
    #>
    if ($ForestDN -and $ForestMode)
    {
        <#
            Convert DN to Fqdn
        #>
        $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
        $myForestName = ([RegEx]::Matches($ForestDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'

        <#
            Wait for Active Directory domain controller to become available in the domain
        #>

        # set execution name for the resource
        $executionName = "Forest_$($myForestName -replace '[-().:\s]', '_')"

        WaitForADDomain "$executionName"
        {
            DomainName  = $myForestName
            WaitTimeout = 300
            DependsOn   = '[WindowsFeature]AddRSATADPowershell'
        }

        # set resource name as dependency
        $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"

        # create DSC resource
        ADForestFunctionalLevel "$executionName"
        {
            ForestIdentity = $ForestDN
            ForestMode     = $ForestMode
            DependsOn      = $dependsOnWaitForADDomain
        } #end ADForestFunctionalLevel
    } #end if
} #end configuration