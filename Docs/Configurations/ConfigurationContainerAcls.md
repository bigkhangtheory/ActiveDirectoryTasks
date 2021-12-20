# ConfigurationContainerAcls

This DSC configuration manages access control lists on Active Directory Configuration container objects.

<br />

## Project Information

|                  |                                                                                                                                 |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ConfigurationContainerAcls |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                          |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                                                              |

<br />

## Parameters

<br />

### Table. Attributes of `ConfigurationContainerAcls`

| Parameter    | Attribute  | DataType   | Description                            | Allowed Values |
| :----------- | :--------- | :--------- | :------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]` | Distinguished Name (DN) of the domain. |                |


---

<br />

## Example `ConfigurationContainerAcls`

```yaml
ConfigurationContainerAcls:
  DomainDN: DC=example,DC=com
  Paths:
    - Name: Configuration
      ChildPath:
        # ---
        - Name: Services
          ChildPath:
            # ---
            - Name: NetServices
              AccessControlList:
                # ---
                - IdentityReference: EXAMPLE\DHCP Administrators
                  PermissionEntries:
                    # ---
                    - AccessControlType:      Allow
                      ActiveDirectoryRights:  GenericAll
            # ---
            - Name: Public Key Services
              AccessControlList:
                # ---
                - IdentityReference: MAPCOM\Certificate Authority Administrators
                  PermissionEntries:
                    # ---
                    - AccessControlType:      Allow
                      ActiveDirectoryRights:  GenericAll
              ChildPath:
                # ---
                - Name: Certificate Templates
                  ChildPath:
                    # ---
                    - Name: Administrator
                      AccessControlList:
                        # ---
                        - IdentityReference: MAPCOM\Certificate Authority Administrators
                          PermissionEntries:
                            # ---
                            - AccessControlType: Allow
                              ActiveDirectoryRights:
                                - GenericRead
                                - GenericWrite
                                - WriteDacl
                            # ---
                            - AccessControlType: Allow
                              ActiveDirectoryRights: ExtendedRight
                              ObjectType: Certificate-Enrollment
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ConfigurationContainerAcls:
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
