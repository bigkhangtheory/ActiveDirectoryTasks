# DhcpServerTasks

This repo provides a structured project for building re-usable and composable **DSC Configurations** _(DSC Composite Resources.md)_ used to manage and configuration **Active Diretory Domain Services**.

---

## Project Configurations *(Composite Resources.md)*

| **Configurations**                                                                                | **Description**                                                                                                            | **Status**  |
| :------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------- | :---------: |
| [ActiveDirectoryComputers](./Docs/Configurations/ActiveDirectoryComputers.md)                     | This DSC configuration creates and manages Computer objects within Active Directory.                                       | *Published* |
| [ActiveDirectoryDistributionGroups](./Docs/Configurations/ActiveDirectoryDistributionGroups.md)   | This DSC configuration manages Distribution Groups within Active Directory.                                                | *Published* |
| [ActiveDirectoryDomain](./Docs/Configurations/ActiveDirectoryDomain)                              | This DSC configuration creates a new domain in a new forest or a child domain in an existing forest.                       | *Published* |
| [ActiveDirectoryDomainController](./Docs/Configurations/ActiveDirectoryDomainController)          | This DSC configuration will install and configure domain controllers in Active Directory.                                  | *Published* |
| [ActiveDirectoryFunctionalLevel](./Docs/Configurations/ActiveDirectoryFunctionalLevel)            | This DSC configuration manages to functional level of a Domain and/or Forest within Active Directory.                      | *Published* |
| [ActiveDirectoryGroups](./Docs/Configurations/ActiveDirectoryGroups.md)                           | This DSC configuration manages Security Groups and memberships within Active Directory.                                    | *Published* |
| [ActiveDirectoryOrganizationalUnits](./Docs/Configurations/ActiveDirectoryOrganizationalUnits.md) | This DSC configuration manage Organizational Units (OUs) within Active Directory.                                          | *Published* |
| [ActiveDirectoryServiceAccounts](./Docs/Configurations/ActiveDirectoryServiceAccounts.md)         | This DSC configuration is used to manage and configure service logon accounts within Active Directory.                     | *Published* |
| [ActiveDirectorySites](./Docs/Configurations/ActiveDirectorySites.md)                             | This DSC configuration managed Replication Sites, Replication Site Links, and Replication Subnets within Active Directory. | *Published* |
| [ActiveDirectorySPNs](./Docs/Configurations/ActiveDirectorySPNs.md)                               | This DSC configuration is used to manage and Service Principal Names within Active Directory.                              | *Published* |
| [ActiveDirectoryUsers](./Docs/Configurations/ActiveDirectoryUsers.md)                             | This DSC configuration creates and manages User objects within Active Directory.                                           | *Published* |
| [ADOrganizationalUnitAcls](./Docs/Configurations/ADOrganizationalUnitAcls.md)                     | This DSC configuration is used to managed access control lists on Active Directory Organizational Units (OUs.md).          | *Published* |
| [ConfigurationContainerAcls](./Docs/Configurations/ConfigurationContainerAcls.md)                 | This DSC configuration is used to managed access control lists on Active Directory Configuration Container objects.        | *Published* |
| [DomainDefaultPasswordPolicy](./Docs/Configurations/DomainDefaultPasswordPolicy)                  | This DSC configuration manage an Active Directory domains default password policy.                                         | *Published* |
| [DomainTrusts](./Docs/Configurations/DomainTrusts.md)                                             | This DSC configuration manages Domain Trusts within Active Directory.                                                      | *Published* |
| [ForestServicePrincipalNames](./Docs/Configurations/ForestServicePrincipalNames.md)               | This DSC configuration manages the addition of supported Service Principal Names within an Active Directory Forest.        | *Published* |
| [ForestUserPrincipalNames](./Docs/Configurations/ForestUserPrincipalNames.md)                     | This DSC configuration will manage forest wide User Principal Name (UPN) suffixes within Active Directory.                 | *Published* |
| [ProtectFromAccidentalDeletion](./Docs/Configurations/ProtectFromAccidentalDeletion.md)           | This DSC configuration prevents AD objects from being deleted.                                                             | *Published* |

---

## Project Objectives

The objective is to:

