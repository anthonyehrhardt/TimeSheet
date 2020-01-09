<cfcomponent namespace="db_Access">
    <cffunction name="getProjectName" access="public" output="true">
        <cfquery name="projectOptions" datasource="#application.DSN#">
            SELECT Project_Name
            FROM Projects
        </cfquery>
        <cfreturn projectOptions>
    </cffunction>

    <cffunction name="fillDBWithExcelData" access="public" output="false">
        <cfargument name="timeSheetVar" required="true">
        <cfargument name="project" required="true">

        <cfquery name="getProjects" datasource="#application.DSN#">
            SELECT id from Projects 
            WHERE project_name = <cfqueryparam value="#arguments.project#" cfsqltype="varchar">
        </cfquery>
        
        <cfquery name="getRecords" datasource="#application.DSN#">
            SELECT task_name_desc FROM ProjectTimeSheet;
        </cfquery>

        <cfloop query="#arguments.timeSheetVar#">
            <cfif len(trim(arguments.timeSheetVar.TaskName))>
                <cfquery name="insertSpreadSheet" datasource="#application.DSN#">
                    INSERT INTO ProjectTimeSheet ( project_id, employee_name, task_date, task_name_desc ) 
                        values ( 
                            <cfqueryparam value="#getProjects.id#" cfsqltype="integer">, 
                            <cfqueryparam value="#arguments.timeSheetVar.EmpName#" cfsqltype="varchar">, 
                            <cfqueryparam value="#arguments.timeSheetVar.TaskDate#" cfsqltype="date">, 
                            <cfqueryparam value="#arguments.timeSheetVar.TaskName#" cfsqltype="varchar">
                            )    
                </cfquery>
            </cfif>
        </cfloop>
        <cfreturn 'success'>        
    </cffunction>

    <cffunction name="getDataFromDB" access="public" output="false">
        <cfargument name="project" required="false">
        <cfargument name="fromDate" required="false" type="date">
        <cfargument name="toDate" required="false" type="date">
        <cfargument name="sortByDateFlag" required="false" default="false">
        
        <cfquery name="getDataFromDBQuery" datasource="#application.DSN#">
            SELECT 
                pts.employee_name as "EmployeeName",
                pts.task_date as "TaskDate",
                pts.task_name_desc as "TaskName"
            FROM
                ProjectTimeSheet pts
            INNER JOIN 
                Projects pro ON pro.id = pts.project_id 
            WHERE 
                pts.task_date BETWEEN <cfqueryparam value="#arguments.fromDate#" cfsqltype="date"> 
                AND <cfqueryparam value="#arguments.toDate#" cfsqltype="date"> 
            AND 
                pro.Project_Name = <cfqueryparam value="#arguments.project#" cfsqltype="varchar">
            <cfif arguments.sortByDateFlag EQ true>
                ORDER BY pts.task_date;
            </cfif>
        </cfquery>
        <cfreturn getDataFromDBQuery>
    </cffunction>

    <cffunction name="dataForReportGroupByDate" access="public" output="false">
        
        <cfargument name="fromDate" required="false" type="date">
        <cfargument name="toDate" required="false" type="date">
        
        <cfquery name="getDataFromDBQuery" datasource="#application.DSN#">
            SELECT
                pts.employee_name as "EmployeeName",
                pts.task_date as "TaskDate",
                pts.task_name_desc as "TaskName"
            FROM
                ProjectTimeSheet pts
            WHERE 
                pts.task_date BETWEEN <cfqueryparam value="#arguments.fromDate#" cfsqltype="date"> 
                AND <cfqueryparam value="#arguments.toDate#" cfsqltype="date">
        </cfquery>
        <cfreturn getDataFromDBQuery>
    </cffunction>
</cfcomponent>