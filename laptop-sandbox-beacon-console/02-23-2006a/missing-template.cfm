<!--- missing-template.cfm --->
<cfdump var="#CGI#" label="CGI Scope - Missing Template Error Handler" expand="No">

<cfif (CGI.SCRIPT_NAME eq "/index.cfm") AND 0>
	<cflocation url="#ReplaceNoCase(CGI.SCRIPT_NAME, "index.cfm", "default.htm")#">
</cfif>
