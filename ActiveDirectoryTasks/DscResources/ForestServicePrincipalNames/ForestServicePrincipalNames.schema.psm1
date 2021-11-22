<#
    .DESCRIPTION
        This DSC configuration will manage forest wide settings including Service Principal Name (SPN) suffixes within Active Directory.
    .PARAMETER ForestDN
        Specifies the target Active Directory forest for the change.
    .PARAMETER ServicePrincipalNameSuffix
        Specifies the Service Principal Name (SPN) Suffix(es) to be explicitly defined in the forest and replace existing Service Principal Names.
    .PARAMETER TombStoneLifetime
        Specifies the AD Tombstone lifetime which determines how long deleted items exist in Active Directory before they are purged.
    .PARAMETER Credential
        Specifies the user account credentials to use to perform this task.
#>
#Requires -Module ActiveDirectoryDsc


configuration ForestServicePrincipalNames
{
    param
    (
        [Parameter(Mandatory)]
        [ValidatePattern('^((DC=[^,]+,?)+)$')]
        [System.String]
        $ForestDN,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $ServicePrincipalNameSuffix,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $ServicePrincipalNameSuffixToAdd,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $ServicePrincipalNameSuffixToRemove,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc


    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myForestName = ([RegEx]::Matches($ForestDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'


    <#
        Wait for Active Directory domain controller to become available in the domain
    #>

    <#
        Ensure required Windows Features
    #>
    xWindowsFeature AddAdDomainServices
    {
        Name   = 'AD-Domain-Services'
        Ensure = 'Present'
    }

    xWindowsFeature AddRSATADPowerShell
    {
        Name      = 'RSAT-AD-PowerShell'
        Ensure    = 'Present'
        DependsOn = '[xWindowsFeature]AddAdDomainServices'
    }

    # set execution name for the resource
    $executionName = "$($myForestName -replace '[-().:\s]', '_')"

    WaitForADDomain "$executionName"
    {
        DomainName  = $myForestName
        WaitTimeout = 300
        DependsOn   = '[xWindowsFeature]AddRSATADPowershell'
    }
    # set resource name as dependency
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    <#
        Parameters for DSC resource 'ADForestProperties'
    #>
    $adForestProperties = @(
        'ServicePrincipalNameSuffix',
        'ServicePrincipalNameSuffixToAdd',
        'ServicePrincipalNameSuffixToRemove',
        'Credential'
    )

    <#
        Create DSC resource for 'ADForestProperties'
    #>

    # store matching parameters into hashtable
    $properties = New-Object -TypeName System.Collections.Hashtable

    # enumerate all parameters and match
    foreach ($p in ($PSBoundParameters.GetEnumerator() | Where-Object -Property Key -In $adForestProperties))
    {
        $properties.Add($p.Key, $p.Value)
    }

    # set the forest name
    $properties.ForestName = $myForestName

    # this resource depends on availble domain
    $properties.DependsOn = $dependsOnWaitForADDomain

    # set execution name for the resource
    $executionName = "ServicePrincipalNames_$($properties.ForestName -replace '[-().:\s]', '_')"

    # create DSC resource
    $Splatting = @{
        ResourceName  = 'ADForestProperties'
        ExecutionName = $executionName
        Properties    = $properties
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($properties)
} #end configuration