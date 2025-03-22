## DELETE TimeEntries [​#](https://engineering.toggl.com/docs/api/time_entries/#delete-timeentries "Direct link to DELETE TimeEntries")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/time_entries/{time_entry_id}
```

Deletes a workspace time entry.

```
curl -X DELETE https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/time_entries/{time_entry_id} \
  -H "Content-Type: application/json" \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/time_entries/#parameters-5 "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/time_entries/#path-4 "Direct link to Path")

| name          | type    | required | description                 |
| :------------ | :------ | :------- | :-------------------------- |
| workspace_id  | integer | true     | Numeric ID of the workspace |
| time_entry_id | integer | true     | TimeEntry ID.               |

### Response [​#](https://engineering.toggl.com/docs/api/time_entries/#response-6 "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/time_entries/#200-6 "Direct link to 200")

Returns only status code.

#### 403 [​#](https://engineering.toggl.com/docs/api/time_entries/#403-4 "Direct link to 403")

User does not have access to this resource.

#### 500 [​#](https://engineering.toggl.com/docs/api/time_entries/#500-6 "Direct link to 500")

Internal Server Error