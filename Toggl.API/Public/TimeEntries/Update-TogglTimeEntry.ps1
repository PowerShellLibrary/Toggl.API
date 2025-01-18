<#
.SYNOPSIS
Updates a workspace time entry in Toggl.

.DESCRIPTION
This cmdlet updates a workspace time entry in Toggl using the provided parameters. It sends a PUT request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER TimeEntryId
TimeEntry ID. (Mandatory)

.PARAMETER Billable
Whether the time entry is marked as billable. (Optional, default: $false)

.PARAMETER CreatedWith
The service/application used to create the time entry. (Optional)

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
The start time in UTC. Format: 2006-01-02T15:04:05Z. (Optional)

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

.EXAMPLE
Update-TogglTimeEntry -ApiToken "your_api_token" -WorkspaceId 123456 -TimeEntryId 789012 -Description "Updated description"
#>
function Update-TogglTimeEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [Parameter(Mandatory = $true)]
        [Int64]$TimeEntryId,

        [bool]$Billable = $false,

        [string]$CreatedWith,

        [string]$Description,

        [int]$Duration,

        [object]$EventMetadata,

        [int]$ProjectId,

        [int[]]$SharedWithUserIds,

        [datetime]$Start,

        [string]$StartDate,

        [string]$Stop,

        [string]$TagAction,

        [int[]]$TagIds,

        [string[]]$Tags,

        [int]$TaskId,

        [int]$UserId
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/time_entries/$TimeEntryId"

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

    $jsonBody = $body | ConvertTo-Json -Compress -Depth 10

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken
    $headers.Add("Content-Type", "application/json")

    try {
        $response = Invoke-RestMethod -Uri $url -Method Put -Headers $headers -Body $jsonBody
        return $response
    }
    catch {
        Write-Error "Failed to update time entry: $_"
    }
}

Export-ModuleMember -Function Update-TogglTimeEntry