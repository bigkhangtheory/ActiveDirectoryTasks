# ADUser

## Parameters

| Parameter                             | Attribute  | DataType         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                              | Allowed Values     |
| ------------------------------------- | ---------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------ |
| **DomainName**                        | *Required* | `[String]`       | Name of the domain where the user account is located (only used if password is managed).                                                                                                                                                                                                                                                                                                                                                                                 |                    |
| **UserName**                          | *Required* | `[String]`       | Specifies the Security Account Manager (SAM) account name of the user (ldapDisplayName 'sAMAccountName').                                                                                                                                                                                                                                                                                                                                                                |                    |
| **Password**                          |            | `[PSCredential]` | Specifies a new password value for the account.                                                                                                                                                                                                                                                                                                                                                                                                                          |                    |
| **Ensure**                            |            | `[String]`       | Specifies whether the user account should be present or absent. Default value is 'Present'.                                                                                                                                                                                                                                                                                                                                                                              | Present, Absent    |
| **CommonName**                        |            | `[String]`       | Specifies the common name assigned to the user account (ldapDisplayName 'cn'). If not specified the default value will be the same value provided in parameter UserName.                                                                                                                                                                                                                                                                                                 |                    |
| **UserPrincipalName**                 |            | `[String]`       | Specifies the User Principal Name (UPN) assigned to the user account (ldapDisplayName 'userPrincipalName').                                                                                                                                                                                                                                                                                                                                                              |                    |
| **DisplayName**                       |            | `[String]`       | Specifies the display name of the object (ldapDisplayName 'displayName').                                                                                                                                                                                                                                                                                                                                                                                                |                    |
| **Path**                              |            | `[String]`       | Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created.                                                                                                                                                                                                                                                                                                                                                                   |                    |
| **GivenName**                         |            | `[String]`       | Specifies the user's given name (ldapDisplayName 'givenName').                                                                                                                                                                                                                                                                                                                                                                                                           |                    |
| **Initials**                          |            | `[String]`       | Specifies the initials that represent part of a user's name (ldapDisplayName 'initials').                                                                                                                                                                                                                                                                                                                                                                                |                    |
| **Surname**                           |            | `[String]`       | Specifies the user's last name or surname (ldapDisplayName 'sn').                                                                                                                                                                                                                                                                                                                                                                                                        |                    |
| **Description**                       |            | `[String]`       | Specifies a description of the object (ldapDisplayName 'description').                                                                                                                                                                                                                                                                                                                                                                                                   |                    |
| **StreetAddress**                     |            | `[String]`       | Specifies the user's street address (ldapDisplayName 'streetAddress').                                                                                                                                                                                                                                                                                                                                                                                                   |                    |
| **POBox**                             |            | `[String]`       | Specifies the user's post office box number (ldapDisplayName 'postOfficeBox').                                                                                                                                                                                                                                                                                                                                                                                           |                    |
| **City**                              |            | `[String]`       | Specifies the user's town or city (ldapDisplayName 'l').                                                                                                                                                                                                                                                                                                                                                                                                                 |                    |
| **State**                             |            | `[String]`       | Specifies the user's or Organizational Unit's state or province (ldapDisplayName 'st').                                                                                                                                                                                                                                                                                                                                                                                  |                    |
| **PostalCode**                        |            | `[String]`       | Specifies the user's postal code or zip code (ldapDisplayName 'postalCode').                                                                                                                                                                                                                                                                                                                                                                                             |                    |
| **Country**                           |            | `[String]`       | Specifies the country or region code for the user's language of choice (ldapDisplayName 'c').                                                                                                                                                                                                                                                                                                                                                                            |                    |
| **Department**                        |            | `[String]`       | Specifies the user's department (ldapDisplayName 'department').                                                                                                                                                                                                                                                                                                                                                                                                          |                    |
| **Division**                          |            | `[String]`       | Specifies the user's division (ldapDisplayName 'division').                                                                                                                                                                                                                                                                                                                                                                                                              |                    |
| **Company**                           |            | `[String]`       | Specifies the user's company (ldapDisplayName 'company').                                                                                                                                                                                                                                                                                                                                                                                                                |                    |
| **Office**                            |            | `[String]`       | Specifies the location of the user's office or place of business (ldapDisplayName 'physicalDeliveryOfficeName').                                                                                                                                                                                                                                                                                                                                                         |                    |
| **JobTitle**                          |            | `[String]`       | Specifies the user's title (ldapDisplayName 'title').                                                                                                                                                                                                                                                                                                                                                                                                                    |                    |
| **EmailAddress**                      |            | `[String]`       | Specifies the user's e-mail address (ldapDisplayName 'mail').                                                                                                                                                                                                                                                                                                                                                                                                            |                    |
| **EmployeeID**                        |            | `[String]`       | Specifies the user's employee ID (ldapDisplayName 'employeeID').                                                                                                                                                                                                                                                                                                                                                                                                         |                    |
| **EmployeeNumber**                    |            | `[String]`       | Specifies the user's employee number (ldapDisplayName 'employeeNumber').                                                                                                                                                                                                                                                                                                                                                                                                 |                    |
| **HomeDirectory**                     |            | `[String]`       | Specifies a user's home directory path (ldapDisplayName 'homeDirectory').                                                                                                                                                                                                                                                                                                                                                                                                |                    |
| **HomeDrive**                         |            | `[String]`       | Specifies a drive that is associated with the UNC path defined by the HomeDirectory property (ldapDisplayName 'homeDrive').                                                                                                                                                                                                                                                                                                                                              |                    |
| **HomePage**                          |            | `[String]`       | Specifies the URL of the home page of the object (ldapDisplayName 'wWWHomePage').                                                                                                                                                                                                                                                                                                                                                                                        |                    |
| **ProfilePath**                       |            | `[String]`       | Specifies a path to the user's profile (ldapDisplayName 'profilePath').                                                                                                                                                                                                                                                                                                                                                                                                  |                    |
| **LogonScript**                       |            | `[String]`       | Specifies a path to the user's log on script (ldapDisplayName 'scriptPath').                                                                                                                                                                                                                                                                                                                                                                                             |                    |
| **Notes**                             |            | `[String]`       | Specifies the notes attached to the user's accoutn (ldapDisplayName 'info').                                                                                                                                                                                                                                                                                                                                                                                             |                    |
| **OfficePhone**                       |            | `[String]`       | Specifies the user's office telephone number (ldapDisplayName 'telephoneNumber').                                                                                                                                                                                                                                                                                                                                                                                        |                    |
| **MobilePhone**                       |            | `[String]`       | Specifies the user's mobile phone number (ldapDisplayName 'mobile').                                                                                                                                                                                                                                                                                                                                                                                                     |                    |
| **Fax**                               |            | `[String]`       | Specifies the user's fax phone number (ldapDisplayName 'facsimileTelephoneNumber').                                                                                                                                                                                                                                                                                                                                                                                      |                    |
| **HomePhone**                         |            | `[String]`       | Specifies the user's home telephone number (ldapDisplayName 'homePhone').                                                                                                                                                                                                                                                                                                                                                                                                |                    |
| **Pager**                             |            | `[String]`       | Specifies the user's pager number (ldapDisplayName 'pager').                                                                                                                                                                                                                                                                                                                                                                                                             |                    |
| **IPPhone**                           |            | `[String]`       | Specifies the user's IP telephony phone number (ldapDisplayName 'ipPhone').                                                                                                                                                                                                                                                                                                                                                                                              |                    |
| **Manager**                           |            | `[String]`       | Specifies the user's manager specified as a Distinguished Name (ldapDisplayName 'manager').                                                                                                                                                                                                                                                                                                                                                                              |                    |
| **LogonWorkstations**                 |            | `[String]`       | Specifies the computers that the user can access. To specify more than one computer, create a single comma-separated list. You can identify a computer by using the Security Account Manager (SAM) account name (sAMAccountName) or the DNS host name of the computer. The SAM account name is the same as the NetBIOS name of the computer. The LDAP display name (ldapDisplayName) for this property is userWorkStations.                                              |                    |
| **Organization**                      |            | `[String]`       | Specifies the user's organization. This parameter sets the Organization property of a user object. The LDAP display name (ldapDisplayName) of this property is 'o'.                                                                                                                                                                                                                                                                                                      |                    |
| **OtherName**                         |            | `[String]`       | Specifies a name in addition to a user's given name and surname, such as the user's middle name. This parameter sets the OtherName property of a user object. The LDAP display name (ldapDisplayName) of this property is 'middleName'.                                                                                                                                                                                                                                  |                    |
| **Enabled**                           |            | `[Boolean]`      | Specifies if the account is enabled. Default value is $true.                                                                                                                                                                                                                                                                                                                                                                                                             |                    |
| **CannotChangePassword**              |            | `[Boolean]`      | Specifies whether the account password can be changed.                                                                                                                                                                                                                                                                                                                                                                                                                   |                    |
| **ChangePasswordAtLogon**             |            | `[Boolean]`      | Specifies whether the account password must be changed during the next logon attempt. This will only be enabled when the user is initially created. This parameter cannot be set to $true if the parameter PasswordNeverExpires is also set to $true.                                                                                                                                                                                                                    |                    |
| **PasswordNeverExpires**              |            | `[Boolean]`      | Specifies whether the password of an account can expire.                                                                                                                                                                                                                                                                                                                                                                                                                 |                    |
| **DomainController**                  |            | `[String]`       | Specifies the Active Directory Domain Services instance to use to perform the task.                                                                                                                                                                                                                                                                                                                                                                                      |                    |
| **Credential**                        |            | `[PSCredential]` | Specifies the user account credentials to use to perform this task.                                                                                                                                                                                                                                                                                                                                                                                                      |                    |
| **PasswordAuthentication**            |            | `[String]`       | Specifies the authentication context type used when testing passwords. Default value is 'Default'.                                                                                                                                                                                                                                                                                                                                                                       | Default, Negotiate |
| **PasswordNeverResets**               |            | `[Boolean]`      | Specifies whether existing user's password should be reset. Default value is $false.                                                                                                                                                                                                                                                                                                                                                                                     |                    |
| **TrustedForDelegation**              |            | `[Boolean]`      | Specifies whether an account is trusted for Kerberos delegation. Default value is $false.                                                                                                                                                                                                                                                                                                                                                                                |                    |
| **RestoreFromRecycleBin**             |            | `[Boolean]`      | Try to restore the user object from the recycle bin before creating a new one.                                                                                                                                                                                                                                                                                                                                                                                           |                    |
| **ServicePrincipalNames**             |            | `[String[]]`     | Specifies the service principal names for the user account.                                                                                                                                                                                                                                                                                                                                                                                                              |                    |
| **ProxyAddresses**                    |            | `[String[]]`     | Specifies the proxy addresses for the user account.                                                                                                                                                                                                                                                                                                                                                                                                                      |                    |
| **AccountNotDelegated**               |            | `[Boolean]`      | Indicates whether the security context of the user is delegated to a service.  When this parameter is set to true, the security context of the account is not delegated to a service even when the service account is set as trusted for Kerberos delegation. This parameter sets the AccountNotDelegated property for an Active Directory account. This parameter also sets the ADS_UF_NOT_DELEGATED flag of the Active Directory User Account Control (UAC) attribute. |                    |
| **AllowReversiblePasswordEncryption** |            | `[Boolean]`      | Indicates whether reversible password encryption is allowed for the account. This parameter sets the AllowReversiblePasswordEncryption property of the account. This parameter also sets the ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED flag of the Active Directory User Account Control (UAC) attribute.                                                                                                                                                                   |                    |
| **CompoundIdentitySupported**         |            | `[Boolean]`      | Specifies whether an account supports Kerberos service tickets which includes the authorization data for the user's device. This value sets the compound identity supported flag of the Active Directory msDS-SupportedEncryptionTypes attribute.                                                                                                                                                                                                                        |                    |
| **PasswordNotRequired**               |            | `[Boolean]`      | Specifies whether the account requires a password. A password is not required for a new account. This parameter sets the PasswordNotRequired property of an account object.                                                                                                                                                                                                                                                                                              |                    |
| **SmartcardLogonRequired**            |            | `[Boolean]`      | Specifies whether a smart card is required to logon. This parameter sets the SmartCardLoginRequired property for a user object. This parameter also sets the ADS_UF_SMARTCARD_REQUIRED flag of the Active Directory User Account Control attribute.                                                                                                                                                                                                                      |                    |
| **ThumbnailPhoto**                    |            | `[String]`       | Specifies the thumbnail photo to be used for the user object. Can be set either to a path pointing to a .jpg-file, or to a Base64-encoded jpeg image. If set to an empty string ('') the current thumbnail photo will be removed. The property ThumbnailPhoto will always return the image as a Base64-encoded string even if the configuration specified a file path.                                                                                                   |                    |
| **DistinguishedName**                 | Read       | `[String]`       | Returns the X.500 path of the object.                                                                                                                                                                                                                                                                                                                                                                                                                                    |                    |
| **ThumbnailPhotoHash**                | Read       | `[String]`       | Return the MD5 hash of the current thumbnail photo, or $null if no thumbnail photo exist.                                                                                                                                                                                                                                                                                                                                                                                |                    |

