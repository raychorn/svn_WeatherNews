<cfset authfailed = 0>
<cfset justLogin = 0>

<cfset LoginID = "">

<cfset bool_useCfID_and_cftoken = false>
<cfif (IsDefined("Client.cfid")) AND (IsDefined("Client.cftoken"))>
	<cfset bool_useCfID_and_cftoken = true>
</cfif>

<cffunction name="isUserID_storedInCookie" access="public" returntype="struct">
	<cfset var retVal = StructNew()>
	<cfset retVal.uname = "">
	<cfset retVal.pword = "">

	<cfif (IsDefined("cookie.BeaconStats"))>
		<cfquery NAME="getCredentialsFromLoginID" DATASOURCE="#INTRANET_DS#">
			select UserID, UserName, UserPassword, UserGreeting, LastLoginDate
			from AvnUsers
			where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
			and Deleted = 0
		</cfquery>
		
		<cfif getCredentialsFromLoginID.RecordCount EQ 1>
		   <cfset rememberMe = "on">
		   <cfset retVal.uname = getCredentialsFromLoginID.UserName>
		   <cfset retVal.pword = getCredentialsFromLoginID.UserPassword>
		<cfelse>
			<cfcookie name="rememberMe" value="0" expires="never">
			<cfcookie name="BeaconStats" value="0" expires="now">
			<cflocation url="#Request.const_login_htm#">
			<cfexit>
		</cfif>
	</cfif>
	<cfreturn retVal>
</cffunction>

<cffunction name="doesLoginID_matchThisValue" access="public" returntype="struct">
	<cfargument name="_aLoginID_" type="string" required="yes">
	<cfargument name="_uname_" type="string" required="yes">
	<cfargument name="_pwd_" type="string" required="yes">
	
	<cfset var retVal = StructNew()>
	<cfset retVal.LoginID = "">
	<cfset retVal.bool_doesLoginID_matchThisValue = false>

	<cfquery NAME="getLoginIDFromCredentials" DATASOURCE="#INTRANET_DS#">
		select LoginID
		from AvnUsers
		where (UserName = '#_uname_#') AND (UserPassword = '#_pwd_#')
		and Deleted = 0
	</cfquery>
	
	<cfif (getLoginIDFromCredentials.RecordCount EQ 1)>
	   <cfset retVal.LoginID = getLoginIDFromCredentials.LoginID>
		<cfset retVal.bool_doesLoginID_matchThisValue = (retVal.LoginID eq _aLoginID_)>
	</cfif>

	<cfreturn retVal>
</cffunction>

<cfparam name="rememberMe" default="0">

<cfset RememberPeriod = DateAdd("d",2,now())>

<cfset bool_override_logic = false>
<cfif (IsDefined("FORM.uname")) AND (IsDefined("FORM.pword"))>
	<cfset bool_override_logic = true>
</cfif>

