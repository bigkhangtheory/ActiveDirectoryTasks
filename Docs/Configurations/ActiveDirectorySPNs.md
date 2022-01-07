# ActiveDirectorySPNs

This DSC configuration will manage registered Service Principal Names (SPNs) within Active Directory.

A service principal name (SPN) is a unique identifier of a service instance.

SPNs are used by Kerberos authentication to associate a service instance with a service logon account.

This allows a client application to request that the service authenticate an account even if the client does not have the account name.

<br />

## Project Information

|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectorySPNs |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                   |
| **Resources**    | [ADServicePrincipalName][ADServicePrincipalName], [xWindowsFeature][xWindowsFeature]                                     |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectorySPNs`

| Parameter                 | Attribute  | DataType        | Description                              | Allowed Values |
| :------------------------ | :--------- | :-------------- | :--------------------------------------- | :------------- |
| **DomainDn**              | *Required* | `[String]`      | Distinguished Name (DN) of the domain.   |                |
| **ServicePrincipalNames** |            | `[Hashtable[]]` | List of managed service principal names. |                |

---

#### Table. Attributes of `ActiveDirectorySPNs::ServicePrincipalNames`

| Parameter                | Attribute  | DataType   | Description                                                                                                                                                    | Allowed Values      |
| :----------------------- | :--------- | :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------ |
| **ServicePrincipalName** | *Required* | `[String]` | The full SPN to add or remove, e.g. HOST/LON-DC1.                                                                                                              |                     |
| **Account**              |            | `[String]` | The user or computer account to add or remove the SPN to, e.g. User1 or LON-DC1$. Default value is ''. If Ensure is set to Present, a value must be specified. |                     |
| **Ensure**               |            | `[String]` | Specifies if the service principal name should be added or removed. Default value is `Present`.                                                                | `Present`, `Absent` |

---

<br />

## Example `ActiveDirectorySPNs`

```yaml
ActiveDirectorySPNs:
  DomainDN: DC=example,DC=com
  SPNs:
    - ServicePrincipalName: MSSQLSvc/sql01.example.com:1433
      Account: svc_mssql
      Ensure:   Present
    - ServicePrincipalName: HTTP/web.example.com
      Account: WEBSERVER01$
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectorySPNs:
    merge_hash: deep
  ActiveDirectorySPNs\ServicePrincipalNames:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - ServicePrincipalName

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