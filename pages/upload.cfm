<html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<style>
    #project,#excelFile{
        border : 1px solid grey;
        border-radius: 5px;
        padding: 5px;
    }
</style>
<body>
    <cfoutput>
    <cfset dbAccess = createObject("component","components/db_Access")>
    <h5>Upload File</h5>
    <form enctype="multipart/form-data" method="POST">
        <div>
            <label for="project"><b>Project :</b></label>
            <select id="project" name="project">
                <option selected>Select Project</option>
                <cfloop query="#dbAccess.getProjectName()#">
                    <option value="#Project_Name#">#Project_Name#</option>
                </cfloop>
            </select>
        </div>
        <div>
            <label for="excelFile"><b>Excel File :</b></label>
            <input type="file" id="excelFile" name="excelFile" multiple>
        </div>
        <input type="submit" class="btn btn-primary" id="submitfile" value="Submit" name="submit">
    </form>
    
    <cfset timeSheetVar = queryNew('')>
    <cfif #structKeyExists(form,"submit")#>
        <cfset tmpPartsArray = form.getPartsArray()>
        <cfloop array="#tmpPartsArray#" index="tmpFile">
            <cfif tmpFile.isFile()>
                <cfset fileName ="#tmpFile.getFileName()#">
                <cfset fileExt = listlast(fileName,'.')>
                <cfif listfindnocase('xlsx,xls',fileExt)>
                    <cffile
                        action="upload"
                        filefield="excelFile"
                        nameconflict="overwrite"
                        destination="C:\ColdFusion2016\cfusion\wwwroot\TimeSheet\uploadedFiles"
                        result="outputfile"
                    >
                    <cfspreadsheet
                        action="read"
                        src="C:\ColdFusion2016\cfusion\wwwroot\TimeSheet\uploadedFiles\#fileName#"
                        query="timeSheetVar"
                        headerrow="1"
                        excludeHeaderRow="true"
                        columnnames="EmpName,TaskDate,TaskName"
                    >
                    </cfspreadsheet>
                    
                    <cffile
                        action="delete"
                        file="C:\ColdFusion2016\cfusion\wwwroot\TimeSheet\uploadedFiles\#fileName#"
                    >
                    <cfset insertRec = dbAccess.fillDBWithExcelData(timeSheetVar = timeSheetVar,project = FORM.project)>
                    #insertRec#
                <cfelse>
                    'Wrong type of file selected'
                </cfif>
            </cfif>
        </cfloop>
    </cfif>
</cfoutput>
</body>
</html>