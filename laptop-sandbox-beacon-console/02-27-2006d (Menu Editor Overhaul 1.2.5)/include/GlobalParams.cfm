<cfparam name="GLOBALPARAMS_INC" default=0>

<cfif not GLOBALPARAMS_INC>
		<cfparam name="gErrString" default="">
		
		<cfset INTRANET_DS = "INTRANETDB">	
		<cfset AVNOPS_DS = "AVNOPS">	
		<cfset MEDIACAST_DS = "WOW">	
		<cfset BUSPROD_DS = "BUSPROD">	
		<cfset BUSHIST_DS = "BUSHIST">	
		<cfset BUSARCHIVE_DS = "BUSARCHIVE">	
		<cfset BEACON_DS = "BEACON">
	
		<cfset request.OPS_PHONE_CONTACT = "866.842.6433 or 405.310.2955">
	
		<cfset GLOBALPARAMS_INC = 1>
</cfif><!--- if not GLOBALS_INC --->	

<cfscript>
	Request.bool_useNewMenu = ( (CGI.REMOTE_ADDR eq "172.18.201.166") OR (CGI.REMOTE_ADDR eq "127.0.0.1") );
</cfscript>