## GET TimeEntries [​#](https://engineering.toggl.com/docs/api/time_entries/#get-timeentries "Direct link to GET TimeEntries")

```
https://api.track.toggl.com/api/v9/me/time_entries
```

Lists latest time entries.

- cURL
- Go
- Ruby
- JavaScript
- Python
- Rust

```
curl  https://api.track.toggl.com/api/v9/me/time_entries \
  -H "Content-Type: application/json" \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/time_entries/#parameters "Direct link to Parameters")

#### Query [​#](https://engineering.toggl.com/docs/api/time_entries/#query "Direct link to Query")

| name            | type    | required | description                                        |
| :-------------- | :------ | :------- | :------------------------------------------------- |
| meta            | boolean | false    | Should the response contain data for meta entities |
| include_sharing | boolean | false    | Include sharing details in the response            |

#### Query [​#](https://engineering.toggl.com/docs/api/time_entries/#query-1 "Direct link to Query")

| name       | type    | required | description                                                                                                        |
| :--------- | :------ | :------- | :----------------------------------------------------------------------------------------------------------------- |
| since      | integer | false    | Get entries modified since this date using UNIX timestamp, including deleted ones.                                 |
| before     | string  | false    | Get entries with start time, before given date (YYYY-MM-DD) or with time in RFC3339 format.                        |
| start_date | string  | false    | Get entries with start time, from start_date YYYY-MM-DD or with time in RFC3339 format. To be used with end_date.  |
| end_date   | string  | false    | Get entries with start time, until end_date YYYY-MM-DD or with time in RFC3339 format. To be used with start_date. |

### Response [​#](https://engineering.toggl.com/docs/api/time_entries/#response "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/time_entries/#200 "Direct link to 200")

| Name  | Type            | Description |
| ----- | --------------- | ----------- |
| items | Array of object | \-          |

##### items [​#](https://engineering.toggl.com/docs/api/time_entries/#items "Direct link to items")

| Name             | Type             | Description                                                                                                                                  |
| ---------------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| at               | string           | When was last updated, the field follows the ISO 8601 format (HH:mm:ss.ssssssZ)                                                              |
| billable         | boolean          | Whether the time entry is marked as billable                                                                                                 |
| client_name      | string           | Related entities meta fields - if requested                                                                                                  |
| description      | string           | null                                                                                                                                         |
| duration         | integer          | Time entry duration. For running entries should be negative, preferable -1                                                                   |
| duronly          | boolean          | Used to create a TE with a duration but without a stop time, this field is deprecated for GET endpoints where the value will always be true. |
| id               | integer          | Time Entry ID                                                                                                                                |
| permissions      | Array of string  | Permission list                                                                                                                              |
| pid              | integer          | Project ID, legacy field                                                                                                                     |
| project_active   | boolean          | \-                                                                                                                                           |
| project_billable | boolean          | \-                                                                                                                                           |
| project_color    | string           | \-                                                                                                                                           |
| project_id       | integer          | null                                                                                                                                         |
| project_name     | string           | \-                                                                                                                                           |
| shared_with      | Array of object  | Indicates who the time entry has been shared with                                                                                            |
| start            | string           | Start time in UTC                                                                                                                            |
| stop             | string           | Stop time in UTC, can be null if it's still running or created with "duration" and "duronly" fields                                          |
| tag_ids          | Array of integer | Tag IDs, null if tags were not provided or were later deleted                                                                                |
| tags             | Array of string  | Tag names, null if tags were not provided or were later deleted                                                                              |
| task_id          | integer          | null                                                                                                                                         |
| task_name        | string           | \-                                                                                                                                           |
| tid              | integer          | Task ID, legacy field                                                                                                                        |
| uid              | integer          | Time Entry creator ID, legacy field                                                                                                          |
| user_avatar_url  | string           | \-                                                                                                                                           |
| user_id          | integer          | Time Entry creator ID                                                                                                                        |
| user_name        | string           | \-                                                                                                                                           |
| wid              | integer          | Workspace ID, legacy field                                                                                                                   |
| workspace_id     | integer          | Workspace ID                                                                                                                                 |

##### shared_with [​#](https://engineering.toggl.com/docs/api/time_entries/#shared_with "Direct link to shared_with")

| Name      | Type    | Description |
| --------- | ------- | ----------- |
| accepted  | boolean | \-          |
| user_id   | integer | \-          |
| user_name | string  | \-          |

#### 403 [​#](https://engineering.toggl.com/docs/api/time_entries/#403 "Direct link to 403")

User does not have access to this resource.

#### 500 [​#](https://engineering.toggl.com/docs/api/time_entries/#500 "Direct link to 500")

Internal Server Error