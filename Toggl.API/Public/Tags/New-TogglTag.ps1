<#
.SYNOPSIS
Creates a new tag in a specified workspace in Toggl.

.DESCRIPTION
This cmdlet creates a new tag in a specified workspace in Toggl. It sends a POST request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER Name
The name of the tag. (Mandatory)

.EXAMPLE
New-TogglTag -ApiToken "your_api_token" -WorkspaceId 123456 -Name "NewTag"
#>
function New-TogglTag {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/tags"

    $body = @{
        name = $Name
    }

    $jsonBody = $body | ConvertTo-Json -Compress -Depth 10

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken
    $headers.Add("Content-Type", "application/json")

    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $jsonBody
        return $response
    }
    catch {
        Write-Error "Failed to create tag: $_"
    }
}

Export-ModuleMember -Function New-TogglTag