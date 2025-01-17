Clear-Host
Import-Module -Name Pester -Force
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

Describe 'Toggl.API.Tests' {
    Context "C1" {

        It "given A=<A>, it returns: '<Expected>'" -TestCases @(
            @{ A = "true"; Expected = $true }
            @{ A = "false"; Expected = $false }
        ) {
            param ($A, $Expected)
            [bool]::Parse($A)  | Should -BeExactly $Expected
        }

        It "shouldn't accept" {
            $true | Should -BeTrue
        }
    }
}
