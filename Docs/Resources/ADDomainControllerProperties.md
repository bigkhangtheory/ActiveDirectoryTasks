# ADDomainControllerProperties

## Parameters

| Parameter            | Attribute  | DataType   | Description                                                                                                                                                                                                                                                                                 | Allowed Values |
| -------------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **IsSingleInstance** | *Required* | `[String]` | Specifies the resource is a single instance, the value must be 'Yes'.                                                                                                                                                                                                                       | Yes            |
| **ContentFreshness** |            | `[UInt32]` | Specifies the Distributed File System Replication (DFSR) server threshold after the number of days its content is considered stale (MaxOfflineTimeInDays). Once the content is considered stale, the Distributed File System Replication (DFSR) server will no longer be able to replicate. |                |

## Description

This resource enforces the single instance properties of a domain controller.
*Properties that must always have a value, but the value can be changed.*

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will set the content freshness to 100 days.

```powershell
Configuration ADDomainControllerProperties_SetContentFreshness_Config
{
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADDomainControllerProperties 'ContentFreshness'
        {
            IsSingleInstance = 'Yes'
            ContentFreshness = 100
        }
    }
}
```

