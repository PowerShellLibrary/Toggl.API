## DELETE Delete tag [​#](https://engineering.toggl.com/docs/api/tags/#delete-delete-tag "Direct link to DELETE Delete tag")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/tags/{tag_id}
```

Delete workspace tags.


```
curl -X DELETE https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/tags/{tag_id} \
  -H "Content-Type: application/json" \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/tags/#parameters-3 "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/tags/#path-3 "Direct link to Path")

| name         | type    | required | description                 |
| :----------- | :------ | :------- | :-------------------------- |
| workspace_id | integer | true     | Numeric ID of the workspace |
| tag_id       | integer | true     | Numeric ID of the tag       |

### Response [​#](https://engineering.toggl.com/docs/api/tags/#response-3 "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/tags/#200-3 "Direct link to 200")

Successful operation.

#### 400 [​#](https://engineering.toggl.com/docs/api/tags/#400-2 "Direct link to 400")

Invalid tag ID.

#### 403 [​#](https://engineering.toggl.com/docs/api/tags/#403-3 "Direct link to 403")

Only organization or workspace administrators may manage tags in this workspace.

#### 404 [​#](https://engineering.toggl.com/docs/api/tags/#404-1 "Direct link to 404")

Tag was not found.

#### 500 [​#](https://engineering.toggl.com/docs/api/tags/#500-3 "Direct link to 500")

Internal Server Error