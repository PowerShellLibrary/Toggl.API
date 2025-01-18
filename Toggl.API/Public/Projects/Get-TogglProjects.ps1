<#
.SYNOPSIS
Gets projects for a specified workspace in Toggl.

.DESCRIPTION
This cmdlet retrieves the list of projects for a specified workspace from Toggl. It sends a GET request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER SortPinned
Place pinned projects at top of response. (Mandatory)

.PARAMETER Active
Return active or inactive projects. You can pass 'both' to get both active and inactive projects. (Optional)

.PARAMETER Since
Retrieve projects created/modified/deleted since this date using UNIX timestamp. (Optional)

.PARAMETER Billable
Filter by billable projects. (Optional)

.PARAMETER UserIds
Filter by user IDs. (Optional)

.PARAMETER ClientIds
Filter by client IDs. (Optional)

.PARAMETER GroupIds
Filter by group IDs. (Optional)

.PARAMETER Statuses
Filter by project statuses. (Optional)

.PARAMETER Name
Filter by project name. (Mandatory)

.PARAMETER Page
Page number for pagination. (Mandatory)

.PARAMETER SortField
Field to sort by. (Mandatory)

.PARAMETER SortOrder
Order to sort by. (Mandatory)

.PARAMETER OnlyTemplates
Filter by template projects. (Mandatory)

.PARAMETER OnlyMe
Get only projects assigned to the current user. (Optional)

.PARAMETER PerPage
Number of items per page, default 151. Cannot exceed 200. (Optional)

.EXAMPLE
Get-TogglProjects -ApiToken "your_api_token" -WorkspaceId 123456 -SortPinned $true -Name "ProjectName" -Page 1 -SortField "name" -SortOrder "asc" -OnlyTemplates $false
#>
function Get-TogglProjects {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [bool]$SortPinned,

        [Parameter()]
        [bool]$Active,

        [Parameter()]
        [int]$Since,

        [Parameter()]
        [bool]$Billable,

        [Parameter()]
        [int[]]$UserIds,

        [Parameter()]
        [int[]]$ClientIds,

        [Parameter()]
        [int[]]$GroupIds,

        [Parameter()]
        [string[]]$Statuses,

        [string]$Name,

        [int]$Page,

        [string]$SortField,

        [string]$SortOrder,

        [bool]$OnlyTemplates,

        [Parameter()]
        [bool]$OnlyMe,

        [Parameter()]
        [int]$PerPage = 151
    )

    $params = @{
        sort_pinned    = $SortPinned
        name           = $Name
        page           = $Page
        sort_field     = $SortField
        sort_order     = $SortOrder
        only_templates = $OnlyTemplates
    }

    if ($PSBoundParameters.ContainsKey('Active')) { $params['active'] = $Active }
    if ($PSBoundParameters.ContainsKey('Since')) { $params['since'] = $Since }
    if ($PSBoundParameters.ContainsKey('Billable')) { $params['billable'] = $Billable }
    if ($PSBoundParameters.ContainsKey('UserIds')) { $params['user_ids'] = $UserIds }
    if ($PSBoundParameters.ContainsKey('ClientIds')) { $params['client_ids'] = $ClientIds }
    if ($PSBoundParameters.ContainsKey('GroupIds')) { $params['group_ids'] = $GroupIds }
    if ($PSBoundParameters.ContainsKey('Statuses')) { $params['statuses'] = $Statuses }
    if ($PSBoundParameters.ContainsKey('OnlyMe')) { $params['only_me'] = $OnlyMe }
    if ($PSBoundParameters.ContainsKey('PerPage')) { $params['per_page'] = $PerPage }

    $queryString = ($params.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'
    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/projects?$queryString"

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken

    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        return $response
    }
    catch {
        Write-Error "Failed to retrieve projects: $_"
    }
}

Export-ModuleMember -Function Get-TogglProjects