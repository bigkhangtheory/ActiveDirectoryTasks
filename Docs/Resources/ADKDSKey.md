﻿# ADKDSKey

## Parameters

| Parameter                    | Attribute  | DataType    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Allowed Values  |
| ---------------------------- | ---------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| **EffectiveTime**            | *Required* | `[String]`  | Specifies the Effective time when a KDS root key can be used. There is a 10 hour minimum from creation date to allow active directory to properly replicate across all domain controllers. For this reason, the date must be set in the future for creation. While this parameter accepts a string, it will be converted into a DateTime object. This will also try to take into account cultural settings. Example: '05/01/1999 13:00 using default or 'en-US' culture would be May 1st, but using 'de-DE' culture would be 5th of January. The culture is automatically pulled from the operating system and this can be checked using 'Get-Culture'. |                 |
| **Ensure**                   |            | `[String]`  | Specifies if this KDS Root Key should be present or absent. Default value is 'Present'.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Present, Absent |
| **AllowUnsafeEffectiveTime** |            | `[Boolean]` | This option will allow you to create a KDS root key if EffectiveTime is set in the past. This may cause issues if you are creating a Group Managed Service Account right after you create the KDS Root Key. In order to get around this, you must create the KDS Root Key using a date in the past. This should be used at your own risk and should only be used in lab environments.                                                                                                                                                                                                                                                                   |                 |
| **ForceRemove**              |            | `[Boolean]` | This option will allow you to remove a KDS root key if there is only one key left. It should not break your Group Managed Service Accounts (gMSA), but if the gMSA password expires and it needs to request a new password, it will not be able to generate a new password until a new KDS Root Key is installed and ready for use. Because of this, the last KDS Root Key will not be removed unless this option is specified.                                                                                                                                                                                                                         |                 |
| **DistinguishedName**        | Read       | `[String]`  | Returns the Distinguished Name (DN) of the KDS root key. The KDS Root Key is stored in 'CN=Master Root Keys,CN=Group Key Distribution Service,CN=Services,CN=Configuration' at the Forest level. This is also why replication needs 10 hours to occur before using the KDS Root Key as a safety measure.                                                                                                                                                                                                                                                                                                                                                |                 |
| **CreationTime**             | Read       | DateTime    | Returns the Creation date and time of the KDS root key for informational purposes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |                 |
| **KeyId**                    | Read       | `[String]`  | Returns the KeyID of the KDS root key. This is the Common Name (CN) within Active Directory and is required to build the Distinguished Name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |                 |

## Description

The ADKDSKey DSC resource will manage KDS Root Keys within Active Directory. The KDS root keys are used to begin generating Group Managed Service Account (gMSA) passwords.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will create a KDS root key. If the date is set to a time
slightly ahead in the future, the key won't be usable for at least 10 hours
from the creation time.

```powershell
Configuration ADKDSKey_CreateKDSRootKey_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADKDSKey 'ExampleKDSRootKey'
        {
            Ensure        = 'Present'
            EffectiveTime = '1/1/2030 13:00'
            # Date must be set to at time in the future
        }
    }
}
```

### Example 2

This configuration will create a KDS root key in the past. This will allow
the key to be used right away, but if all the domain controllers haven't
replicated yet, there may be issues when retrieving the gMSA password.
Use with caution

```powershell
Configuration ADKDSKey_CreateKDSRootKeyInPast_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADKDSKey 'ExampleKDSRootKeyInPast'
        {
            Ensure                   = 'Present'
            EffectiveTime            = '1/1/1999 13:00'
            AllowUnsafeEffectiveTime = $true # Use with caution
        }
    }
}
```

### Example 3

This configuration will remove the last KDS root key. Use with caution.
If gMSAs are installed on the network, they will not be able to reset
their passwords and it may cause services to fail.

```powershell
Configuration ADKDSKey_CreateKDSRootKeyRemoveLastKey_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADKDSKey 'ExampleKDSRootKeyForceRemove'
        {
            Ensure        = 'Absent'
            EffectiveTime = '1/1/2030 13:00'
            ForceRemove   = $true # This will allow you to remove the key if it's the last one
        }
    }
}
```

