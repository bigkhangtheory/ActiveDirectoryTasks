# ADOrganizationalUnit

## Parameters

| Parameter                           | Attribute  | DataType         | Description                                                                                                    | Allowed Values  |
| ----------------------------------- | ---------- | ---------------- | -------------------------------------------------------------------------------------------------------------- | --------------- |
| **Name**                            | *Required* | `[String]`       | The name of the Organizational Unit (OU).                                                                      |                 |
| **Path**                            | *Required* | `[String]`       | Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created.         |                 |
| **Ensure**                          |            | `[String]`       | Specifies whether the Organizational Unit (OU) should be present or absent. Default value is 'Present'.        | Present, Absent |
| **Credential**                      |            | `[PSCredential]` | The credential to be used to perform the operation on Active Directory.                                        |                 |
| **ProtectedFromAccidentalDeletion** |            | `[Boolean]`      | Specifies if the Organizational Unit (OU) container should be protected from deletion. Default value is $true. |                 |
| **Description**                     |            | `[String]`       | Specifies the description of the Organizational Unit (OU). Default value is empty ('').                        |                 |
| **RestoreFromRecycleBin**           |            | `[Boolean]`      | Try to restore the Organizational Unit (OU) from the recycle bin before creating a new one.                    |                 |
| **DistinguishedName**               | Read       | `[String]`       | Returns the X.500 distinguished name of the Organizational Unit.                                               |                 |

## Description

The ADOrganizational Unit DSC resource will manage Organizational Units (OUs) within Active Directory.

An OU is a subdivision within an Active Directory into which you can place users, groups, computers, and other organizational units.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.
* The parameter `RestoreFromRecycleBin` requires that the feature Recycle Bin has been enabled prior to an object being
  deleted. If the Recycle Bin feature is disabled then the property `msDS-LastKnownRDN` is not added the deleted object.

## Examples

### Example 1

This configuration will add an Active Directory organizational unit to the domain.

```powershell
Configuration ADOrganizationalUnit_CreateADOU_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Path,

        [Parameter()]
        [System.Boolean]
        $ProtectedFromAccidentalDeletion = $true,

        [Parameter()]
        [ValidateNotNull()]
        [System.String]
        $Description = ''
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADOrganizationalUnit 'ExampleOU'
        {
            Name                            = $Name
            Path                            = $Path
            ProtectedFromAccidentalDeletion = $ProtectedFromAccidentalDeletion
            Description                     = $Description
            Ensure                          = 'Present'
        }
    }
}
```