## Description

The ADUser DSC resource will manage Users within Active Directory.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.
* The parameter `RestoreFromRecycleBin` requires that the feature Recycle
  Bin has been enabled prior to an object is deleted. If the feature
  Recycle Bin is disabled then the property `msDS-LastKnownRDN` is not
  added the deleted object.

## Examples

### Example 1

This configuration will create a user with a managed password.
This might be used to manage the lifecycle of a service account.

```powershell
Configuration ADUser_CreateUserAndManagePassword_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Password
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADUser 'Contoso\ExampleUser'
        {
            Ensure     = 'Present'
            UserName   = 'ExampleUser'
            Password   = $Password
            DomainName = 'contoso.com'
            Path       = 'CN=Users,DC=contoso,DC=com'
        }
    }
}
```

### Example 2

This configuration will create a user with a password and then ignore
when the password has changed. This might be used with a traditional
user account where a managed password is not desired.

```powershell
Configuration ADUser_CreateUserAndIgnorePasswordChanges_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Password
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADUser 'Contoso\ExampleUser'
        {
            Ensure              = 'Present'
            UserName            = 'ExampleUser'
            Password            = $Password
            PasswordNeverResets = $true
            DomainName          = 'contoso.com'
            Path                = 'CN=Users,DC=contoso,DC=com'
        }
    }
}
```

