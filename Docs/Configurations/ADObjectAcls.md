# ADObjectAcls

The **ADObjectAcls** DSC configuration manages the access control list for a list of Active Directory objects, including User, Group, and Compuer objects.

<br />

## Project Information

|                  |                                                                                                                                       |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/ActiveDirectoryTasks/-/tree/master/ActiveDirectoryTasks/DscResources/ADObjectAcls |
| **Dependencies** | [ActiveDirectoryDsc][ActiveDirectoryDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                |
| **Resources**    | [ADObjectPermissionEntry][ADObjectPermissionEntry], [xWindowsFeature][xWindowsFeature]                                                |

<br />

## Parameters

<br />

### Table. Attributes of `ADObjectAcls`

| Parameter    | Attribute  | DataType        | Description                            | Allowed Values |
| :----------- | :--------- | :-------------- | :------------------------------------- | :------------- |
| **DomainDn** | *Required* | `[String]`      | Distinguished Name (DN) of the domain. |                |
| **Objects**  |            | `[Hashtable[]]` | List of Active Directory objects.      |                |

---

#### Table. Attributes of `ADObjectAcls::Objects`

| Parameter                              | Attribute  | DataType     | Description                                                                                                                                                 | Allowed Values                                              |
| :------------------------------------- | :--------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------- |
| **Path**                               | *Required* | `[String]`   | Active Directory path of the target object to add or remove the permission entry, specified as a Distinguished Name, not inluding the `DomainDn`.           |                                                             |
| **IdentityReference**                  | *Required* | `[String]`   | Indicates the identity of the principal for the ACE. Use the notation `DOMAIN\SamAccountName` for the identity.                                             |                                                             |
| **ActiveDirectoryRights**              |            | `[String[]]` | A combination of one or more of the ActiveDirectoryRights enumeration values that specifies the rights of the access rule. Default value is `'GenericAll'`. | [See AD Access Rights](#####ad-access-rights)               |
| **AccessControlType**                  | *Required* | `[String]`   | Indicates whether to Allow or Deny access to the target object.                                                                                             | `Allow`, `Deny`                                             |
| **ObjectType**                         | *Required* | `[String]`   | The schema GUID of the object to which the access rule applies. Specify `'Any'` if object type should not be restricted.                                    |                                                             |
| **ActiveDirectorySecurityInheritance** | *Required* | `[String]`   | One of the 'ActiveDirectorySecurityInheritance' enumeration values that specifies the inheritance type of the access rule.                                  | `All`, `Children`, `Descendents`, `None`, `SelfAndChildren` |
| **InheritedObjectType**                | *Required* | `[String]`   | The schema GUID of the child object type that can inherit this access rule.                                                                                 |                                                             |

---

##### AD Access Rights

| Access Right           | Description                                                                                                                                                                                                                    |
| :--------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AccessSystemSecurity` | The right to get or set the SACL in the object security descriptor.                                                                                                                                                            |
| `CreateChild`          | The right to create child objects of the object.                                                                                                                                                                               |
| `Delete`               | The right to delete the object.                                                                                                                                                                                                |
| `DeleteChild`          | The right to delete child objects of the object.                                                                                                                                                                               |
| `DeleteTree`           | The right to delete all child objects of this object, regardless of the permissions of the child objects.                                                                                                                      |
| `ExtendedRight`        | The right to perform an operation controlled by an extended access right. See [AD Extended Rights](#####ad-extended-rights)                                                                                                    |
| `GenericAll`           | The right to create or delete child objects, delete a subtree, read and write properties, examine child objects and the object itself, add and remove the object from the directory, and read or write with an extended right. |
| `GenericExecute`       | The right to read permissions on, and list the contents of, a container object.                                                                                                                                                |
| `GenericRead`          | The right to read permissions on this object, read all the properties on this object, list this object name when the parent container is listed, and list the contents of this object if it is a container.                    |
| `GenericWrite`         | The right to read permissions on this object, write all the properties on this object, and perform all validated writes to this object.                                                                                        |
| `ListChildren`         | The right to list child objects of this object.                                                                                                                                                                                |
| `ListObject`           | The right to list a particular object. If the user is not granted such a right, and the user does not have ADS_RIGHT_ACTRL_DS_LIST set on the object parent, the object is hidden from the user.                               |
| `ReadControl`          | The right to read data from the security descriptor of the object, not including the data in the SACL.                                                                                                                         |
| `ReadProperty`         | The right to read properties of the object.                                                                                                                                                                                    |
| `Self`                 | The right to perform an operation controlled by a validated write access right.                                                                                                                                                |
| `WriteDacl`            | The right to modify the discretionary access-control list (DACL) in the object security descriptor.                                                                                                                            |
| `WriteOwner`           | The right to assume ownership of the object. The user must be an object trustee. The user cannot transfer the ownership to other users.                                                                                        |
| `WriteProperty`        | The right to write properties of the object.                                                                                                                                                                                   |

---

##### AD Extended Rights

| Object Type                                     | Description                                       | Applies To                                                                                                                                 |
| :---------------------------------------------- | :------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------------------------------- |
| `Add-GUID`                                      | Add GUID                                          | `Domain-DNS`                                                                                                                               |
| `Allocate-Rids`                                 | Allocate Rids                                     | `NTDS-DSA`                                                                                                                                 |
| `Allowed-To-Authenticate`                       | Allowed to Authenticate                           | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`inetOrgPerson`,`User`, `Computer`                                   |
| `Apply-Group-Policy`                            | Apply Group Policy                                | `Group-Policy-Container`                                                                                                                   |
| `Certificate-AutoEnrollment`                    | AutoEnrollment                                    | `PKI-Certificate-Template`                                                                                                                 |
| `Certificate-Enrollment`                        | Enroll                                            | `PKI-Certificate-Template`                                                                                                                 |
| `Change-Domain-Master`                          | Change Domain Master                              | `Cross-Ref-Container`                                                                                                                      |
| `Change-Infrastructure-Master`                  | Change Infrastructure Master                      | `Infrastructure-Update`                                                                                                                    |
| `Change-PDC`                                    | Change PDC                                        | `Domain-DNS`                                                                                                                               |
| `Change-Rid-Master`                             | Change Rid Master                                 | `RID-Manager`                                                                                                                              |
| `Change-Schema-Master`                          | Change Schema Master                              | `DMD`                                                                                                                                      |
| `Create-Inbound-Forest-Trust`                   | Create Inbound Forest Trust                       | `Domain-DNS`                                                                                                                               |
| `DNS-Host-Name-Attributes`                      | DNS Host Name Attributes                          | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`Computer`                                                           |
| `Do-Garbage-Collection`                         | Do Garbage Collection                             | `NTDS-DSA`                                                                                                                                 |
| `Domain-Administer-Server`                      | Domain Administer Server                          | `Sam-Server`                                                                                                                               |
| `Domain-Other-Parameters`                       | Other Domain Parameters (for use by SAM)          | `Domain-DNS`                                                                                                                               |
| `Domain-Password`                               | Domain Password & Lockout Policies                | `Domain-DNS`,`Domain`                                                                                                                      |
| `DS-Bypass-Quota`                               | Bypass the quota restrictions during creation.    |                                                                                                                                            |
| `DS-Check-Stale-Phantoms`                       | Check Stale Phantoms                              | `NTDS-DSA`                                                                                                                                 |
| `DS-Clone-Domain-Controller`                    | Allow a DC to create a clone of itself            | `Domain-DNS`                                                                                                                               |
| `DS-Execute-Intentions-Script`                  | Execute Forest Update Script                      | `Cross-Ref-Container`                                                                                                                      |
| `DS-Install-Replica`                            | Add/Remove Replica In Domain                      | `Domain-DNS`                                                                                                                               |
| `DS-Query-Self-Quota`                           | Query Self Quota                                  | `ms-DS-Quota-Container`                                                                                                                    |
| `DS-Read-Partition-Secrets`                     | Read secret attributes of objects in a Partition  |                                                                                                                                            |
| `DS-Replication-Get-Changes`                    | Replicating Directory Changes                     | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `DS-Replication-Get-Changes-All`                | Replicating Directory Changes All                 | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `DS-Replication-Get-Changes-In-Filtered-Set`    | Replicating Directory Changes In Filtered Set     | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `DS-Replication-Manage-Topology`                | Manage Replication Topology                       | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `DS-Replication-Monitor-Topology`               | Monitor Active Directory Replication              | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `DS-Replication-Synchronize`                    | Replication Synchronization                       | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `DS-Set-Owner`                                  | Set Owner of an object during creation.           |                                                                                                                                            |
| `DS-Validated-Write-Computer`                   | Validated write to computer attributes.           | `Computer`                                                                                                                                 |
| `DS-Write-Partition-Secrets`                    | Write secret attributes of objects in a Partition |                                                                                                                                            |
| `Email-Information`                             | Phone and Mail Options                            | `inetOrgPerson`,`Group`,`User`                                                                                                             |
| `Enable-Per-User-Reversibly-Encrypted-Password` | Enable Per User Reversibly Encrypted Password     | `Domain-DNS`                                                                                                                               |
| `General-Information`                           | General Information                               | `inetOrgPerson`,`User`                                                                                                                     |
| `Generate-RSoP-Logging`                         | Generate Resultant Set of Policy (Logging)        | `Domain-DNS`,`Organizational-Unit`                                                                                                         |
| `Generate-RSoP-Planning`                        | Generate Resultant Set of Policy (Planning)       | `Domain-DNS`,`Organizational-Unit`                                                                                                         |
| `Manage-Optional-Features`                      | Manage Optional Features for Active Directory     | `Cross-Ref-Container`                                                                                                                      |
| `Membership`                                    | Group Membership                                  | `inetOrgPerson`,`User`                                                                                                                     |
| `Migrate-SID-History`                           | Migrate SID History                               | `Domain-DNS`                                                                                                                               |
| `msmq-Open-Connector`                           | Open Connector Queue                              | `Site`                                                                                                                                     |
| `msmq-Peek`                                     | Peek Message                                      | `MSMQ-Queue`                                                                                                                               |
| `msmq-Peek-computer-Journal`                    | Peek Computer Journal                             | `MSMQ-Configuration`                                                                                                                       |
| `msmq-Peek-Dead-Letter`                         | Peek Dead Letter                                  | `MSMQ-Configuration`                                                                                                                       |
| `msmq-Receive`                                  | Receive Message                                   | `MSMQ-Queue`                                                                                                                               |
| `msmq-Receive-computer-Journal`                 | Receive Computer Journal                          | `MSMQ-Configuration`                                                                                                                       |
| `msmq-Receive-Dead-Letter`                      | Receive Dead Letter                               | `MSMQ-Configuration`                                                                                                                       |
| `msmq-Receive-journal`                          | Receive Journal                                   | `MSMQ-Queue`                                                                                                                               |
| `msmq-Send`                                     | Send Message                                      | `MSMQ-Group`,`MSMQ-Queue`                                                                                                                  |
| `MS-TS-GatewayAccess`                           | MS-TS-GatewayAccess                               | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`Computer`                                                           |
| `Open-Address-Book`                             | Open Address List                                 | `Address-Book-Container`                                                                                                                   |
| `Personal-Information`                          | Personal Information                              | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Cloud-Extensions`,`ms-DS-Managed-Service-Account`,`inetOrgPerson`,`Computer`,`Contact`,`User` |
| `Private-Information`                           | Private Information                               | `User`,`inetOrgPerson`                                                                                                                     |
| `Public-Information`                            | Public Information                                | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`inetOrgPerson`,`Computer`,`User`                                    |
| `RAS-Information`                               | Remote Access Information                         | `inetOrgPerson`,`User`                                                                                                                     |
| `Read-Only-Replication-Secret-Synchronization`  | Read Only Replication Secret Synchronization      | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `Reanimate-Tombstones`                          | Reanimate Tombstones                              | `DMD`,`Configuration`,`Domain-DNS`                                                                                                         |
| `Recalculate-Hierarchy`                         | Recalculate Hierarchy                             | `NTDS-DSA`                                                                                                                                 |
| `Recalculate-Security-Inheritance`              | Recalculate Security Inheritance                  | `NTDS-DSA`                                                                                                                                 |
| `Receive-As`                                    | Receive As                                        | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`inetOrgPerson`,`Computer`,`User`                                    |
| `Refresh-Group-Cache`                           | Refresh Group Cache for Logons                    | `NTDS-DSA`                                                                                                                                 |
| `Reload-SSL-Certificate`                        | Reload SSL/TLS Certificate                        | `NTDS-DSA`                                                                                                                                 |
| `Run-Protect-Admin-Groups-Task`                 | Run Protect Admin Groups Task                     | `Domain-DNS`                                                                                                                               |
| `SAM-Enumerate-Entire-Domain`                   | Enumerate Entire SAM Domain                       | `Sam-Server`                                                                                                                               |
| `Self-Membership`                               | Add/Remove self as member                         | `Group`                                                                                                                                    |
| `Send-As`                                       | Send As                                           | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`inetOrgPerson`,`Computer`,`User`                                    |
| `Send-To`                                       | Send To                                           | `Group`                                                                                                                                    |
| `Terminal-Server-License-Server`                | Terminal Server License Server                    | `User`,`inetOrgPerson`                                                                                                                     |
| `Unexpire-Password`                             | Unexpire Password                                 | `Domain-DNS`                                                                                                                               |
| `Update-Password-Not-Required-Bit`              | Update Password Not Required Bit                  | `Domain-DNS`                                                                                                                               |
| `Update-Schema-Cache`                           | Update Schema Cache                               | `DMD`                                                                                                                                      |
| `User-Account-Restrictions`                     | Account Restrictions                              | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`inetOrgPerson`,`Computer`,`User`                                    |
| `User-Change-Password`                          | Change Password                                   | `ms-DS-Managed-Service-Account`,`inetOrgPerson`,`Computer`,`User`                                                                          |
| `User-Force-Change-Password`                    | Reset Password                                    | `ms-DS-Managed-Service-Account`,`inetOrgPerson`,`Computer`,`User`                                                                          |
| `User-Logon`                                    | Logon Information                                 | `inetOrgPerson`,`User`                                                                                                                     |
| `Validated-DNS-Host-Name`                       | Validated write to DNS host name                  | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`Computer`                                                           |
| `Validated-MS-DS-Additional-DNS-Host-Name`      | Validated write to MS DS Additional DNS Host Name | `Computer`                                                                                                                                 |
| `Validated-MS-DS-Behavior-Version`              | Validated write to MS DS behavior version         | `NTDS-DSA`                                                                                                                                 |
| `Validated-SPN`                                 | Validated write to service principal name         | `ms-DS-Group-Managed-Service-Account`,`ms-DS-Managed-Service-Account`,`Computer`                                                           |
| `Web-Information`                               | Web Information                                   | `inetOrgPerson`,`Contact`,`User`                                                                                                           |

---

<br />

## Example `ADObjectAcls`

```yaml
ADObjectAcls:
  DomainDN: DC=example,DC=com
  Objects:
  - Path: CN=Account Operators,CN=Builtin
    AccessControlList:
    # ---
    - IdentityReference: MAPCOM\Group Membership Operators
        PermissionEntries:
        # ---
        - AccessControlType: Allow
            ActiveDirectoryRights:
            - GenericRead
            - GenericExecute
            ObjectType: Group

        # ---
        - AccessControlType: Allow
            ActiveDirectoryRights:
            - ExtendedRight
            ObjectType: Membership
  # ---
  - Path: CN=DnsAdmins,CN=Users
    AccessControlList:
    # ---
    - IdentityReference: MAPCOM\Group Membership Operators
        PermissionEntries:
        # ---
        - AccessControlType: Allow
            ActiveDirectoryRights:
            - GenericRead
            - GenericExecute
            ObjectType: Group

        # ---
        - AccessControlType: Allow
            ActiveDirectoryRights:
            - ExtendedRight
            ObjectType: Membership

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  ADObjectAcls:
    merge_hash: deep

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