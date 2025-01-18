<#
.SYNOPSIS
Returns time entries for detailed report according to the given filters.

.DESCRIPTION
This cmdlet retrieves time entries for a detailed report from Toggl using the provided parameters. It sends a POST request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER Billable
Whether the time entry is set as billable, optional, premium feature. (Optional)

.PARAMETER ClientIds
Client IDs, optional, filtering attribute. To filter records with no clients, use [null]. (Optional)

.PARAMETER Description
Description, optional, filtering attribute. (Optional)

.PARAMETER EndDate
End date, example time.DateOnly. Should be greater than Start date. (Optional)

.PARAMETER EnrichResponse
EnrichResponse, optional, default false. It will force the detailed report to return as much information as possible, as it does for the export. (Optional)

.PARAMETER FirstId
(Optional)

.PARAMETER FirstRowNumber
(Optional)

.PARAMETER FirstTimestamp
(Optional)

.PARAMETER GroupIds
Group IDs, optional, filtering attribute. (Optional)

.PARAMETER Grouped
Whether time entries should be grouped, optional, default false. (Optional)

.PARAMETER HideAmounts
Whether amounts should be hidden, optional, default false. (Optional)

.PARAMETER MaxDurationSeconds
Max duration seconds, optional, filtering attribute. Time Audit only, should be greater than MinDurationSeconds. (Optional)

.PARAMETER MinDurationSeconds
Min duration seconds, optional, filtering attribute. Time Audit only, should be less than MaxDurationSeconds. (Optional)

.PARAMETER OrderBy
Order by field, optional, default "date". Can be "date", "user", "duration", "description" or "last_update". (Optional)

.PARAMETER OrderDir
Order direction, optional. Can be ASC or DESC. (Optional)

.PARAMETER PageSize
PageSize defines the number of items per page, optional, default 50. (Optional)

.PARAMETER ProjectIds
Project IDs, optional, filtering attribute. To filter records with no projects, use [null]. (Optional)

.PARAMETER Rounding
Whether time should be rounded, optional, default from user preferences. (Optional)

.PARAMETER RoundingMinutes
Rounding minutes value, optional, default from user preferences. Should be 0, 1, 5, 6, 10, 12, 15, 30, 60 or 240. (Optional)

.PARAMETER StartTime
(Optional)

.PARAMETER StartDate
Start date, example time.DateOnly. Should be less than End date. (Optional)

.PARAMETER TagIds
Tag IDs, optional, filtering attribute. To filter records with no tags, use [null]. (Optional)

.PARAMETER TaskIds
Task IDs, optional, filtering attribute. To filter records with no tasks, use [null]. (Optional)

.PARAMETER TimeEntryIds
TimeEntryIDs filters by time entries. This was added to support retro-compatibility with reports v2. (Optional)

.PARAMETER UserIds
User IDs, optional, filtering attribute. (Optional)

.EXAMPLE
Search-TogglTimeEntries -ApiToken "your_api_token" -WorkspaceId 123456 -StartDate "2023-01-01" -EndDate "2023-12-31"
#>
function Search-TogglTimeEntries {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [bool]$Billable,

        [int[]]$ClientIds,

        [string]$Description,

        [string]$EndDate,

        [bool]$EnrichResponse = $false,

        [int]$FirstId,

        [int]$FirstRowNumber,

        [int]$FirstTimestamp,

        [int[]]$GroupIds,

        [bool]$Grouped = $false,

        [bool]$HideAmounts = $false,

        [int]$MaxDurationSeconds,

        [int]$MinDurationSeconds,

        [string]$OrderBy = "date",

        [string]$OrderDir = "asc",

        [int]$PageSize = 50,

        [int[]]$ProjectIds,

        [int]$Rounding,

        [int]$RoundingMinutes,

        [string]$StartTime,

        [string]$StartDate,

        [int[]]$TagIds,

        [int[]]$TaskIds,

        [int[]]$TimeEntryIds,

        [int[]]$UserIds
    )

    $url = "$Global:TogglReportsBaseUrl/workspace/$WorkspaceId/search/time_entries"

    $body = @{}

    if ($PSBoundParameters.ContainsKey('Billable')) { $body.billable = $Billable }
    if ($PSBoundParameters.ContainsKey('ClientIds')) { $body.client_ids = $ClientIds }
    if ($PSBoundParameters.ContainsKey('Description')) { $body.description = $Description }
    if ($PSBoundParameters.ContainsKey('EndDate')) { $body.end_date = $EndDate }
    if ($PSBoundParameters.ContainsKey('EnrichResponse')) { $body.enrich_response = $EnrichResponse }
    if ($PSBoundParameters.ContainsKey('FirstId')) { $body.first_id = $FirstId }
    if ($PSBoundParameters.ContainsKey('FirstRowNumber')) { $body.first_row_number = $FirstRowNumber }
    if ($PSBoundParameters.ContainsKey('FirstTimestamp')) { $body.first_timestamp = $FirstTimestamp }
    if ($PSBoundParameters.ContainsKey('GroupIds')) { $body.group_ids = $GroupIds }
    if ($PSBoundParameters.ContainsKey('Grouped')) { $body.grouped = $Grouped }
    if ($PSBoundParameters.ContainsKey('HideAmounts')) { $body.hide_amounts = $HideAmounts }
    if ($PSBoundParameters.ContainsKey('MaxDurationSeconds')) { $body.max_duration_seconds = $MaxDurationSeconds }
    if ($PSBoundParameters.ContainsKey('MinDurationSeconds')) { $body.min_duration_seconds = $MinDurationSeconds }
    if ($PSBoundParameters.ContainsKey('OrderBy')) { $body.order_by = $OrderBy }
    if ($PSBoundParameters.ContainsKey('OrderDir')) { $body.order_dir = $OrderDir }
    if ($PSBoundParameters.ContainsKey('PageSize')) { $body.page_size = $PageSize }
    if ($PSBoundParameters.ContainsKey('ProjectIds')) { $body.project_ids = $ProjectIds }
    if ($PSBoundParameters.ContainsKey('Rounding')) { $body.rounding = $Rounding }
    if ($PSBoundParameters.ContainsKey('RoundingMinutes')) { $body.rounding_minutes = $RoundingMinutes }
    if ($PSBoundParameters.ContainsKey('StartTime')) { $body.start_time = $StartTime }
    if ($PSBoundParameters.ContainsKey('StartDate')) { $body.start_date = $StartDate }
    if ($PSBoundParameters.ContainsKey('TagIds')) {
        if ($TagIds.Count -eq 0) {
            $body.tag_ids = @($null)
        }
        else {
            $body.tag_ids = $TagIds
        }
    }
    if ($PSBoundParameters.ContainsKey('TaskIds')) { $body.task_ids = $TaskIds }
    if ($PSBoundParameters.ContainsKey('TimeEntryIds')) { $body.time_entry_ids = $TimeEntryIds }
    if ($PSBoundParameters.ContainsKey('UserIds')) { $body.user_ids = $UserIds }

    $jsonBody = $body | ConvertTo-Json -Compress -Depth 10

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken
    $headers.Add("Content-Type", "application/json")

    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $jsonBody
        return $response
    }
    catch {
        Write-Error "Failed to fetch detailed reports: $_"
    }
}

Export-ModuleMember -Function Search-TogglTimeEntries