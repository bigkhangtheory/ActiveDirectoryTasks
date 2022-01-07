# WaitForADDomain

## Parameters

| Parameter                   | Attribute  | DataType         | Description                                                                                                                                                                                                                                                                        | Allowed Values |
| --------------------------- | ---------- | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **DomainName**              | *Required* | `[String]`       | Specifies the fully qualified domain name to wait for.                                                                                                                                                                                                                             |                |
| **SiteName**                |            | `[String]`       | Specifies the site in the domain where to look for a domain controller.                                                                                                                                                                                                            |                |
| **Credential**              |            | `[PSCredential]` | Specifies the credentials that are used when accessing the domain, unless the built-in PsDscRunAsCredential is used.                                                                                                                                                               |                |
| **WaitTimeout**             |            | `[UInt64]`       | Specifies the timeout in seconds that the resource will wait for the domain to be accessible. Default value is 300 seconds.                                                                                                                                                        |                |
| **RestartCount**            |            | `[UInt32]`       | Specifies the number of times the node will be reboot in an effort to connect to the domain.                                                                                                                                                                                       |                |
| **WaitForValidCredentials** |            | `[Boolean]`      | Specifies that the resource will not throw an error if authentication fails using the provided credentials and continue wait for the timeout. This can be used if the credentials are known to eventually exist but there are a potential timing issue before they are accessible. |                |
| **IsAvailable**             | Read       | `[Boolean]`      | Returns a value indicating if a domain controller was found.                                                                                                                                                                                                                       |                |

## Description

The WaitForADDomain resource is used to wait for Active Directory domain
controller to become available in the domain, or available in
a specific site in the domain.

>Running the resource as *NT AUTHORITY\SYSTEM*, only work when
>evaluating the domain on the current node, for example on a
>node that should be a domain controller (which might require a
>restart of the node once the node becomes a domain controller).
>In all other scenarios use either the built-in parameter
>`PsDscRunAsCredential`, or the parameter `Credential`.

Using the parameter `WaitForValidCredentials` ignores authentication
errors a let the resource wait until time timeout is reached. If the
parameter `WaitForValidCredentials` is not specified and the resource
throws an authentication error, then the resource will fail. But the
Local Configuration Manger (LCM) will automatically run the configuration
again to try to get the node in desired state. If and when the LCM retries
depends on how the LCM is configured.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will wait for an Active Directory domain controller
to respond within 300 seconds (default) in the domain 'contoso.com'
before returning and allowing the configuration to continue to run.
If the timeout is reached an error will be thrown.
This will use the current user when determining if the domain is available,
if run though LCM this will use SYSTEM (which might not have access).

```powershell
Configuration WaitForADDomain_WaitForDomainController_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        WaitForADDomain 'contoso.com'
        {
            DomainName = 'contoso.com'
        }
    }
}
```

### Example 2

This configuration will wait for an Active Directory domain controller
to respond within 300 seconds (default) in the domain 'contoso.com'
before returning and allowing the configuration to continue to run.
If the timeout is reached an error will be thrown.
This will use the user credential passed in the built-in PsDscRunAsCredential
parameter when determining if the domain is available.

```powershell
Configuration WaitForADDomain_WaitForDomainControllerUsingBuiltInCredential_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        WaitForADDomain 'contoso.com'
        {
            DomainName           = 'contoso.com'

            PsDscRunAsCredential = $Credential
        }
    }
}
```

### Example 3

This configuration will wait for an Active Directory domain controller
to respond within 300 seconds (default) in the domain 'contoso.com'
before returning and allowing the configuration to continue to run.
If the timeout is reached an error will be thrown.
This will use the user credential passed in the parameter Credential
when determining if the domain is available.

```powershell
Configuration WaitForADDomain_WaitForDomainControllerUsingCredential_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        WaitForADDomain 'contoso.com'
        {
            DomainName = 'contoso.com'
            Credential = $Credential
        }
    }
}
```

### Example 4

This configuration will wait for an Active Directory domain controller
in the site 'Europe' to respond within 300 seconds (default) in the
domain 'contoso.com' before returning and allowing the configuration to
continue to run.
If the timeout is reached an error will be thrown.
This will use the user credential passed in the built-in PsDscRunAsCredential
parameter when determining if the domain is available.

```powershell
Configuration WaitForADDomain_WaitForDomainControllerInSite_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        WaitForADDomain 'contoso.com'
        {
            DomainName           = 'contoso.com'
            SiteName             = 'Europe'

            PsDscRunAsCredential = $Credential
        }
    }
}
```

### Example 5

This configuration will wait for an Active Directory domain controller
to respond within 300 seconds (default) in the domain 'contoso.com'
before returning and allowing the configuration to continue to run.
If the timeout is reached the node will be restarted up to two times
and again wait after each restart. If no domain controller is found
after the second restart an error will be thrown.
This will use the user credential passed in the built-in PsDscRunAsCredential
parameter when determining if the domain is available.

```powershell
Configuration WaitForADDomain_WaitForDomainControllerWithReboot_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        WaitForADDomain 'contoso.com'
        {
            DomainName           = 'contoso.com'
            RestartCount         = 2

            PsDscRunAsCredential = $Credential
        }
    }
}
```

### Example 6

This configuration will wait for an Active Directory domain controller
to respond within 600 seconds in the domain 'contoso.com' before
returning and allowing the configuration to continue to run. If the timeout
is reached an error will be thrown.
This will use the user credential passed in the built-in PsDscRunAsCredential
parameter when determining if the domain is available.

```powershell
Configuration WaitForADDomain_WaitForDomainControllerWithLongerDelay_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        WaitForADDomain 'contoso.com'
        {
            DomainName           = 'contoso.com'
            WaitTimeout          = 600

            PsDscRunAsCredential = $Credential
        }
    }
}
```

### Example 7

This configuration will wait for an Active Directory domain controller
to respond within the default period, and ignore any authentication
errors.

```powershell
Configuration WaitForADDomain_WaitForDomainControllerIgnoringAuthenticationErrors_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        WaitForADDomain 'contoso.com'
        {
            DomainName              = 'contoso.com'
            WaitForValidCredentials = $true

            PsDscRunAsCredential    = $Credential
        }
    }
}
```

