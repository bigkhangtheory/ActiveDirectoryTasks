# ActiveDirectorySites

This DSC configuration manages and configures Active Directory Replication Sites, Sitelinks, and Subnets.

<br />

## Project Information

|                  |                                                                                                                                                                        |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectorySites.                                             |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                                                 |
| **Resources**    | [ADReplicationSite][ADReplicationSite], [ADReplicationSiteLink][ADReplicationSiteLink], [ADReplicationSubnet][ADReplicationSubnet], [xWindowsFeature][xWindowsFeature] |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectorySites`

| Parameter     | Attribute  | DataType        | Description                                | Allowed Values |
| :------------ | :--------- | :-------------- | :----------------------------------------- | :------------- |
| **DomainDn**  | *Required* | `[String]`      | Distinguished Name (DN) of the domain.     |                |
| **Sites**     |            | `[Hashtable[]]` | List of Active Directory Site objects.     |                |
| **SiteLinks** |            | `[Hashtable[]]` | List of Active Directory Site Link objects |                |
| **Subnets**   |            | `[Hashtable[]]` | List of Active Directory Site subnets      |                |

---

#### Table. Attributes of `ActiveDirectorySites::Sites`

Sites are used in Active Directory to either enable clients to discover network resources (published shares, domain controllers) close to the physical location of a client computer or to reduce network traffic over wide area network (WAN) links. Sites can also be used to optimize replication between domain controllers.

| Parameter                      | Attribute  | DataType    | Description                                                                                                      | Allowed Values      |
| :----------------------------- | :--------- | :---------- | :--------------------------------------------------------------------------------------------------------------- | :------------------ |
| **Name**                       | *Required* | `[String]`  | Specifies the name of the Active Directory replication site.                                                     |                     |
| **Description**                |            | `[String]`  | Specifies a description of the object. This parameter sets the value of the Description property for the object. |                     |
| **RenameDefaultFirstSiteName** |            | `[Boolean]` | Specifies if the Default-First-Site-Name should be renamed if it exists. Default value is $false.                |                     |
| **Ensure**                     |            | `[String]`  | Specifies if the Active Directory replication site should be present or absent. Default value is `Present`.      | `Present`, `Absent` |

---

#### Table. Attributes of `ActiveDirectorySites::SiteLinks`

A site link connects two or more sites. Site links reflect the administrative policy for how sites are to be interconnected and the methods used to transfer replication traffic. You must connect sites with site links so that domain controllers at each site can replicate Active Directory changes.

| Parameter                         | Attribute  | DataType     | Description                                                                                                       | Allowed Values      |
| :-------------------------------- | :--------- | :----------- | :---------------------------------------------------------------------------------------------------------------- | :------------------ |
| **Name**                          | *Required* | `[String]`   | Specifies the name of the site link.                                                                              |                     |
| **Description**                   |            | `[String]`   | This parameter sets the value of the Description property for the object.                                         |                     |
| **Cost**                          |            | `[UInt32]`   | Specifies the cost to be placed on the site link.                                                                 |                     |
| **ReplicationFrequencyInMinutes** |            | `[UInt32]`   | Species the frequency (in minutes) for which replication will occur where this site link is in use between sites. |                     |
| **SitesIncluded**                 |            | `[String[]]` | Specifies the list of sites included in the site link.                                                            |                     |
| **SitesExcluded**                 |            | `[String[]]` | Specifies the list of sites to exclude from the site link.                                                        |                     |
| **OptionChangeNotification**      |            | `[Boolean]`  | Enables or disables Change Notification Replication on a site link. Default value is $false.                      |                     |
| **OptionTwoWaySync**              |            | `[Boolean]`  | Enables or disables Two Way Sync on a site link. Default value is $false.                                         |                     |
| **OptionDisableCompression**      |            | `[Boolean]`  | Enables or disables Compression on a site link. Default value is $false.                                          |                     |
| **Ensure**                        |            | `[String]`   | Specifies if the site link should be present or absent. Default value is `Present`.                               | `Present`, `Absent` |

---

#### Table. Attributes of `ActiveDirectorySites::Subnets`

| Parameter       | Attribute  | DataType   | Description                                                                                                      | Allowed Values      |
| :-------------- | :--------- | :--------- | :--------------------------------------------------------------------------------------------------------------- | :------------------ |
| **Name**        | *Required* | `[String]` | The name of the Active Directory replication subnet, e.g. `10.0.0.0/24`.                                         |                     |
| **Site**        | *Required* | `[String]` | The name of the assigned Active Directory replication site, e.g. `Default-First-Site-Name`.                      |                     |
| **Location**    |            | `[String]` | The location for the Active Directory replication site. Default value is empty ('') location.                    |                     |
| **Description** |            | `[String]` | Specifies a description of the object. This parameter sets the value of the Description property for the object. |                     |
| **Ensure**      |            | `[String]` | Specifies if the Active Directory replication subnet should be present or absent. Default value is `Present`.    | `Present`, `Absent` |

---

<br />

## Example `ActiveDirectorySites`

```yaml
ActiveDirectorySites:
  DomainDN: DC=example,DC=com
  Sites:
  - Name: HQ
    Ensure: Present
    Description: This site describes the Active Directory logical boundary found at Company headquarters.

  - Name: Florida
    Ensure: Present
    Description: this site describes the Active Directory logical boundary found at remote site located in Miami, FL.

  - Name: Nashville
    Ensure: Present
    Description: This site describes the Active Directory logical boundary found at remote site located in Nashville, TN.

  SiteLinks:
  - Name: Link1
    Cost: 100
    ReplicationFrequencyInMinutes: 15
    Description: This site link connects Active Directory sites to headquarters.
    SitesIncluded:
    - HQ
    - Florida
    Ensure: Present
    OptionChangeNotification: true
    OptionTwoWaySync: false
    OptionDisableCompression: false

  Subnets:
  - Name: 192.168.1.0/24
    Site: HQ-SITE

  - Name: 192.168.2.0/24
    Site: Florida

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectorySites:
    merge_hash: deep
  ActiveDirectorySites\Sites:
    merge_baseType_array: Unique
    merge_hash_array: DeepTuple
    merge_options:
      tuple_keys:
        - Name
  ActiveDirectorySites\SitesLinks:
    merge_baseType_array: Unique
    merge_hash_array: DeepTuple
    merge_options:
      tuple_keys:
        - Name
  ActiveDirectorySites\Subnets:
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