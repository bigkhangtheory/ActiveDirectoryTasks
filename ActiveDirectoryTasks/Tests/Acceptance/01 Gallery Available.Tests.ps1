﻿#take the first trusted gallery to test against, otherwise the PSGallery. This is sufficient for this demo
$repository = Get-PSRepository | Where-Object InstallationPolicy -EQ Trusted -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $repository) {
    $repository = Get-PSRepository -Name PSGallery
}
$repositoryName = $repository.Name
$moduleName = 'ServerTasks'

Describe "Module '$moduleName' is available" -Tags 'FunctionalQuality' {
    It 'Can be found' {
        Get-Module -name $moduleName | Should Not BeNullOrEmpty
    }

    It "Module '$moduleName' can be imported" {
        { Import-Module -name $moduleName -Scope CurrentUser } | Should Not Throw
    }
}
