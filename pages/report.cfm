<html>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        #project, #fromDate, #toDate{
            border : 1px solid;
            border-radius: 5px;
            padding: 5px;
            margin-top: 5px;
        }
        
    </style>
    <body>
        <cfoutput>
            <cfparam name="form.sortByDate" default="false">
        <cfset dbAccess = createObject("component","components/db_Access")>
        <h5>Get Report Type 1</h5>
            <form method="POST">
                <div>
                    <label for="project"><b>Project :</b></label>
                    <select id="project" name="project">
                        <option>Select Project</option>
                        <cfloop query="#dbAccess.getProjectName()#">
                            <option value="#Project_Name#">#Project_Name#</option>
                        </cfloop>
                    </select>
                </div>
                <div >
                    <label for="fromDate"><b>From Date :</b></label>
                    <input type="date" id="fromDate" name="fromDate">
                </div>
                <div >
                    <label for="toDate"><b>To Date :</b></label>
                    <input type="date" id="toDate" name="toDate">
                </div>
                <div>
                    <label for="sortByDate"><b>Sort By Date:</b></label>
                    <input type="checkbox" id="sortByDate" value="true" name="sortByDate" style="margin-top:10px;">
                </div>
                <div>
                    <label for="toDate"><b>Download :</b></label>
                    <input type="checkbox" id="download" value="download" name="downloadFile" style="margin-top:10px;">
                </div>
                <input type="submit" value="Pull" id="submit" name="submit" class="btn btn-primary">
            </form>
            
            <cfif structKeyExists(form,"submit")>
                <cfset fetchedData = dbAccess.getDataFromDB(project = #form.project#, fromDate = #form.fromDate#, toDate = #form.toDate#, sortByDateFlag = #form.sortByDate#)>
                    
                    <cfspreadsheet
                        action="write"
                        filename="C:\ColdFusion2016\cfusion\wwwroot\TimeSheet\uploadedFiles\fetched-data.xlsx"
                        query="fetchedData"
                        overwrite="true"
                        >
                    </cfspreadsheet>
                <cfif structKeyExists(form,"downloadFile")>
                    <cfheader name="Content-Disposition" value="inline; filename=fetched-data.xlsx">
                    <cfcontent type="application/msexcel">
                </cfif>
                    <cfset resultTimeSheet = queryNew('')>
                    <cfif fetchedData.recordcount GT 0>
                        <table class="table table-bordered table-striped" style="font-size:12px;">
                            <thead>
                              <tr>
                                <th>Name</th>
                                <th>Date</th>
                                <th>Task</th>
                              </tr>
                            </thead>
                            <tbody>
                              <cfloop query="#fetchedData#">
                                <tr>
                                    <td>#fetchedData.EmployeeName#</td>
                                    <td>#DateFormat(fetchedData.TaskDate)#</td>
                                    <td>#fetchedData.TaskName#</td>
                                </tr>
                              </cfloop>
                            </tbody>
                        </table>
                    <cfelse>
                        "No Records Found, please check you input!"
                    </cfif>
            </cfif>
        </cfoutput>
    </body>
</html>