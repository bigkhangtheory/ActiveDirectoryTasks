# ADServicePrincipalName

## Parameters

| Parameter                | Attribute  | DataType   | Description                                                                                                                                                    | Allowed Values  |
| ------------------------ | ---------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| **Ensure**               |            | `[String]` | Specifies if the service principal name should be added or removed. Default value is 'Present'.                                                                | Present, Absent |
| **ServicePrincipalName** | *Required* | `[String]` | The full SPN to add or remove, e.g. HOST/LON-DC1.                                                                                                              |                 |
| **Account**              |            | `[String]` | The user or computer account to add or remove the SPN to, e.g. User1 or LON-DC1$. Default value is ''. If Ensure is set to Present, a value must be specified. |                 |

## Description

The ADServicePrincipalName DSC resource will manage service principal names. A service principal name (SPN) is a unique identifier of a service instance. SPNs are used by Kerberos authentication to associate a service instance with a service logon account. This allows a client application to request that the service authenticate an account even if the client does not have the account name.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will add a Service Principal Name to a user account.

```powershell
Configuration ADServicePrincipalName_AddUserServicePrincipalName_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADServicePrincipalName 'SQL01Svc'
        {
            ServicePrincipalName = 'MSSQLSvc/sql01.contoso.com:1433'
            Account              = 'SQL01Svc'
        }
    }
}
```

### Example 2

This configuration will add a Service Principal Name to a computer account.

```powershell
Configuration ADServicePrincipalName_AddComputerServicePrincipalName_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADServicePrincipalName 'web.contoso.com'
        {
            ServicePrincipalName = 'HTTP/web.contoso.com'
            Account              = 'IIS01$'
        }
    }
}
```

