param (
    [Parameter(Mandatory = $false)]
    [string]$ApiToken = $env:TOGGL_API_TOKEN,

    [Parameter(Mandatory = $false)]
    [int]$WorkspaceId = [int]$env:TOGGL_WORKSPACE_ID
)

if (-not $ApiToken) {
    Write-Error "ApiToken is required."
    return
}

if (-not $WorkspaceId) {
    Write-Error "WorkspaceId is required."
    return
}

Clear-Host
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

Write-Host "Cleaning up the workspace"

Write-Host "Removing projects" -ForegroundColor DarkGreen
Get-TogglProjects -ApiToken $ApiToken -WorkspaceId $WorkspaceId  | % {
    Write-Host "Removing project: $($_.name)" -ForegroundColor DarkGray
    Remove-TogglProject `
        -ApiToken $ApiToken `
        -WorkspaceId $WorkspaceId `
        -ProjectId $_.id
}

Write-Host "Removing tags" -ForegroundColor DarkGreen
Get-TogglTags -ApiToken $ApiToken -WorkspaceId $WorkspaceId | % {
    Write-Host "Removing tag: $($_.name)" -ForegroundColor DarkGray
    Remove-TogglTag `
        -ApiToken $ApiToken `
        -WorkspaceId $WorkspaceId `
        -TagId $_.id
}

Write-Host "Removing time entries" -ForegroundColor DarkGreen
Get-TogglTimeEntries -ApiToken $ApiToken | ? { $_.wid -eq $WorkspaceId }  | ? { $_.server_deleted_at -eq $null } | % {
    Write-Host "Removing time entry: $($_.description)" -ForegroundColor DarkGray
    Remove-TogglTimeEntry `
        -ApiToken $ApiToken `
        -WorkspaceId $WorkspaceId `
        -TimeEntryId $_.id
}