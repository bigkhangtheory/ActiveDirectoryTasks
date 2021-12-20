# ActiveDirectoryDistributionGroups

This DSC configuration is used to manage group memberships of Distribution Groups within Active Directory

<br />

## Project Information

|                  |                                                                                                                                        |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryDistributionGroups |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                 |
| **Resources**    | [ADGroup][ADGroup], [xWindowsFeature][xWindowsFeature]                                                                                 |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryDistributionGroups`

| Parameter    | Attribute  | DataType        | Description                            | Allowed Values |
| :----------- | :--------- | :-------------- | :------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]`      | Distinguished Name (DN) of the domain. |                |
| **Groups**   | *Required* | `[Hashtable[]]` | List of Distribution Groups to create. |                |

---

#### Table. Attributes of `Groups`

| Parameter                 | Attribute  | DataType         | Description                                                                                          | Allowed Values                                     |
| :------------------------ | :--------- | :--------------- | :--------------------------------------------------------------------------------------------------- | :------------------------------------------------- |
| **GroupName**             | *Required* | `[String]`       | Name of the Active Directory group.                                                                  |                                                    |
| **Path**                  | *Optional* | `[String]`       | Location of the group within Active Directory expressed as a Distinguished Name.                     |                                                    |
| **Ensure**                | *Optional* | `[String]`       | Specifies if this Active Directory group should be present or absent. Default value is `Present`.    | `Present`, `Absent`                                |
| **Description**           | *Optional* | `[String]`       | Description of the Active Directory group.                                                           |                                                    |
| **DisplayName**           | *Optional* | `[String]`       | Display name of the Active Directory group.                                                          |                                                    |
| **Credential**            | *Optional* | `[PSCredential]` | Credentials used to enact the change upon.                                                           |                                                    |
| **DomainController**      | *Optional* | `[String]`       | Active Directory domain controller to enact the change upon.                                         |                                                    |
| **Members**               | *Optional* | `[String[]]`     | Active Directory group membership should match membership exactly.                                   |                                                    |
| **MembersToInclude**      | *Optional* | `[String[]]`     | Active Directory group should include these members.                                                 |                                                    |
| **MembersToExclude**      | *Optional* | `[String[]]`     | Active Directory group should NOT include these members.                                             |                                                    |
| **MembershipAttribute**   | *Optional* | `[String]`       | Active Directory attribute used to perform membership operations. Default value is 'SamAccountName'. | SamAccountName, DistinguishedName, ObjectGUID, SID |
| **ManagedBy**             | *Optional* | `[String]`       | Active Directory managed by attribute specified as a DistinguishedName.                              |                                                    |
| **Notes**                 | *Optional* | `[String]`       | Active Directory group notes field.                                                                  |                                                    |
| **RestoreFromRecycleBin** | *Optional* | `[Boolean]`      | Try to restore the group from the recycle bin before creating a new one.                             |                                                    |

---

<br />

## Example `ActiveDirectoryDistributionGroups`

```yaml
ActiveDirectoryDistributionGroups:
  DomainDN: DC=mapcom,DC=local
  Groups:
    - GroupName: myemailgroup
      Path: OU=Client,OU=Distribution,OU=Roles,OU=Groups,OU=Enterprise
      Description: Members of this group are email buds
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryDistributionGroups:
    merge_hash: deep
  ActiveDirectoryDistributionGroups\Groups:
    merge_hash_array: deep
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