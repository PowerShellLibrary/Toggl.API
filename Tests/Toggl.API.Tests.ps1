Clear-Host
Import-Module -Name Pester -Force
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

Describe 'Toggl.API.Tests' {
    Context "Authentication Header Tests" {

        It "should generate correct authorization header" {
            $expected = 'Basic MTIzYTEyYWJjZDFhYjEyMzRkODZhNDcxZTkxNjI5NWM6YXBpX3Rva2Vu'

            $header = Get-TogglAuthHeader -ApiToken 123a12abcd1ab1234d86a471e916295c
            $header.ContainsKey('Authorization') | Should -Be $true
            $header.Authorization | Should Not BeNullOrEmpty
            $header.Authorization | Should -BeExactly $expected
        }

        It "given apiToken=<apiToken>, it throws exception" -TestCases @(
            @{ apiToken = "" }
            @{ apiToken = $null }
        ) {
            { Get-TogglAuthHeader -ApiToken '' } | Should Throw "Cannot bind argument to parameter 'ApiToken' because it is an empty string."
        }
    }
}
