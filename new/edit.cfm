<!-- edit.cfm -->
<cfprocessingdirective pageencoding="utf-8">
<!DOCTYPE html>
<html>
<head>
    <title>Edit Timesheet Entry</title>
</head>
<body>
    <h1>Edit Timesheet Entry</h1>
    <cfset row = url.row>

    <!-- Form to edit entry -->
    <form action="update.cfm" method="post">
        <input type="hidden" name="row" value="#row#">
        <label>Date:</label>
        <input type="text" name="date" value="#cols[1]#" required><br>
        <label>Project:</label>
        <input type="text" name="project" value="#cols[2]#" required><br>
        <label>Hours Worked:</label>
        <input type="number" name="hours" value="#cols[3]#" min="0" required><br>
        <input type="submit" value="Update Entry">
    </form>
</body>
</html>
