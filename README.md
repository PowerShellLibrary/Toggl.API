# Toggl.API

PowerShell module to interact with the [**Toggl API**](https://engineering.toggl.com/docs/).

## Available Endpoints

### Reports
- **Search-TogglTimeEntries**: Searches for time entries in detailed reports with various filters.

### Time Entries
- **Get-TogglTimeEntries**: Lists the latest time entries.
- **Get-TogglTimeEntryById**: Retrieves a time entry by its ID.
- **New-TogglTimeEntry**: Creates a new time entry.
- **Update-TogglTimeEntry**: Updates an existing time entry.
- **Remove-TogglTimeEntry**: Deletes a time entry.

### Authentication
- **Get-TogglAuthHeader**: Generates the authentication header from the API token.