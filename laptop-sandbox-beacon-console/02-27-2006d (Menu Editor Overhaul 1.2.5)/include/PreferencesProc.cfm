

	<cfif ListFindNoCase(Form.Fieldnames, "ACCOUNTSUBMIT")>


		<cfset sFN="FfirstName,FfirstName,FlastName,FlastName,Femail,Femail,Fusername">
		<cfset sFT="null,name,null,name,null,email,null">
		<cf_errorCheck fieldList = "#sFN#" fieldTypes= "#sFT#">
		
		<cfif Len(gErrString) EQ 0>
			<!--- <cfset m_err = REFind("( )|([\+\*\?\[\^\$\(\)\{\|\\""!##%&=};:<>}/])", #Form.Fusername#, 1)> --->
			<cfset m_err = REFind("( )|([\+\*\?\[\^\$\(\)\{\|\\""!##%&=};:<>}/])", #Form.Fusername#, 1)>
			<cfset m_err2 = REFind("([\+\*\?\[\^\$\(\)\{\|\\""##%&=};:<>}/])", #Form.Fgreeting#, 1)>
			<cfif m_err>
				<cfset gErrString =  "Fusername,">
				<cfset gErrStringMessage = "Please complete all required fields correctly">
			<cfelseif m_err2>
				<cfset gErrString =  "Fgreeting,">
				<cfset gErrStringMessage = "Please complete all required fields correctly">
			<cfelse>
				<cfif LEN(#Form.Fgreeting#) EQ 0>
					<cfset modGreeting = "Hi " & #form.FfirstName#>
				<cfelse>
					<cfset modGreeting = #Form.Fgreeting#>
				</cfif> 

				<cfquery NAME="uUserInformation" DATASOURCE="#INTRANET_DS#">
					Update AvnUsers
					set UserName = '#form.Fusername#',
						UserGreeting = '#modGreeting#',
						UserFname = '#form.FfirstName#',
						UserLname = '#form.FlastName#',
						UserEmail = '#form.Femail#'
					where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
					and Deleted = 0
				</cfquery>
									
				<cfset BeaconStats = ListSetAt(BeaconStats,2,#modGreeting#,"|")>
				<cfcookie name="BeaconStats" value="#BeaconStats#" expires="#RememberPeriod#">
				<cfset gErrString =  "none">
				<cfset gErrStringMessage = "Information has been updated successfully">

			</cfif>	
		<cfelse>
			<cfset gErrStringMessage = "Please complete all required fields correctly">
		</cfif>

	<cfelseif ListFindNoCase(Form.Fieldnames, "PASSSUBMIT")>
		<cfset sFN="FoldPass,FnewPass,FnewPass2">
		<cfset sFT="null,null,null">
		<cf_errorCheck fieldList = "#sFN#" fieldTypes= "#sFT#">
		
		<cfif Len(gErrString) EQ 0>
			<cfif CompareNoCase(FnewPass,FnewPass2) NEQ 0>
				<cfset gErrString =  "FnewPass,FnewPass2">
				<cfset gErrStringMessage = "You new password must be typed exactly the same in both fields">
			<cfelseif LEN(FnewPass) LT 6>
				<cfset gErrString =  "FnewPass,FnewPass2">
				<cfset gErrStringMessage = "You new password must be at least six (6) characters long">
			<cfelseif REFindNoCase("([\+\*\?\[\^\$\(\)\{\|\\""!##%&=};:<>}/ ])", #FnewPass#)>
				<cfset gErrString =  "FnewPass,FnewPass2">
				<cfset gErrStringMessage = "You new password must contain only alphanumeric characters (no spaces)">
			<cfelseif NOT REFindNoCase("^([A-Z]|[a-z])",#FnewPass#)>
				<cfset gErrString =  "FnewPass,FnewPass2">
				<cfset gErrStringMessage = "You new password must begin with an alpha character">
			<cfelse>
				<cfquery NAME="getUserStatsFromLoginID" DATASOURCE="#INTRANET_DS#">
					select UserID, UserPassword
					from AvnUsers
					where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
					and Deleted = 0
				</cfquery>
				<cfif CompareNoCase(getUserStatsFromLoginID.UserPassword,FoldPass) NEQ 0>
					<cfset gErrString =  "FoldPass">
					<cfset gErrStringMessage = "You old password does not match the current password stored in the system">
				<cfelse>
					<cfquery NAME="uUserInformation" DATASOURCE="#INTRANET_DS#">
					Update AvnUsers
					set UserPassword = '#form.FnewPass#'
					where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
					and Deleted = 0
					</cfquery>
					<cfset gErrString =  "none">
					<cfset gErrStringMessage = "Password has been set successfully">
				</cfif>
			</cfif>			
		<cfelse>
			<cfset gErrStringMessage = "Please complete all required fields correctly">
		</cfif>
	
	<cfelseif ListFindNoCase(Form.Fieldnames, "IPSubmit") OR ListFindNoCase(Form.Fieldnames, "SATSubmit") OR ListFindNoCase(Form.Fieldnames, "RADSubmit")>
		<cfif ListFindNoCase(Form.Fieldnames, "IPCHECKBOX")>
			<cfquery NAME="uFlightInformation" DATASOURCE="#INTRANET_DS#">
				UPDATE AvnFlights
				SET Deleted = 1, 
					SetAsDefault = 0
				FROM AvnUsers U, AvnFlights F	
				WHERE U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' AND U.UserID = F.UserID
						AND F.FlightID IN (#Form.IPCHECKBOX#)
						AND F.SectionID = #SectionID#
						AND F.Deleted = 0
			</cfquery>
		</cfif>
		<cfif ListFindNoCase(Form.Fieldnames, "IPRADIOBUTTON")>
			<cfquery NAME="uFlightInformation1" DATASOURCE="#INTRANET_DS#">
				UPDATE AvnFlights
				SET SetAsDefault = 0
				FROM AvnUsers U, AvnFlights F	
				WHERE U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' AND U.UserID = F.UserID
						AND F.SectionID = #SectionID#
						AND F.Deleted = 0
			</cfquery>
			<cfquery NAME="uFlightInformation2" DATASOURCE="#INTRANET_DS#">
				UPDATE AvnFlights
				SET SetAsDefault = 1
				FROM AvnUsers U, AvnFlights F	
				WHERE U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' AND U.UserID = F.UserID
						AND F.FlightID = #Form.IPRADIOBUTTON#
						AND F.SectionID = #SectionID#
						AND F.Deleted = 0
			</cfquery>
		</cfif>

	</cfif>






<!--- 
				<cfquery NAME="getCredentialsFromLoginID" DATASOURCE="#INTRANET_DS#">
					select UserID, UserName, UserGreeting, UserFname, UserLname, UserEmail
					from AvnUsers
					where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
					and Deleted = 0
				</cfquery>

 --->
