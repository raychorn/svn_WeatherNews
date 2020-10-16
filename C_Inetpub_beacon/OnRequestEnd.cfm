<cfset _db = "">
<cfset _db = _db & "Request.LoginID = ">
<cfif (IsDefined("Request.LoginID"))>
	<cfset _db = _db & "[#Request.LoginID#]">
<cfelse>
	<cfset _db = _db & "[undefined]">
</cfif>
<cfdump var="#cookie#" label="cookie (#_db#)" expand="No">

<cfif (IsDefined("Session.cfcatch"))>
	<cfdump var="#Session.cfcatch#" label="Session.cfcatch" expand="No">
	<cfset Session.cfcatch = -1>
</cfif>

<cfscript>
	writeOutput('<font color="cyan"><b>+++</b></font>');
</cfscript>
