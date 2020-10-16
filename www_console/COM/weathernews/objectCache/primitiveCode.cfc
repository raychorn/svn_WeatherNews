<cfcomponent displayname="Primitive Code" name="primitiveCode">
	
	<cfscript>
		this.const_PK_violation_msg = 'Violation of PRIMARY KEY constraint';
	
		function _isPKviolation(eMsg) {
			var bool = false;
			if (FindNoCase(this.const_PK_violation_msg, eMsg) gt 0) {
				bool = true;
			}
			return bool;
		}
	</cfscript>
	
	<cffunction name="cf_directory" access="public" returntype="boolean">
		<cfargument name="_qName_" type="string" required="yes">
		<cfargument name="_path_" type="string" required="yes">
		<cfargument name="_filter_" type="string" required="yes">
		<cfargument name="_recurse_" type="boolean" default="False">
	
		<cfset Request.directoryError = "False">
		<cfset Request.directoryErrorMsg = "">
		<cfset Request.directoryFullErrorMsg = "">
		<cftry>
			<cfif (_recurse_)>
				<cfdirectory action="LIST" directory="#_path_#" name="#_qName_#" filter="#_filter_#" recurse="Yes">
			<cfelse>
				<cfdirectory action="LIST" directory="#_path_#" name="#_qName_#" filter="#_filter_#">
			</cfif>

			<cfcatch type="Any">
				<cfset Request.directoryError = "True">

				<cfsavecontent variable="Request.directoryErrorMsg">
					<cfoutput>
						#cfcatch.message#<br>
						#cfcatch.detail#
					</cfoutput>
				</cfsavecontent>
				<cfsavecontent variable="Request.directoryFullErrorMsg">
					<cfdump var="#cfcatch#" label="cfcatch" expand="Yes">
				</cfsavecontent>
			</cfcatch>
		</cftry>
	
		<cfreturn Request.directoryError>
	</cffunction>
	
	<cffunction name="cf_lock" access="public" returntype="any">
		<cfargument name="_myFunc_" type="any" required="yes">
		<cfargument name="_myType_" type="string" required="yes">
		<cfargument name="_myScope_" type="string" required="yes">
		<cfargument name="_myName_" type="string" default="" required="no">
	
		<cfif (Len(_myScope_) gt 0)>
			<cfif (LCASE(_myScope_) eq LCASE('APPLICATION')) OR (LCASE(_myScope_) eq LCASE('SESSION')) OR (LCASE(_myScope_) eq LCASE('SERVER'))>
				<cflock timeout="30" throwontimeout="No" type="#_myType_#" scope="#LCASE(_myScope_)#">
					<cfscript>
						if (IsCustomFunction(_myFunc_)) {
							return _myFunc_();
						}
					</cfscript>
				</cflock>
			</cfif>
		<cfelse>
			<cflock timeout="30" throwontimeout="No" name="myName" type="#_myType_#">
				<cfscript>
					if (IsCustomFunction(_myFunc_)) {
						return _myFunc_();
					}
				</cfscript>
			</cflock>
		</cfif>
	
	</cffunction>

	<cffunction name="safely_execSQL" access="public">
		<cfargument name="_qName_" type="string" required="yes">
		<cfargument name="_DSN_" type="string" required="yes">
		<cfargument name="_sql_" type="string" required="yes">
		<cfargument name="_cachedWithin_" type="string" default="">
		
		<cfscript>
			var q = -1;
		</cfscript>
	
		<cfset Request.errorMsg = "">
		<cfset Request.moreErrorMsg = "">
		<cfset Request.explainError = "">
		<cfset Request.explainErrorHTML = "">
		<cfset Request.dbError = "False">
		<cfset Request.isPKviolation = "False">
		<cftry>
			<cfif (Len(Trim(arguments._qName_)) gt 0)>
				<cfif (Len(_DSN_) gt 0)>
					<cfif (Len(_cachedWithin_) gt 0) AND (IsNumeric(_cachedWithin_))>
						<cfquery name="#arguments._qName_#" datasource="#_DSN_#" cachedwithin="#_cachedWithin_#">
							#PreserveSingleQuotes(_sql_)#
						</cfquery>
					<cfelse>
						<cfquery name="#arguments._qName_#" datasource="#_DSN_#">
							#PreserveSingleQuotes(_sql_)#
						</cfquery>
					</cfif>
				<cfelse>
					<cfquery name="#arguments._qName_#" dbtype="query">
						#PreserveSingleQuotes(_sql_)#
					</cfquery>
				</cfif>
			<cfelse>
				<cfset Request.errorMsg = "Missing Query Name which is supposed to be the first parameter.">
				<cfthrow message="#Request.errorMsg#" type="missingQueryName" errorcode="-100">
			</cfif>
	
			<cfcatch type="Database">
				<cfset Request.dbError = "True">
	
				<cfsavecontent variable="Request.errorMsg">
					<cfoutput>
						[#cfcatch.message#]<br>
						[#cfcatch.detail#]<br>
						[<b>cfcatch.SQLState</b>=#cfcatch.SQLState#]
					</cfoutput>
				</cfsavecontent>
	
				<cfif 0>
					<cflog file="#Application.applicationname#" type="Error" text="[#cfcatch.Sql#]">
				</cfif>
	
				<cfsavecontent variable="Request.moreErrorMsg">
					<cfoutput>
						<UL>
							<LI>#cfcatch.Sql#</LI>
							<LI>#cfcatch.type#</LI>
							<LI>#cfcatch.message#</LI>
							<LI>#cfcatch.detail#</LI>
							<LI><b>cfcatch.SQLState</b>=#cfcatch.SQLState#</LI>
						</UL>
					</cfoutput>
				</cfsavecontent>
	
				<cfsavecontent variable="Request.explainError">
					<cfoutput>
						[#Application.explainError(cfcatch, false)#]
					</cfoutput>
				</cfsavecontent>
	
				<cfsavecontent variable="Request.explainErrorHTML">
					<cfoutput>
						[#Application.explainError(cfcatch, true)#]
					</cfoutput>
				</cfsavecontent>
	
				<cfscript>
					if (Len(_DSN_) gt 0) {
						Request.isPKviolation = _isPKviolation(Request.errorMsg);
					}
				</cfscript>
	
				<cfset Request.dbErrorMsg = Request.errorMsg>
				<cfsavecontent variable="Request.fullErrorMsg">
					<cfdump var="#cfcatch#" label="cfcatch">
				</cfsavecontent>
				<cfsavecontent variable="Request.verboseErrorMsg">
					<cfif (IsDefined("Request.bool_show_verbose_SQL_errors"))>
						<cfif (Request.bool_show_verbose_SQL_errors)>
							<cfdump var="#cfcatch#" label="cfcatch :: Request.isPKviolation = [#Request.isPKviolation#]" expand="No">
						</cfif>
					</cfif>
				</cfsavecontent>
	
				<cfscript>
					if ( (IsDefined("Request.bool_show_verbose_SQL_errors")) AND (IsDefined("Request.verboseErrorMsg")) ) {
						if (Request.bool_show_verbose_SQL_errors) {
							if (NOT Request.isPKviolation) 
								writeOutput(Request.verboseErrorMsg);
						}
					}
				</cfscript>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="cf_file" access="public" returntype="string">
		<cfargument name="_fname_" type="string" required="yes">
		<cfargument name="_action_" type="string" required="yes">
	
		<cfset var theData = "">
		
		<cfset Request.fileError = "False">
		<cftry>
			<cfif (UCASE(_action_) eq UCASE("READ"))>
				<cffile action="READ" file="#_fname_#" variable="theData">
			</cfif>
	
			<cfcatch type="Any">
				<cfset Request.fileError = "True">
				<cfsavecontent variable="Request.verboseFileErrorMsg">
					<cfdump var="#cfcatch#" label="cfcatch - (#_action_#) [#_fname_#]">
				</cfsavecontent>
			</cfcatch>
		</cftry>
	
		<cfreturn theData>
	</cffunction>

	<cffunction name="cf_dump" access="public">
		<cfargument name="_var_" type="any" required="yes">
		<cfargument name="_label_" type="string" required="yes">
	
		<cftry>
			<cfdump var="#_var_#" label="#_label_#" expand="No">
			
			<cfcatch type="Any">
				<cfdump var="#cfcatch#" label="cfcatch - (cf_dump)">
			</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>
