<#
    .DESCRIPTION
        This DSC configuration manages Access Control Entries for Active Directory objects.
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER Paths
        Specify a list of object distinguished name values for the target object.
#>
#Requires -Module AccessControlDsc
#Requires -Module ActiveDirectoryDsc


configuration ActiveDirectoryAcls
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
        $Paths
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName AccessControlDsc
    Import-DscResource -ModuleName ActiveDirectoryDsc


    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'


    <#
        Wait for Active Directory domain controller to become available in the domain
    #>

    # set execution name for the resource
    $executionName = "$($myDomainName -replace '[-().:\s]', '_')"

    WaitForADDomain "$executionName"
    {
        DomainName  = $myDomainName
        WaitTimeout = 300
    }
    # set resource name as dependency
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    <#
        Create DSC resources for Active Directory ACEs
    #>
    foreach ($p in $Paths)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $p = @{ } + $p

        # formulate execution name from Path
        $executionName = "$($p.DistinguishedName -replace '[-().:\s]', '_')"

        # create NTFS access control resource
        ActiveDirectoryAccessEntry "$executionName"
        {
            DistinguishedName = '{0},{1}' -f $p.DistinguishedName, $DomainDN
            <#
                Indicates the access control information in the form of an array of instances of the ActiveDirectoryAccessControlList CIM class. 
            #>
            AccessControlList = @(
                # enumerate the access control list
                foreach ($a in $p.AccessControlList)
                {
                    # if not specified, set 'ForcePrincipal' to $false
                    if ($null -eq $a.ForcePrincipal)
                    {
                        $a.ForcePrincipal = $false 
                    } #end if

                    ActiveDirectoryAccessControlList 
                    {
                        Principal          = $a.Principal
                        ForcePrincipal     = $a.ForcePrincipal
                        <#
                            Indicates the access control entry in the form of an array of instances of the ActiveDirectoryAccessRule CIM class.
                        #>
                        AccessControlEntry = @(
                            # enumerate access control entries
                            foreach ($e in $a.AccessControlEntry)
                            {
                                # if 'ActiveDirectoryRights' not specified, set 'GenericAll'
                                if ($null -eq $e.ActiveDirectoryRights)
                                {
                                    $e.ActiveDirectoryRights = 'GenericAll'
                                }
                                
                                # if 'InheritianceType' not specifed, allow all
                                if ($null -eq $e.InheritanceType)
                                {
                                    $e.InheritanceType = 'All'
                                }

                                # if not specified, ensure 'Present'
                                if ($null -eq $e.Ensure)
                                {
                                    $e.Ensure = 'Present'
                                } #end if

                                ActiveDirectoryAccessRule
                                {
                                    AccessControlType   = $e.AccessControlType 
                                    ActiveDirectoryRights = @() + $e.ActiveDirectoryRights 
                                    ObjectType          = $e.ObjectType
                                    InheritanceType     = $e.InheritanceType
                                    InheritedObjectType = $e.InheritedObjectType
                                    Ensure              = $e.Ensure  
                                }
                            } #end foreach
                        ) #end ActiveDirectoryAccessRule
                    } #end @() ActiveDirectoryAccessControlList
                } #end foreach
            ) #end @() AccessControlList
            DependsOn         = $dependsOnWaitForADDomain
        } #end ActiveDirectoryAccessEntry
    } #end foreach 
} #end configuration
