<cfapplication name="BEACON" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(2,0,0,0)#" applicationtimeout="#CreateTimeSpan(2,0,0,0)#" clientstorage="cf_client" loginstorage="Session">
<cfif FindNoCase("su-extweb-d",CGI.SERVER_NAME) NEQ 0>
 	<cfset CorporateRootPath = "http://#CGI.SERVER_NAME#:8081/c/">
<cfelseif FindNoCase("su-extweb-s",CGI.SERVER_NAME) NEQ 0>
 	<cfset CorporateRootPath = "http://#CGI.SERVER_NAME#/c/">
<cfelse>
	<cfset CorporateRootPath = "http://www.weathernews.com/us/c/">
</cfif>
<!--- <cfsetting showdebugoutput="no" /> --->
<cfset request.AVNOPS_DS = "AVNOPS">
<!--- Set the Demis location --->
<cfset demisLocation = "http://demis-dev.wni.com/wms/wms.asp" />