## GET Tags [​#](https://engineering.toggl.com/docs/api/tags/#get-tags "Direct link to GET Tags")

```
https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/tags
```

List Workspace tags.


```
curl  https://api.track.toggl.com/api/v9/workspaces/{workspace_id}/tags \
  -H "Content-Type: application/json" \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/api/tags/#parameters "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/api/tags/#path "Direct link to Path")

| name         | type    | required | description                 |
| :----------- | :------ | :------- | :-------------------------- |
| workspace_id | integer | true     | Numeric ID of the workspace |

### Response [​#](https://engineering.toggl.com/docs/api/tags/#response "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/api/tags/#200 "Direct link to 200")

| Name  | Type            | Description |
| ----- | --------------- | ----------- |
| items | Array of object | \-          |

##### items [​#](https://engineering.toggl.com/docs/api/tags/#items "Direct link to items")

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

#### 403 [​#](https://engineering.toggl.com/docs/api/tags/#403 "Direct link to 403")

User does not have access to this resource.

#### 500 [​#](https://engineering.toggl.com/docs/api/tags/#500 "Direct link to 500")

Internal Server Error