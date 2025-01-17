Clear-Host
Import-Module -Name Pester -Force
Import-Module .\Toggl.API\Toggl.API.psm1 -Force

Describe 'Toggl.API.Tests' {
    Context "Authentication Header Tests" {

        It "should generate correct authorization header" {
            $expected = 'Basic MTIzYTEyYWJjZDFhYjEyMzRkODZhNDcxZTkxNjI5NWM6YXBpX3Rva2Vu'

            $header = Get-TogglAuthHeader -ApiKey 123a12abcd1ab1234d86a471e916295c
            $header.ContainsKey('Authorization') | Should -Be $true
            $header.Authorization | Should Not BeNullOrEmpty
            $header.Authorization | Should -BeExactly $expected
        }

        It "given apiKey=<apiKey>, it throws exception" -TestCases @(
            @{ apiKey = "" }
            @{ apiKey = $null }
        ) {
            { Get-TogglAuthHeader -ApiKey '' } | Should Throw "Cannot bind argument to parameter 'ApiKey' because it is an empty string."
        }
    }
}
