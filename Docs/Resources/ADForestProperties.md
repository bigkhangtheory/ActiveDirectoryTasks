# ADForestProperties

## Parameters

| Parameter                              | Attribute  | DataType         | Description                                                                                                                                                                                                                           | Allowed Values |
| -------------------------------------- | ---------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **Credential**                         |            | `[PSCredential]` | Specifies the user account credentials to use to perform this task.                                                                                                                                                                   |                |
| **ForestName**                         | *Required* | `[String]`       | Specifies the target Active Directory forest for the change.                                                                                                                                                                          |                |
| **ServicePrincipalNameSuffix**         |            | `[String[]]`     | Specifies the Service Principal Name (SPN) Suffix(es) to be explicitly defined in the forest and replace existing Service Principal Names. Cannot be used with ServicePrincipalNameSuffixToAdd or ServicePrincipalNameSuffixToRemove. |                |
| **ServicePrincipalNameSuffixToAdd**    |            | `[String[]]`     | Specifies the Service Principal Name (SPN) Suffix(es) to be added to the forest. Cannot be used with ServicePrincipalNameSuffix.                                                                                                      |                |
| **ServicePrincipalNameSuffixToRemove** |            | `[String[]]`     | Specifies the Service Principal Name (SPN) Suffix(es) to be removed from the forest. Cannot be used with ServicePrincipalNameSuffix.                                                                                                  |                |
| **TombStoneLifetime**                  |            | SInt32           | Specifies the AD Tombstone lifetime which determines how long deleted items exist in Active Directory before they are purged.                                                                                                         |                |
| **UserPrincipalNameSuffix**            |            | `[String[]]`     | Specifies the User Principal Name (UPN) Suffix(es) to be explicitly defined in the forest and replace existing User Principal Names. Cannot be used with UserPrincipalNameSuffixToAdd or UserPrincipalNameSuffixToRemove.             |                |
| **UserPrincipalNameSuffixToAdd**       |            | `[String[]]`     | Specifies the User Principal Name (UPN) Suffix(es) to be added to the forest. Cannot be used with UserPrincipalNameSuffix.                                                                                                            |                |
| **UserPrincipalNameSuffixToRemove**    |            | `[String[]]`     | Specifies the User Principal Name (UPN) Suffix(es) to be removed from the forest. Cannot be used with UserPrincipalNameSuffix.                                                                                                        |                |

## Description

The ADForestProperties DSC resource will manage forest wide settings within an Active Directory forest.
These include User Principal Name (UPN) suffixes, Service Principal Name (SPN) suffixes and the tombstone lifetime.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will manage the Service and User Principal name suffixes
in the forest by replacing any existing suffixes with the ones specified
in the configuration.

```powershell
Configuration ADForestProperties_ReplaceForestProperties_Config
{
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node 'localhost'
    {
        ADForestProperties 'contoso.com'
        {
            ForestName                 = 'contoso.com'
            UserPrincipalNameSuffix    = 'fabrikam.com', 'industry.com'
            ServicePrincipalNameSuffix = 'corporate.com'
        }
    }
}
```

### Example 2

This configuration will manage the Service and User Principal name suffixes in
the forest by adding and removing the desired suffixes. This will not overwrite
existing suffixes in the forest.

```powershell
Configuration ADForestProperties_AddRemoveForestProperties_Config
{
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADForestProperties 'ContosoProperties'
        {
            ForestName                         = 'contoso.com'
            ServicePrincipalNameSuffixToAdd    = 'test.net'
            ServicePrincipalNameSuffixToRemove = 'test.com'
            UserPrincipalNameSuffixToAdd       = 'cloudapp.net', 'fabrikam.com'
            UserPrincipalNameSuffixToRemove    = 'pester.net'
        }
    }
}
```

### Example 3

This configuration will manage the Tombstone Lifetime setting of the
Active Directory forest.

```powershell
Configuration ADForestProperties_TombstoneLifetime_Config
{
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADForestProperties 'ContosoProperties'
        {
            ForestName        = 'contoso.com'
            TombstoneLifetime = 200
        }
    }
}
```

