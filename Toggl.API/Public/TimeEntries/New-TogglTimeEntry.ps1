<#
.SYNOPSIS
Creates a new time entry in Toggl.

.DESCRIPTION
This cmdlet creates a new time entry in Toggl using the provided parameters. It sends a POST request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
The ID of the workspace. (Mandatory)

.PARAMETER Billable
Whether the time entry is marked as billable. (Optional, default: $false)

.PARAMETER CreatedWith
The service/application used to create the time entry. (Mandatory)

.PARAMETER Description
The description of the time entry. (Optional)

.PARAMETER Duration
The duration of the time entry. For running entries should be negative, preferable -1. (Optional)

.PARAMETER EventMetadata
Metadata related to the event. (Optional)

.PARAMETER ProjectId
The ID of the project associated with the time entry. (Optional)

.PARAMETER SharedWithUserIds
List of user IDs to share this time entry with. (Optional)

.PARAMETER Start
The start time in UTC. Format: 2006-01-02T15:04:05Z. (Mandatory)

.PARAMETER StartDate
The start date. Format: 2006-11-07. (Optional)

.PARAMETER Stop
The stop time in UTC. (Optional)

.PARAMETER TagAction
Action to perform on tags. Can be "add" or "delete". (Optional)

.PARAMETER TagIds
IDs of tags to add/remove. (Optional)

.PARAMETER Tags
Names of tags to add/remove. If name does not exist as tag, one will be created automatically. (Optional)

.PARAMETER TaskId
The ID of the task associated with the time entry. (Optional)

.PARAMETER UserId
The ID of the user who created the time entry. (Optional)

.PARAMETER WorkspaceId
The ID of the workspace. (Mandatory)

.EXAMPLE
New-TogglTimeEntry -ApiToken "your_api_token" -WorkspaceId 123456 -CreatedWith "MyApp" -Start "2023-10-01T08:00:00Z"

#>
function New-TogglTimeEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [Parameter()]
        [bool]$Billable = $false,

        [Parameter(Mandatory = $true)]
        [string]$CreatedWith,

        [Parameter()]
        [string]$Description,

        [Parameter()]
        [int]$Duration,

        [Parameter()]
        [object]$EventMetadata,

        [Parameter()]
        [int]$ProjectId,

        [Parameter()]
        [int[]]$SharedWithUserIds,

        [Parameter(Mandatory = $true)]
        [datetime]$Start,

        [Parameter()]
        [string]$StartDate,

        [Parameter()]
        [string]$Stop,

        [Parameter()]
        [string]$TagAction,

        [Parameter()]
        [int[]]$TagIds,

        [Parameter()]
        [string[]]$Tags,

        [Parameter()]
        [int]$TaskId,

        [Parameter()]
        [int]$UserId
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/time_entries"

    $body = @{}

    if ($PSBoundParameters.ContainsKey('Billable')) { $body.billable = $Billable }
    if ($PSBoundParameters.ContainsKey('CreatedWith')) { $body.created_with = $CreatedWith }
    if ($PSBoundParameters.ContainsKey('Description')) { $body.description = $Description }
    if ($PSBoundParameters.ContainsKey('Duration')) { $body.duration = $Duration }
    if ($PSBoundParameters.ContainsKey('EventMetadata')) { $body.event_metadata = $EventMetadata }
    if ($PSBoundParameters.ContainsKey('ProjectId')) { $body.project_id = $ProjectId }
    if ($PSBoundParameters.ContainsKey('SharedWithUserIds')) { $body.shared_with_user_ids = $SharedWithUserIds }
    if ($PSBoundParameters.ContainsKey('Start')) { $body.start = $Start.ToString("yyyy-MM-ddTHH:mm:ssZ") }
    if ($PSBoundParameters.ContainsKey('StartDate')) { $body.start_date = $StartDate }
    if ($PSBoundParameters.ContainsKey('Stop')) { $body.stop = $Stop }
    if ($PSBoundParameters.ContainsKey('TagAction')) { $body.tag_action = $TagAction }
    if ($PSBoundParameters.ContainsKey('TagIds')) { $body.tag_ids = $TagIds }
    if ($PSBoundParameters.ContainsKey('Tags')) { $body.tags = $Tags }
    if ($PSBoundParameters.ContainsKey('TaskId')) { $body.task_id = $TaskId }
    if ($PSBoundParameters.ContainsKey('UserId')) { $body.user_id = $UserId }
    if ($PSBoundParameters.ContainsKey('WorkspaceId')) { $body.workspace_id = $WorkspaceId }

    $jsonBody = $body | ConvertTo-Json -Compress -Depth 10

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken
    $headers.Add("Content-Type", "application/json")

    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $jsonBody
        return $response
    }
    catch {
        Write-Error "Failed to create time entry: $_"
    }
}

Export-ModuleMember -Function New-TogglTimeEntry