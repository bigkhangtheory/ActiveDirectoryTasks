<#
    .DESCRIPTION
        This DSC configuration manages Users, Computers, and  Managed Service Accounts within Active Directory.
    .PARAMETER DomainDN
        Specify the Distinguished Name (DN) of the domain.
    .PARAMETER KDSKey
        Management of KDS Root Keys within Active Directory.
    .PARAMETER ManagedServiceAccounts
        Specify a list of managed service accounts to create within Active Directory.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADKDSKey
        https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADManagedServiceAccount
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-08-29
#>
#Requires -Module ActiveDirectoryDsc
#Requires -Module xPSDesiredStateConfiguration


configuration ActiveDirectoryDomainPrincipals
{
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DomainDN,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $KDSKey,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $ManagedServiceAccounts
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc


    <#
        Help function to manage ADPrincipalGroupMembership
    #>
    function Add-MemberOfAttribute
    {
        param
        (
            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [System.String]
            $ExecutionName,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [System.String]
            $ExecutionType,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [System.String]
            $AccountName,

            [Parameter()]
            [System.String[]]
            $MemberOf
        )

        if ( $null -ne $MemberOf -and $MemberOf.Count -gt 0 )
        {
            xScript "$($ExecutionName)_MemberOf"
            {
                TestScript =
                {
                    # get current member groups in MemberOf
                    $currentGroups = Get-ADPrincipalGroupMembership -Identity $using:AccountName | `
                        Where-Object { $using:MemberOf -contains $_.SamAccountName } | `
                        Select-Object -ExpandProperty SamAccountName

                    Write-Verbose "ADPrincipal '$using:AccountName' is member of required groups: $($currentGroups -join ', ')"

                    $missingGroups = $using:MemberOf | Where-Object { -not ($currentGroups -contains $_) }

                    if ( $missingGroups.Count -eq 0 )
                    {
                        return $true
                    }

                    Write-Verbose "ADPrincipal '$using:AccountName' is not member of required groups: $($missingGroups -join ', ')"
                    return $false
                }
                SetScript  =
                {
                    Add-ADPrincipalGroupMembership -Identity $using:AccountName -MemberOf $using:MemberOf
                }
                GetScript  = { return 'NA' }
                DependsOn  = "[$ExecutionType]$ExecutionName"
            }
        }
    } #end function Add-MemberOfAttribute



    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $domainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'


    $dependsOnKdsKey = $null

    if ( $null -ne $KDSKey )
    {
        (Get-DscSplattedResource -ResourceName ADKDSKey -ExecutionName 'adKDSKey' -Properties $KDSKey -NoInvoke).Invoke($KDSKey)

        $dependsOnKdsKey = '[ADKDSKey]adKDSKey'
    }

    if ( $null -ne $ManagedServiceAccounts )
    {
        foreach ($svcAccount in $ManagedServiceAccounts)
        {
            # Remove Case Sensitivity of ordered Dictionary or Hashtables
            $svcAccount = @{} + $svcAccount

            # save group list
            $memberOf = $svcAccount.MemberOf
            $svcAccount.Remove( 'MemberOf' )

            if ( $null -ne $dependsOnKdsKey )
            {
                $svcAccount.DependsOn = $dependsOnKdsKey
            }

            $executionName = "adMSA_$($svcAccount.ServiceAccountName)"

            (Get-DscSplattedResource -ResourceName ADManagedServiceAccount -ExecutionName $executionName -Properties $svcAccount -NoInvoke).Invoke($svcAccount)

            # append $ to acoountname to identify it as MSA
            Add-MemberOfAttribute -ExecutionName $executionName -ExecutionType ADManagedServiceAccount -AccountName "$($svcAccount.ServiceAccountName)$" -MemberOf $memberOf
        }
    }
}
