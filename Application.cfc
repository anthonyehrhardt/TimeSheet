<cfcomponent output="false">
    <cfset This.DSN = "TimeSheetDB">
    <cfset This.Name = "TimeSheetManagement">
    <cffunction name="onApplicationStart" access="public" output="true">
        <cfset application.DSN = This.DSN>
    </cffunction>

    <cffunction name="onRequestStart" access="public" output="true">
        <cfset URL.upload = "upload">
        <cfset URL.report = "report">
        <cfset URL.report2 = "report2">
        <cfset URL.report3 = "report3">
        <cfparam name = "URL.page" default="upload">
    </cffunction>
</cfcomponent>