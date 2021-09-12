<#
    .DESCRIPTION
        This DSC configuration manages groups and group memberships within Active Directory
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER Groups
        List of Organizational Units (OUs) within Active Directory.
    .PARAMETER Credential
        Credentials used to enact the change upon.
#>
#Requires -Module ActiveDirectoryDsc
#Requires -Module xPSDesiredStateConfiguration


configuration ActiveDirectoryGroups
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
        $Groups,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    )

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

                Write-Verbose -Message "ADPrincipal '$using:Identity' is member of required groups: $($currentGroups -join ', ')"
                
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
                if ( $null -eq $missingGroups )
                {
                    return $true
                }
                
                # otherwise, return $false
                Write-Verbose -Message "The principal $Using:Identity is not a member of the required groups: $($missingGroups -join ', ')"
                return $false 
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
            GetScript  =
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


                return @{
                    Result = "$($currentGroups -join ', ')"
                }
            
            }
            
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
        Create DSC resource for 'ADGroup'
    #>

    # aggregate dependencies
    #$dependencies = @()

    <#
        Enumerate all Groupes and create DSC resource
    #>
    foreach ( $g in $Groups )
    {
        # save the MemberOf list and remove from primary hashtable
        $memberOf = $g.MemberOf
        $g.Remove('MemberOf')

        # remove case sensitivity from hashtables
        $g = @{} + $g

        # if not specified, set 'GroupScope' to 'Global'
        if (-not $g.ContainsKey('GroupScope'))
        {
            $g.GroupScope = 'Global'
        }

        # if not specified, set the group Category to 'Security'
        if (-not $g.ContainsKey('Category'))
        {
            $g.Category = 'Security'
        }

        # append the Domain DN to the group path
        if ( $g.GroupScope -eq 'DomainLocal' )
        {
            #$dependencies += "[ADGroup]$executionName"
            $g.Path = '{0},{1}' -f $g.Path, $DomainDn
        }
        elseif ( ($g.GroupScope -eq 'Global') -or (-not [string]::IsNullOrWhiteSpace($g.Path)) )
        {
            $g.Path = '{0},{1}' -f $g.Path, $DomainDn
        }

        # if not specified, ensure 'Present'
        if (-not $g.ContainsKey('Ensure'))
        {
            $g.Ensure = 'Present'
        }

        # if not specified, set the DisplayName using the GroupName
        if (-not $g.ContainsKey('DisplayName'))
        {
            $g.DisplayName = $g.GroupName
        }

        # if specified, add Credentials to perform the operation
        if ($PSBoundParameters.ContainsKey('Credential'))
        {
            $g.Credential = $Credential
        }

        # set the name of the Node assigned as the Domain Controller for the resource
        if (-not $g.ContainsKey('DomainController'))
        {
            $g.DomainController = $node.Name
        }

        # if not specified, use 'SamAccountName' for membership operations
        if (-not $g.ContainsKey('MembershipAttribute'))
        {
            $g.MembershipAttribute = 'SamAccountName'
        }

        # if not specified, describe 'Notes' to specify DSC management
        if (-not $g.ContainsKey('Notes'))
        {
            $g.Notes = @'
This security group is being managed with Desired State Configuration (DSC).

The DSC project can be found at https://prod1gitlab.mapcom.local/dsc/dsc-deploy.
'@
        }

        # if not specified, disable 'RestoreFromRecycleBin'
        if (-not $g.ContainsKey('RestoreFromRecycleBin'))
        {
            $g.RestoreFromRecycleBin = $false
        }

        # this resource depends on response from Active Directory
        $g.DependsOn = $dependsOnWaitForADDomain

        # create execution name for the resource
        $executionName = "$($g.GroupName -replace '[-().:\s]', '_')_$($myDomainName -replace '[-().:\s]', '_')"

        <#
            Create DSC resource for Active Directory Groups
        #>
        try
        {
            $Splatting = @{
                ResourceName  = 'ADGroup'
                ExecutionName = $executionName
                Properties    = $g
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($g)
        }
        catch
        {
            Write-Verbose -Message 'ERROR: Failed to add group memberships.'
            throw "$($_.Exception.Message)"
        } #end try

        # if 'MemberOf' was specified, create the cusotm resource
        if ($null -ne $memberOf -and $memberOf.Count -gt 0)
        {
            # splat parameters
            $Splatting = @{
                ExecutionType = 'ADGroup'
                ExecutionName = $executionName
                Identity      = $g.GroupName
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