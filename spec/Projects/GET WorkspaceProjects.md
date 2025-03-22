## GET WorkspaceProjects [​#](https://engineering.toggl.com/docs/api/projects/#get-workspaceprojects "Direct link to GET WorkspaceProjects")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/projects
```

Get projects for given workspace.


```
curl  https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/projects \
  -H "Content-Type: application/json" \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/projects/#parameters-5 "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/projects/#path-5 "Direct link to Path")

| name         | type    | required | description                 |
| :----------- | :------ | :------- | :-------------------------- |
| workspace_id | integer | true     | Numeric ID of the workspace |

#### Query [​#](https://engineering.toggl.com/docs/api/projects/#query-2 "Direct link to Query")

| name        | type    | required | description                              |
| :---------- | :------ | :------- | :--------------------------------------- |
| sort_pinned | boolean | true     | Place pinned projects at top of response |

#### Query [​#](https://engineering.toggl.com/docs/api/projects/#query-3 "Direct link to Query")

| name           | type    | required | description                                                                                      |
| :------------- | :------ | :------- | :----------------------------------------------------------------------------------------------- |
| active         | boolean | false    | Return active or inactive project. You can pass 'both' to get both active and inactive projects. |
| since          | integer | false    | Retrieve projects created/modified/deleted since this date using UNIX timestamp.                 |
| billable       | boolean | false    | billable                                                                                         |
| user_ids       | array   | false    | user_ids                                                                                         |
| client_ids     | array   | false    | client_ids                                                                                       |
| group_ids      | array   | false    | group_ids                                                                                        |
| statuses       | array   | false    | statuses                                                                                         |
| name           | string  | true     | name                                                                                             |
| page           | integer | true     | page                                                                                             |
| sort_field     | string  | true     | sort_field                                                                                       |
| sort_order     | string  | true     | sort_order                                                                                       |
| only_templates | boolean | true     | only_templates                                                                                   |
| only_me        | boolean | false    | get only projects assigned to the current user                                                   |
| per_page       | integer | false    | Number of items per page, default 151. Cannot exceed 200.                                        |

### Response [​#](https://engineering.toggl.com/docs/api/projects/#response-5 "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/projects/#200-5 "Direct link to 200")

| Name  | Type            | Description |
| ----- | --------------- | ----------- |
| items | Array of object | \-          |

##### items [​#](https://engineering.toggl.com/docs/api/projects/#items-1 "Direct link to items")

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

##### current_period [​#](https://engineering.toggl.com/docs/api/projects/#current_period "Direct link to current_period")

| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| end_date   | string | \-          |
| start_date | string | \-          |

##### recurring_parameters [​#](https://engineering.toggl.com/docs/api/projects/#recurring_parameters "Direct link to recurring_parameters")

| Name                 | Type    | Description                                         |
| -------------------- | ------- | --------------------------------------------------- |
| custom_period        | integer | Custom period, used when "period" field is "custom" |
| estimated_seconds    | integer | Estimated seconds                                   |
| parameter_end_date   | string  | null                                                |
| parameter_start_date | string  | Recurring start date                                |
| period               | string  | Period                                              |
| project_start_date   | string  | Project start date                                  |

#### 403 [​#](https://engineering.toggl.com/docs/api/projects/#403-5 "Direct link to 403")

User does not have access to this resource.

#### 500 [​#](https://engineering.toggl.com/docs/api/projects/#500-5 "Direct link to 500")

Internal Server Error