<cfif (not isdefined("cookie.initialized")) OR (bool_override_logic)>

	<cfif not isdefined("cookie.rememberMe")>
		<cfif not isdefined("uname") or not isdefined("pword")>
			<cflocation url="/login.htm?ghjghdasd">
			<cfexit>
		</cfif>
	<cfelse>
		<cfif cookie.rememberMe EQ 1>

			<cfif not isdefined("cookie.BeaconStats")>
				<cfif not isdefined("uname") or not isdefined("pword")>
					<cfcookie name="rememberMe" value="0" expires="never">
					<cflocation url="login.htm">
					<cfexit>
				</cfif>
			<cfelse> <!---  Check to see if that LoginID is still valid  --->
				<cfscript>
					ss = isUserID_storedInCookie();
				</cfscript>
				
				<cfif IsStruct(ss) AND (IsDefined("ss.uname")) AND (IsDefined("ss.pword"))>
				   <cfset rememberMe = "on">
				   <cfset uname = ss.uname>
				   <cfset pword = ss.pword>
				</cfif>
			</cfif>
		<cfelse>
			<cfif (IsDefined("cookie.BeaconStats"))>
				<cfset LoginID = ListGetAt(cookie.BeaconStats,1,"|")>
				<cfset ss = StructNew()>
				<cfif ( (IsDefined("uname")) AND (IsDefined("pword")) )>
					<cfset ss = doesLoginID_matchThisValue(LoginID, uname, pword)>
					<cfif (NOT ss.bool_doesLoginID_matchThisValue)>
						<cfset LoginID = "">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>

	<cftry>
		<!--- Run the query to validate USERNAME and PASSWORD --->
		<CFQUERY NAME="user" DATASOURCE="#INTRANET_DS#">
			select UserID, UserName, UserPassword, UserGreeting, LastLoginDate, LoginID, ISNULL(isLoggedIn, 0) as 'isLoggedIn', ISNULL(isLoggedInAsCFToken, '') as 'isLoggedInAsCFToken'
			from AvnUsers
			<cfif (IsDefined("Request.LoginID")) AND (Len(Request.LoginID) gt 0)>
				where LoginID = '#Request.LoginID#' 
			<cfelse>
				where UserName='#uname#' 
				and UserPassword='#pword#'
			</cfif>
			and Deleted = 0
		</CFQUERY>
	
		<!--- Run output verification --->
		<cfif user.recordcount is 1>
			<cfif (user.isLoggedIn eq 0) OR ( (IsDefined("uname")) AND (IsDefined("pword")) )>
				<CFQUERY NAME="UPDuser" DATASOURCE="#INTRANET_DS#">
				UPDATE AvnUsers
				SET LastLoginDate = getdate(), isLoggedIn = 1
				<cfif (bool_useCfID_and_cftoken)>
					, isLoggedInAsCFToken = '#Client.cfid#_#Client.cftoken#'
				<cfelse>
					, isLoggedInAsCFToken = '#Cookie.JSESSIONID#'
				</cfif>
				WHERE UserName='#uname#' 
					and UserPassword='#pword#'
					and Deleted = 0
				</CFQUERY>
				
				<!--- Run the query to LogAudit --->
				<CFQUERY NAME="iLogAudit" DATASOURCE="#INTRANET_DS#">
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
			<cfelseif (user.isLoggedIn neq 0)>
				<cfscript>
					bool_hasAuthFailed = false;
					if (bool_useCfID_and_cftoken) {
						if ( (IsDefined("Client.cftoken")) AND (user.isLoggedInAsCFToken neq "#Client.cfid#_#Client.cftoken#") ) {
							bool_hasAuthFailed = true;
						}
					} else if ( (IsDefined("Cookie.JSESSIONID")) AND (user.isLoggedInAsCFToken neq Cookie.JSESSIONID) ) {
						bool_hasAuthFailed = true;
					}
					if (bool_hasAuthFailed) {
						authfailed = 2;  // <!--- Flag this attempt as already logged in --->
					}
				</cfscript>
			</cfif>
		<cfelse>
			<!--- Run the query to LogAudit --->
			<CFQUERY NAME="iLogAudit" DATASOURCE="#INTRANET_DS#">
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

		<cfcatch type="Any">
			<!--- BEGIN: If the user is unknown then invite them to login again... --->
			<cfcookie name="rememberMe" value="0" expires="never">
			<cfcookie name="BeaconStats" value="0" expires="now">
			<cflocation url="login.htm?authfailed=-9">
			<cfexit>
			<!--- END! If the user is unknown then invite them to login again... --->
		</cfcatch>
	</cftry>

<cfelse>

	<cfif not isdefined("cookie.initialized") or
	not isdefined("cookie.rememberMe") or
	not isdefined("cookie.BeaconStats") >
		<cflocation url="login.htm?logout">
	</cfif>
	
	<cfoutput>
	<cfif (DateDiff("h",ListGetAt(cookie.BeaconStats,4,"|"),now()) GT 48)>
		<cflocation url="login.htm?logout&reason=1">
	<cfelse>
		<cfset BeaconStats = ListSetAt(BeaconStats,4,now(),"|")>
		<cfcookie name="BeaconStats" value="#BeaconStats#"  expires="#RememberPeriod#">
	</cfif>
	</cfoutput>

	<!--- BEGIN: Perform a sanity check to make sure the user who is logged-in is on the current workstation --->
	<cfset Request.LoginID = ListGetAt(cookie.BeaconStats,1,"|")>

	<cfset isDbError = false>
	<cftry>
		<!--- Run the query to validate USERNAME and PASSWORD --->
		<CFQUERY NAME="userQ" DATASOURCE="#INTRANET_DS#">
			select UserID, UserName, UserPassword, UserGreeting, LastLoginDate, LoginID, ISNULL(isLoggedIn, 0) as 'isLoggedIn', ISNULL(isLoggedInAsCFToken, '') as 'isLoggedInAsCFToken'
			from AvnUsers
			where LoginID = '#Request.LoginID#' 
			and Deleted = 0
		</CFQUERY>

		<cfcatch type="Any">
			<cfset isDbError = true>
		</cfcatch>
	</cftry>

	<cfif (NOT isDbError)>
		<cfscript>
			expected_session_id = '';
			if (bool_useCfID_and_cftoken) {
				expected_session_id = Client.cfid & '_' & Client.cftoken;
			} else {
				expected_session_id = Cookie.JSESSIONID;
			}
		</cfscript>
		
		<cfif NOT (userQ.isLoggedInAsCFToken IS expected_session_id)>
			<cfcookie name="rememberMe" value="0" expires="never">
			<cfcookie name="BeaconStats" value="0" expires="now">
			<cfset Request.reasonType = "<b>You are already logged in from another workstation or browser.  Kindly perform a login from the browser or workstation you are currently using to resume your usage session but keep in mind any other user sessions you may have previously initiated will be terminated upon a successful login.  Remember to logout when you are done.</b>">
			<cfinclude template="../login.htm">
			<cfexit>
		</cfif>
	</cfif>
	<!--- END! Perform a sanity check to make sure the user who is logged-in is on the current workstation --->

</cfif>	

