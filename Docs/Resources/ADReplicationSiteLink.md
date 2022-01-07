# ADReplicationSiteLink

## Parameters

| Parameter                         | Attribute  | DataType     | Description                                                                                                       | Allowed Values  |
| --------------------------------- | ---------- | ------------ | ----------------------------------------------------------------------------------------------------------------- | --------------- |
| **Name**                          | *Required* | `[String]`   | Specifies the name of the site link.                                                                              |                 |
| **Cost**                          |            | SInt32       | Specifies the cost to be placed on the site link.                                                                 |                 |
| **Description**                   |            | `[String]`   | This parameter sets the value of the Description property for the object.                                         |                 |
| **ReplicationFrequencyInMinutes** |            | SInt32       | Species the frequency (in minutes) for which replication will occur where this site link is in use between sites. |                 |
| **SitesIncluded**                 |            | `[String[]]` | Specifies the list of sites included in the site link.                                                            |                 |
| **SitesExcluded**                 |            | `[String[]]` | Specifies the list of sites to exclude from the site link.                                                        |                 |
| **Ensure**                        |            | `[String]`   | Specifies if the site link should be present or absent. Default value is 'Present'.                               | Present, Absent |
| **OptionChangeNotification**      |            | `[Boolean]`  | Enables or disables Change Notification Replication on a site link. Default value is $false.                      |                 |
| **OptionTwoWaySync**              |            | `[Boolean]`  | Enables or disables Two Way Sync on a site link. Default value is $false.                                         |                 |
| **OptionDisableCompression**      |            | `[Boolean]`  | Enables or disables Compression on a site link. Default value is $false.                                          |                 |

## Description

The ADReplicationSiteLink DSC resource will manage Replication Site Links within Active Directory. A site link connects two or more sites. Site links reflect the administrative policy for how sites are to be interconnected and the methods used to transfer replication traffic. You must connect sites with site links so that domain controllers at each site can replicate Active Directory changes.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will create an AD Replication Site Link.

```powershell
Configuration ADReplicationSiteLink_CreateReplicationSiteLink_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADReplicationSiteLink 'HQSiteLink'
        {
            Name                          = 'HQSiteLInk'
            SitesIncluded                 = @('site1', 'site2')
            Cost                          = 100
            ReplicationFrequencyInMinutes = 15
            Ensure                        = 'Present'
        }
    }
}
```

### Example 2

This configuration will modify an existing AD Replication Site Link.

```powershell
Configuration ADReplicationSiteLink_ModifyExistingReplicationSiteLink_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADReplicationSiteLink 'HQSiteLink'
        {
            Name                          = 'HQSiteLInk'
            SitesIncluded                 = 'site1'
            SitesExcluded                 = 'site2'
            Cost                          = 100
            ReplicationFrequencyInMinutes = 20
            Ensure                        = 'Present'
        }
    }
}
```

### Example 3

This configuration will modify an existing AD Replication Site Link by enabling Replication Options.

```powershell
Configuration ADReplicationSiteLink_EnableOptions_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADReplicationSiteLink 'HQSiteLink'
        {
            Name                          = 'HQSiteLInk'
            SitesIncluded                 = 'site1'
            SitesExcluded                 = 'site2'
            Cost                          = 100
            ReplicationFrequencyInMinutes = 20
            OptionChangeNotification      = $true
            OptionTwoWaySync              = $true
            OptionDisableCompression      = $true
            Ensure                        = 'Present'
        }
    }
}
```

