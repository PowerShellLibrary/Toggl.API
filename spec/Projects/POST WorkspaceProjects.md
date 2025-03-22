## POST WorkspaceProjects [​#](https://engineering.toggl.com/docs/api/projects/#post-workspaceprojects "Direct link to POST WorkspaceProjects")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/projects
```

Create project for given workspace.


```
curl -X POST https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/projects \
  -H "Content-Type: application/json" \
  -d '\{"active":"boolean","auto_estimates":"boolean","billable":"boolean","cid":"integer","client_id":"integer","client_name":"string","color":"string","currency":"string","end_date":"string","estimated_hours":"integer","external_reference":"string","fixed_fee":"number","is_private":"boolean","is_shared":"boolean","name":"string","rate":"number","rate_change_mode":"string","recurring":"boolean","recurring_parameters":\{"custom_period":"integer","period":"string","project_start_date":"string"\},"start_date":"string","template":"boolean","template_id":"integer"\}' \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/projects/#parameters-6 "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/projects/#path-6 "Direct link to Path")

| name         | type    | required | description                 |
| :----------- | :------ | :------- | :-------------------------- |
| workspace_id | integer | true     | Numeric ID of the workspace |

#### Body [​#](https://engineering.toggl.com/docs/api/projects/#body-2 "Direct link to Body")

| Name                 | Type    | Description                                                                                           |
| -------------------- | ------- | ----------------------------------------------------------------------------------------------------- |
| active               | boolean | Whether the project is active or archived                                                             |
| auto_estimates       | boolean | Whether estimates are based on task hours, optional, premium feature                                  |
| billable             | boolean | Whether the project is set as billable, optional, premium feature                                     |
| cid                  | integer | Client ID, legacy                                                                                     |
| client_id            | integer | Client ID, optional                                                                                   |
| client_name          | string  | Client name, optional                                                                                 |
| color                | string  | Project color                                                                                         |
| currency             | string  | Project currency, optional, premium feature                                                           |
| end_date             | string  | End date of a project timeframe                                                                       |
| estimated_hours      | integer | Estimated hours, optional, premium feature                                                            |
| external_reference   | string  | \-                                                                                                    |
| fixed_fee            | number  | Project fixed fee, optional, premium feature                                                          |
| is_private           | boolean | Whether the project is private or not                                                                 |
| is_shared            | boolean | Shared                                                                                                |
| name                 | string  | Project name                                                                                          |
| rate                 | number  | Hourly rate, optional, premium feature                                                                |
| rate_change_mode     | string  | Rate change mode, optional, premium feature. Can be "start-today", "override-current", "override-all" |
| recurring            | boolean | Project is recurring, optional, premium feature                                                       |
| recurring_parameters | object  | Project recurring parameters, optional, premium feature                                               |
| start_date           | string  | Start date of a project timeframe                                                                     |
| template             | boolean | Project is template, optional, premium feature                                                        |
| template_id          | integer | Template ID, optional                                                                                 |

##### recurring_parameters [​#](https://engineering.toggl.com/docs/api/projects/#recurring_parameters-1 "Direct link to recurring_parameters")

| Name               | Type    | Description                                                  |
| ------------------ | ------- | ------------------------------------------------------------ |
| custom_period      | integer | Recurring custom period, the "period" field must be "custom" |
| period             | string  | Recurring period, example "monthly"                          |
| project_start_date | string  | Recurring start date                                         |

### Response [​#](https://engineering.toggl.com/docs/api/projects/#response-6 "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/projects/#200-6 "Direct link to 200")

| Name                 | Type            | Description                                                                               |
| -------------------- | --------------- | ----------------------------------------------------------------------------------------- |
| active               | boolean         | Whether the project is active or archived                                                 |
| actual_hours         | integer         | null                                                                                      |
| actual_seconds       | integer         | null                                                                                      |
| at                   | string          | Last updated date                                                                         |
| auto_estimates       | boolean         | null                                                                                      |
| billable             | boolean         | null                                                                                      |
| can_track_time       | boolean         | \-                                                                                        |
| cid                  | integer         | Client ID legacy field                                                                    |
| client_id            | integer         | null                                                                                      |
| client_name          | string          | \-                                                                                        |
| color                | string          | Color                                                                                     |
| created_at           | string          | Creation date                                                                             |
| currency             | string          | null                                                                                      |
| current_period       | object          | Current project period, premium feature                                                   |
| end_date             | string          | End date                                                                                  |
| estimated_hours      | integer         | null                                                                                      |
| estimated_seconds    | integer         | null                                                                                      |
| external_reference   | string          | ExternalReference can be used to store an external reference to the Track Project Entity. |
| fixed_fee            | number          | Fixed fee, premium feature                                                                |
| id                   | integer         | Project ID                                                                                |
| integration_ext_id   | string          | The external ID of the linked entity in the external system (e.g. JIRA/SalesForce)        |
| integration_ext_type | string          | The external type of the linked entity in the external system (e.g. JIRA/SalesForce)      |
| integration_provider | string          | The provider (e.g. JIRA/SalesForce) that has an entity linked to this Toggl Track entity  |
| is_private           | boolean         | Whether the project is private                                                            |
| is_shared            | boolean         | Shared Project                                                                            |
| name                 | string          | Name                                                                                      |
| permissions          | string          | \-                                                                                        |
| pinned               | boolean         | \-                                                                                        |
| rate                 | number          | Hourly rate                                                                               |
| rate_last_updated    | string          | null                                                                                      |
| recurring            | boolean         | Whether the project is recurring, premium feature                                         |
| recurring_parameters | Array of object | Project recurring parameters, premium feature                                             |
| shared_at            | string          | \-                                                                                        |
| shared_hash          | string          | \-                                                                                        |
| start_date           | string          | Start date                                                                                |
| status               | string          | Status of the project (upcoming, active, ended, archived, deleted)                        |
| tasks_count          | integer         | \-                                                                                        |
| template             | boolean         | null                                                                                      |
| template_id          | integer         | null                                                                                      |
| wid                  | integer         | Workspace ID legacy field                                                                 |
| workspace_id         | integer         | Workspace ID                                                                              |

##### current_period [​#](https://engineering.toggl.com/docs/api/projects/#current_period-1 "Direct link to current_period")

| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| end_date   | string | \-          |
| start_date | string | \-          |

##### recurring_parameters [​#](https://engineering.toggl.com/docs/api/projects/#recurring_parameters-2 "Direct link to recurring_parameters")

| Name                 | Type    | Description                                         |
| -------------------- | ------- | --------------------------------------------------- |
| custom_period        | integer | Custom period, used when "period" field is "custom" |
| estimated_seconds    | integer | Estimated seconds                                   |
| parameter_end_date   | string  | null                                                |
| parameter_start_date | string  | Recurring start date                                |
| period               | string  | Period                                              |
| project_start_date   | string  | Project start date                                  |

#### 403 [​#](https://engineering.toggl.com/docs/api/projects/#403-6 "Direct link to 403")

User does not have access to this resource.

#### 500 [​#](https://engineering.toggl.com/docs/api/projects/#500-6 "Direct link to 500")

Internal Server Error