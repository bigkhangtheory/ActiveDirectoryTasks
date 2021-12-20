# ADReplicationSite

## Parameters

| Parameter                      | Attribute  | DataType    | Description                                                                                                                                                                                  | Allowed Values  |
| ------------------------------ | ---------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| **Ensure**                     | *Optional* | `[String]`  | Specifies if the Active Directory replication site should be present or absent. Default value is 'Present'.                                                                                  | Present, Absent |
| **Name**                       | *Required* | `[String]`  | Specifies the name of the Active Directory replication site.                                                                                                                                 |                 |
| **RenameDefaultFirstSiteName** | *Optional* | `[Boolean]` | Specifies if the Default-First-Site-Name should be renamed if it exists. Default value is $false.                                                                                            |                 |
| **Description**                | *Optional* | `[String]`  | Specifies a description of the object. This parameter sets the value of the Description property for the object. The LDAP Display Name (ldapDisplayName) for this property is 'description'. |                 |

## Description

The ADReplicationSite DSC resource will manage Replication Sites within Active Directory. Sites are used in Active Directory to either enable clients to discover network resources (published shares, domain controllers) close to the physical location of a client computer or to reduce network traffic over wide area network (WAN) links. Sites can also be used to optimize replication between domain controllers.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will create an Active Directory replication site
called 'Seattle'.

```powershell
Configuration ADReplicationSite_CreateADReplicationSite_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADReplicationSite 'SeattleSite'
        {
            Ensure = 'Present'
            Name   = 'Seattle'
        }
    }
}
```

### Example 2

This configuration will create an Active Directory replication site called
'Seattle'. If the 'Default-First-Site-Name' site exists, it will rename
this site instead of create a new one.

```powershell
Configuration ADReplicationSite_CreateADReplicationSiteRenameDefault_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADReplicationSite 'SeattleSite'
        {
            Ensure                     = 'Present'
            Name                       = 'Seattle'
            RenameDefaultFirstSiteName = $true
        }
    }
}
```

### Example 3

This configuration will remove the Active Directory replication site
called 'Cupertino'.

```powershell
Configuration ADReplicationSite_RemoveADReplicationSite_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADReplicationSite 'CupertinoSite'
        {
            Ensure = 'Absent'
            Name   = 'Cupertino'
        }
    }
}
```

