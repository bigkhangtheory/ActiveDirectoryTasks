# ActiveDirectoryUsers

This DSC configuration creates and manages User objects within Active Directory.

<br />

## Project Information

|                  |                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryUsers |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                    |
| **Resources**    | [ADUser][ADUser], [xWindowsFeature][xWindowsFeature]                                                                      |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryUsers`

| Parameter      | Attribute  | DataType         | Description                                                         | Allowed Values |
| :------------- | :--------- | :--------------- | :------------------------------------------------------------------ | :------------- |
| **DomainDn**   | *Required* | `[String]`       | Distinguished Name (DN) of the domain.                              |                |
| **Users**      |            | `[Hashtable[]]`  | List of Active Directory user objects.                              |                |
| **Credential** |            | `[PSCredential]` | Specifies the user account credentials to use to perform this task. |                |

---

#### Table. Attributes of `ActiveDirectoryUsers::Users`

| Parameter                             | Attribute  | DataType         | Description                                                                                                                                                                                                                                                         | Allowed Values         |
| :------------------------------------ | :--------- | :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--------------------- |
| **UserName**                          | *Required* | `[String]`       | Specifies the Security Account Manager (SAM) account name of the user (ldapDisplayName `sAMAccountName`).                                                                                                                                                           |                        |
| **Password**                          |            | `[PSCredential]` | Specifies a new password value for the account.                                                                                                                                                                                                                     |                        |
| **CommonName**                        |            | `[String]`       | Specifies the common name assigned to the user account (ldapDisplayName `cn`). If not specified the default value will be the same value provided in parameter UserName.                                                                                            |                        |
| **UserPrincipalName**                 |            | `[String]`       | Specifies the User Principal Name (UPN) assigned to the user account (ldapDisplayName `userPrincipalName`).                                                                                                                                                         |                        |
| **DisplayName**                       |            | `[String]`       | Specifies the display name of the object (ldapDisplayName `displayName`).                                                                                                                                                                                           |                        |
| **Path**                              |            | `[String]`       | Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created.                                                                                                                                                              |                        |
| **GivenName**                         |            | `[String]`       | Specifies the user's given name (ldapDisplayName `givenName`).                                                                                                                                                                                                      |                        |
| **Initials**                          |            | `[String]`       | Specifies the initials that represent part of a user's name (ldapDisplayName `initials`).                                                                                                                                                                           |                        |
| **Surname**                           |            | `[String]`       | Specifies the user's last name or surname (ldapDisplayName `sn`).                                                                                                                                                                                                   |                        |
| **Description**                       |            | `[String]`       | Specifies a description of the object (ldapDisplayName `description`).                                                                                                                                                                                              |                        |
| **StreetAddress**                     |            | `[String]`       | Specifies the user's street address (ldapDisplayName `streetAddress`).                                                                                                                                                                                              |                        |
| **POBox**                             |            | `[String]`       | Specifies the user's post office box number (ldapDisplayName `postOfficeBox`).                                                                                                                                                                                      |                        |
| **City**                              |            | `[String]`       | Specifies the user's town or city (ldapDisplayName `l`).                                                                                                                                                                                                            |                        |
| **State**                             |            | `[String]`       | Specifies the user's or Organizational Unit's state or province (ldapDisplayName `st`).                                                                                                                                                                             |                        |
| **PostalCode**                        |            | `[String]`       | Specifies the user's postal code or zip code (ldapDisplayName `postalCode`).                                                                                                                                                                                        |                        |
| **Country**                           |            | `[String]`       | Specifies the country or region code for the user's language of choice (ldapDisplayName `c`).                                                                                                                                                                       |                        |
| **Department**                        |            | `[String]`       | Specifies the user's department (ldapDisplayName `department`).                                                                                                                                                                                                     |                        |
| **Division**                          |            | `[String]`       | Specifies the user's division (ldapDisplayName `division`).                                                                                                                                                                                                         |                        |
| **Company**                           |            | `[String]`       | Specifies the user's company (ldapDisplayName `company`).                                                                                                                                                                                                           |                        |
| **Office**                            |            | `[String]`       | Specifies the location of the user's office or place of business (ldapDisplayName `physicalDeliveryOfficeName`).                                                                                                                                                    |                        |
| **JobTitle**                          |            | `[String]`       | Specifies the user's title (ldapDisplayName `title`).                                                                                                                                                                                                               |                        |
| **EmailAddress**                      |            | `[String]`       | Specifies the user's e-mail address (ldapDisplayName `mail`).                                                                                                                                                                                                       |                        |
| **EmployeeID**                        |            | `[String]`       | Specifies the user's employee ID (ldapDisplayName `employeeID`).                                                                                                                                                                                                    |                        |
| **EmployeeNumber**                    |            | `[String]`       | Specifies the user's employee number (ldapDisplayName `employeeNumber`).                                                                                                                                                                                            |                        |
| **HomeDirectory**                     |            | `[String]`       | Specifies a user's home directory path (ldapDisplayName `homeDirectory`).                                                                                                                                                                                           |                        |
| **HomeDrive**                         |            | `[String]`       | Specifies a drive that is associated with the UNC path defined by the HomeDirectory property (ldapDisplayName `homeDrive`).                                                                                                                                         |                        |
| **HomePage**                          |            | `[String]`       | Specifies the URL of the home page of the object (ldapDisplayName `wWWHomePage`).                                                                                                                                                                                   |                        |
| **ProfilePath**                       |            | `[String]`       | Specifies a path to the user's profile (ldapDisplayName `profilePath`).                                                                                                                                                                                             |                        |
| **LogonScript**                       |            | `[String]`       | Specifies a path to the user's log on script (ldapDisplayName `scriptPath`).                                                                                                                                                                                        |                        |
| **Notes**                             |            | `[String]`       | Specifies the notes attached to the user's accoutn (ldapDisplayName `info`).                                                                                                                                                                                        |                        |
| **OfficePhone**                       |            | `[String]`       | Specifies the user's office telephone number (ldapDisplayName `telephoneNumber`).                                                                                                                                                                                   |                        |
| **MobilePhone**                       |            | `[String]`       | Specifies the user's mobile phone number (ldapDisplayName `mobile`).                                                                                                                                                                                                |                        |
| **Fax**                               |            | `[String]`       | Specifies the user's fax phone number (ldapDisplayName `facsimileTelephoneNumber`).                                                                                                                                                                                 |                        |
| **HomePhone**                         |            | `[String]`       | Specifies the user's home telephone number (ldapDisplayName `homePhone`).                                                                                                                                                                                           |                        |
| **Pager**                             |            | `[String]`       | Specifies the user's pager number (ldapDisplayName `pager`).                                                                                                                                                                                                        |                        |
| **IPPhone**                           |            | `[String]`       | Specifies the user's IP telephony phone number (ldapDisplayName `ipPhone`).                                                                                                                                                                                         |                        |
| **Manager**                           |            | `[String]`       | Specifies the user's manager specified as a Distinguished Name (ldapDisplayName `manager`).                                                                                                                                                                         |                        |
| **LogonWorkstations**                 |            | `[String]`       | Specifies the computers that the user can access. To specify more than one computer, create a single comma-separated list. Computers are identified by using the Security Account Manager (SAM) account name (sAMAccountName) or the DNS host name of the computer. |                        |
| **Organization**                      |            | `[String]`       | Specifies the user's organization. This parameter sets the Organization property of a user object. The LDAP display name (ldapDisplayName) of this property is 'o'.                                                                                                 |                        |
| **OtherName**                         |            | `[String]`       | Specifies a name in addition to a user's given name and surname, such as the user's middle name. This parameter sets the OtherName property of a user object. The LDAP display name (ldapDisplayName) of this property is 'middleName'.                             |                        |
| **Enabled**                           |            | `[Boolean]`      | Specifies if the account is enabled. Default value is $true.                                                                                                                                                                                                        |                        |
| **CannotChangePassword**              |            | `[Boolean]`      | Specifies whether the account password can be changed.                                                                                                                                                                                                              |                        |
| **ChangePasswordAtLogon**             |            | `[Boolean]`      | Specifies whether the account password must be changed during the next logon attempt. This will only be enabled when the user is initially created. This parameter cannot be set to $true if the parameter PasswordNeverExpires is also set to $true.               |                        |
| **PasswordNeverExpires**              |            | `[Boolean]`      | Specifies whether the password of an account can expire.                                                                                                                                                                                                            |                        |
| **DomainController**                  |            | `[String]`       | Specifies the Active Directory Domain Services instance to use to perform the task.                                                                                                                                                                                 |                        |
| **PasswordAuthentication**            |            | `[String]`       | Specifies the authentication context type used when testing passwords. Default value is `Default`.                                                                                                                                                                  | `Default`, `Negotiate` |
| **PasswordNeverResets**               |            | `[Boolean]`      | Specifies whether existing user's password should be reset. Default value is $false.                                                                                                                                                                                |                        |
| **TrustedForDelegation**              |            | `[Boolean]`      | Specifies whether an account is trusted for Kerberos delegation. Default value is $false.                                                                                                                                                                           |                        |
| **RestoreFromRecycleBin**             |            | `[Boolean]`      | Try to restore the user object from the recycle bin before creating a new one.                                                                                                                                                                                      |                        |
| **ServicePrincipalNames**             |            | `[String[]]`     | Specifies the service principal names for the user account.                                                                                                                                                                                                         |                        |
| **ProxyAddresses**                    |            | `[String[]]`     | Specifies the proxy addresses for the user account.                                                                                                                                                                                                                 |                        |
| **AccountNotDelegated**               |            | `[Boolean]`      | Indicates whether the security context of the user is delegated to a service.  When this parameter is set to true, the security context of the account is not delegated to a service even when the service account is set as trusted for Kerberos delegation.       |                        |
| **AllowReversiblePasswordEncryption** |            | `[Boolean]`      | Indicates whether reversible password encryption is allowed for the account. This parameter sets the `AllowReversiblePasswordEncryption` property of the account.                                                                                                   |                        |
| **CompoundIdentitySupported**         |            | `[Boolean]`      | Specifies whether an account supports Kerberos service tickets which includes the authorization data for the user's device.                                                                                                                                         |                        |
| **PasswordNotRequired**               |            | `[Boolean]`      | Specifies whether the account requires a password. A password is not required for a new account. This parameter sets the PasswordNotRequired property of an account object.                                                                                         |                        |
| **SmartcardLogonRequired**            |            | `[Boolean]`      | Specifies whether a smart card is required to logon. This parameter sets the SmartCardLoginRequired property for a user object. This parameter also sets the ADS_UF_SMARTCARD_REQUIRED flag of the Active Directory User Account Control attribute.                 |                        |
| **ThumbnailPhoto**                    |            | `[String]`       | Specifies the thumbnail photo to be used for the user object. Can be set either to a path pointing to a .jpg-file, or to a Base64-encoded jpeg image.                                                                                                               |                        |
| **MemberOf**                          |            | `[String[]]`     | Specify Active Directory group memberhips for the user-based service account.                                                                                                                                                                                       |                        |
| **Ensure**                            |            | `[String]`       | Specifies whether the user account should be present or absent. Default value is `Present`.                                                                                                                                                                         | `Present`, `Absent`    |

---

<br />

## Example `ActiveDirectoryUsers`

```yaml
ActiveDirectoryUsers:
  DomainDN: DC=example,DC=com
  Users:
    - UserName: test1
      Password: '[ENC=PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uUFNDdXN0b21PYmplY3Q8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPE1TPg0KICAgICAgPE9iaiBOPSJLZXlEYXRhIiBSZWZJZD0iMSI+DQogICAgICAgIDxUTiBSZWZJZD0iMSI+DQogICAgICAgICAgPFQ+U3lzdGVtLk9iamVjdFtdPC9UPg0KICAgICAgICAgIDxUPlN5c3RlbS5BcnJheTwvVD4NCiAgICAgICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgICAgICA8L1ROPg0KICAgICAgICA8TFNUPg0KICAgICAgICAgIDxPYmogUmVmSWQ9IjIiPg0KICAgICAgICAgICAgPFROUmVmIFJlZklkPSIwIiAvPg0KICAgICAgICAgICAgPE1TPg0KICAgICAgICAgICAgICA8UyBOPSJIYXNoIj44MDg1MzBFQzZDOUMyNENEODIzMjEyMkNBNDAwQUQyQjA4RUYwQTA0QjlGQzM2NUQxOUY1NTY3MjdEQjNDOUJEPC9TPg0KICAgICAgICAgICAgICA8STMyIE49Ikl0ZXJhdGlvbkNvdW50Ij41MDAwMDwvSTMyPg0KICAgICAgICAgICAgICA8QkEgTj0iS2V5Ij5leUt6OUNtWjhFRUoyVmlqR1dhYVVodW9IcEtCeEd6SmZza3F1L3JicWxXZzVoVXkwYWd5QW1xZnI5WWExbDAxPC9CQT4NCiAgICAgICAgICAgICAgPEJBIE49Ikhhc2hTYWx0Ij5nQ3NLTldCTUdRMjF0Smc1QVA1UXcyRGdoWDZpTkx2cy8vZHFQbE5PNExnPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJTYWx0Ij54OVhLaTVPRVg3SXRsbnQySkRPY0tJdlNZLzN1V2dOQjBjWFpaSitpWjZBPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJJViI+NUVpcFhyeVBSeDA3dDI2dk1mNGlPR0dURldiT2tzVDdraHRxcjNiM1NsND08L0JBPg0KICAgICAgICAgICAgPC9NUz4NCiAgICAgICAgICA8L09iaj4NCiAgICAgICAgPC9MU1Q+DQogICAgICA8L09iaj4NCiAgICAgIDxCQSBOPSJDaXBoZXJUZXh0Ij54OUp0WXZDbXFKQmpaVitqNmQxK3VUazBEM0FiZ3cvMTRJbk5EMEN2ZXZCVTlkUG5tL091WFR4bWdGVVQzaUlMdGYzRnNxQ0VVc29wYkhSaHBPdjE5dz09PC9CQT4NCiAgICAgIDxCQSBOPSJITUFDIj5pR3FoYkYwR0w5NUF6bDFSTVhMa0twQ2VNRXcwa29QeGtJd1NzMVczWU9vPTwvQkE+DQogICAgICA8UyBOPSJUeXBlIj5TeXN0ZW0uTWFuYWdlbWVudC5BdXRvbWF0aW9uLlBTQ3JlZGVudGlhbDwvUz4NCiAgICA8L01TPg0KICA8L09iaj4NCjwvT2Jqcz4=]'
      MemberOf:
        - Domain Users
    - UserName: test2
      Password: '[ENC=PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uUFNDdXN0b21PYmplY3Q8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPE1TPg0KICAgICAgPE9iaiBOPSJLZXlEYXRhIiBSZWZJZD0iMSI+DQogICAgICAgIDxUTiBSZWZJZD0iMSI+DQogICAgICAgICAgPFQ+U3lzdGVtLk9iamVjdFtdPC9UPg0KICAgICAgICAgIDxUPlN5c3RlbS5BcnJheTwvVD4NCiAgICAgICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgICAgICA8L1ROPg0KICAgICAgICA8TFNUPg0KICAgICAgICAgIDxPYmogUmVmSWQ9IjIiPg0KICAgICAgICAgICAgPFROUmVmIFJlZklkPSIwIiAvPg0KICAgICAgICAgICAgPE1TPg0KICAgICAgICAgICAgICA8UyBOPSJIYXNoIj44MDg1MzBFQzZDOUMyNENEODIzMjEyMkNBNDAwQUQyQjA4RUYwQTA0QjlGQzM2NUQxOUY1NTY3MjdEQjNDOUJEPC9TPg0KICAgICAgICAgICAgICA8STMyIE49Ikl0ZXJhdGlvbkNvdW50Ij41MDAwMDwvSTMyPg0KICAgICAgICAgICAgICA8QkEgTj0iS2V5Ij5leUt6OUNtWjhFRUoyVmlqR1dhYVVodW9IcEtCeEd6SmZza3F1L3JicWxXZzVoVXkwYWd5QW1xZnI5WWExbDAxPC9CQT4NCiAgICAgICAgICAgICAgPEJBIE49Ikhhc2hTYWx0Ij5nQ3NLTldCTUdRMjF0Smc1QVA1UXcyRGdoWDZpTkx2cy8vZHFQbE5PNExnPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJTYWx0Ij54OVhLaTVPRVg3SXRsbnQySkRPY0tJdlNZLzN1V2dOQjBjWFpaSitpWjZBPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJJViI+NUVpcFhyeVBSeDA3dDI2dk1mNGlPR0dURldiT2tzVDdraHRxcjNiM1NsND08L0JBPg0KICAgICAgICAgICAgPC9NUz4NCiAgICAgICAgICA8L09iaj4NCiAgICAgICAgPC9MU1Q+DQogICAgICA8L09iaj4NCiAgICAgIDxCQSBOPSJDaXBoZXJUZXh0Ij54OUp0WXZDbXFKQmpaVitqNmQxK3VUazBEM0FiZ3cvMTRJbk5EMEN2ZXZCVTlkUG5tL091WFR4bWdGVVQzaUlMdGYzRnNxQ0VVc29wYkhSaHBPdjE5dz09PC9CQT4NCiAgICAgIDxCQSBOPSJITUFDIj5pR3FoYkYwR0w5NUF6bDFSTVhMa0twQ2VNRXcwa29QeGtJd1NzMVczWU9vPTwvQkE+DQogICAgICA8UyBOPSJUeXBlIj5TeXN0ZW0uTWFuYWdlbWVudC5BdXRvbWF0aW9uLlBTQ3JlZGVudGlhbDwvUz4NCiAgICA8L01TPg0KICA8L09iaj4NCjwvT2Jqcz4=]'
      MemberOf:
        - Domain Admins
        - Domain Users
  Credential: '[ENC=PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uUFNDdXN0b21PYmplY3Q8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPE1TPg0KICAgICAgPE9iaiBOPSJLZXlEYXRhIiBSZWZJZD0iMSI+DQogICAgICAgIDxUTiBSZWZJZD0iMSI+DQogICAgICAgICAgPFQ+U3lzdGVtLk9iamVjdFtdPC9UPg0KICAgICAgICAgIDxUPlN5c3RlbS5BcnJheTwvVD4NCiAgICAgICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgICAgICA8L1ROPg0KICAgICAgICA8TFNUPg0KICAgICAgICAgIDxPYmogUmVmSWQ9IjIiPg0KICAgICAgICAgICAgPFROUmVmIFJlZklkPSIwIiAvPg0KICAgICAgICAgICAgPE1TPg0KICAgICAgICAgICAgICA8UyBOPSJIYXNoIj44MDg1MzBFQzZDOUMyNENEODIzMjEyMkNBNDAwQUQyQjA4RUYwQTA0QjlGQzM2NUQxOUY1NTY3MjdEQjNDOUJEPC9TPg0KICAgICAgICAgICAgICA8STMyIE49Ikl0ZXJhdGlvbkNvdW50Ij41MDAwMDwvSTMyPg0KICAgICAgICAgICAgICA8QkEgTj0iS2V5Ij5leUt6OUNtWjhFRUoyVmlqR1dhYVVodW9IcEtCeEd6SmZza3F1L3JicWxXZzVoVXkwYWd5QW1xZnI5WWExbDAxPC9CQT4NCiAgICAgICAgICAgICAgPEJBIE49Ikhhc2hTYWx0Ij5nQ3NLTldCTUdRMjF0Smc1QVA1UXcyRGdoWDZpTkx2cy8vZHFQbE5PNExnPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJTYWx0Ij54OVhLaTVPRVg3SXRsbnQySkRPY0tJdlNZLzN1V2dOQjBjWFpaSitpWjZBPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJJViI+NUVpcFhyeVBSeDA3dDI2dk1mNGlPR0dURldiT2tzVDdraHRxcjNiM1NsND08L0JBPg0KICAgICAgICAgICAgPC9NUz4NCiAgICAgICAgICA8L09iaj4NCiAgICAgICAgPC9MU1Q+DQogICAgICA8L09iaj4NCiAgICAgIDxCQSBOPSJDaXBoZXJUZXh0Ij54OUp0WXZDbXFKQmpaVitqNmQxK3VUazBEM0FiZ3cvMTRJbk5EMEN2ZXZCVTlkUG5tL091WFR4bWdGVVQzaUlMdGYzRnNxQ0VVc29wYkhSaHBPdjE5dz09PC9CQT4NCiAgICAgIDxCQSBOPSJITUFDIj5pR3FoYkYwR0w5NUF6bDFSTVhMa0twQ2VNRXcwa29QeGtJd1NzMVczWU9vPTwvQkE+DQogICAgICA8UyBOPSJUeXBlIj5TeXN0ZW0uTWFuYWdlbWVudC5BdXRvbWF0aW9uLlBTQ3JlZGVudGlhbDwvUz4NCiAgICA8L01TPg0KICA8L09iaj4NCjwvT2Jqcz4=]'

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryUsers:
    merge_hash: deep
  ActiveDirectoryUsers\Users:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - UserName

