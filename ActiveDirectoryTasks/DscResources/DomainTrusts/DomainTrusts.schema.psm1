<#
    .DESCRIPTION
        This DSC configuration manages Organizational Units (OUs) within Active Directory.
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER Trust
        Specify a list of Active Directory Trusts to create with the Domain.
#>
#Requires -Module ActiveDirectoryDsc


configuration DomainTrusts
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
        $Trusts
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


    <#
        Create DSC resource for Active Directory trusts
    #>
    foreach ($t in $Trusts)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $t = @{ } + $t

        # set the source domain name requesting trust
        $t.SourceDomainName = $myDomainName

        # if not specified, ensure 'Present'
        if (-not $t.ContainsKey('Ensure'))
        {
            $t.Ensure = 'Present'
        }

        # if not specified, disable allowing Trust recreation
        if (-not $t.ContainsKey('AllowTrustRecreation'))
        {
            $t.AllowTrustRecreation = $false
        }

        # create execution name for the resource
        $executionName = "$($t.TrustDirection)_$($t.TargetDomainName -replace '[-().:\s]', '_')"

        # create DSC resource
        $Splatting = @{
            ResourceName = 'ADDomainTrust'
            ExecutionName = $executionName
            Properties = $t
            NoInvoke = $true
        }
        try
        {
            (Get-DscSplattedResource @Splatting).Invoke($t)
        }
        catch
        {
            Write-Verbose -Message "ERROR: Failed to create Domain Trust."
            throw "$($_.Exception.Message)"
        } #end try
    } #end foreach
} #end configuration