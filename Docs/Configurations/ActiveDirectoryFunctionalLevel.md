# ActiveDirectoryFunctionalLevel

This DSC configuration manages Domand and Forest Functional Levels.

For further details, see [Forest and Domain Functional Levels](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-functional-levels).

**WARNING: This action might be irreversible!** Make sure you understand the consequences of changing the domain functional level.

Read more about raising function levels and potential roll back scenarios in the Active Directory documentation.

For example: [Upgrade Domain Controllers to Windows Server 2016](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/deploy/upgrade-domain-controllers).

<br />

## Project Information

|                  |                                                                                                                                     |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryFunctionalLevel |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                              |
| **Resources**    | [ADDomainFunctionalLevel][ADDomainFunctionalLevel], [ADForestFunctionalLevel][ADForestFunctionalLevel], [xWindowsFeature][xWindowsFeature]                                              |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryFunctionalLevel`

| Parameter      | Attribute  | DataType   | Description                                                     | Allowed Values                                                                         |
| :------------- | :--------- | :--------- | :-------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| **ForestDn**   | *Required* | `[String]` | Distinguished Name (DN) of the forest.                          |                                                                                        |
| **ForestMode** | *Required* | `[String]` | Specifies the functional level for the Active Directory forest. | `Windows2008R2Domain`, `Windows2012Domain`, `Windows2012R2Domain`, `Windows2016Domain` |
| **DomainDn**   | *Required* | `[String]` | Distinguished Name (DN) of the domain.                          |                                                                                        |
| **DomainMode** | *Required* | `[String]` | Specifies the functional level for the Active Directory domain. | `Windows2008R2Domain`, `Windows2012Domain`, `Windows2012R2Domain`, `Windows2016Domain` |

---

<br />

## Example `ActiveDirectoryFunctionalLevel`

```yaml
ActiveDirectoryFunctionalLevel:
  ForestDN: DC=mapcom,DC=local
  ForestMode: Windows2008R2Forest
  DomainDN: DC=mapcom,DC=local
  DomainMode: Windows2008R2Domain
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryFunctionalLevel:
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