<#
.SYNOPSIS
Creates a new project in a specified workspace in Toggl.

.DESCRIPTION
This cmdlet creates a new project in a specified workspace in Toggl. It sends a POST request to the Toggl API.

.PARAMETER ApiToken
The API token for authentication. (Mandatory)

.PARAMETER WorkspaceId
Numeric ID of the workspace. (Mandatory)

.PARAMETER Name
Project name. (Mandatory)

.PARAMETER Active
Whether the project is active or archived. (Optional)

.PARAMETER AutoEstimates
Whether estimates are based on task hours, optional, premium feature. (Optional)

.PARAMETER Billable
Whether the project is set as billable, optional, premium feature. (Optional)

.PARAMETER ClientId
Client ID, optional. (Optional)

.PARAMETER ClientName
Client name, optional. (Optional)

.PARAMETER Color
Project color. (Optional)

.PARAMETER Currency
Project currency, optional, premium feature. (Optional)

.PARAMETER EndDate
End date of a project timeframe. (Optional)

.PARAMETER EstimatedHours
Estimated hours, optional, premium feature. (Optional)

.PARAMETER ExternalReference
External reference. (Optional)

.PARAMETER FixedFee
Project fixed fee, optional, premium feature. (Optional)

.PARAMETER IsPrivate
Whether the project is private or not. (Optional)

.PARAMETER IsShared
Whether the project is shared. (Optional)

.PARAMETER Rate
Hourly rate, optional, premium feature. (Optional)

.PARAMETER RateChangeMode
Rate change mode, optional, premium feature. Can be "start-today", "override-current", "override-all". (Optional)

.PARAMETER Recurring
Whether the project is recurring, optional, premium feature. (Optional)

.PARAMETER RecurringParameters
Project recurring parameters, optional, premium feature. (Optional)

.PARAMETER StartDate
Start date of a project timeframe. (Optional)

.PARAMETER Template
Whether the project is a template, optional, premium feature. (Optional)

.PARAMETER TemplateId
Template ID, optional. (Optional)

.EXAMPLE
New-TogglProject -ApiToken "your_api_token" -WorkspaceId 123456 -Name "New Project"
#>
function New-TogglProject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,

        [Parameter(Mandatory = $true)]
        [int]$WorkspaceId,

        [Parameter(Mandatory = $true)]
        [string]$Name,

        [bool]$Active,

        [bool]$AutoEstimates,

        [bool]$Billable,

        [int]$ClientId,

        [string]$ClientName,

        [string]$Color,

        [string]$Currency,

        [string]$EndDate,

        [int]$EstimatedHours,

        [string]$ExternalReference,

        [decimal]$FixedFee,

        [bool]$IsPrivate,

        [bool]$IsShared,

        [decimal]$Rate,

        [string]$RateChangeMode,

        [bool]$Recurring,

        [psobject]$RecurringParameters,

        [string]$StartDate,

        [bool]$Template,

        [int]$TemplateId
    )

    $url = "$Global:TogglBaseUrl/workspaces/$WorkspaceId/projects"

    $body = @{
        name = $Name
    }

    if ($PSBoundParameters.ContainsKey('Active')) { $body.active = $Active }
    if ($PSBoundParameters.ContainsKey('AutoEstimates')) { $body.auto_estimates = $AutoEstimates }
    if ($PSBoundParameters.ContainsKey('Billable')) { $body.billable = $Billable }
    if ($PSBoundParameters.ContainsKey('ClientId')) { $body.client_id = $ClientId }
    if ($PSBoundParameters.ContainsKey('ClientName')) { $body.client_name = $ClientName }
    if ($PSBoundParameters.ContainsKey('Color')) { $body.color = $Color }
    if ($PSBoundParameters.ContainsKey('Currency')) { $body.currency = $Currency }
    if ($PSBoundParameters.ContainsKey('EndDate')) { $body.end_date = $EndDate }
    if ($PSBoundParameters.ContainsKey('EstimatedHours')) { $body.estimated_hours = $EstimatedHours }
    if ($PSBoundParameters.ContainsKey('ExternalReference')) { $body.external_reference = $ExternalReference }
    if ($PSBoundParameters.ContainsKey('FixedFee')) { $body.fixed_fee = $FixedFee }
    if ($PSBoundParameters.ContainsKey('IsPrivate')) { $body.is_private = $IsPrivate }
    if ($PSBoundParameters.ContainsKey('IsShared')) { $body.is_shared = $IsShared }
    if ($PSBoundParameters.ContainsKey('Rate')) { $body.rate = $Rate }
    if ($PSBoundParameters.ContainsKey('RateChangeMode')) { $body.rate_change_mode = $RateChangeMode }
    if ($PSBoundParameters.ContainsKey('Recurring')) { $body.recurring = $Recurring }
    if ($PSBoundParameters.ContainsKey('RecurringParameters')) { $body.recurring_parameters = $RecurringParameters }
    if ($PSBoundParameters.ContainsKey('StartDate')) { $body.start_date = $StartDate }
    if ($PSBoundParameters.ContainsKey('Template')) { $body.template = $Template }
    if ($PSBoundParameters.ContainsKey('TemplateId')) { $body.template_id = $TemplateId }

    $jsonBody = $body | ConvertTo-Json -Compress -Depth 10

    $headers = Get-TogglAuthHeader -ApiToken $ApiToken
    $headers.Add("Content-Type", "application/json")

    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $jsonBody
        return $response
    }
    catch {
        Write-Error "Failed to create project: $_"
    }
}

Export-ModuleMember -Function New-TogglProject