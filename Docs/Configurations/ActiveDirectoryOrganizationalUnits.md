# ActiveDirectoryOrganizationalUnits

This DSC configuration manages Organizational Units (OUs) within Active Directory in a hierachical structure.

<br />

## Project Information

|                  |                                                                                                                                         |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryOrganizationalUnits |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                  |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                                                                      |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryOrganizationalUnits`

| Parameter    | Attribute  | DataType   | Description                            | Allowed Values |
| :----------- | :--------- | :--------- | :------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]` | Distinguished Name (DN) of the domain. |                |


---

<br />

## Example `ActiveDirectoryOrganizationalUnits`

```yaml
ActiveDirectoryOrganizationalUnits:
  DomainDN: DC=mapcom,DC=local
  OUs:
    - Name: Enterprise
      Description: This Organizational Unit contains all company Enterprise objects.
      ChildOu:
        - Name: Computers
          ChildOu:
            - Name: Desktops
              ChildOu:
                - Name: IT
                  ChildOu:
                    - Name: Domain
                    - Name: Privileged
                    - Name: Remote
                - Name: Operations
                  ChildOu:
                    - Name: Admin
                    - Name: Agent
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
            - Name: Resource
              ChildOu:
                - Name: IT
                - Name: Linux
                - Name: Operations
            - Name: Roles
              ChildOu:
                - Name: IT
                - Name: Linux
                - Name: Operations
        - Name: Users
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryOrganizationalUnits:
    merge_hash: deep

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