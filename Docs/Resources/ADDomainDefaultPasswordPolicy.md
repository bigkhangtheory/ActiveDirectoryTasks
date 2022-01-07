# ADDomainDefaultPasswordPolicy

## Parameters

| Parameter                       | Attribute  | DataType         | Description                                                                                      | Allowed Values |
| ------------------------------- | ---------- | ---------------- | ------------------------------------------------------------------------------------------------ | -------------- |
| **DomainName**                  | *Required* | `[String]`       | Name of the domain to which the password policy will be applied.                                 |                |
| **ComplexityEnabled**           |            | `[Boolean]`      | Whether password complexity is enabled for the default password policy.                          |                |
| **LockoutDuration**             |            | `[UInt32]`       | Length of time that an account is locked after the number of failed login attempts (minutes).    |                |
| **LockoutObservationWindow**    |            | `[UInt32]`       | Maximum time between two unsuccessful login attempts before the counter is reset to 0 (minutes). |                |
| **LockoutThreshold**            |            | `[UInt32]`       | Number of unsuccessful login attempts that are permitted before an account is locked out.        |                |
| **MinPasswordAge**              |            | `[UInt32]`       | Minimum length of time that you can have the same password (minutes).                            |                |
| **MaxPasswordAge**              |            | `[UInt32]`       | Maximum length of time that you can have the same password (minutes).                            |                |
| **MinPasswordLength**           |            | `[UInt32]`       | Minimum number of characters that a password must contain.                                       |                |
| **PasswordHistoryCount**        |            | `[UInt32]`       | Number of previous passwords to remember.                                                        |                |
| **ReversibleEncryptionEnabled** |            | `[Boolean]`      | Whether the directory must store passwords using reversible encryption.                          |                |
| **DomainController**            |            | `[String]`       | Active Directory domain controller to enact the change upon.                                     |                |
| **Credential**                  |            | `[PSCredential]` | Credentials used to access the domain.                                                           |                |

## Description

The ADDomainDefaultPasswordPolicy DSC resource will manage an Active Directory domain's default password policy.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will set an Active Directory domain's default password
policy to set the minimum password length and complexity.

```powershell
Configuration ADDomainDefaultPasswordPolicy_ConfigureDefaultPasswordPolicy_Config
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DomainName,

        [Parameter(Mandatory = $true)]
        [System.Boolean]
        $ComplexityEnabled,

        [Parameter(Mandatory = $true)]
        [System.Int32]
        $MinPasswordLength
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADDomainDefaultPasswordPolicy 'DefaultPasswordPolicy'
        {
            DomainName        = $DomainName
            ComplexityEnabled = $ComplexityEnabled
            MinPasswordLength = $MinPasswordLength
        }
    }
}
```

