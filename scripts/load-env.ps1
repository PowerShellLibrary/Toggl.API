param (
    [switch]$Verbose
)

Get-Content "$PSScriptRoot\..\.env" | ForEach-Object {
    if ($_ -match '^(.*?)=(.*)$') {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim()

        if ($Verbose) {
            Write-Host "Setting environment variable: $Key=$value" -ForegroundColor Green
        }
        else {
            Write-Host "Setting environment variable: $Key=********" -ForegroundColor Green
        }
        Set-Item "env:$key" $value
    }
}