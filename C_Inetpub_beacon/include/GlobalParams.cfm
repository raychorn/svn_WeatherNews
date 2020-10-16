<cfparam name="GLOBALPARAMS_INC" default=0>

<cfif not GLOBALPARAMS_INC>
		<cfparam name="gErrString" default="">
		
		<cfset INTRANET_DS = "INTRANETDB">	
		<cfset AVNOPS_DS = "AVNOPS">	
		<cfset MEDIACAST_DS = "WOW">	
		<cfset BUSPROD_DS = "BUSPROD">	
		<cfset BUSHIST_DS = "BUSHIST">	
		<cfset BUSARCHIVE_DS = "BUSARCHIVE">	
	
		<cfset request.OPS_PHONE_CONTACT = "866.842.6433 or 405.310.2955">
		
		<cfif (FindNoCase(".deepspacenine.", CGI.SERVER_NAME) gt 0)>
			<cfset Request.const_login_htm = "login.cfm">
			<cfset Request.const_default_htm = "default.cfm">
		<cfelse>
			<cfset Request.const_login_htm = "login.htm">
			<cfset Request.const_default_htm = "default.htm">
		</cfif>
	
		<cfset GLOBALPARAMS_INC = 1>
</cfif><!--- if not GLOBALS_INC --->	
