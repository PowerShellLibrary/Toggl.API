Get-Content "$PSScriptRoot\..\.env" | ForEach-Object {
    if ($_ -match '^(.*?)=(.*)$') {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim()
        Write-Host "Setting environment variable: $key=$value" -ForegroundColor Green
        Set-Item "env:$key" $value
    }
}