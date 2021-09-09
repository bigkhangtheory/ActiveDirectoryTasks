<#
    .DESCRIPTION
        This DSC configuration will manage registered Service Principal Names (SPN).
        
        A service principal name (SPN) is a unique identifier of a service instance.

        SPNs are used by Kerberos authentication to associate a service instance with a service logon account.

        This allows a client application to request that the service authenticate an account even if the client does not have the account name.
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER SPNs
        Specify a list of Service Principal Names to register.
#>
#Requires -Module ActiveDirectoryDsc
#Requires -Module xPSDesiredStateConfiguration


configuration ServicePrincipalNames
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
        $SPNs
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
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'


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
    $executionName = "$($myDomainName -replace '[-().:\s]', '_')"

    WaitForADDomain "$executionName"
    {
        DomainName  = $myDomainName
        WaitTimeout = 300
        DependsOn   = '[xWindowsFeature]AddRSATADPowershell'
    }
    # set resource name as dependency
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    <#
        Create DSC resource for ADServicePrincipalName
    #>
    foreach ($s in $SPNs)
    {
        # remove case sensitivity for ordered Dictionary or Hashtables
        $s = @{ } + $s

        # if not specified, ensure 'Present'
        if (-not $s.ContainsKey('Ensure'))
        {
            $s.Ensure = 'Present'
        }

        # this resource depends on Domain availibility
        $s.DependsOn = $dependsOnWaitForADDomain

        # create execution name for the resource
        $executionName = "$($s.ServicePrincipalName -replace '[-().:\s/]', '_')_$($s.Account -replace '[-().:\s]', '_')"

        # create DSC resource
        $Splatting = @{
            ResourceName  = 'ADServicePrincipalName'
            ExecutionName = $executionName
            Properties    = $s
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($s)
    } #end foreach
} #end configuration