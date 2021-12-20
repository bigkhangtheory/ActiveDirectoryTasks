<#
    .DESCRIPTION
        The 'AddNodeToGroup' Desired State Configuration (DSC) resource can be used within a node block to enroll the target node into a Security Group within Active Directory

    .PARAMETER DomainController
        Active Directory domain controller to enact the change upon.

    .PARAMETER Groups
        Specifies a list of Active Directory Security Groups.

    .PARAMETER Credential
        Credentials used to enact the change upon.
#>
#Requires -Module ActiveDirectoryDsc

configuration NodeGroupMemberships
{
    param
    (
        [Parameter(Mandatory)]
        [ValidatePattern('^((DC=[^,]+,?)+)$')]
        [System.String]
        $DomainDN,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $Groups,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DomainController,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc


    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'


    # set execution name for the resource
    $executionName = "$($myDomainName -replace '[-().:\s]', '_')"

    WaitForADDomain "$executionName"
    {
        DomainName  = $myDomainName
        WaitTimeout = 300

    }
    # set resource name as dependency
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"



    <#
        Format the Node name as SamAccountName
    #>
    $nodeName = '{0}$' -f $node.Name


    <#
        Enumerate all groups to enroll the arget node
    ##>
    if ($PSBoundParameters.ContainsKey('Groups'))
    {
        foreach ($g in $Groups)
        {
            Write-Host "Found Group $g" -ForegroundColor Yellow

            # create hashtable to store resource parameters
            $params = @{
                GroupName        = $g
                DomainController = $DomainController
                Credential       = $Credential
                MembersToInclude = @() + $nodeName
                DependsOn        = $dependsOnWaitForADDomain
            }

            # create execution name for the resource
            $executionName = "$("$($params.GroupName)_$($params.MembersToInclude)" -replace '[-()$.:\s]', '_')"

            $output = @"

            Creating DSC resource for ADGroup with properties

            ADGroup $executionName
            {
                GroupName           = $($params.GroupName)
                DomainController    = $($params.DomainController)
                Credential          = $($params.Credential)
                MembersToInclude    = $($params.MembersToInclude)
                DependsOn           = $($params.DependsOn)
            }
"@

            Write-Host $output -ForegroundColor Yellow

            # create the DSC resource
            $Splatting = @{
                ResourceName  = 'ADGroup'
                ExecutionName = $executionName
                Properties    = $params
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($params)
        } #end foreach
    } #end if
}