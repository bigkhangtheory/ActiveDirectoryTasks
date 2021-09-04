<#
    .DESCRIPTION
        This DSC configuration will manage forest wide settings including User Principal Name (UPN) suffixes, Service Principal Name (SPN) suffixes and tombstone lifetime.
    .PARAMETER ForestDN
        Specifies the target Active Directory forest for the change.
    .PARAMETER ServicePrincipalNameSuffix
        Specifies the Service Principal Name (SPN) Suffix(es) to be explicitly defined in the forest and replace existing Service Principal Names.
    .PARAMETER UserPrincipalNameSuffix
        Specifies the User Principal Name (UPN) Suffix(es) to be explicitly defined in the forest and replace existing User Principal Names.
    .PARAMETER TombStoneLifetime
        Specifies the AD Tombstone lifetime which determines how long deleted items exist in Active Directory before they are purged.
    .PARAMETER Credential
        Specifies the user account credentials to use to perform this task.
#>
#Requires -Module ActiveDirectoryDsc


configuration ForestProperties
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
        $UserPrincipalNameSuffix,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Int32]
        $TombstoneLifetime,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName ActiveDirectoryDsc

    
    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myForestName = ([RegEx]::Matches($ForestDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'


    <#
        Wait for Active Directory domain controller to become available in the domain
    #>

    # store matching parameters into hashtable
    $properties = New-Object -TypeName System.Collections.Hashtable

    # set Domain name
    $properties.DomainName = $myForestName

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
        Parameters for DSC resource 'ADForestProperties'
    #>
    $adForestProperties = @(
        'ServicePrincipalNameSuffix',
        'UserPrincipalNameSuffix',
        'TombStoneLifetime',
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
    $executionName = "$($properties.ForestName -replace '[-().:\s]', '_')"

    # create DSC resource
    $Splatting = @{
        ResourceName  = 'ADForestProperties'
        ExecutionName = $executionName
        Properties    = $properties
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($properties)
} #end configuration