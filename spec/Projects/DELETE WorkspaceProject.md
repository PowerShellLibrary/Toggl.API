## DELETE WorkspaceProject [​#](https://engineering.toggl.com/docs/api/projects/#delete-workspaceproject "Direct link to DELETE WorkspaceProject")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/projects/{project_id}
```

Delete project for given workspace.

```
curl -X DELETE https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/projects/{project_id} \
  -H "Content-Type: application/json" \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/projects/#parameters-10 "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/projects/#path-10 "Direct link to Path")

| name         | type    | required | description                 |
| :----------- | :------ | :------- | :-------------------------- |
| workspace_id | integer | true     | Numeric ID of the workspace |
| project_id   | integer | true     | Numeric ID of the project   |

#### Query [​#](https://engineering.toggl.com/docs/api/projects/#query-4 "Direct link to Query")

| name           | type   | required | description                                        |
| :------------- | :----- | :------- | :------------------------------------------------- |
| teDeletionMode | string | false    | Time entries deletion mode: 'delete' or 'unassign' |

### Response [​#](https://engineering.toggl.com/docs/api/projects/#response-10 "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/projects/#200-10 "Direct link to 200")

Successful operation.

#### 400 [​#](https://engineering.toggl.com/docs/api/projects/#400-7 "Direct link to 400")

Possible errors:

- Invalid project_id

#### 403 [​#](https://engineering.toggl.com/docs/api/projects/#403-9 "Direct link to 403")

User does not have access to this resource.

#### 500 [​#](https://engineering.toggl.com/docs/api/projects/#500-10 "Direct link to 500")

Internal Server Error