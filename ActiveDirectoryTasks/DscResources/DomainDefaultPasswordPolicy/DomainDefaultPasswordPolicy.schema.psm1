<#
    .DESCRIPTION
        This DSC configuration manages an Active Directory domain's default password policy.
    .PARAMETER DomainDN
        Specify the name of the domain to which the password policy will be applied.
    .PARAMETER ComplexityEnabled
        Specify whether password complexity is enabled for the default password policy.
    .PARAMETER LockoutDuration
        Specify the length of time that an account is locked after the number of failed login attempts (minutes).
        The available range is from 0 to 99,999 minutes.
    .PARAMETER LockoutObservationWindow
        Specify the maximum time between two unsuccessful login attempts before the counter is reset to 0 (minutes).
        The available range is from 0 to 99,999 minutes.
    .PARAMETER LockoutThreshold
        Specify the number of unsuccessful login attempts that are permitted before an account is locked out.
        The availible range is 0 to 999.
    .PARAMETER MinPasswordAge
        Specify the minimum length of time that you can have the same password (minutes).
        The availible range is 0 to 1437120 (998 days).
    .PARAMETER MaxPasswordAge
        Specify the maximum length of time that you can have the same password (minutes).
        The availible range is 0 to 1438560 (999 days).
    .PARAMETER MinPasswordLength
        Specify the minimum number of characters that a password must contain.
        The available range is 0 to 14.
    .PARAMETER PasswordHistoryCount
        Specify the number of previous passwords to remember.
        The available range is 0 to 24.
    .PARAMETER ReversibleEncryptionEnabled
        Specify whether the directory must store passwords using reversible encryption.
    .PARAMETER DomainController
        Specify the Active Directory domain controller to enact the change upon.
    .PARAMETER Credential
        Specify the credentials used to access the domain.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainDefaultPasswordPolicy
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-08-29
#>
#Requires -Module ActiveDirectoryDsc


configuration DomainDefaultPasswordPolicy
{
    param
    (
        [Parameter(Mandatory)]
        [ValidatePattern('^((DC=[^,]+,?)+)$')]
        [System.String]
        $DomainDN,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Boolean]
        $ComplexityEnabled,

        [Parameter()]
        [ValidateRange(0, 99999)]
        [System.UInt32]
        $LockoutDuration,

        [Parameter()]
        [ValidateRange(1, 99999)]
        [System.UInt32]
        $LockoutObservationWindow,

        [Parameter()]
        [ValidateRange(0, 999)]
        [System.UInt32]
        $LockoutThreshold,

        [Parameter()]
        [ValidateRange(0, 1437120)]
        [System.UInt32]
        $MinPasswordAge,

        [Parameter()]
        [ValidateRange(0, 1438560)]
        [System.UInt32]
        $MaxPasswordAge,
        
        [Parameter()]
        [ValidateRange(0, 14)]
        [System.UInt32]
        $MinPasswordLength,

        [Parameter()]
        [ValidateRange(0, 24)]
        [System.UInt32]
        $PasswordHistoryCount,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Boolean]
        $ReversibleEncryptionEnabled = $false,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DomainController,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName ActiveDirectoryDsc

    <#
        Parameters for DSC resource 'ADDomainDefaultPasswordPolicy'
    #>
    $adDomainDefaultPasswordPolicy = @(
        'ComplexityEnabled',
        'LockoutDuration',
        'LockoutObservationWindow',
        'LockoutThreshold',
        'MinPasswordAge',
        'MaxPasswordAge',
        'MinPasswordLength',
        'PasswordHistoryCount',
        'ReversibleEncryptionEnabled',
        'DomainController',
        'Credential'
    )

    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'


    <#
        Wait for Active Directory domain controller to become available in the domain
    #>

    # store matching parameters into hashtable
    $properties = New-Object -TypeName System.Collections.Hashtable

    # set Domain name
    $properties.DomainName = $myDomainName

    # set wait timeout
    $properties.WaitTimeout = 300

    # if credentials are specified, set and wait for valid credentials
    if ($null -ne $Credential)
    {
        $properties.Credential = $Credential
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
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    <#
        Create DSC resource for 'ADDomainDefaultPasswordPolicy'
    #>

    # store matching parameters into hashtable
    $properties = New-Object -TypeName System.Collections.Hashtable

    # enumerate all parameters and match
    foreach ($p in ($PSBoundParameters.GetEnumerator() | Where-Object -Property Key -In $adDomainDefaultPasswordPolicy))
    {
        $properties.Add($p.Key, $p.Value)
    }

    # if not specified, set 'DomainController' to current Node
    if (-not $properties.ContainsKey('DomainController'))
    {
        $properties.DomainController = $node.Name
    }

    # set the Domain Name for the resource
    $properties.DomainName = $myDomainName

    # this resource depends on availability of the Domain
    $properties.DependsOn = $dependsOnWaitForADDomain

    # create execution name for the resource
    $executionName = "$($properties.DomainName -replace '[-().:\s]', '_')"

    # create DSC resource
    $Splatting = @{
        ResourceName  = 'ADDomainDefaultPasswordPolicy'
        ExecutionName = $executionName
        Properties    = $properties
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($properties)
} #end configuration
