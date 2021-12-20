# ADComputer

## Parameters

| Parameter                 | Attribute  | DataType         | Description                                                                                                                                                                                                    | Allowed Values  |
| ------------------------- | ---------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| **ComputerName**          | *Required* | `[String]`       | Specifies the name of the Active Directory computer account to manage. You can identify a computer by its distinguished name, GUID, security identifier (SID) or Security Accounts Manager (SAM) account name. |                 |
| **Location**              | *Optional* | `[String]`       | Specifies the location of the computer, such as an office number.                                                                                                                                              |                 |
| **DnsHostName**           | *Optional* | `[String]`       | Specifies the fully qualified domain name (FQDN) of the computer account.                                                                                                                                      |                 |
| **ServicePrincipalNames** | *Optional* | `[String[]]`     | Specifies the service principal names for the computer account.                                                                                                                                                |                 |
| **UserPrincipalName**     | *Optional* | `[String]`       | Specifies the User Principal Name (UPN) assigned to the computer account.                                                                                                                                      |                 |
| **DisplayName**           | *Optional* | `[String]`       | Specifies the display name of the computer account.                                                                                                                                                            |                 |
| **Path**                  | *Optional* | `[String]`       | Specifies the X.500 path of the Organizational Unit (OU) or container where the computer is located.                                                                                                           |                 |
| **Description**           | *Optional* | `[String]`       | Specifies a description of the computer account.                                                                                                                                                               |                 |
| **Manager**               | *Optional* | `[String]`       | Specifies the user or group Distinguished Name that manages the computer account. Valid values are the user's or group's DistinguishedName, ObjectGUID, SID or SamAccountName.                                 |                 |
| **DomainController**      | *Optional* | `[String]`       | Specifies the Active Directory Domain Services instance to connect to perform the task.                                                                                                                        |                 |
| **Credential**            | *Optional* | `[PSCredential]` | Specifies the user account credentials to use to perform the task.                                                                                                                                             |                 |
| **RequestFile**           | *Optional* | `[String]`       | Specifies the full path to the Offline Domain Join Request file to create.                                                                                                                                     |                 |
| **Ensure**                | *Optional* | `[String]`       | Specifies whether the computer account is present or absent. Default value is 'Present'.                                                                                                                       | Present, Absent |
| **RestoreFromRecycleBin** | *Optional* | `[Boolean]`      | Try to restore the computer account from the recycle bin before creating a new one.                                                                                                                            |                 |
| **EnabledOnCreation**     | *Optional* | `[Boolean]`      | Specifies if the computer account is created enabled or disabled. By default the Enabled property of the computer account will be set to the default value of the cmdlet New-ADComputer.                       |                 |
| **DistinguishedName**     | Read       | `[String]`       | Returns the X.500 path of the computer object.                                                                                                                                                                 |                 |
| **SID**                   | Read       | `[String]`       | Returns the security identifier of the computer object.                                                                                                                                                        |                 |
| **SamAccountName**        | Read       | `[String]`       | Returns the SAM account name of the computer object.                                                                                                                                                           |                 |
| **Enabled**               | Read       | `[Boolean]`      | Returns $true if the computer object is enabled, otherwise it returns $false.                                                                                                                                  |                 |

## Description

The ADComputer DSC resource will manage computer accounts within Active Directory.
This resource can be used to provision a computer account before the computer is
added to the domain. These pre-created computer objects can be used with offline
domain join, unsecure domain Join and RODC domain join scenarios.

>**Note:** An Offline Domain Join (ODJ) request file will only be created
>when a computer account is first created in the domain. Setting an Offline
>Domain Join (ODJ) Request file path for a configuration that updates a
>computer account that already exists, or restore it from the recycle bin
>will not cause the Offline Domain Join (ODJ) request file to be created.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.
* The parameter `RestoreFromRecycleBin` requires that the feature Recycle
  Bin has been enabled prior to an object is deleted. If the feature
  Recycle Bin is disabled then the property `msDS-LastKnownRDN` is not
  added the deleted object.

## Examples

### Example 1

This configuration will create two Active Directory computer accounts
enabled. The property Enabled will not be enforced in either case.

```powershell
Configuration ADComputer_AddComputerAccount_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADComputer 'CreateEnabled_SQL01'
        {
            ComputerName         = 'SQL01'

            PsDscRunAsCredential = $Credential
        }

        ADComputer 'CreateEnabled_SQL02'
        {
            ComputerName         = 'SQL02'
            EnabledOnCreation    = $true

            PsDscRunAsCredential = $Credential
        }
    }
}
```

### Example 2

This configuration will create an Active Directory computer account
disabled. The property Enabled will not be enforced.

```powershell
Configuration ADComputer_AddComputerAccountDisabled_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADComputer 'CreateDisabled'
        {
            ComputerName         = 'CLU_CNO01'
            EnabledOnCreation    = $false

            PsDscRunAsCredential = $Credential
        }
    }
}
```

### Example 3

This configuration will create an Active Directory computer account
on the specified domain controller and in the specific organizational
unit.

```powershell
Configuration ADComputer_AddComputerAccountSpecificPath_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADComputer 'CreateComputerAccount'
        {
            DomainController = 'DC01'
            ComputerName     = 'SQL01'
            Path             = 'OU=Servers,DC=contoso,DC=com'
            Credential       = $Credential
        }
    }
}
```

### Example 4

This configuration will create an Active Directory computer account
on the specified domain controller and in the specific organizational
unit. After the account is create an Offline Domain Join Request file
is created to the specified path.

```powershell
Configuration ADComputer_AddComputerAccountAndCreateODJRequest_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADComputer 'CreateComputerAccount'
        {
            DomainController = 'DC01'
            ComputerName     = 'NANO-200'
            Path             = 'OU=Servers,DC=contoso,DC=com'
            RequestFile      = 'D:\ODJFiles\NANO-200.txt'
            Credential       = $Credential
        }
    }
}
```

### Example 5

This configuration will create a computer account disabled, configure
a cluster using the disabled computer account, and enforcing the
computer account to be enabled.

```powershell
Configuration ADComputer_CreateClusterComputerAccount_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName ActiveDirectoryDsc
    Import-DscResource -ModuleName xFailoverCluster -ModuleVersion '1.14.1'

    node localhost
    {
        ADComputer 'ClusterAccount'
        {
            ComputerName      = 'CLU_CNO01'
            EnabledOnCreation = $false
        }

        xCluster 'CreateCluster'
        {
            Name                          = 'CLU_CNO01'
            StaticIPAddress               = '192.168.100.20/24'
            DomainAdministratorCredential = $Credential

            DependsOn                     = '[ADComputer]ClusterAccount'
        }

        ADObjectEnabledState 'EnforceEnabledPropertyToEnabled'
        {
            Identity    = 'CLU_CNO01'
            ObjectClass = 'Computer'
            Enabled     = $true

            DependsOn   = '[xCluster]CreateCluster'
        }
    }
}
```

