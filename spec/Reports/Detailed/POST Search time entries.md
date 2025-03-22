## POST Search time entries [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#post-search-time-entries "Direct link to POST Search time entries")

```
https://api.track.toggl.com/reports/api/v3/workspace/{workspace_id}/search/time_entries
```

Returns time entries for detailed report according to the given filters. Supports pagination via X-Next-ID and X-Next-Row-Number headers returned in the response. See [Overview](https://developers.track.toggl.com/docs/reports_start#detailed-reports)


```
curl -X POST https://api.track.toggl.com/reports/api/v3/workspace/{workspace_id}/search/time_entries \
  -H "Content-Type: application/json" \
  -d '\{"billable":"boolean","client_ids":[\{\}],"description":"string","end_date":"string","enrich_response":"boolean","first_id":"integer","first_row_number":"integer","first_timestamp":"integer","group_ids":[\{\}],"grouped":"boolean","hide_amounts":"boolean","max_duration_seconds":"integer","min_duration_seconds":"integer","order_by":"string","order_dir":"string","page_size":"integer","project_ids":[\{\}],"rounding":"integer","rounding_minutes":"integer","startTime":"string","start_date":"string","tag_ids":[\{\}],"task_ids":[\{\}],"time_entry_ids":[\{\}],"user_ids":[\{\}]\}' \
  -u <email>:<password>
```

### Parameters [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#parameters "Direct link to Parameters")

#### Path [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#path "Direct link to Path")

| name         | type    | required | description  |
| :----------- | :------ | :------- | :----------- |
| workspace_id | integer | true     | Workspace ID |

#### Body [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#body "Direct link to Body")

| Name                 | Type             | Description                                                                                                                                      |
| -------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| billable             | boolean          | Whether the time entry is set as billable, optional, premium feature.                                                                            |
| client_ids           | Array of integer | Client IDs, optional, filtering attribute. To filter records with no clients, use \[null\].                                                      |
| description          | string           | Description, optional, filtering attribute.                                                                                                      |
| end_date             | string           | End date, example time.DateOnly. Should be greater than Start date.                                                                              |
| enrich_response      | boolean          | EnrichResponse, optional, default false. It will force the detailed report to return as much information as possible, as it does for the export. |
| first_id             | integer          | \-                                                                                                                                               |
| first_row_number     | integer          | \-                                                                                                                                               |
| first_timestamp      | integer          | \-                                                                                                                                               |
| group_ids            | Array of integer | Group IDs, optional, filtering attribute.                                                                                                        |
| grouped              | boolean          | Whether time entries should be grouped, optional, default false.                                                                                 |
| hide_amounts         | boolean          | Whether amounts should be hidden, optional, default false.                                                                                       |
| max_duration_seconds | integer          | Max duration seconds, optional, filtering attribute. Time Audit only, should be greater than MinDurationSeconds.                                 |
| min_duration_seconds | integer          | Min duration seconds, optional, filtering attribute. Time Audit only, should be less than MaxDurationSeconds.                                    |
| order_by             | string           | Order by field, optional, default "date". Can be "date", "user", "duration", "description" or "last_update".                                     |
| order_dir            | string           | Order direction, optional. Can be ASC or DESC.                                                                                                   |
| page_size            | integer          | PageSize defines the number of items per page, optional, default 50.                                                                             |
| project_ids          | Array of integer | Project IDs, optional, filtering attribute. To filter records with no projects, use \[null\].                                                    |
| rounding             | integer          | Whether time should be rounded, optional, default from user preferences.                                                                         |
| rounding_minutes     | integer          | Rounding minutes value, optional, default from user preferences. Should be 0, 1, 5, 6, 10, 12, 15, 30, 60 or 240.                                |
| startTime            | string           | \-                                                                                                                                               |
| start_date           | string           | Start date, example time.DateOnly. Should be less than End date.                                                                                 |
| tag_ids              | Array of integer | Tag IDs, optional, filtering attribute. To filter records with no tags, use \[null\].                                                            |
| task_ids             | Array of integer | Task IDs, optional, filtering attribute. To filter records with no tasks, use \[null\].                                                          |
| time_entry_ids       | Array of integer | TimeEntryIDs filters by time entries. This was added to support retro-compatibility with reports v2.                                             |
| user_ids             | Array of integer | User IDs, optional, filtering attribute.                                                                                                         |

### Response [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#response "Direct link to Response")

#### 200 [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#200 "Direct link to 200")

Returns grouped time entries for detailed report

#### 400 [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#400 "Direct link to 400")

Possible error messages:

- At least one parameter must be set
- Invalid workspace id
- Invalid '{parameter}' value, allowed values are: '{valid_values}'

#### 402 [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#402 "Direct link to 402")

Workspace needs to have this feature enabled

#### 403 [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#403 "Direct link to 403")

Workspace not found/accessible

#### 500 [​#](https://engineering.toggl.com/docs/reports/detailed_reports/#500 "Direct link to 500")

Internal Server Error