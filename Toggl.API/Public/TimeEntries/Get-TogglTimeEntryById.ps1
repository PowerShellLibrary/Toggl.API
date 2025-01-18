<#
.SYNOPSIS
Retrieves a time entry by ID from Toggl.

.DESCRIPTION
This cmdlet retrieves a time entry by ID from Toggl using the provided parameters. It sends a GET request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER TimeEntryId
The ID of the time entry to retrieve. (Mandatory)

.PARAMETER Meta
Should the response contain data for meta entities. (Optional)

.PARAMETER IncludeSharing
Include sharing details in the response. (Optional)

.EXAMPLE
Get-TogglTimeEntryById -ApiToken "your_api_token" -TimeEntryId 123456

#>
function Get-TogglTimeEntryById {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [Int64]$TimeEntryId,

        [bool]$Meta = $false,

        [bool]$IncludeSharing = $false
    )

    $params = @{
        meta = $Meta
        include_sharing = $IncludeSharing
    }

    $queryString = ($params.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'
    $url = "$Global:TogglBaseUrl/me/time_entries/$TimeEntryId`?$queryString"

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken

    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        return $response
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 404) {
            return $null
        }
        else {
            Write-Error "Failed to retrieve time entry: $_"
        }
    }
}

Export-ModuleMember -Function Get-TogglTimeEntryById