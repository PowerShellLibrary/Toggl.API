## PUT TimeEntries [​#](https://engineering.toggl.com/docs/api/time_entries/#put-timeentries "Direct link to PUT TimeEntries")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/time_entries/{time_entry_id}
```

Updates a workspace time entry.



```
curl -X PUT https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/time_entries/{time_entry_id} \
  -H "Content-Type: application/json" \
  -d '\{"billable":"boolean","created_with":"string","description":"string","duration":"integer","duronly":"boolean","event_metadata":\{"origin_feature":"string","visible_goals_count":"integer"\},"pid":"integer","project_id":"integer","shared_with_user_ids":[\{\}],"start":"string","start_date":"string","stop":"string","tag_action":"string","tag_ids":[\{\}],"tags":[\{\}],"task_id":"integer","tid":"integer","uid":"integer","user_id":"integer","wid":"integer","workspace_id":"integer"\}' \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/time_entries/#parameters-4 "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/time_entries/#path-3 "Direct link to Path")

| name          | type    | required | description                 |
| :------------ | :------ | :------- | :-------------------------- |
| workspace_id  | integer | true     | Numeric ID of the workspace |
| time_entry_id | integer | true     | TimeEntry ID.               |

#### Query [​#](https://engineering.toggl.com/docs/api/time_entries/#query-5 "Direct link to Query")

| name            | type    | required | description                                            |
| :-------------- | :------ | :------- | :----------------------------------------------------- |
| meta            | boolean | false    | Should the response contain data for meta entities     |
| include_sharing | boolean | false    | Should the response contain time entry sharing details |

#### Body [​#](https://engineering.toggl.com/docs/api/time_entries/#body-2 "Direct link to Body")

| Name                 | Type             | Description                                                                                                                                                                    |
| -------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| billable             | boolean          | Whether the time entry is marked as billable, optional, default false                                                                                                          |
| created_with         | string           | Must be provided when creating a time entry and should identify the service/application used to create it                                                                      |
| description          | string           | Time entry description, optional                                                                                                                                               |
| duration             | integer          | Time entry duration. For running entries should be negative, preferable -1                                                                                                     |
| duronly              | boolean          | Deprecated: Used to create a time entry with a duration but without a stop time. This parameter can be ignored.                                                                |
| event_metadata       | object           | \-                                                                                                                                                                             |
| pid                  | integer          | Project ID, legacy field                                                                                                                                                       |
| project_id           | integer          | Project ID, optional                                                                                                                                                           |
| shared_with_user_ids | Array of integer | List of user IDs to share this time entry with                                                                                                                                 |
| start                | string           | Start time in UTC, required for creation. Format: 2006-01-02T15:04:05Z                                                                                                         |
| start_date           | string           | If provided during creation, the date part will take precedence over the date part of "start". Format: 2006-11-07                                                              |
| stop                 | string           | Stop time in UTC, can be omitted if it's still running or created with "duration". If "stop" and "duration" are provided, values must be consistent (start + duration == stop) |
| tag_action           | string           | Can be "add" or "delete". Used when updating an existing time entry                                                                                                            |
| tag_ids              | Array of integer | IDs of tags to add/remove                                                                                                                                                      |
| tags                 | Array of string  | Names of tags to add/remove. If name does not exist as tag, one will be created automatically                                                                                  |
| task_id              | integer          | Task ID, optional                                                                                                                                                              |
| tid                  | integer          | Task ID, legacy field                                                                                                                                                          |
| uid                  | integer          | Time Entry creator ID, legacy field                                                                                                                                            |
| user_id              | integer          | Time Entry creator ID, if omitted will use the requester user ID                                                                                                               |
| wid                  | integer          | Workspace ID, legacy field                                                                                                                                                     |
| workspace_id         | integer          | Workspace ID, required                                                                                                                                                         |

##### event_metadata [​#](https://engineering.toggl.com/docs/api/time_entries/#event_metadata-1 "Direct link to event_metadata")

| Name                | Type    | Description |
| ------------------- | ------- | ----------- |
| origin_feature      | string  | \-          |
| visible_goals_count | integer | \-          |

### Response [​#](https://engineering.toggl.com/docs/api/time_entries/#response-5 "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/time_entries/#200-5 "Direct link to 200")

A workspace TimeEntry.

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

##### shared_with [​#](https://engineering.toggl.com/docs/api/time_entries/#shared_with-4 "Direct link to shared_with")

| Name      | Type    | Description |
| --------- | ------- | ----------- |
| accepted  | boolean | \-          |
| user_id   | integer | \-          |
| user_name | string  | \-          |

#### 403 [​#](https://engineering.toggl.com/docs/api/time_entries/#403-3 "Direct link to 403")

User does not have access to this resource.

#### 500 [​#](https://engineering.toggl.com/docs/api/time_entries/#500-5 "Direct link to 500")

Internal Server Error