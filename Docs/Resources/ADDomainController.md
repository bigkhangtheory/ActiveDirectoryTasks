# ADDomainController

## Parameters

| Parameter                               | Attribute  | DataType         | Description                                                                                                                                                                                                                                                                                                                                                                                                          | Allowed Values                                                                 |
| --------------------------------------- | ---------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |

## Description

The ADDomainController DSC resource will install and configure domain
controllers in Active Directory. Installation of Read-Only Domain Controllers
(RODC) is also supported.

Promotion of a Domain Controller using an existing DNS is available using
the `InstallDns` parameter. The parameter specifies if the DNS Server service
should be installed and configured on the domain controller. If this is
not set the default value of the parameter `InstallDns` of the cmdlet
[`Install-ADDSDomainController`](https://docs.microsoft.com/en-us/powershell/module/addsdeployment/install-addsdomaincontroller)
is used. The parameter `InstallDns` is only used during the provisioning
of a domain controller. The parameter cannot be used to install or uninstall
the DNS server on an already provisioned domain controller.

>**Note:** If the account used for the parameter `Credential`
>cannot connect to another domain controller, for example using a credential
>without the domain name, then the cmdlet `Install-ADDSDomainController` will
>seemingly halt (without reporting an error) when trying to replicate
>information from another domain controller.
>Make sure to use a correct domain account with the correct permission as
>the account for the parameter `Credential`.

The parameter `FlexibleSingleMasterOperationRole` is ignored until
the node has been provisioned as a domain controller. Take extra care
to make sure the Flexible Single Master Operation (FSMO) roles are moved
accordingly to avoid that two domain controller try to get to be the
owner of the same role (potential "ping-pong"-behavior).

>The resource does not support seizing of Flexible Single Master Operation
>(FSMO) roles

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will add a domain controller to the domain
contoso.com.

```powershell
Configuration ADDomainController_AddDomainControllerToDomainMinimal_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $SafeModePassword
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        WindowsFeature 'InstallADDomainServicesFeature'
        {
            Ensure = 'Present'
            Name   = 'AD-Domain-Services'
        }

        WindowsFeature 'RSATADPowerShell'
        {
            Ensure    = 'Present'
            Name      = 'RSAT-AD-PowerShell'

            DependsOn = '[WindowsFeature]InstallADDomainServicesFeature'
        }

        WaitForADDomain 'WaitForestAvailability'
        {
            DomainName = 'contoso.com'
            Credential = $Credential

            DependsOn  = '[WindowsFeature]RSATADPowerShell'
        }

        ADDomainController 'DomainControllerMinimal'
        {
            DomainName                    = 'contoso.com'
            Credential                    = $Credential
            SafeModeAdministratorPassword = $SafeModePassword

            DependsOn                     = '[WaitForADDomain]WaitForestAvailability'
        }
    }
}
```

### Example 2

This configuration will add a domain controller to the domain
contoso.com, specifying all properties of the resource.

```powershell
Configuration ADDomainController_AddDomainControllerToDomainAllProperties_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $SafeModePassword
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        WindowsFeature 'InstallADDomainServicesFeature'
        {
            Ensure = 'Present'
            Name   = 'AD-Domain-Services'
        }

        WindowsFeature 'RSATADPowerShell'
        {
            Ensure    = 'Present'
            Name      = 'RSAT-AD-PowerShell'

            DependsOn = '[WindowsFeature]InstallADDomainServicesFeature'
        }

        WaitForADDomain 'WaitForestAvailability'
        {
            DomainName = 'contoso.com'
            Credential = $Credential

            DependsOn  = '[WindowsFeature]RSATADPowerShell'
        }

        ADDomainController 'DomainControllerAllProperties'
        {
            DomainName                    = 'contoso.com'
            Credential                    = $Credential
            SafeModeAdministratorPassword = $SafeModePassword
            DatabasePath                  = 'C:\Windows\NTDS'
            LogPath                       = 'C:\Windows\Logs'
            SysvolPath                    = 'C:\Windows\SYSVOL'
            SiteName                      = 'Europe'
            IsGlobalCatalog               = $true

            DependsOn                     = '[WaitForADDomain]WaitForestAvailability'
        }
    }
}
```

### Example 3

This configuration will add a domain controller to the domain
contoso.com using the information from media.

```powershell
Configuration ADDomainController_AddDomainControllerToDomainUsingIFM_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $SafeModePassword
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        WindowsFeature 'InstallADDomainServicesFeature'
        {
            Ensure = 'Present'
            Name   = 'AD-Domain-Services'
        }

        WindowsFeature 'RSATADPowerShell'
        {
            Ensure    = 'Present'
            Name      = 'RSAT-AD-PowerShell'

            DependsOn = '[WindowsFeature]InstallADDomainServicesFeature'
        }

        WaitForADDomain 'WaitForestAvailability'
        {
            DomainName = 'contoso.com'
            Credential = $Credential

            DependsOn  = '[WindowsFeature]RSATADPowerShell'
        }

        ADDomainController 'DomainControllerWithIFM'
        {
            DomainName                    = 'contoso.com'
            Credential                    = $Credential
            SafeModeAdministratorPassword = $SafeModePassword
            InstallationMediaPath         = 'F:\IFM'

            DependsOn                     = '[WaitForADDomain]WaitForestAvailability'
        }
    }
}
```

### Example 4

This configuration will add a read-only domain controller to the domain contoso.com
and specify a list of account, whose passwords are allowed/denied for synchronisation.

```powershell
Configuration ADDomainController_AddReadOnlyDomainController_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $SafeModePassword
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        WindowsFeature 'InstallADDomainServicesFeature'
        {
            Ensure = 'Present'
            Name   = 'AD-Domain-Services'
        }

        WindowsFeature 'RSATADPowerShell'
        {
            Ensure    = 'Present'
            Name      = 'RSAT-AD-PowerShell'

            DependsOn = '[WindowsFeature]InstallADDomainServicesFeature'
        }

        WaitForADDomain 'WaitForestAvailability'
        {
            DomainName = 'contoso.com'
            Credential = $Credential

            DependsOn  = '[WindowsFeature]RSATADPowerShell'
        }

        ADDomainController 'Read-OnlyDomainController(RODC)'
        {
            DomainName                          = 'contoso.com'
            Credential                          = $Credential
            SafeModeAdministratorPassword       = $SafeModePassword
            ReadOnlyReplica                     = $true
            SiteName                            = 'Default-First-Site-Name'
            AllowPasswordReplicationAccountName = @('pvdi.test1', 'pvdi.test')
            DenyPasswordReplicationAccountName  = @('SVC_PVS', 'TA2SCVMM')

            DependsOn                           = '[WaitForADDomain]WaitForestAvailability'
        }
    }
}
```

### Example 5

This configuration will add a domain controller to the domain
contoso.com, and when the configuration is enforced it will
move the Flexible Single Master Operation (FSMO) role
'RIDMaster' from the current owner to this domain controller.

```powershell
Configuration ADDomainController_AddDomainControllerAndMoveRole_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $SafeModePassword
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        WindowsFeature 'InstallADDomainServicesFeature'
        {
            Ensure = 'Present'
            Name   = 'AD-Domain-Services'
        }

        WindowsFeature 'RSATADPowerShell'
        {
            Ensure    = 'Present'
            Name      = 'RSAT-AD-PowerShell'

            DependsOn = '[WindowsFeature]InstallADDomainServicesFeature'
        }

        WaitForADDomain 'WaitForestAvailability'
        {
            DomainName = 'contoso.com'
            Credential = $Credential

            DependsOn  = '[WindowsFeature]RSATADPowerShell'
        }

        ADDomainController 'DomainControllerMinimal'
        {
            DomainName                        = 'contoso.com'
            Credential                        = $Credential
            SafeModeAdministratorPassword     = $SafeModePassword
            FlexibleSingleMasterOperationRole = @('RIDMaster')

            DependsOn                         = '[WaitForADDomain]WaitForestAvailability'
        }
    }
}
```

### Example 6

This configuration will add a domain controller to the domain contoso.com
without installing the local DNS server service and using the one in the existing domain.

```powershell
Configuration ADDomainController_AddDomainControllerUsingInstallDns_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        WindowsFeature 'InstallADDomainServicesFeature'
        {
            Ensure = 'Present'
            Name   = 'AD-Domain-Services'
        }

        WindowsFeature 'RSATADPowerShell'
        {
            Ensure    = 'Present'
            Name      = 'RSAT-AD-PowerShell'

            DependsOn = '[WindowsFeature]InstallADDomainServicesFeature'
        }

        WaitForADDomain 'WaitForestAvailability'
        {
            DomainName = 'contoso.com'
            Credential = $Credential

            DependsOn  = '[WindowsFeature]RSATADPowerShell'
        }

        ADDomainController 'DomainControllerUsingExistingDNSServer'
        {
            DomainName                    = 'contoso.com'
            Credential                    = $Credential
            SafeModeAdministratorPassword = $Credential
            InstallDns                    = $false

            DependsOn                     = '[WaitForADDomain]WaitForestAvailability'
        }
    }
}
```

