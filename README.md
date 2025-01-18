# Toggl.API

PowerShell module to interact with the [**Toggl API**](https://engineering.toggl.com/docs/).

## Available Endpoints

### Projects
- **Get-TogglProjects**: Retrieves the list of projects for a specified workspace.
- **New-TogglProject**: Creates a new project in a specified workspace.
- **Remove-TogglProject**: Deletes a project in a specified workspace.

### Reports
- **Search-TogglTimeEntries**: Searches for time entries in detailed reports with various filters.

### Tags
- **Get-TogglTags**: Lists workspace tags.
- **New-TogglTag**: Creates a new tag in a specified workspace.
- **Remove-TogglTag**: Deletes a tag in a specified workspace.

### Time Entries
- **Get-TogglTimeEntries**: Lists the latest time entries.
- **Get-TogglTimeEntryById**: Retrieves a time entry by its ID.
- **New-TogglTimeEntry**: Creates a new time entry.
- **Update-TogglTimeEntry**: Updates an existing time entry.
- **Remove-TogglTimeEntry**: Deletes a time entry.

### Authentication
- **Get-TogglAuthHeader**: Generates the authentication header from the API token.