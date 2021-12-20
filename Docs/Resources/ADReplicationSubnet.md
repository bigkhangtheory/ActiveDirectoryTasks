# ADReplicationSubnet

## Parameters

| Parameter       | Attribute  | DataType   | Description                                                                                                      | Allowed Values  |
| --------------- | ---------- | ---------- | ---------------------------------------------------------------------------------------------------------------- | --------------- |
| **Ensure**      | *Optional* | `[String]` | Specifies if the Active Directory replication subnet should be present or absent. Default value is 'Present'.    | Present, Absent |
| **Name**        | *Required* | `[String]` | The name of the Active Directory replication subnet, e.g. 10.0.0.0/24.                                           |                 |
| **Site**        | Required   | `[String]` | The name of the assigned Active Directory replication site, e.g. Default-First-Site-Name.                        |                 |
| **Location**    | *Optional* | `[String]` | The location for the Active Directory replication site. Default value is empty ('') location.                    |                 |
| **Description** | *Optional* | `[String]` | Specifies a description of the object. This parameter sets the value of the Description property for the object. |                 |

## Description

The ADReplicationSubnet DSC resource will manage replication subnets.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will create an AD Replication Subnet.

```powershell
Configuration ADReplicationSubnet_CreateReplicationSubnet_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADReplicationSubnet 'LondonSubnet'
        {
            Name        = '10.0.0.0/24'
            Site        = 'London'
            Location    = 'Datacenter 3'
            Description = 'Datacenter Management Subnet'
        }
    }
}
```

