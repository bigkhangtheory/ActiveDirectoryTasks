# ActiveDirectoryServiceAccounts

The **ActiveDirectoryServiceAccounts** DSC configuration is used to manage and configure service logon accounts within Active Directory.

<br />

## Project Information

|                  |                                                                                                                                      |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://github.com/bigkhangtheory/ActiveDirectoryTasks/tree/master/ActiveDirectoryTasks/DscResources/ActiveDirectoryServiceAccounts. |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                               |
| **Resources**    | [ADUser][ADUser], [ADKDSKey][ADKDSKey], [ADManagedServiceAccount][ADManagedServiceAccount], [xWindowsFeature][xWindowsFeature]       |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryServiceAccounts`

| Parameter                  | Attribute  | DataType        | Description                                               | Allowed Values |
| :------------------------- | :--------- | :-------------- | :-------------------------------------------------------- | :------------- |
| **DomainDn**               | *Required* | `[String]`      | Distinguished Name (DN) of the domain.                    |                |
| **UserServiceAccounts**    |            | `[Hashtable[]]` | List of user-based service accounts.                      |                |
| **KDSKey**                 |            | `[Hashtable[]]` | Specify a KDS Root Key to manage within Active Directory. |                |
| **ManagedServiceAccounts** |            | `[Hashtable[]]` |                                                           |                |

---

#### Table. Attributes of `ActiveDirectoryServiceAccounts::UserServiceAccounts`

| Parameter                | Attribute  | DataType         | Description                                                                                                                                                                       | Allowed Values      |
| ------------------------ | ---------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| **UserName**             | *Required* | `[String]`       | Specifies the Security Account Manager (SAM), `(&(objectClass=User)(sAMAccountName=*))`, account name of the user.                                                                |                     |
| **CommonName**           |            | `[String]`       | Specifies the common name, `(&(objectClass=User)(cn=*))`, assigned to the user account. If not specified the default value will be the same value provided in parameter UserName. |                     |
| **DisplayName**          |            | `[String]`       | Specifies the display name, `(&(objectClass=User)(displayName=*))`, of the object.                                                                                                |                     |
| **Description**          |            | `[String]`       | Specifies a description, `(&(objectClass=User)(description=*))`, of the object.                                                                                                   |                     |
| **Password**             |            | `[PSCredential]` | Specifies a new password value for the account.                                                                                                                                   |                     |
| **Enabled**              |            | `[Boolean]`      | Specifies if the account is enabled. Default value is `true`.                                                                                                                     |                     |
| **CannotChangePassword** |            | `[Boolean]`      | Specifies whether the account password can be changed.                                                                                                                            |                     |
| **PasswordNeverExpires** |            | `[Boolean]`      | Specifies whether the password of an account can expire.                                                                                                                          |                     |
| **MemberOf**             |            | `[String[]]`     | Specify Active Directory group memberhips for the user-based service account.                                                                                                     |                     |
| **Ensure**               |            | `[String]`       | Specifies whether the user account should be present or absent. Default value is `Present`.                                                                                       | `Present`, `Absent` |

---

#### Table. Attributes of `ActiveDirectoryServiceAccounts::KDSKey`

| Parameter                    | Attribute  | DataType    | Description                                                                                                                                                                                                                                                                                                                         | Allowed Values      |
| :--------------------------- | :--------- | :---------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------ |
| **EffectiveTime**            | *Required* | `[String]`  | Specifies the Effective time when a KDS root key can be used. See [KDS Root Key Effective Time](#####kds-root-key-effective-time).                                                                                                                                                                                                  |                     |
| **AllowUnsafeEffectiveTime** |            | `[Boolean]` | This option will allow you to create a KDS root key if EffectiveTime is set in the past. This may cause issues if you are creating a Group Managed Service Account right after you create the KDS Root Key. In order to get around this, you must create the KDS Root Key using a date in the past.                                 |                     |
| **ForceRemove**              |            | `[Boolean]` | This option will allow you to remove a KDS root key if there is only one key left. It should not break your Group Managed Service Accounts (gMSA), but if the gMSA password expires and it needs to request a new password, it will not be able to generate a new password until a new KDS Root Key is installed and ready for use. |                     |
| **Ensure**                   |            | `[String]`  | Specifies if this KDS Root Key should be present or absent. Default value is 'Present'.                                                                                                                                                                                                                                             | `Present`, `Absent` |

---

##### KDS Root Key Effective Time

There is a 10 hour minimum from creation date to allow active directory to properly replicate across all domain controllers. For this reason, the date must be set in the future for creation. While this parameter accepts a string, it will be converted into a DateTime object. This will also try to take into account cultural settings.

Example: `05/01/1999 13:00` using default or `en-US` culture would be May 1st, but using `de-DE` culture would be 5th of January. The culture is automatically pulled from the operating system and this can be checked using `Get-Culture`.

---

#### Table. Attributes of `ActiveDirectoryServiceAccounts::ManagedServiceAccounts`

| Parameter                     | Attribute  | DataType     | Description                                                                                                                                                                                                         | Allowed Values                                                   |
| :---------------------------- | :--------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--------------------------------------------------------------- |
| **ServiceAccountName**        | *Required* | `[String]`   | Specifies the Security Account Manager (SAM) account name of the managed service account. Once created, the user's SamAccountName and CN cannot be changed.                                                         |                                                                  |
| **AccountType**               | *Required* | `[String]`   | The type of managed service account. Standalone will create a Standalone Managed Service Account (sMSA) and Group will create a Group Managed Service Account (gMSA).                                               | `Group`, `Standalone`                                            |
| **Path**                      |            | `[String]`   | Specifies the X.500 path of the Organizational Unit (OU) or container where the new account is created. Specified as a Distinguished Name (DN).                                                                     |                                                                  |
| **Description**               |            | `[String]`   | Specifies the description of the account (ldapDisplayName `description`).                                                                                                                                           |                                                                  |
| **DisplayName**               |            | `[String]`   | Specifies the display name of the account (ldapDisplayName `displayName`).                                                                                                                                          |                                                                  |
| **KerberosEncryptionType**    |            | `[String[]]` | Specifies which Kerberos encryption types the account supports when creating service tickets. This value sets the encryption types supported flags of the Active Directory msDS-SupportedEncryptionTypes attribute. | `None`, `RC4`, `AES128`, `AES256`                                |
| **ManagedPasswordPrincipals** |            | `[String[]]` | Specifies the membership policy for systems which can use a group managed service account. Only used when `Group` is selected for `AccountType`.                                                                    |                                                                  |
| **MembershipAttribute**       |            | `[String]`   | Active Directory attribute used to perform membership operations for Group Managed Service Accounts (gMSA). If not specified, this value defaults to SamAccountName.                                                | `SamAccountName`, `DistinguishedName`, `ObjectGUID`, `ObjectSid` |
| **Ensure**                    |            | `[String]`   | Specifies whether the user account is created or deleted. If not specified, this value defaults to Present.                                                                                                         | `Present`, `Absent`                                              |

---

<br />

## Example `ActiveDirectoryServiceAccounts`

```yaml
ActiveDirectoryServiceAccounts:
  DomainDN: DC=example,DC=com

  UserServiceAccounts:
    - UserName: svc_service1
      Description: Service Account 1
      Path: OU=Service,OU=Privileged,OU=Users,OU=Enterprise
      MemberOf:
        - Service Accounts

    - UserName: svc_service2
      Description: Service Account 2
      MemberOf:
        - Service Accounts

  KDSKey:
    EffectiveTime:            '1-jan-2021 00:00'
    AllowUnsafeEffectiveTime: true   # Use with caution

  ManagedServiceAccounts:
    - ServiceAccountName: msa_service1
      AccountType:        Group
      Path:               OU=Service,OU=Privileged,OU=Users,OU=Enterprise
      Description:        This Group Managed Service Account is used to manage Service 1
      KerberosEncryptionType:
        - AES128
        - AES256
      ManagedPasswordPrincipals:
        - DSC Managed Nodes

  Credential: "[ENC=PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uUFNDdXN0b21PYmplY3Q8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPE1TPg0KICAgICAgPE9iaiBOPSJLZXlEYXRhIiBSZWZJZD0iMSI+DQogICAgICAgIDxUTiBSZWZJZD0iMSI+DQogICAgICAgICAgPFQ+U3lzdGVtLk9iamVjdFtdPC9UPg0KICAgICAgICAgIDxUPlN5c3RlbS5BcnJheTwvVD4NCiAgICAgICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgICAgICA8L1ROPg0KICAgICAgICA8TFNUPg0KICAgICAgICAgIDxPYmogUmVmSWQ9IjIiPg0KICAgICAgICAgICAgPFROUmVmIFJlZklkPSIwIiAvPg0KICAgICAgICAgICAgPE1TPg0KICAgICAgICAgICAgICA8UyBOPSJIYXNoIj44MDg1MzBFQzZDOUMyNENEODIzMjEyMkNBNDAwQUQyQjA4RUYwQTA0QjlGQzM2NUQxOUY1NTY3MjdEQjNDOUJEPC9TPg0KICAgICAgICAgICAgICA8STMyIE49Ikl0ZXJhdGlvbkNvdW50Ij41MDAwMDwvSTMyPg0KICAgICAgICAgICAgICA8QkEgTj0iS2V5Ij5leUt6OUNtWjhFRUoyVmlqR1dhYVVodW9IcEtCeEd6SmZza3F1L3JicWxXZzVoVXkwYWd5QW1xZnI5WWExbDAxPC9CQT4NCiAgICAgICAgICAgICAgPEJBIE49Ikhhc2hTYWx0Ij5nQ3NLTldCTUdRMjF0Smc1QVA1UXcyRGdoWDZpTkx2cy8vZHFQbE5PNExnPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJTYWx0Ij54OVhLaTVPRVg3SXRsbnQySkRPY0tJdlNZLzN1V2dOQjBjWFpaSitpWjZBPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJJViI+NUVpcFhyeVBSeDA3dDI2dk1mNGlPR0dURldiT2tzVDdraHRxcjNiM1NsND08L0JBPg0KICAgICAgICAgICAgPC9NUz4NCiAgICAgICAgICA8L09iaj4NCiAgICAgICAgPC9MU1Q+DQogICAgICA8L09iaj4NCiAgICAgIDxCQSBOPSJDaXBoZXJUZXh0Ij54OUp0WXZDbXFKQmpaVitqNmQxK3VUazBEM0FiZ3cvMTRJbk5EMEN2ZXZCVTlkUG5tL091WFR4bWdGVVQzaUlMdGYzRnNxQ0VVc29wYkhSaHBPdjE5dz09PC9CQT4NCiAgICAgIDxCQSBOPSJITUFDIj5pR3FoYkYwR0w5NUF6bDFSTVhMa0twQ2VNRXcwa29QeGtJd1NzMVczWU9vPTwvQkE+DQogICAgICA8UyBOPSJUeXBlIj5TeXN0ZW0uTWFuYWdlbWVudC5BdXRvbWF0aW9uLlBTQ3JlZGVudGlhbDwvUz4NCiAgICA8L01TPg0KICA8L09iaj4NCjwvT2Jqcz4=]"

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ActiveDirectoryServiceAccounts:
    merge_hash: deep
  ActiveDirectoryServiceAccounts\UserServiceAccounts:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - UserName
  ActiveDirectoryServiceAccounts\ManagedServiceAccounts:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - ServiceAccountName

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