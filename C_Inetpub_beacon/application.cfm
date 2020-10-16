<cftry>
	<cfscript>
		if (NOT IsDefined("This.name")) {
			aa = ListToArray(CGI.SCRIPT_NAME, '/');
			subName = aa[1];
			if (Len(subName) gt 0) {
				subName = '_' & subName;
			}
			appName = UCASE(ReplaceList(CGI.SERVER_NAME & subName, ' ,.,-', '_,_,_'));
		}
	</cfscript>

	<cfapplication name="#appName#" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0,1,0,0)#" applicationtimeout="#CreateTimeSpan(1,0,0,0)#" clientstorage="clientvars" loginstorage="Session">

	<cfcatch type="Any">
		<cfapplication name="#appName#" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0,1,0,0)#" applicationtimeout="#CreateTimeSpan(1,0,0,0)#" clientstorage="cf_client" loginstorage="Session">
	</cfcatch>
</cftry>

<cfif FindNoCase("su-extweb-d",CGI.SERVER_NAME) NEQ 0>
 	<cfset CorporateRootPath = "http://#CGI.SERVER_NAME#:8081/c/">
<cfelseif FindNoCase("su-extweb-s",CGI.SERVER_NAME) NEQ 0>
 	<cfset CorporateRootPath = "http://#CGI.SERVER_NAME#/c/">
<cfelse>
	<cfset CorporateRootPath = "http://www.weathernews.com/us/c/">
</cfif>
<!--- <cfsetting showdebugoutput="no" /> --->
<cfset request.AVNOPS_DS = "AVNOPS">