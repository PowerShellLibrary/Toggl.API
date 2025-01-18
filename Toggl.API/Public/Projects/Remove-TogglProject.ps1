<#
.SYNOPSIS
Deletes a project in a specified workspace in Toggl.

.DESCRIPTION
This cmdlet deletes a project in a specified workspace in Toggl. It sends a DELETE request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER ProjectId
Numeric ID of the project. (Mandatory)

.PARAMETER TeDeletionMode
Time entries deletion mode: 'delete' or 'unassign'. (Optional)

.EXAMPLE
Remove-TogglProject -ApiToken "your_api_token" -WorkspaceId 123456 -ProjectId 789012
#>
function Remove-TogglProject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [Parameter(Mandatory = $true)]
        [int]$ProjectId,

        [string]$TeDeletionMode
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/projects/$ProjectId"

    $params = @{}
    if ($PSBoundParameters.ContainsKey('TeDeletionMode')) { $params['teDeletionMode'] = $TeDeletionMode }

    if ($params.Count -gt 0) {
        $queryString = ($params.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'
        $url = "$url?$queryString"
    }

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken

    try {
        Invoke-RestMethod -Uri $url -Method Delete -Headers $headers
        Write-Output "Project deleted successfully."
    }
    catch {
        Write-Error "Failed to delete project: $_"
    }
}

Export-ModuleMember -Function Remove-TogglProject