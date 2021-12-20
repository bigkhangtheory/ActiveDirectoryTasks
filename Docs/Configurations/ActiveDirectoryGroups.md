# ActiveDirectoryGroups

This DSC configuration manages groups and group memberships within Active Directory.

<br />

## Project Information

|                  |                                                                                                                            |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryGroups |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                     |
| **Resources**    | [ADGroup][ADGroup], [xWindowsFeature][xWindowsFeature]                                                                     |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryGroups`

| Parameter    | Attribute  | DataType        | Description                                                           | Allowed Values |
| :----------- | :--------- | :-------------- | :-------------------------------------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]`      | Distinguished Name (DN) of the domain.                                |                |
| **Groups**   |            | `[Hashtable[]]` | Specifies a list of Security Groups to create within Active Diretory. |                |

---

#### Table. Attributes of `Groups`

| Parameter                 | Attribute  | DataType         | Description                                                                                          | Allowed Values                                             |
| ------------------------- | ---------- | ---------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **GroupName**             | *Required* | `[String]`       | Name of the Active Directory group.                                                                  |                                                            |
| **GroupScope**            |            | `[String]`       | Active Directory group scope. Default value is `Global`.                                             | `DomainLocal`, `Global`, `Universal`                       |
| **Category**              |            | `[String]`       | Active Directory group category. Default value is `Security`.                                        | `Security`, `Distribution`                                 |
| **Path**                  |            | `[String]`       | Location of the group within Active Directory expressed as a Distinguished Name.                     |                                                            |
| **Ensure**                |            | `[String]`       | Specifies if this Active Directory group should be present or absent. Default value is `Present`.    | `Present`, `Absent`                                        |
| **Description**           |            | `[String]`       | Description of the Active Directory group.                                                           |                                                            |
| **DisplayName**           |            | `[String]`       | Display name of the Active Directory group.                                                          |                                                            |
| **Credential**            |            | `[PSCredential]` | Credentials used to enact the change upon.                                                           |                                                            |
| **DomainController**      |            | `[String]`       | Active Directory domain controller to enact the change upon.                                         |                                                            |
| **Members**               |            | `[String[]]`     | Active Directory group membership should match membership exactly.                                   |                                                            |
| **MembersToInclude**      |            | `[String[]]`     | Active Directory group should include these members.                                                 |                                                            |
| **MembersToExclude**      |            | `[String[]]`     | Active Directory group should NOT include these members.                                             |                                                            |
| **MembershipAttribute**   |            | `[String]`       | Active Directory attribute used to perform membership operations. Default value is `SamAccountName`. | `SamAccountName`, `DistinguishedName`, `ObjectGUID`, `SID` |
| **ManagedBy**             |            | `[String]`       | Active Directory managed by attribute specified as a DistinguishedName.                              |                                                            |
| **Notes**                 |            | `[String]`       | Active Directory group notes field.                                                                  |                                                            |
| **RestoreFromRecycleBin** |            | `[Boolean]`      | Try to restore the group from the recycle bin before creating a new one.                             |                                                            |
| **MemberOf**              |            | `[String[]]`     | Specify Active Directory groups for nested group membership.                                         |                                                            |

<br />

## Example `ActiveDirectoryGroups`

```yaml
ActiveDirectoryGroups:
  DomainDN: DC=example,DC=com
  Groups:
    - GroupName: System Administrators (II)
      GroupScope: Global
      Path: OU=Tiers,OU=Privileged,OU=Groups,OU=Enterprise
      Members:
        - admin_acct1
        - admin_acct2
        - System Administrators (III)
      MemberOf:
        - Group Policy Object Viewers
        - NAS Operators
        - Print Operators
        - System Administrators (I)
        - WSUS Reporters

    - GroupName: System Administrators (I)
      GroupScope: Global
      Path: OU=Tiers,OU=Privileged,OU=Groups,OU=Enterprise
      Members:
        - admin_acct3
        - admin_acct4
        - System Administrators (II)
      MemberOf:
        - Account Operators
        - DHCP Users
        - Event Log Readers
        - Workstation Operators
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryGroups:
    merge_hash: deep
  ActiveDirectoryGroups\Groups:
    merge_baseType_array: Unique
    merge_hash_array: DeepTuple
    merge_options:
      tuple_keys:
        - GroupName

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