<#
    .DESCRIPTION
        This DSC configuration creates and manages User objects within Active Directory
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER Users
        Specify a list of Computers within Active Directory.
    .PARAMETER Credential
        Credentials used to enact the change upon.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADUser
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-08-29
#>
#Requires -Module ActiveDirectoryDsc
#Requires -Module xPSDesiredStateConfiguration


configuration ActiveDirectoryUsers
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
        $Users,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    ) #end params

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    <#
        Helper function
    #>
    function ADPrincipalGroupMembership
    {
        <#
            .SYNOPSIS
                Adds an Active Directory Computer as a member to one or many Active Directory Groups.
        #>
        param
        (
            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [System.String]
            $ExecutionType,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [System.String]
            $ExecutionName,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [System.String]
            $Identity,

            [Parameter()]
            [System.String[]]
            $MemberOf,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [System.Management.Automation.PSCredential]
            [System.Management.Automation.Credential()]
            $Credential
        )

        <#
            Create DSC xScript resource
        #>
        xScript "$($ExecutionName)_MemberOf"
        {
            <#
                Test the resource
            #>
            TestScript =
            {
                Write-Verbose -Message "Retrieving current list of group memberships for the principal $Using:Identity..."
                try
                {
                    # retrieve current list of group memberships
                    $uurrentGroups = Get-ADPrincipalGroupMembership -Identity $Using:Identity | `
                        Where-Object -Property $using:MemberOf -Contains -Value $_.SamAccountName | `
                        Select-Object -ExpandProperty SamAccountName
                }
                catch
                {
                    Write-Verbose -Message "Retrieving current list of group memberships for the principal $Using:Identity... FAILED."
                    throw "$($_.Exception.Message)"
                } #end try

                # identify any missing groups
                Write-Verbose -Message "Identifying missing group memberships for the principal $Using:Identity..."
                try
                {
                    $missingGroups = $Using:MemberOf | Where-Object { -not ( $uurrentGroups -contains $_ ) }
                }
                catch
                {
                    Write-Verbose -Message "Identifying missing group memberships for the principal $Using:Identity... FAILED."
                    throw "$($_.Exception.Message)"
                }

                # if no missing groups, return $true
                if ( $missingGroups.Count -eq 0 )
                {
                    Write-Verbose -Message "The principal $Using:Identity is missing $($missingGroups.Count) groups."
                    return $true
                }
                else
                {
                    # otherwise, return $false
                    Write-Verbose -Message "The principal $Using:Identity is missing $($missingGroups.Count) groups."
                    Write-Verbose -Message "The principal $Using:Identity is not a member of the required groups: $($missingGroups -join ', ')"
                    return $false 
                }
            } #end TestScript

            <#
                Set the resource
            #>
            SetScript  = 
            {
                Write-Verbose -Message "Adding the principal $Using:Identity as member of the required groups: $($Using:MemberOf -join ', ')..."
                
                # split parameters
                $Splatting = @{
                    Identity = $Using:Identity
                    MemberOf = $Using:MemberOf
                }

                # if specified, add Credentials to perform the operation
                if ($null -ne $Using:Credential)
                {
                    $Splatting.Credential = $Using:Credential 
                }

                # set the group membership
                try
                {
                    Add-ADPrincipalGroupMembership @Splatting
                }
                catch
                {
                    Write-Verbose -Message "Adding the principal $Using:Identity as member of the required groups: $($Using:MemberOf -join ', ')... FAILED."
                    throw "$($_.Exception.Message)"
                } #end try
            } #end SetScript

            <#
                Get the resource
            #>
            GetScript  = { return 'NA' }
            
            # this resource depends on the created principal
            DependsOn  = "[$ExecutionType]$ExecutionName"
        } #end xScript
    } #end function ADPrincipalGroupMembership


    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'

    <#
        Wait for Active Directory domain controller to become available in the domain
    #>

    # parameters for 'WaitForADDomain'
    $waitForADDomain = @(
        'Credential'
    )

    # store matching parameters into hashtable
    $properties = New-Object -TypeName System.Collections.Hashtable

    # enumerate parameters for matches in WaitForADDomain
    foreach ($p in ($PSBoundParameters.GetEnumerator() | Where-Object -Property Key -In $waitForADDomain))
    {
        $properties.Add($p.Key, $p.Value)
    }

    # set Domain Name
    $properties.DomainName = $myDomainName

    # set wait timeout
    $properties.WaitTimeout = 300

    # if credentials are specifed, set 'WaitForValidCredentials'
    if ($properties.ContainsKey('Credential'))
    {
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
        Create DSC resource for 'ADUser'
    #>

    # Enumerate all Groupes and create DSC resource
    foreach ( $u in $Users )
    {
        # save the memberOf list and remove from main hashtable
        $memberOf = $u.MemberOf
        $u.Remove('MemberOf')

        # remove case sensitivity from orderd Dictionary and Hashtables
        $u = @{ } + $u

        # if not specifed, set 'DomainName'
        if ((-not $u.ContainsKey('DomainName')) -or ([String]::IsNullOrWhiteSpace($u.DomainName)))
        {
            $u.DomainName = $myDomainName
        }

        # if not specified, ensure 'Present'
        if (-not $u.ContainsKey('Ensure'))
        {
            $u.Ensure = 'Present'
        }

        # if not specified, set the 'CommonName' to match the 'UserName'
        if (-not $u.ContainsKey('CommonName'))
        {
            $u.CommonName = $u.UserName
        }

        # if not specified, set 'UserPrincipalName' by appending the Computername with '@' and the domain name
        if (-not $u.ContainsKey('UserPrincipalName'))
        {
            $u.UserPrincipalName = '{0}@{1}' -f $u.UserName, $myDomainName
        }

        # if not specified, set 'DisplayName' to match 'CommonName'
        if (-not $u.ContainsKey('DisplayName'))
        {
            $u.Displayname = $u.UserName
        }
        

        # set the Distinguished Name path of the Computer
        if ($u.Path)
        {
            $u.Path = '{0},{1}' -f $u.Path, $DomainDN
        }
        else
        {
            # otherwise, set the default Computer container
            $u.Path = 'CN=Users,{0}' -f $DomainDN 
        }

        # if note specified, set 'Country' to 'United States'
        if (-not $u.ContainsKey('Country'))
        {
            $u.Country = 'US'
        }
        # if not specified, set the 'Department' to 'IT'
        if (-not $u.ContainsKey('Department'))
        {
            $u.Department = 'IT'
        }

        # if not specified, set the 'Company' to 'MAP Communications'
        if (-not $u.ContainsKey('Company'))
        {
            $u.Company = 'MAP Communications'
        }

        # if not specified, describe 'Notes' to specify DSC management
        if (-not $u.ContainsKey('Notes'))
        {
            $u.Notes = @"
This user account is being managed with Desired State Configuration (DSC).

The DSC project can be found at https://prod1gitlab.mapcom.local/dsc/dsc-deploy.
"@
        }

        # if not specified, set the 'Organization' to 'MAP Communications.'
        if (-not $u.ContainsKey('Organization'))
        {
            $u.Organization = 'MAP Communications'
        }

        # it not specified, set 'Enabled'
        if (-not $u.ContainsKey('Enabled'))
        {
            $u.Enabled = $true 
        }

        # if not specified, set 'CannotChangePassword' to $false
        if (-not $u.ContainsKey('CannotChangePassword'))
        {
            $u.CannotChangePassword = $false
        }

        # if not specified, allow password expiration
        if (-not $u.ContainsKey('PasswordNeverExpires'))
        {
            $u.PasswordNeverExpires = $false
        }

        # set the name of the Node assigned as the Domain Controller for the resource
        if (-not $u.ContainsKey('DomainController'))
        {
            $u.DomainController = $node.Name
        }

        # if specified, add Credentials to perform the operation
        if ($PSBoundParameters.ContainsKey('Credential'))
        {
            $u.Credential = $Credential
        }

        # if not specified, the User account is not trusted for delegation
        if (-not $u.ContainsKey('TrustedForDelegation'))
        {
            $u.TrustedForDelegation = $false
        }
        elseif ($u.TrustedForDelegation -eq $true)
        {
            $u.AccountNotDelegated = $false
        }

        # if not specified, disable restoring from Recycle Bin
        if (-not $u.ContainsKey('RestoreFromRecycleBin'))
        {
            $u.RestoreFromRecycleBin = $false
        }

        # if not specified, set 'AccountNotDelegated' to $false
        if (-not $u.ContainsKey('AccountNotDelegated'))
        {
            $u.AccountNotDelegated = $false
        }

        # if not specified, set 'AllowReversiblePasswordEncryption' to $false
        if (-not $u.ContainsKey('AllowReversiblePasswordEncryption'))
        {
            $u.AllowReversiblePasswordEncryption = $false
        }

        # if not specified, set 'PasswordNotRequired' to $false
        if (-not $u.ContainsKey('PasswordNotRequired'))
        {
            $u.PasswordNotRequired = $false
        }

        # if not specified, set 'SmartcardLogonRequired' to $false
        if (-not $u.ContainsKey('SmartcardLogonRequired'))
        {
            $u.SmartcardLogonRequired = $false
        }

        # this resource depends on response from Active Directory
        $u.DependsOn = $dependsOnWaitForADDomain

        # create execution name for the resource
        $executionName = "$($u.UserName -replace '[-().:\s]', '_')_$($myDomainName -replace '[-().:\s]', '_')"

        # create DSC resource
        try
        {
            $Splatting = @{
                ResourceName  = 'ADUser'
                ExecutionName = $executionName
                Properties    = $u
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($u)
        }
        catch
        {
            Write-Verbose -Message 'ERROR: Failed to create resource for Active Directory User.'
            throw "$($_.Exception.Message)"
        } #end try

        # if 'MemberOf' was specified, create the cusotm resource
        if ($null -ne $memberOf -and $memberOf.Count -gt 0)
        {
            # splat parameters
            $Splatting = @{
                ExecutionType = 'ADUser'
                ExecutionName = $executionName
                Identity      = $u.UserName
                MemberOf      = $memberOf
            }

            # if specified, add Credentials to perform the operation
            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $Splatting.Credential = $Credential
            }

            # call the custom function
            try
            {
                ADPrincipalGroupMembership @Splatting
            }
            catch
            {
                Write-Verbose -Message 'ERROR: Failed to add group memberships.'
                throw "$($_.Exception.Message)"
            } #end try
        } #end if
    } #end foreach
} #end configuration