### Example 3

This configuration will update a user with a thumbnail photo using
a jpeg image encoded as a Base64 string.

```powershell
Configuration ADUser_UpdateThumbnailPhotoAsBase64_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADUser 'Contoso\ExampleUser'
        {
            UserName       = 'ExampleUser'
            DomainName     = 'contoso.com'
            ThumbnailPhoto = '/9j/4AAQSkZJRgABAQEAYABgAAD/4QB .... STRING TRUNCATED FOR LENGTH'
        }
    }
}
```

### Example 4

This configuration will update a user with a thumbnail photo using
a jpeg file.

```powershell
Configuration ADUser_UpdateThumbnailPhotoFromFile_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADUser 'Contoso\ExampleUser'
        {
            UserName       = 'ExampleUser'
            DomainName     = 'contoso.com'
            ThumbnailPhoto = 'C:\ThumbnailPhotos\ExampleUser.jpg'
        }
    }
}
```

### Example 5

This configuration will remove the thumbnail photo from the user.

```powershell
Configuration ADUser_RemoveThumbnailPhoto_Config
{
    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADUser 'Contoso\ExampleUser'
        {
            UserName       = 'ExampleUser'
            DomainName     = 'contoso.com'
            ThumbnailPhoto = ''
        }
    }
}
```