```

<br />

[ActiveDirectoryDsc]: https://github.com/dsccommunity/ActiveDirectoryDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[ADComputer]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADComputer
[ADDomain]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomain
[ADDomainController]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainController
[ADDomainControllerProperties]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainControllerProperties
[ADDomainDefaultPasswordPolicy]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainDefaultPasswordPolicy
[ADDomainFunctionalLevel]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainFunctionalLevel
[ADDomainTrust]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADDomainTrust
[ADForestFunctionalLevel]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADForestFunctionalLevel
[ADForestProperties]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADForestProperties
[ADGroup]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADGroup
[ADKDSKey]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADKDSKey
[ADManagedServiceAccount]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADManagedServiceAccount
[ADObjectEnabledState]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADObjectEnabledState
[ADObjectPermissionEntry]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADObjectPermissionEntry
[ADOptionalFeature]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADOptionalFeature
[ADOrganizationalUnit]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADOrganizationalUnit
[ADReplicationSite]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADReplicationSite
[ADReplicationSiteLink]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADReplicationSiteLink
[ADReplicationSubnet]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADReplicationSubnet
[ADServicePrincipalName]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADServicePrincipalName
[ADUser]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/ADUser
[WaitForADDomain]: https://github.com/dsccommunity/ActiveDirectoryDsc/wiki/WaitForADDomain
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
