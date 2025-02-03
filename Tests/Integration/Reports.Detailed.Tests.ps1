if (-not (Get-Module -Name Pester)) {
    Import-Module -Name Pester -Force
}
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

Describe 'Reports.Detailed Integration Tests' {
    BeforeAll {
        $configPath = Join-Path -Path $PSScriptRoot -ChildPath "..\config.json"
        $config = Get-Content -Path $configPath | ConvertFrom-Json

        $apiToken = $config.apiToken
        $workspaceId = $config.workspaceId

        $startDate = "2023-01-01"
        $endDate = "2023-12-31"

        $timeEntryIds = @()
        $tagIds = @()
        $start = [datetime]::ParseExact("2023-01-01", "yyyy-MM-dd", $null)
        $createdWith = "PesterTest"

        # Create first time entry
        $response1 = New-TogglTimeEntry `
            -ApiToken $apiToken `
            -WorkspaceId $workspaceId `
            -CreatedWith $createdWith `
            -Start $start `
            -Description "Test Time Entry 1"

        $response1 | Should -Not -BeNullOrEmpty
        $timeEntryIds += $response1.id

        # Create second time entry
        $response2 = New-TogglTimeEntry `
            -ApiToken $apiToken `
            -WorkspaceId $workspaceId `
            -CreatedWith $createdWith `
            -Start $start `
            -Description "Test Time Entry 2"

        $response2 | Should -Not -BeNullOrEmpty
        $timeEntryIds += $response2.id

        $response3 = New-TogglTimeEntry `
            -ApiToken $apiToken `
            -WorkspaceId $workspaceId `
            -CreatedWith $createdWith `
            -Start $start `
            -Description "Test Time Entry 3" `
            -Tags @("tag1", "tag2")

        $response3 | Should -Not -BeNullOrEmpty
        $timeEntryIds += $response3.id
        $tagIds += $response3.tag_ids
    }

    AfterAll {
        foreach ($timeEntryId in $timeEntryIds) {
            Remove-TogglTimeEntry `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -TimeEntryId $timeEntryId
        }
    }

    Context "Search-TogglTimeEntries" {
        It "should search for time entries with given filters" {

            $response = Search-TogglTimeEntries `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -StartDate $startDate `
                -EndDate $endDate `
                -PageSize 10

            $response | Should -Not -BeNullOrEmpty
            $response.GetType().Name | Should -Be "Object[]"
            $response.Count | Should -BeExactly $timeEntryIds.Count

            $response | ForEach-Object {
                $_.description | Should -Match "Test Time Entry"
            }

            $response.time_entries.id | ForEach-Object {
                $timeEntryIds | Should -Contain $_
            }
        }

        It "should search for time entries without tags" {
            $response = Search-TogglTimeEntries `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -StartDate $startDate `
                -EndDate $endDate `
                -TagIds @() `
                -PageSize 10

            $response | Should -Not -BeNullOrEmpty
            $response.GetType().Name | Should -Be "Object[]"

            $response | ForEach-Object {
                $_.tags | Should -BeNullOrEmpty
            }
        }

        It "should search for time entries with tags" {
            $response = Search-TogglTimeEntries `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -StartDate $startDate `
                -EndDate $endDate `
                -TagIds $tagIds `
                -PageSize 10

            $response | Should -Not -BeNullOrEmpty

            $response.GetType().Name | Should -Be "PSCustomObject"

            $response.tag_ids | Should -BeExactly $tagIds
        }
    }
}