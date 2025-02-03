if (-not (Get-Module -Name Pester)) {
    Import-Module -Name Pester -Force
}
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

Describe 'Toggl Projects Integration Tests' {
    BeforeAll {
        $configPath = Join-Path -Path $PSScriptRoot -ChildPath "..\config.json"
        $config = Get-Content -Path $configPath | ConvertFrom-Json

        $apiToken = $config.apiToken
        $workspaceId = $config.workspaceId

        $projectName = "TestProjectToRemove"
        $projectId = $null
    }

    Context "New-TogglProject" {
        It "should create a new project in the workspace" {
            $newProject = New-TogglProject `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -Name $projectName `
                -Active $true

            $newProject | Should -Not -BeNullOrEmpty
            $newProject.name | Should -BeExactly $projectName
            $Script:projectId = $newProject.id
        }
    }

    Context "Get-TogglProjects" {
        It "should retrieve the project from the workspace" {
            $projects = Get-TogglProjects `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -SortPinned $true `
                -Name $projectName `
                -Page 1 `
                -SortField "name" `
                -SortOrder "asc" `
                -OnlyTemplates $false
            $projects | Where-Object { $_.id -eq $Script:projectId } | Should -Not -BeNullOrEmpty
        }
    }

    Context "Remove-TogglProject" {
        It "should delete the project from the workspace" -Skip:($Script:projectId -eq $null) {
            Remove-TogglProject `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -ProjectId $Script:projectId

            # Verify the project was deleted
            $projects = Get-TogglProjects `
                -ApiToken $apiToken `
                -WorkspaceId $workspaceId `
                -SortPinned $true `
                -Name $projectName `
                -Page 1 `
                -SortField "name" `
                -SortOrder "asc" `
                -OnlyTemplates $false
            $projects | Where-Object { $_.id -eq $Script:projectId } | Should BeNullOrEmpty
        }
    }
}