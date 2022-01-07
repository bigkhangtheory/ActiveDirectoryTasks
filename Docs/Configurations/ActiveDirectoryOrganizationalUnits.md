# ActiveDirectoryOrganizationalUnits

The **ActiveDirectoryOrganizationalUnits** DSC configuration manages Organizational Units (OUs) within Active Directory in a hierachical structure.

An OU is a subdivision within an Active Directory into which you can place users, groups, computers, and other organizational units.

<br />

## Project Information

|                  |                                                                                                                                         |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryOrganizationalUnits |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                  |
| **Resources**    | [ADOrganizationalUnit][ADOrganizationalUnit], [xWindowsFeature][xWindowsFeature]                                                        |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryOrganizationalUnits`

| Parameter    | Attribute  | DataType        | Description                                                | Allowed Values |
| :----------- | :--------- | :-------------- | :--------------------------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]`      | Distinguished Name (DN) of the domain.                     |                |
| **OUs**      | *Required* | `[Hashtable[]]` | List of Organizational Units (OUs) within Active Directory |                |

---

<br />

### Table. Attributes of `OUs`

| Parameter       | Attribute  | DataType        | Description                                                                                    | Allowed Values |
| :-------------- | :--------- | :-------------- | :--------------------------------------------------------------------------------------------- | :------------- |
| **Name**        | *Required* | `[String]`      | The name of the Organizational Unit (OU).                                                      |                |
| **Description** |            | `[String]`      | Specify a description to be included for the OU with Active Directory. Defaults to `DomainDN`. |                |
| **ChildOu**     |            | `[Hashtable[]]` | List of Child Organizational Units. For each Child OU the parameter Name must be specified.    |                |

---

<br />

## Example `ActiveDirectoryOrganizationalUnits`

```yaml
ActiveDirectoryOrganizationalUnits:
  DomainDN: DC=example,DC=com
  OUs:
    - Name: Enterprise
      Description: This Organizational Unit contains all company Enterprise objects.
      ChildOu:
        - Name: Computers
          ChildOu:
            - Name: Desktops
              ChildOu:
                - Name: Privileged
                  ChildOu:
                    - Name: IT
                    - Name: Development
                    - Name: Remote
                - Name: Operations
            - Name: Servers
              ChildOu:
                - Name: Linux
                - Name: Windows
                  ChildOu:
                    - Name: Application
                    - Name: CertificateAuthorities
                    - Name: DHCP
                    - Name: Hyper-V
                    - Name: IIS
                    - Name: RDS
                    - Name: SQL
                    - Name: WDS
                    - Name: WSUS
        - Name: Groups
          ChildOu:
            - Name: Privileged
              ChildOu:
                - Name: Resources
                - Name: Roles
                - Name: Tiers
            - Name: Business
              ChildOu:
                - Name: Admins
                - Name: Staff
                - Name: VPs
        - Name: Users
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryOrganizationalUnits:
    merge_hash: deep
  ActiveDirectoryOrganizationalUnits:
    merge_baseType_array: Unique
    merge_hash_array: DeepTuple
    merge_options:
      tuple_keys:
        - Name
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