- Simplify the way to consume a shared configuration
- Allow direct re-use in new environment *(no copy-paste/modification of DSC Config or data)*
- Reduce the _cost_ of sharing, by automating the scaffolding (plaster), testing (pester, PSSA, Integration tests.md), building (Composite Resource), publishing to our internal [Powershell repository](https://repo.windows.mapcom.local/nuget/powershell/)
- Ensuring high quality, by allowing the use of a testing harness fit for TDD
- Allow Build tools, tasks and scripts to be more standardized and re-usable
- Ensure quick and simple iterations during the development process

To achieve the objectives:

- Provide a familiar scaffolding structure similar to PowerShell modules
- Create a model that can be self contained (or bootstrap itself with minimum dependencies.md)
- Be CI/CD tool independant
- Declare Dependencies in Module Manifest for Pulling requirements from a gallery
- Embed default Configuration Data alongside configs
- Provides guidelines, conventions and design patterns (i.e. re-using Configuration Data)

---

## Project Guidelines

The [DSC Resource repository](http://github.com/powershell/dscresources) includes guidance on authoring that is applicable to configurations as well.

For more information, visit the links below:

- [Best practices](https://github.com/PowerShell/DscResources/blob/master/BestPractices)
- [Style guidelines](https://github.com/PowerShell/DscResources/blob/master/StyleGuidelines)
- [Maintainers](https://github.com/PowerShell/DscResources/blob/master/Maintainers)

### Project Structure

```
CompositeResourceName
│   .gitignore
│   .gitlab-ci.yml
│   Build.ps1
│   CompositeResourceName.PSDeploy.ps1
│   PSDepend.Build.psd1
│   README.md
│
├───Build
│   ├───BuildHelpers
│   │       Invoke-InternalPSDepend.ps1
│   │       Resolve-Dependency.ps1
│   │       Set-PSModulePath.ps1
│   └───Tasks
│           CleanBuildOutput.ps1
│           CopyModule.ps1
│           Deploy.ps1
│           DownloadDscResources.ps1
│           Init.ps1
│           IntegrationTests.ps1
│           SetPsModulePath.ps1
│           TestReleaseAcceptance.ps1
│
├───BuildOutput
│   │   localhost_Configuration1.mof
│   │   localhost_Configuration2.mof
│   │   localhost_Configuration3.mof
│   │   localhost_ConfigurationN.mof
│   │
│   ├───Modules
│   │
│   └───Pester
│           IntegrationTestResults.xml
│
├───Docs
│       Configuration1.md
│       Configuration2.md
│       Configuration3.md
│       ConfigurationN.md
│
└───CompositeResourceName
    │   CompositeResourceName.psd1
    │
    ├───DscResources
    │   ├───Configuration1
    │   │       Configuration1.psd1
    │   │       Configuration1.psm1
    │   │
    │   ├───Configuration2
    │   │       Configuration2.psd1
    │   │       Configuration2.psm1
    │   │
    │   ├───Configuration3
    │   │       Configuration3.psd1
    │   │       Configuration3.psm1
    │   │
    │   ├───ConfigurationN
    │   │       ConfigurationN.psd1
    │   │       ConfigurationN.psm1
    │   ...
    │
    └───Tests
        ├───Acceptance
        │       01 Gallery Available.Tests.ps1
        │       02 HasDscResources.Tests.ps1
        │       03 CanBeUninstalled.Tests.ps1
        │
        └───Integration
            │   01 DscResources.Tests.ps1
            │   02.Final.Tests.ps1
            │
            └───Assets
                │   AllNodes.yml
                │   Datum.yml
                │   TestHelpers.psm1
                │
                └───Config
                        Configuration1.yml
                        Configuration2.yml
                        Configuration3.yml
                        ConfigurationN.yml

```

The Composite Resource should be self contained, but will require files for building/testing or development.

The repository will hence need some project files on top of the files required for functionality.

Adopting the 2 layers structure like so:

```
+-- CompositeResourceName\
    +-- CompositeResourceName\
```

Allows to place Project files like build, CI configs and so on at the top level, and everything under the second level are the files that need to be shared and will be uploaded to the PSGallery.

Within that second layer, the Configuration looks like a standard module with some specificities.

#### Root Tree

The root of the tree would be similar to a module root tree where you have supporting files for, say, the CI/CD integration.

In this example, I'm illustrating the idea with:

- A `Build.ps1` that defines the build workflow by composing tasks (see [SampleModule](https://github.com/gaelcolas/SampleModule))
- A `Build/` folder, which includes the minimum tasks to bootstrap + custom ones
- the `.gitignore` where folders like BuildOutput or kitchen specific files are added (`module/`)
- The [PSDepend.Build.psd1](./PSDepend.Build.ps1), so that the build process can use [PSDepend](https://github.com/RamblingCookieMonster/PSDepend/) to pull any prerequisites to build this project
- The Gitlab runner configuration file

### Configuration Module Folder

Very similar to a PowerShell Module folder, the Shared configuration re-use the same principles and techniques.

The re-usable configuration itself is declared in the ps1, the metadata and dependencies in the psd1 to leverage all the goodies of module management, then we have some assets ordered in folders:

- ConfigurationData: the default/example configuration data, organised in test suite/scenarios
- Test Acceptance & Integration: the pester tests used to validate the configuration, per test suite/scenario
- the examples of re-using that shared configuration, per test suite/scenario
