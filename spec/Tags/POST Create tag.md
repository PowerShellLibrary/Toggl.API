## POST Create tag [​#](https://engineering.toggl.com/docs/api/tags/#post-create-tag "Direct link to POST Create tag")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/tags
```

Create workspace tags.


```
curl -X POST https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/tags \
  -H "Content-Type: application/json" \
  -d '\{"name":"string"\}' \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/tags/#parameters-1 "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/tags/#path-1 "Direct link to Path")

| name         | type    | required | description                 |
| :----------- | :------ | :------- | :-------------------------- |
| workspace_id | integer | true     | Numeric ID of the workspace |

#### Body [​#](https://engineering.toggl.com/docs/api/tags/#body "Direct link to Body")

| Name | Type   | Description |
| ---- | ------ | ----------- |
| name | string | Tag name    |

### Response [​#](https://engineering.toggl.com/docs/api/tags/#response-1 "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/tags/#200-1 "Direct link to 200")

| Name  | Type            | Description |
| ----- | --------------- | ----------- |
| items | Array of object | \-          |

##### items [​#](https://engineering.toggl.com/docs/api/tags/#items-1 "Direct link to items")

| Name                 | Type    | Description                                                                              |
| -------------------- | ------- | ---------------------------------------------------------------------------------------- |
| at                   | string  | When was created/last modified                                                           |
| creator_id           | integer | CreatorID the user who created the tag                                                   |
| deleted_at           | string  | When was deleted                                                                         |
| id                   | integer | Tag ID                                                                                   |
| integration_ext_id   | string  | The external ID of the linked entity in the external system (e.g. JIRA/SalesForce)       |
| integration_ext_type | string  | The external type of the linked entity in the external system (e.g. JIRA/SalesForce)     |
| integration_provider | string  | The provider (e.g. JIRA/SalesForce) that has an entity linked to this Toggl Track entity |
| name                 | string  | Tag name                                                                                 |
| permissions          | string  | \-                                                                                       |
| workspace_id         | integer | Workspace ID                                                                             |

#### 400 [​#](https://engineering.toggl.com/docs/api/tags/#400 "Direct link to 400")

Possible errors:

- Invalid JSON input
- tag name can't be blank
- a tag with the name '{tag_name}' already exists

#### 403 [​#](https://engineering.toggl.com/docs/api/tags/#403-1 "Direct link to 403")

Only organization or workspace administrators may manage tags in this workspace.

#### 500 [​#](https://engineering.toggl.com/docs/api/tags/#500-1 "Direct link to 500")

Internal Server Error