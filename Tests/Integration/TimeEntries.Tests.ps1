Import-Module -Name Pester -Force
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

$configPath = Join-Path -Path $PSScriptRoot -ChildPath "..\config.json"
$config = Get-Content -Path $configPath | ConvertFrom-Json

$apiToken = $config.apiToken
$workspaceId = $config.workspaceId

Describe 'TimeEntries Integration Tests' {
    $timeEntryId = $null

    Context "New-TogglTimeEntry" {
        It "should create a new time entry" {
            $start = [datetime]::UtcNow
            $description = "Test Time Entry"
            $createdWith = "PesterTest"

            $response = New-TogglTimeEntry `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -CreatedWith $createdWith `
                -Start $start `
                -Description $description

            $response | Should Not BeNullOrEmpty
            $response.description | Should -BeExactly $description
            $Script:timeEntryId = $response.id
        }
    }

    Context "Get-TogglTimeEntryById" {
        It "should retrieve the created time entry by ID" -Skip:($Script:timeEntryId -eq $null) {
            $response = Get-TogglTimeEntryById `
                -ApiToken $apiToken `
                -TimeEntryId $Script:timeEntryId

            $response | Should Not BeNullOrEmpty
            $response.id | Should -BeExactly $Script:timeEntryId
        }

        It "should return null for a non-existing time entry ID" {
            $nonExistingTimeEntryId = 999999999

            $response = Get-TogglTimeEntryById `
                -ApiToken $apiToken `
                -TimeEntryId $nonExistingTimeEntryId

            $response | Should BeNullOrEmpty
        }
    }

    Context "Update-TogglTimeEntry" {
        It "should update the time entry" -Skip:($Script:timeEntryId -eq $null) {
            $newDescription = "Updated Test Time Entry"

            $response = Update-TogglTimeEntry `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -TimeEntryId $Script:timeEntryId `
                -Description $newDescription

            $response | Should Not BeNullOrEmpty
            $response.description | Should -BeExactly $newDescription
        }
    }

    Context "Get-TogglTimeEntries" {
        It "should retrieve the list of time entries" {
            $response = Get-TogglTimeEntries `
                -ApiToken $apiToken `
                -Since ([int][double]::Parse((Get-Date).AddDays(-7).ToUniversalTime().Subtract([datetime]'1970-01-01').TotalSeconds))

            $response | Should Not BeNullOrEmpty
            $response.GetType().Name | Should -Be "Object[]"

            $filteredResponse = $response | Where-Object { $_.server_deleted_at -ne $null }
            $filteredResponse | Should Not BeNullOrEmpty
            $filteredResponse.Count | Should -BeGreaterThan 0
        }
    }

    Context "Remove-TogglTimeEntry" {
        It "should delete the time entry" -Skip:($Script:timeEntryId -eq $null) {
            Remove-TogglTimeEntry `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -TimeEntryId $Script:timeEntryId

            $response = Get-TogglTimeEntryById `
                -ApiToken $apiToken `
                -TimeEntryId $Script:timeEntryId

            $response | Should BeNullOrEmpty
        }
    }
}