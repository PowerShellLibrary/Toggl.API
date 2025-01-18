Import-Module -Name Pester -Force
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

$configPath = Join-Path -Path $PSScriptRoot -ChildPath "..\config.json"
$config = Get-Content -Path $configPath | ConvertFrom-Json

$apiToken = $config.apiToken
$workspaceId = $config.workspaceId

Describe 'Toggl Tag Integration Tests' {
    $tagName = "TestTagToRemove"

    Context "New-TogglTag" {
        It "should create a new tag in the workspace" {
            $newTag = New-TogglTag -ApiToken $apiToken -WorkspaceId $workspaceId -Name $tagName
            $newTag | Should -Not -BeNullOrEmpty
            $newTag.name | Should -BeExactly $tagName
            $Script:tagId = $newTag.id
        }
    }

    Context "Get-TogglTags" {
        It "should retrieve the list of tags for the workspace" -Skip:($Script:tagId -eq $null) {
            $tags = Get-TogglTags -ApiToken $apiToken -WorkspaceId $workspaceId
            $tags | Should -Not -BeNullOrEmpty
            $tags | Where-Object { $_.name -eq $tagName } | Should -Not -BeNullOrEmpty
        }
    }

    Context "Remove-TogglTag" {
        It "should delete the tag from the workspace" -Skip:($Script:tagId -eq $null) {
            Remove-TogglTag -ApiToken $apiToken -WorkspaceId $workspaceId -TagId $Script:tagId

            # Verify the tag was deleted
            $tags = Get-TogglTags -ApiToken $apiToken -WorkspaceId $workspaceId
            $tags | Where-Object { $_.id -eq $Script:tagId } | Should BeNullOrEmpty
        }
    }
}