<!-- index.cfm -->
<cfprocessingdirective pageencoding="utf-8">
<!DOCTYPE html>
<html>
<head>
    <title>Timesheet Application</title>
</head>
<body>
    <h1>Timesheet Application</h1>

    <!-- Form to add new entry -->
    <h2>Add New Entry</h2>
    <form action="index.cfm" method="post">
        <label>Date:</label>
        <input type="text" name="date" required><br>
        <label>Project:</label>
        <input type="text" name="project" required><br>
        <label>Hours Worked:</label>
        <input type="number" name="hours" min="0" required><br>
        <input type="submit" value="Add Entry">
    </form>

    <!-- Display existing entries -->
    <h2>Timesheet Entries</h2>
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Project</th>
            <th>Hours Worked</th>
            <th>Actions</th>
        </tr>
        <cfloop file="timesheet.csv" index="row">
            <cfset cols = ListToArray(row,",")>
            <tr>
                <td>#cols[1]#</td>
                <td>#cols[2]#</td>
                <td>#cols[3]#</td>
                <td><a href="edit.cfm?row=#currentrow#">Edit</a> | <a href="delete.cfm?row=#currentrow#">Delete</a></td>
            </tr>
        </cfloop>
    </table>
</body>
</html>
