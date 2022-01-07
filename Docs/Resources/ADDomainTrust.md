# ADDomainTrust

## Parameters

| Parameter                | Attribute  | DataType         | Description                                                                                                                      | Allowed Values                   |
| ------------------------ | ---------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| **Ensure**               |            | `[String]`       | Specifies whether the computer account is present or absent. Default value is 'Present'.                                         | Present, Absent                  |
| **TargetCredential**     | Required   | `[PSCredential]` | Specifies the credentials to authenticate to the target domain.                                                                  |                                  |
| **TargetDomainName**     | *Required* | `[String]`       | Specifies the name of the Active Directory domain that is being trusted.                                                         |                                  |
| **TrustType**            | Required   | `[String]`       | Specifies the type of trust. The value 'External' means the context Domain, while the value 'Forest' means the context 'Forest'. | External, Forest                 |
| **TrustDirection**       | Required   | `[String]`       | Specifies the direction of the trust.                                                                                            | Bidirectional, Inbound, Outbound |
| **SourceDomainName**     | *Required* | `[String]`       | Specifies the name of the Active Directory domain that is requesting the trust.                                                  |                                  |
| **AllowTrustRecreation** |            | `[Boolean]`      | Specifies if the is allowed to be recreated if required. Default value is $false.                                                |                                  |

## Description

The ADDomainTrust DSC resource will manage Domain Trusts within Active Directory. A trust is a relationship, which you establish between domains or forests. To understand more about trusts in Active Directory, please see the article [Forest Design Models](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/plan/forest-design-models) for more information.

## Requirements

* Target machine must be running Windows Server 2008 R2 or later.

## Examples

### Example 1

This configuration will create a new one way inbound trust between two
domains.

```powershell
Configuration ADDomainTrust_ExternalInboundTrust_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $SourceDomain,

        [Parameter(Mandatory = $true)]
        [System.String]
        $TargetDomain,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $TargetDomainAdminCred
    )

    Import-DscResource -module ActiveDirectoryDsc

    node localhost
    {
        ADDomainTrust 'Trust'
        {
            Ensure           = 'Present'
            SourceDomainName = $SourceDomain
            TargetDomainName = $TargetDomain
            TargetCredential = $TargetDomainAdminCred
            TrustDirection   = 'Inbound'
            TrustType        = 'External'
        }
    }
}
```

### Example 2

This configuration will create a new one way inbound trust between two
domains, and allows the trust to recreated if it should have the wrong
trust type.

```powershell
Configuration ADDomainTrust_ExternalInboundTrustWithOptInToRecreate_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $SourceDomain,

        [Parameter(Mandatory = $true)]
        [System.String]
        $TargetDomain,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $TargetDomainAdminCred
    )

    Import-DscResource -module ActiveDirectoryDsc

    node localhost
    {
        ADDomainTrust 'Trust'
        {
            Ensure               = 'Present'
            SourceDomainName     = $SourceDomain
            TargetDomainName     = $TargetDomain
            TargetCredential     = $TargetDomainAdminCred
            TrustDirection       = 'Inbound'
            TrustType            = 'External'
            AllowTrustRecreation = $true
        }
    }
}
```

