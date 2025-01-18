function Get-TogglAuthHeader {
    param (
        [Parameter(Mandatory)]
        [string] $ApiToken
    )

    return @{ Authorization = "Basic " + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("$ApiToken`:api_token")) }
}