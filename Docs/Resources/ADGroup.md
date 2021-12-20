# ADGroup

## Parameters

| Parameter                 | Attribute  | DataType         | Description                                                                                          | Allowed Values                                     |
| ------------------------- | ---------- | ---------------- | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| **GroupName**             | *Required* | `[String]`       | Name of the Active Directory group.                                                                  |                                                    |
| **GroupScope**            |            | `[String]`       | Active Directory group scope. Default value is 'Global'.                                             | DomainLocal, Global, Universal                     |
| **Category**              |            | `[String]`       | Active Directory group category. Default value is 'Security'.                                        | Security, Distribution                             |
| **Path**                  |            | `[String]`       | Location of the group within Active Directory expressed as a Distinguished Name.                     |                                                    |
| **Ensure**                |            | `[String]`       | Specifies if this Active Directory group should be present or absent. Default value is 'Present'.    | Present, Absent                                    |
| **Description**           |            | `[String]`       | Description of the Active Directory group.                                                           |                                                    |
| **DisplayName**           |            | `[String]`       | Display name of the Active Directory group.                                                          |                                                    |
| **Credential**            |            | `[PSCredential]` | Credentials used to enact the change upon.                                                           |                                                    |
| **DomainController**      |            | `[String]`       | Active Directory domain controller to enact the change upon.                                         |                                                    |
| **Members**               |            | `[String[]]`     | Active Directory group membership should match membership exactly.                                   |                                                    |
| **MembersToInclude**      |            | `[String[]]`     | Active Directory group should include these members.                                                 |                                                    |
| **MembersToExclude**      |            | `[String[]]`     | Active Directory group should NOT include these members.                                             |                                                    |
| **MembershipAttribute**   |            | `[String]`       | Active Directory attribute used to perform membership operations. Default value is 'SamAccountName'. | SamAccountName, DistinguishedName, ObjectGUID, SID |
| **ManagedBy**             |            | `[String]`       | Active Directory managed by attribute specified as a DistinguishedName.                              |                                                    |
| **Notes**                 |            | `[String]`       | Active Directory group notes field.                                                                  |                                                    |
| **RestoreFromRecycleBin** |            | `[Boolean]`      | Try to restore the group from the recycle bin before creating a new one.                             |                                                    |
| **DistinguishedName**     | Read       | `[String]`       | Returns the distinguished name of the Active Directory group.                                        |                                                    |

## Description

The ADGroup DSC resource will manage groups within Active Directory.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.
* The parameter `RestoreFromRecycleBin` requires that the feature Recycle
  Bin has been enabled prior to an object is deleted. If the feature
  Recycle Bin is disabled then the property `msDS-LastKnownRDN` is not
  added the deleted object.

## Examples

### Example 1

This configuration will create a new domain-local group

```powershell
Configuration ADGroup_NewGroup_Config
{
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $GroupName,

        [ValidateSet('DomainLocal', 'Global', 'Universal')]
        [System.String]
        $Scope = 'Global',

        [ValidateSet('Security', 'Distribution')]
        [System.String]
        $Category = 'Security',

        [ValidateNotNullOrEmpty()]
        [System.String]
        $Description
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADGroup 'ExampleGroup'
        {
            GroupName   = $GroupName
            GroupScope  = $Scope
            Category    = $Category
            Description = $Description
            Ensure      = 'Present'
        }
    }
}
```

### Example 2

This configuration will create a new domain-local group with three members.

```powershell
Configuration ADGroup_NewGroupWithMembers_Config
{
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADGroup 'dl1'
        {
            GroupName  = 'DL_APP_1'
            GroupScope = 'DomainLocal'
            Members    = 'john', 'jim', 'sally'
        }
    }
}
```

### Example 3

This configuration will create a new domain-local group in contoso with
three members in different domains.

```powershell
Configuration ADGroup_NewGroupMultiDomainMembers_Config
{
    Import-DscResource -ModuleName ActiveDirectoryDsc

    node localhost
    {
        ADGroup 'dl1'
        {
            GroupName           = 'DL_APP_1'
            GroupScope          = 'DomainLocal'
            MembershipAttribute = 'DistinguishedName'
            Members             = @(
                'CN=john,OU=Accounts,DC=contoso,DC=com'
                'CN=jim,OU=Accounts,DC=subdomain,DC=contoso,DC=com'
                'CN=sally,OU=Accounts,DC=anothersub,DC=contoso,DC=com'
            )
        }
    }
}
```

