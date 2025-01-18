<#
.SYNOPSIS
Deletes a tag in a specified workspace in Toggl.

.DESCRIPTION
This cmdlet deletes a tag in a specified workspace in Toggl. It sends a DELETE request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER TagId
Numeric ID of the tag. (Mandatory)

.EXAMPLE
Remove-TogglTag -ApiToken "your_api_token" -WorkspaceId 123456 -TagId 789012
#>
function Remove-TogglTag {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [Parameter(Mandatory = $true)]
        [int]$TagId
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/tags/$TagId"

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken

    try {
        Invoke-RestMethod -Uri $url -Method Delete -Headers $headers
        Write-Output "Tag deleted successfully."
    }
    catch {
        Write-Error "Failed to delete tag: $_"
    }
}

Export-ModuleMember -Function Remove-TogglTag