<html>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        #fromDate, #toDate{
            border : 1px solid;
            border-radius: 5px;
            padding: 5px;
            margin-top: 5px;
        }
    </style>
    <body>
            <cfset dbAccess = createObject("component","components/db_Access")>
            <h5>Get Report Type 2</h5>
            <form method="POST">
                <div>
                    <label for="fromDate"><b>From Date :</b></label>
                    <input type="date" id="fromDate" name="fromDate">
                </div>
                <div>
                    <label for="toDate"><b>To Date :</b></label>
                    <input type="date" id="toDate" name="toDate">
                </div>
                <div>
                    <label for="toDate"><b>Download :</b></label>
                    <input type="checkbox" id="download" value="download" name="downloadFile" style="margin-top:10px;">
                </div>
                <input type="submit" value="Pull" id="submit" name="submit" class="btn btn-primary">
            </form>
            
            <cfif structKeyExists(form,"submit")>
                <cfset dataGroupByDate = dbAccess.dataForReportGroupByDate(fromDate = #form.fromDate#, toDate = #form.toDate#)>
                <!--- to download or not --->
                <cfif structKeyExists(form,"downloadFile")>
                    <cfheader name="Content-Disposition" value="inline; filename=fetched-data.xls">
                    <cfcontent type="application/msexcel"> 
                </cfif> 
                    <cfset resultTimeSheet = queryNew('')>
                    <cfif dataGroupByDate.recordcount GT 0>
                        <table class="table table-bordered table-striped" style="font-size : 12px;">
                            <thead>
                              <tr>
                                <th>Date</th>
                                <th>Task</th>
                              </tr>
                            </thead>
                            <tbody>
                                <cfoutput query="dataGroupByDate" group="TaskDate">
                                    <tr>
                                        <td>#dateFormat(dataGroupByDate.TaskDate)#</td>
                                        <td>
                                            <!--- no list created for empty records --->
                                            <cfoutput>
                                                <cfif dataGroupByDate.TaskName NEQ "" AND dataGroupByDate.TaskName NEQ "weekly off">
                                                    <ul>
                                                        <li>#dataGroupByDate.TaskName#</li>
                                                    </ul>
                                                </cfif>
                                            </cfoutput>
                                        </td>
                                    </tr>
                                </cfoutput>
                            </tbody>
                        </table>
                    <cfelse>
                        <cfoutput>
                            "No Records Found, please check your input!"
                        </cfoutput>
                    </cfif>
           
            </cfif>
    </body>
</html>