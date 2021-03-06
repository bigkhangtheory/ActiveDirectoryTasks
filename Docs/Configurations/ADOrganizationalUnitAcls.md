# ADOrganizationalUnitAcls



<br />

## Project Information

|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/ActiveDirectoryTasks/-/tree/master/ActiveDirectoryTasks/DscResources/ADOrganizationalUnitAcls |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                 |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `ADOrganizationalUnitAcls`

| Parameter    | Attribute  | DataType   | Description                            | Allowed Values |
| :----------- | :--------- | :--------- | :------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]` | Distinguished Name (DN) of the domain. |                |


---

<br />

## Example `ADOrganizationalUnitAcls`

```yaml
ADOrganizationalUnitAcls:
  DomainDN: DC=example,DC=com
  Paths:
    - Name: Enterprise
      ChildPath:
        # ---
        - Name: Groups
          ChildPath:
            # ---
            - Name: Distribution
              AccessControlList:
                # ---
                - IdentityReference: MAPCOM\Distribution Lists Administrators
                  PermissionEntries:
                    # ---
                    - AccessControlType: Allow
                      ActiveDirectoryRights:
                        - GenericAll
                      ActiveDirectorySecurityInheritance: Descendents
                      InheritedObjectType: Group
            # ---
            - Name: Organization
              AccessControlList:
                # ---
                - IdentityReference: MAPCOM\Group Membership Operators
                  PermissionEntries:
                    # ---
                    - AccessControlType: Allow
                      ActiveDirectoryRights:
                        - GenericRead
                        - GenericExecute
                      ActiveDirectorySecurityInheritance: Descendents
                      InheritedObjectType: Group
                    # ---
                    - AccessControlType: Allow
                      ActiveDirectoryRights:
                        - ExtendedRight
                      ObjectType: Membership
                      ActiveDirectorySecurityInheritance: Descendents
                      InheritedObjectType: Group
            # ---
            - Name: Privileged
              AccessControlList:
                # ---
                - IdentityReference: MAPCOM\Privleged Group Administrators
                  PermissionEntries:
                    # ---
                    - AccessControlType: Allow
                      ActiveDirectoryRights:
                        - GenericAll
                      ActiveDirectorySecurityInheritance: Descendents
                      InheritedObjectType: Group

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ADOrganizationalUnitAcls:
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
