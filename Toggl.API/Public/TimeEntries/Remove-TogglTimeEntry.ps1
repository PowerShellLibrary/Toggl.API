<#
.SYNOPSIS
Deletes a workspace time entry.

.DESCRIPTION
This cmdlet deletes a time entry from a specified workspace in Toggl.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER TimeEntryId
TimeEntry ID. (Mandatory)

.EXAMPLE
Remove-TogglTimeEntry -ApiToken "your_api_token" -WorkspaceId 123456 -TimeEntryId 789012
#>
function Remove-TogglTimeEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [Parameter(Mandatory = $true)]
        [Int64]$TimeEntryId
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/time_entries/$TimeEntryId"

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken

    try {
        Invoke-RestMethod -Uri $url -Method Delete -Headers $headers
        Write-Output "Time entry deleted successfully."
    }
    catch {
        Write-Error "Failed to delete time entry: $_"
    }
}

Export-ModuleMember -Function Remove-TogglTimeEntry