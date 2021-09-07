<#
    .DESCRIPTION
        This DSC configuration creates and manages Computer objects within Active Directory
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER Computers
        Specify a list of Computers within Active Directory.
    .PARAMETER Credential
        Credentials used to enact the change upon.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADComputer
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-08-29
#>
#Requires -Module ActiveDirectoryDsc
#Requires -Module xPSDesiredStateConfiguration


configuration ActiveDirectoryComputers
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
        $Computers,

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
                    $currentGroups = Get-ADPrincipalGroupMembership -Identity $Using:Identity | `
                        Where-Object { $using:MemberOf -Contains $_.SamAccountName } | `
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
                    $missingGroups = $Using:MemberOf | Where-Object { -not ( $currentGroups -contains $_ ) }
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
        Create DSC resource for 'ADComputer'
    #>


    # Enumerate all Groupes and create DSC resource
    foreach ( $c in $Computers )
    {
        # save the memberOf list and remove from main hashtable
        $memberOf = $c.MemberOf
        $c.Remove('MemberOf')

        # remove case sensitivity from orderd Dictionary and Hashtables
        $c = @{ } + $c

        # if not specified, set 'DnsHostName' by appending the ComputerName with the domain name
        if (-not $c.ContainsKey('DnsHostName'))
        {
            $c.DnsHostName = '{0}.{1}' -f $c.ComputerName, $myDomainName
        }

        # if not specified, set 'UserPrincipalName' by appending the Computername with '@' and the domain name
        if (-not $c.ContainsKey('UserPrincipalName'))
        {
            $c.UserPrincipalName = '{0}@{1}' -f $c.ComputerName, $myDomainName
        }

        # if not specified, set 'DisplayName' with the 'ComputerName'
        if (-not $c.ContainsKey('DisplayName'))
        {
            $c.Displayname = $c.ComputerName
        }

        # set the Distinguished Name path of the Computer
        if ($c.Path)
        {
            $c.Path = '{0},{1}' -f $c.Path, $DomainDN
        }
        else
        {
            # otherwise, set the default Computer container
            $c.Path = 'CN=Computers,{0}' -f $DomainDN 
        }

        # set the name of the Node assigned as the Domain Controller for the resource
        if (-not $c.ContainsKey('DomainController'))
        {
            $c.DomainController = $node.Name
        }

        # if specified, add Credentials to perform the operation
        if ($PSBoundParameters.ContainsKey('Credential'))
        {
            $c.Credential = $Credential
        }

        # if not specified, ensure 'Present'
        if (-not $c.ContainsKey('Ensure'))
        {
            $c.Ensure = 'Present'
        }

        # if not specified, set 'RestoreFromRecycleBin' to $false
        if (-not $c.ContainsKey('RestoreFromRecycleBin'))
        {
            $c.RestoreFromRecycleBin = $false
        }

        # it not specified, set 'EnabledOnCreation'
        if (-not $c.ContainsKey('EnabledOnCreation'))
        {
            $c.EnabledOnCreation = $true 
        }



        # this resource depends on response from Active Directory
        $c.DependsOn = $dependsOnWaitForADDomain

        # create execution name for the resource
        $executionName = "$($c.ComputerName -replace '[-().:\s]', '_')_$($myDomainName -replace '[-().:\s]', '_')"

        # create DSC resource
        try
        {
            $Splatting = @{
                ResourceName  = 'ADComputer'
                ExecutionName = $executionName
                Properties    = $c
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($c)
        }
        catch
        {
            Write-Verbose -Message 'ERROR: Failed to compile MOF file.'
            throw "$($_.Exception.Message)"
        } #end try

        # if 'MemberOf' was specified, create the cusotm resource
        if ($null -ne $memberOf -and $memberOf.Count -gt 0)
        {
            # splat parameters
            $Splatting = @{
                ExecutionType = 'ADComputer'
                ExecutionName = $executionName
                Identity      = $c.ComputerName
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