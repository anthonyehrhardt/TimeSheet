<!-- update.cfm -->
<cfprocessingdirective pageencoding="utf-8">
<cfset row = form.row>
<cfset date = form.date>
<cfset project = form.project>
<cfset hours = form.hours>

<cffile action="read" file="timesheet.csv" variable="csvData">
<cfset lines = ListToArray(csvData, chr(10))>
<cfset lines[row] = "#date#,#project#,#hours#">
<cffile action="write" file="timesheet.csv" output="#ArrayToList(lines, chr(10))#">

<!-- Redirect back to index.cfm -->
<script>window.location.href = "index.cfm";</script>
