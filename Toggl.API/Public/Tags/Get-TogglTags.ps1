<#
.SYNOPSIS
Lists workspace tags from Toggl.

.DESCRIPTION
This cmdlet retrieves the list of tags for a specified workspace from Toggl. It sends a GET request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.EXAMPLE
Get-TogglTags -ApiToken "your_api_token" -WorkspaceId 123456
#>
function Get-TogglTags {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/tags"

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken

    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        return $response
    }
    catch {
        Write-Error "Failed to retrieve tags: $_"
    }
}

Export-ModuleMember -Function Get-TogglTags