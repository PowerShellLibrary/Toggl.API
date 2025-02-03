$configPath = Join-Path -Path $PSScriptRoot -ChildPath "..\config.json"

if (Test-Path -Path $configPath) {
    $config = Get-Content -Path $configPath | ConvertFrom-Json
    $apiToken = $config.apiToken
    $workspaceId = $config.workspaceId
}
else {
    if ($env:TOGGL_API_TOKEN -eq $null) {
        .\scripts\load-env.ps1
    }
    $apiToken = $env:TOGGL_API_TOKEN
    $workspaceId = $env:TOGGL_WORKSPACE_ID
}