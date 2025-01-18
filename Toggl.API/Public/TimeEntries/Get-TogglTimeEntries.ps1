<#
.SYNOPSIS
Lists latest time entries from Toggl.

.DESCRIPTION
This cmdlet retrieves the latest time entries from Toggl using the provided parameters. It sends a GET request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER Meta
Should the response contain data for meta entities. (Optional)

.PARAMETER IncludeSharing
Include sharing details in the response. (Optional)

.PARAMETER Since
Get entries modified since this date using UNIX timestamp, including deleted ones. (Optional)

.PARAMETER Before
Get entries with start time, before given date (YYYY-MM-DD) or with time in RFC3339 format. (Optional)

.PARAMETER StartDate
Get entries with start time, from start_date YYYY-MM-DD or with time in RFC3339 format. To be used with end_date. (Optional)

.PARAMETER EndDate
Get entries with start time, until end_date YYYY-MM-DD or with time in RFC3339 format. To be used with start_date. (Optional)

.EXAMPLE
Get-TogglTimeEntries -ApiToken "your_api_token" -Since 1609459200 -Before "2023-12-31" -StartDate "2023-01-01" -EndDate "2023-12-31"
#>
function Get-TogglTimeEntries {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [bool]$Meta = $false,

        [bool]$IncludeSharing = $false,

        [int]$Since,

        [string]$Before,

        [string]$StartDate,

        [string]$EndDate
    )

    $params = @{
        meta            = $Meta
        include_sharing = $IncludeSharing
    }

    if ($PSBoundParameters.ContainsKey('Since')) { $params['since'] = $Since }
    if ($PSBoundParameters.ContainsKey('Before')) { $params['before'] = $Before }
    if ($PSBoundParameters.ContainsKey('StartDate')) { $params['start_date'] = $StartDate }
    if ($PSBoundParameters.ContainsKey('EndDate')) { $params['end_date'] = $EndDate }

    $queryString = ($params.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'
    $url = "$Global:TogglBaseUrl/me/time_entries?$queryString"

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken

    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        return $response
    }
    catch {
        Write-Error "Failed to retrieve time entries: $_"
    }
}

Export-ModuleMember -Function Get-TogglTimeEntries