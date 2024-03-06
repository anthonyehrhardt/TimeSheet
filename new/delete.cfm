<!-- delete.cfm -->
<cfprocessingdirective pageencoding="utf-8">
<cfset row = url.row>

<cffile action="read" file="timesheet.csv" variable="csvData">
<cfset lines = ListToArray(csvData, chr(10))>
<cfset ArrayDeleteAt(lines, row)>
<cffile action="write" file="timesheet.csv" output="#ArrayToList(lines, chr(10))#">

<!-- Redirect back to index.cfm -->
<script>window.location.href = "index.cfm";</script>
