@{

    PSDependOptions              = @{
        AddToPath      = $true
        Target         = 'BuildOutput\Modules'
        DependencyType = 'PSGalleryModule'
        Parameters     = @{
            Repository = 'PSGallery'
        }
    }

    # -------------------------------------------------------------------------
    # PowerShell Modules
    # -------------------------------------------------------------------------

    BuildHelpers                 = 'latest'
    # Helper functions for PowerShell CI/CD scenarios

    Datum                        = '0.39.0'
    # Module to manage Hierachical Configuration Data

    'Datum.InvokeCommand'        = '0.1.2'
    # Datum Handler module to encrypt and decrypt secrets in Datum using Dave Wyatt's ProtectedData module

    'Datum.ProtectedData'        = 'latest'
    # Datum Handler module to encrypt and decrypt secrets in Datum using Dave Wyatt's ProtectedData module

    DscBuildHelpers              = 'latest'
    # Build Helpers for DSC Resources and Configurations

    InvokeBuild                  = '5.8.4'
    # Build and test automation in PowerShell

    Pester                       = '4.10.1'
    # Pester provides a framework for running BDD style Tests to execute and validate PowerShell commands inside of PowerShell.
    # It offers a powerful set of Mocking Functions that allow tests to mimic and mock the functionality of any command inside of a piece of PowerShell code being tested.
    # Pester tests can execute any command or script that is accessible to a pester test file. This can include functions, Cmdlets, Modules and scripts.
    # Pester can be run in ad hoc style in a console or it can be integrated into the Build scripts of a Continuous Integration system.

    'posh-git'                   = 'latest'
    # Provides prompt with Git status summary information and tab completion for Git commands, parameters, remotes and branch names.

    'powershell-yaml'            = '0.4.2'
    # Powershell module for serializing and deserializing YAML

    ProtectedData                = '4.1.3'
    # Encrypt and share secret data between different users and computers.

    PSScriptAnalyzer             = 'latest'
    # Provides script analysis and checks for potential code defects in the scripts by applying a group of built-in or customized rules on the scripts being analyzed.

    PSDeploy                     = 'latest'
    # Module to simplify PowerShell based deployments


    'Indented.Net.Ip'            = '6.2.0'
    # A collection of commands written to perform IPv4 subnet math.

    # -------------------------------------------------------------------------
    # DSC Resources
    # -------------------------------------------------------------------------

    AccessControlDsc             = '1.4.1'
    # The AccessControlDsc module allows you to configure and manage access control on NTFS and Registry objects. It also allows management of audit access for Active Directory object SACL.

    ActiveDirectoryDsc           = '6.0.1'
    # Contains DSC resources for deployment and configuration of Active Directory.
    # These DSC resources allow you to configure new domains, child domains, and high availability domain controllers, establish cross-domain trusts and manage users, groups and OUs.

    GroupPolicyDsc               = '1.0.3'
    # This module provides the functionality needed to manipulate Group Policy.

    xPSDesiredStateConfiguration = '9.1.0'
    # DSC resources for configuring common operating systems features, files and settings
}
