# ActiveDirectorySites

This DSC configuration manages and configures Active Directory Replication Sites, Sitelinks, and Subnets.

<br />

## Project Information

|                  |                                                                                                                            |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectorySites. |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                     |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                                                         |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectorySites`

| Parameter    | Attribute  | DataType   | Description                            | Allowed Values |
| :----------- | :--------- | :--------- | :------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]` | Distinguished Name (DN) of the domain. |                |


---

<br />

## Example `ActiveDirectorySites`

```yaml
ActiveDirectorySites:
  DomainDN: DC=mapcom,DC=local
  # Sites
  #
  # Specify named Replication Sites within Active Directory.
  # Sites are used in Active Directory to either enable clients to discover network resources (published shares, domain controllers) close to the physical location of a client computer or to reduce network traffic over wide area network (WAN) links.
  # Sites can also be used to optimize replication between domain controllers.
  Sites:
  - Name: HQ-SITE
    Ensure: Present
    Description: This site describes the Active Directory logical boundary found at Company headquarters.

  - Name: FL1-SITE
    Ensure: Present
    Description: this site describes the Active Directory logical boundary found at remote site located in Miami, FL.

  - Name: TN2-SITE
    Ensure: Present
    Description: This site describes the Active Directory logical boundary found at remote site located in Nashville, TN.

  # SiteLinks
  #
  # Specify named Replication Site Links within Active Directory.
  # A site link connects two or more sites.
  # Site links reflect the administrative policy for how sites are to be interconnected and the methods used to transfer replication traffic.
  SiteLinks:
  - Name: Link1
    Cost: 100
    ReplicationFrequencyInMinutes: 15
    Description: This site link connects Active Directory sites to headquarters.
    SitesIncluded:
    - Site1
    - Site2
    Ensure: Present
    # OptionChangeNotification
    #
    # Enables or disables Change Notification Replication on a site link. Default value is $false.
    OptionChangeNotification: true
    # OptionTwoWaySync
    #
    # Enables or disables Two Way Sync on a site link. Default value is $false.
    OptionTwoWaySync: false
    # OptionDisableCompression
    #
    # Enables or disables Compression on a site link. Default value is $false.
    OptionDisableCompression: false


  # Subnets
  #
  # Specify named Replication Subnets within Active Directory
  Subnets:
  - Name: 10.101.1.0/24
    Site: HQ-SITE
    Location: Chesapeake, VA
    Description: This subnet defines the logical network boundary for Windows Servers located at headquarters.
    Ensure: Present

  - Name: 10.200.28.0/20
    Site: TX4-SITE
    Location: North Richland Hills, TX
    Description: This subnet defines the logical network boundary for the remote site located in North Richland Hills, TX with site code TX4.

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectorySites:
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