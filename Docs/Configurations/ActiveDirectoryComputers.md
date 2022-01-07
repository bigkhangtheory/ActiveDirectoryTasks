# ActiveDirectoryComputers

The **ActiveDirectoryComputers** DSC configuration will manage computer accounts within Active Directory.

This resource can be used to provision a computer account before the computer is added to the domain. These pre-created computer objects can be used with offline domain join, unsecure domain Join and RODC domain join scenarios.

<br />

## Project Information

|                  |                                                                                                                               |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryComputers |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                        |
| **Resources**    | [ADComputer][ADComputer], [xWindowsFeature][xWindowsFeature]                                                                  |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryComputers`

| Parameter     | Attribute  | DataType        | Description                            | Allowed Values |
| :------------ | :--------- | :-------------- | :------------------------------------- | :------------- |
| **DomainDn**  | *Required* | `[String]`      | Distinguished Name (DN) of the domain. |                |
| **Computers** | *Required* | `[Hashtable[]]` | List of computer accounts to create.   |                |

---

#### Table. Attributes of `Computers`

| Parameter                 | Attribute  | DataType         | Description                                                                                                                                                                                                    | Allowed Values      |
| :------------------------ | :--------- | :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------ |
| **ComputerName**          | *Required* | `[String]`       | Specifies the name of the Active Directory computer account to manage. You can identify a computer by its distinguished name, GUID, security identifier (SID) or Security Accounts Manager (SAM) account name. |                     |
| **Path**                  |            | `[String]`       | Specifies the X.500 path of the Organizational Unit (OU) or container where the computer is located.                                                                                                           |                     |
| **Location**              |            | `[String]`       | Specifies the location of the computer, such as an office number.                                                                                                                                              |                     |
| **DnsHostName**           |            | `[String]`       | Specifies the fully qualified domain name (FQDN) of the computer account.                                                                                                                                      |                     |
| **ServicePrincipalNames** |            | `[String[]]`     | Specifies the service principal names for the computer account.                                                                                                                                                |                     |
| **UserPrincipalName**     |            | `[String]`       | Specifies the User Principal Name (UPN) assigned to the computer account.                                                                                                                                      |                     |
| **DisplayName**           |            | `[String]`       | Specifies the display name of the computer account.                                                                                                                                                            |                     |
| **Description**           |            | `[String]`       | Specifies a description of the computer account.                                                                                                                                                               |                     |
| **Manager**               |            | `[String]`       | Specifies the user or group Distinguished Name that manages the computer account. Valid values are the user's or group's DistinguishedName, ObjectGUID, SID or SamAccountName.                                 |                     |
| **DomainController**      |            | `[String]`       | Specifies the Active Directory Domain Services instance to connect to perform the task.                                                                                                                        |                     |
| **Credential**            |            | `[PSCredential]` | Specifies the user account credentials to use to perform the task.                                                                                                                                             |                     |
| **RequestFile**           |            | `[String]`       | Specifies the full path to the Offline Domain Join Request file to create.                                                                                                                                     |                     |
| **Ensure**                |            | `[String]`       | Specifies whether the computer account is present or absent. Default value is 'Present'.                                                                                                                       | `Present`, `Absent` |
| **RestoreFromRecycleBin** |            | `[Boolean]`      | Try to restore the computer account from the recycle bin before creating a new one.                                                                                                                            |                     |
| **EnabledOnCreation**     |            | `[Boolean]`      | Specifies if the computer account is created enabled or disabled. By default the Enabled property of the computer account will be set to the default value of the cmdlet New-ADComputer.                       |                     |
| **MemberOf**              |            | `[String[]]`     | List of Domain Groups of the computer.                                                                                                                                                                         |                     |

---

<br />

## Example `ActiveDirectoryComputers`

```yaml
ActiveDirectoryComputers:
  DomainDN: DC=example,DC=com
  Computers:
    - ComputerName: Server01
    - ComputerName: Client01
      EnabledOnCreation: false
      Description: Testclient 1
      Path:        OU=Computers
      MemberOf:
        - Client Security Group
        - Special Security Group

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryComputers:
    merge_hash: deep
  ActiveDirectoryComputers\Computers:
    merge_baseType_array: Unique
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - ComputerName
```

<br />

[ActiveDirectoryDsc]: https://github.com/dsccommunity/ActiveDirectoryDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[ADComputer]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADComputer
[ADDomain]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomain
[ADDomainController]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainController
[ADDomainControllerProperties]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainControllerProperties
[ADDomainDefaultPasswordPolicy]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainDefaultPasswordPolicy
[ADDomainFunctionalLevel]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainFunctionalLevel
[ADDomainTrust]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainTrust
[ADForestFunctionalLevel]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADForestFunctionalLevel
[ADForestProperties]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADForestProperties
[ADGroup]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADGroup
[ADKDSKey]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADKDSKey
[ADManagedServiceAccount]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADManagedServiceAccount
[ADObjectEnabledState]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADObjectEnabledState
[ADObjectPermissionEntry]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADObjectPermissionEntry
[ADOptionalFeature]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADOptionalFeature
[ADOrganizationalUnit]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADOrganizationalUnit
[ADReplicationSite]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADReplicationSite
[ADReplicationSiteLink]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADReplicationSiteLink
[ADReplicationSubnet]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADReplicationSubnet
[ADServicePrincipalName]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADServicePrincipalName
[ADUser]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADUser
[WaitForADDomain]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/WaitForADDomain
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration