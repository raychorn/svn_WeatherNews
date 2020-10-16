<cfset authfailed = 0>
<cfset justLogin = 0>

<cfparam name="rememberMe" default="0">

<cfset RememberPeriod = DateAdd("d",2,now())>

<cfif not isdefined("cookie.initialized")>

	<cfif not isdefined("cookie.rememberMe")>
		<cfif not isdefined("uname") or not isdefined("pword")>
			<cflocation url="#Request.urlPrefix##Request.login_htm#?ghjghdasd">
			<cfexit>
		</cfif>
	<cfelse>
		<cfif cookie.rememberMe EQ 1>

			<cfif not isdefined("cookie.BeaconStats")>
				<cfif not isdefined("uname") or not isdefined("pword")>
					<cfcookie name="rememberMe" value="0" expires="never">
					<cflocation url="#Request.urlPrefix##Request.login_htm#">
					<cfexit>
				</cfif>
			<cfelse> <!---  Check to see if that LoginID is still valid  --->
				<cfquery NAME="getCredentialsFromLoginID" DATASOURCE="#Request.INTRANET_DS#">
					select UserID, UserName, UserPassword, UserGreeting, LastLoginDate
					from AvnUsers
					where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
					and Deleted = 0
				</cfquery>

				<cfif getCredentialsFromLoginID.RecordCount EQ 1>
				   <cfset rememberMe = "on">
				   <cfset uname = getCredentialsFromLoginID.UserName>
				   <cfset pword = getCredentialsFromLoginID.UserPassword>
				<cfelse>
					<cfcookie name="rememberMe" value="0" expires="never">
					<cfcookie name="BeaconStats" value="0" expires="now">
					<cflocation url="#Request.urlPrefix##Request.login_htm#">
					<cfexit>
				</cfif>
			</cfif>
		<cfelse>
			<cfif not isdefined("uname") or not isdefined("pword")>
				<cflocation url="#Request.urlPrefix##Request.login_htm#">
				<cfexit>
			</cfif>
		</cfif>
	</cfif>

	<!--- Run the query to validate USERNAME and PASSWORD --->
	<CFQUERY NAME="user" DATASOURCE="#Request.INTRANET_DS#">
		select UserID, UserName, UserPassword, UserGreeting, LastLoginDate, LoginID, isLoggedInActivityDate, isLoggedInAsCFToken, isLoggedIn
		from AvnUsers
		where UserName='#uname#' 
		and UserPassword='#pword#'
		and Deleted = 0
	</CFQUERY>

	<cfif 0>
		<cfdump var="#user#" label="user" expand="No">
	</cfif>
	
	<!--- Run output verification --->
	<cfif (user.recordcount is 1)>
	
		<CFQUERY NAME="UPDuser" DATASOURCE="#Request.INTRANET_DS#">
			UPDATE AvnUsers
			SET LastLoginDate = getdate(), isLoggedInActivityDate = GetDate(), isLoggedInAsCFToken = '#Client.cftoken#', isLoggedIn = 1
			WHERE UserName='#uname#' 
				and UserPassword='#pword#'
				and Deleted = 0
				AND (isLoggedIn = 0)
		</CFQUERY>
		
		<!--- Run the query to LogAudit --->
		<CFQUERY NAME="iLogAudit" DATASOURCE="#Request.INTRANET_DS#">
			Insert into ExtLogAudit(UserName,Success)
			Values ('#uname#',1) 
		</CFQUERY>

		<cfoutput>
			<cfcookie name="initialized" value="1">
			<cfset BeaconStats = #user.LoginID# & "|">
			<cfset BeaconStats = BeaconStats & #user.UserGreeting# & "|">
 			<cfset BeaconStats = BeaconStats & #user.LastLoginDate# & "|">
			<cfset BeaconStats = BeaconStats & #now()#>
<!--- 			<cfcookie name="LoginID" value="#user.LoginID#" expires="#RememberPeriod#"> --->
			
			<cfif rememberMe EQ "on">
				<cfcookie name="rememberMe" value="1" expires="#RememberPeriod#">
			<cfelse>	
				<cfcookie name="rememberMe" value="0" expires="never">
			</cfif>	

			<cfcookie name="BeaconStats" value="#BeaconStats#" expires="#RememberPeriod#">

<!--- 			<cfcookie name="usergreeting" value="#user.UserGreeting#">
			<cfcookie name="userlastlogin" value="#user.LastLoginDate#">
			<cfcookie name="userlastactivity" value="#now()#">
 --->		</cfoutput>
	<cfelse>
		<!--- Run the query to LogAudit --->
		<CFQUERY NAME="iLogAudit" DATASOURCE="#Request.INTRANET_DS#">
			Insert into ExtLogAudit(UserName,Success)
			Values ('#uname#',0) 
		</CFQUERY>

		<cfset authfailed = 1>
		<cfcookie name="rememberMe" value="0" expires="never">
	</cfif>



<!--- Debug 
<cfoutput>
#cookie.BeaconStats#<br>
#cookie.initialized#<br>
#cookie.username#<br>
#cookie.password#<br>
#cookie.LoginID#<br>
#cookie.usergreeting#<br>
</cfoutput>
--->

<cfelse>

	<cfif not isdefined("cookie.initialized") or
	not isdefined("cookie.rememberMe") or
	not isdefined("cookie.BeaconStats") >
		<cflocation url="#Request.urlPrefix##Request.login_htm#?logout">
	</cfif>
	
	<cfoutput>
	<cfif (DateDiff("h",ListGetAt(cookie.BeaconStats,4,"|"),now()) GT 48)>
		<cflocation url="#Request.urlPrefix##Request.login_htm#?logout&reason=1">
	<cfelse>
		<cfset BeaconStats = ListSetAt(BeaconStats,4,now(),"|")>
		<cfcookie name="BeaconStats" value="#BeaconStats#"  expires="#RememberPeriod#">
	</cfif>
	</cfoutput>

</cfif>	

