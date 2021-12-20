# ADDomain

## Parameters

| Parameter                         | Attribute  | DataType         | Description                                                                                                                                                                                                                                                                                                                                                                                          | Allowed Values                                       |
| --------------------------------- | ---------- | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| **DomainName**                    | *Required* | `[String]`       | The fully qualified domain name (FQDN) of a new domain. If setting up a child domain this must be set to a single-label DNS name.                                                                                                                                                                                                                                                                    |                                                      |
| **Credential**                    | Required   | `[PSCredential]` | Specifies the user name and password that corresponds to the account used to install the domain controller. These are only used when adding a child domain and these credentials need the correct permission in the parent domain. This will not be created as a user in the new domain. The domain administrator password will be the same as the password of the local Administrator of this node. |                                                      |
| **SafeModeAdministratorPassword** | Required   | `[PSCredential]` | Password for the administrator account when the computer is started in Safe Mode.                                                                                                                                                                                                                                                                                                                    |                                                      |
| **ParentDomainName**              | *Optional* | `[String]`       | Fully qualified domain name (FQDN) of the parent domain.                                                                                                                                                                                                                                                                                                                                             |                                                      |
| **DomainNetBiosName**             | *Optional* | `[String]`       | NetBIOS name for the new domain.                                                                                                                                                                                                                                                                                                                                                                     |                                                      |
| **DnsDelegationCredential**       | *Optional* | `[PSCredential]` | Credential used for creating DNS delegation.                                                                                                                                                                                                                                                                                                                                                         |                                                      |
| **DatabasePath**                  | *Optional* | `[String]`       | Path to a directory that contains the domain database.                                                                                                                                                                                                                                                                                                                                               |                                                      |
| **LogPath**                       | *Optional* | `[String]`       | Path to a directory for the log file that will be written.                                                                                                                                                                                                                                                                                                                                           |                                                      |
| **SysvolPath**                    | *Optional* | `[String]`       | Path to a directory where the Sysvol file will be written.                                                                                                                                                                                                                                                                                                                                           |                                                      |
| **ForestMode**                    | *Optional* | `[String]`       | The Forest Functional Level for the entire forest.                                                                                                                                                                                                                                                                                                                                                   | Win2008, Win2008R2, Win2012, Win2012R2, WinThreshold |
| **DomainMode**                    | *Optional* | `[String]`       | The Domain Functional Level for the entire domain.                                                                                                                                                                                                                                                                                                                                                   | Win2008, Win2008R2, Win2012, Win2012R2, WinThreshold |
| **DomainExist**                   | Read       | `[Boolean]`      | Returns $true if the domain is available, or $false if the domain could not be found.                                                                                                                                                                                                                                                                                                                |                                                      |
| **DnsRoot**                       | Read       | `[String]`       | Returns the fully qualified domain name (FQDN) DNS root of the domain.                                                                                                                                                                                                                                                                                                                               |                                                      |
| **Forest**                        | Read       | `[String]`       | Returns the fully qualified domain name (FQDN) of the forest.                                                                                                                                                                                                                                                                                                                                        |                                                      |

## Description

The ADDomain resource creates a new domain in a new forest or a child domain in an existing forest. While it is possible to set the forest functional level and the domain functional level during deployment with this resource the common restrictions apply. For more information see [TechNet](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-functional-levels).

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will create a new domain with a new forest and a forest
functional level of Server 2016.

```powershell
Configuration ADDomain_NewForest_Config
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

    node 'localhost'
    {
        WindowsFeature 'ADDS'
        {
            Name   = 'AD-Domain-Services'
            Ensure = 'Present'
        }

        WindowsFeature 'RSAT'
        {
            Name   = 'RSAT-AD-PowerShell'
            Ensure = 'Present'
        }

        ADDomain 'contoso.com'
        {
            DomainName                    = 'contoso.com'
            Credential                    = $Credential
            SafemodeAdministratorPassword = $SafeModePassword
            ForestMode                    = 'WinThreshold'
        }
    }
}
```

### Example 2

This configuration will create a new child domain in an existing forest with
a Domain Functional Level of Windows Server 2016 (WinThreshold).
The credential parameter must contain the domain qualified credentials of a
user in the forest who has permissions to create a new child domain.

```powershell
Configuration ADDomain_NewChildDomain_Config
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

    node 'localhost'
    {
        WindowsFeature 'ADDS'
        {
            Name   = 'AD-Domain-Services'
            Ensure = 'Present'
        }

        WindowsFeature 'RSAT'
        {
            Name   = 'RSAT-AD-PowerShell'
            Ensure = 'Present'
        }

        ADDomain 'child'
        {
            DomainName                    = 'child'
            Credential                    = $Credential
            SafemodeAdministratorPassword = $SafeModePassword
            DomainMode                    = 'WinThreshold'
            ParentDomainName              = 'contoso.com'
        }
    }
}
```

