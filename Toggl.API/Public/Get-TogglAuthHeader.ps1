function Get-TogglAuthHeader {
    param (
        [Parameter(Mandatory)]
        [string] $ApiKey
    )

    return @{ Authorization = "Basic " + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("$ApiKey`:api_token")) }
}