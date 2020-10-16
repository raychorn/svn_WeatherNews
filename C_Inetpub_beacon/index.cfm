<!--- login.cfm (processes login.htm) --->
<cfinclude template="include/GlobalParams.cfm">
<cfinclude template="include/authentication.cfm">

<cfif (isdefined("cookie.initialized")) AND (cookie.rememberMe eq 1)>
	<cflocation url="#Request.const_default_htm#">
<cfelse>
	<cflocation url="#Request.const_login_htm#">
</cfif>

