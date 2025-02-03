if (-not (Get-Module -Name Pester)) {
    Import-Module -Name Pester -Force
}
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

Describe 'Toggl Tag Integration Tests' {
    BeforeAll {
        . "$PSScriptRoot\..\Initialize-Parameters.ps1"

        $tagName = "TestTagToRemove"
    }

    Context "New-TogglTag" {
        It "should create a new tag in the workspace" {
            $newTag = New-TogglTag -ApiToken $apiToken -WorkspaceId $workspaceId -Name $tagName
            $newTag | Should -Not -BeNullOrEmpty
            $newTag.name | Should -BeExactly $tagName
            $Script:tagId = $newTag.id
        }
    }

    Context "Get-TogglTags" {
        It "should retrieve the list of tags for the workspace" {
            $tags = Get-TogglTags -ApiToken $apiToken -WorkspaceId $workspaceId
            $tags | Should -Not -BeNullOrEmpty
            $tags | Where-Object { $_.name -eq $tagName } | Should -Not -BeNullOrEmpty
        }
    }

    Context "Remove-TogglTag" {
        It "should delete the tag from the workspace" {
            Remove-TogglTag -ApiToken $apiToken -WorkspaceId $workspaceId -TagId $Script:tagId

            # Verify the tag was deleted
            $tags = Get-TogglTags -ApiToken $apiToken -WorkspaceId $workspaceId
            $tags | Where-Object { $_.id -eq $Script:tagId } | Should -BeNullOrEmpty
        }
    }
}