<cfcomponent>

	<cffunction name="cf_log" access="public">
		<cfargument name="_someText_" type="string" required="yes">
		
		<cflog file="#Application.applicationName#" type="Information" text="#_someText_#">
	</cffunction>

	<cfscript>
		This.name = UCASE(CGI.SERVER_NAME & Replace(ListDeleteAt(CGI.SCRIPT_NAME, ListLen(CGI.SCRIPT_NAME, '/'), '/'), '/', '_', 'all'));
		This.clientManagement = "Yes";
		This.sessionManagement = "No";
		This.sessionTimeout = "#CreateTimeSpan(0,8,0,0)#";
		This.applicationTimeout = "#CreateTimeSpan(1,0,0,0)#";
		This.clientStorage = "clientvars";
		This.loginStorage = "Cookie";
		This.setClientCookies = "Yes";
		This.setDomainCookies = "No";
		This.scriptProtect = "All";

		function _explainError(_error, bool_asHTML, bool_includeStackTrace) {
			var e = '';
			var v = '';
			var vn = '';
			var i = -1;
			var k = -1;
			var bool_isError = false;
			var sCurrent = -1;
			var sId = -1;
			var sLine = -1;
			var sColumn = -1;
			var sTemplate = -1;
			var nTagStack = -1;
			var sMisc = '';
			var sMiscList = '';
			var _content = '<ul>';
			var _ignoreList = '<remoteAddress>, <browser>, <dateTime>, <HTTPReferer>, <diagnostics>, <TagContext>';
			var _specialList = '<StackTrace>';
			var content_specialList = '';
			var aToken = '';
			var special_templatesList = ''; // comma-delimited list or template keywords

			if (NOT IsBoolean(bool_asHTML)) {
				bool_asHTML = false;
			}
			
			if (NOT IsBoolean(bool_includeStackTrace)) {
				bool_includeStackTrace = false;
			}
			
			if (NOT bool_asHTML) {
				_content = '';
			}

			for (e in _error) {
				if (FindNoCase('<#e#>', _ignoreList) eq 0) {
					try {
						if (0) {
							v = '--- UNKNOWN --';
							vn = "_error." & e;
			
							if (IsDefined(vn)) {
								v = Evaluate(vn);
							}
						} else {
							v = _error[e];
						}
					} catch (Any ee) {
						v = '--- ERROR --';
					}
	
					if (FindNoCase('<#e#>', _specialList) neq 0) {
						if (NOT bool_asHTML) {
							content_specialList = content_specialList & '#e#=#v#, ';
						} else {
							v = '<textarea cols="100" rows="20" readonly style="font-size: 10px;">#v#</textarea>';
							content_specialList = content_specialList & '<li><b>#e#</b>&nbsp;#v#</li>';
						}
					} else {
						if (NOT bool_asHTML) {
							_content = _content & '#e#=#v#,';
						} else {
							_content = _content & '<li><b>#e#</b>&nbsp;#v#</li>';
						}
					}
				}
			}
			if (bool_includeStackTrace) {
				nTagStack = ArrayLen(_error.TAGCONTEXT);
				if (NOT bool_asHTML) {
					_content = _content &	'The contents of the tag stack are: nTagStack = [#nTagStack#], ';
				} else {
					_content = _content &	'<li><p><b>The contents of the tag stack are: nTagStack = [#nTagStack#] </b>';
				}
				if (nTagStack gt 0) {
					for (i = 1; i neq nTagStack; i = i + 1) {
						bool_isError = false;
						try {
							sCurrent = _error.TAGCONTEXT[i];
						} catch (Any e2) {
							bool_isError = true;
							break;
						}
						if (NOT bool_isError) {
							sMiscList = '';
							for (sMisc in sCurrent) {
								if (NOT bool_asHTML) {
									sMiscList = ListAppend(sMiscList, ' [#sMisc#=#sCurrent[sMisc]#] ', ' | ');
								} else {
									sMiscList = sMiscList & '<b><small>[#sMisc#=#sCurrent[sMisc]#]</small></b><br>';
								}
							}
							if (NOT bool_asHTML) {
								_content = _content & sMiscList & '.';
							} else {
								_content = _content & '<br>' & sMiscList & '.';
							}
						}
					}
				}
				if (bool_asHTML) {
					_content = _content & '</p></li>';
				}
				_content = _content & content_specialList;
				if (bool_asHTML) {
					_content = _content & '</ul>';
				} else {
					_content = _content & ',';
				}
			}
			
			return _content;
		}

		function explainError(_error, bool_asHTML) {
			return _explainError(_error, bool_asHTML, false);
		}

		function explainErrorWithStack(_error, bool_asHTML) {
			return _explainError(_error, bool_asHTML, true);
		}
		
		function onSessionStart() {
			try {
				Session.started = now();
				if (NOT IsDefined("Application.sessions")) {
					Application.sessions = 0;
				}
				Application.sessions = Application.sessions + 1;
			} catch (Any e) {
			}
		}

		function onSessionEnd(SessionScope,ApplicationScope) {
			try {
				SessionScope.ended = now();
				SessionScope.sessionLength = -1;
				if (IsDefined("SessionScope.started")) {
					SessionScope.sessionLength = TimeFormat(SessionScope.ended - SessionScope.started, "H:mm:ss");
				}
				if (NOT IsDefined("Application.sessions")) {
					Application.sessions = 0;
				}
				Application.sessions = Application.sessions - 1;
				cf_log('Session #SessionScope.sessionid# ended. Length: #SessionScope.sessionLength# Active sessions: #Application.sessions#');
			} catch (Any e) {
			}
		}

	</cfscript>

	<cffunction name="onApplicationStart" access="public">
		<cfset Application.INTRANET_DS = "INTRANETDB">
		<cftry>
			<!--- Test whether the DB is accessible by selecting some data. --->
			<cfquery name="testDB" dataSource="#Application.INTRANET_DS#">
				SELECT TOP 1 * FROM AvnUsers
			</cfquery>
			<!--- If we get a database error, report an error to the user, log the
			      error information, and do not start the application. --->
			<cfcatch type="database">
				<cfoutput>
					This application encountered an error<br>
					Unable to use the ColdFusion Data Source named "#Application.INTRANET_DS#"<br>
					Please contact support.
				</cfoutput>
				<cflog file="#This.Name#" type="error" text="#Application.INTRANET_DS# DSN is not available. message: #cfcatch.message# Detail: #cfcatch.detail# Native Error: #cfcatch.NativeErrorCode#" >
				<cfreturn False>
			</cfcatch>
		</cftry>

		<cflog file="#This.Name#" type="Information" text="Application Started">
		<!--- You do not have to lock code in the onApplicationStart method that sets
		      Application scope variables. --->
		<cfscript>
			Application.sessions = 0;
		</cfscript>
		<cfreturn True>
	</cffunction>

	<cffunction name="onApplicationEnd" access="public">
		<cfargument name="ApplicationScope" required=true/>
		<cflog file="#This.Name#" type="Information" text="Application #Arguments.ApplicationScope.applicationname# Ended" >
	</cffunction>

	<cffunction name="onError" access="public">
		<cfargument name="Exception" required=true/>
		<cfargument type="String" name="EventName" required=true/>

		<!--- Log all errors. --->
		<cfset rootcause_message = "">
		<cfif (IsDefined("Arguments.Exception.rootcause.message"))>
			<cfset rootcause_message = ", Root Cause Message: #Arguments.Exception.rootcause.message#">
		</cfif>
		<cflog file="#This.Name#" type="error" text="Event Name: #Arguments.Eventname#, Message: #Arguments.Exception.message##rootcause_message# [#explainError(Arguments.Exception, false)#]">
		<!--- Display an error message if there is a page context. --->
		<cfif NOT ( (Arguments.EventName IS "onSessionEnd") OR (Arguments.EventName IS "onApplicationEnd") )>
			<cfoutput>
				<h2>An unexpected error occurred.</h2>
				<p>Error Event: #Arguments.EventName#</p>
				<p>Error details:<br>
				<cfdump var="#Arguments.Exception#" label="Arguments.Exception" expand="No">
			</cfoutput>
		</cfif>
	</cffunction>

	<cffunction name="onRequestStart" access="public">
		<cfargument name = "_targetPage" required=true/>

		<cfif 0>
			<cflog file="#This.Name#" type="Information" text="_onRequestStart.1 :: _targetPage = [#_targetPage#]">
		</cfif>
		
		<cfif FindNoCase("su-extweb-d",CGI.SERVER_NAME) NEQ 0>
		 	<cfset Request.CorporateRootPath = "http://#CGI.SERVER_NAME#:8081/c/">
		<cfelseif FindNoCase("su-extweb-s",CGI.SERVER_NAME) NEQ 0>
		 	<cfset Request.CorporateRootPath = "http://#CGI.SERVER_NAME#/c/">
		<cfelse>
			<cfset Request.CorporateRootPath = "http://www.weathernews.com/us/c/">
		</cfif>
		<!--- <cfsetting showdebugoutput="no" /> --->
		<cfset Request.AVNOPS_DS = "AVNOPS">

		<cfset Request.INTRANET_DS = Application.INTRANET_DS>
		<cfset Request.MEDIACAST_DS = "WOW">	
		<cfset Request.BUSPROD_DS = "BUSPROD">	
		<cfset Request.BUSPROD_DSBUSHIST_DS = "BUSHIST">	
		<cfset Request.BUSARCHIVE_DS = "BUSARCHIVE">	
	
		<cfset request.OPS_PHONE_CONTACT = "866.842.6433 or 405.310.2955">
		
		<cfif (FindNoCase(".wni.com", CGI.SERVER_NAME) eq 0)>
			<cfset _maxElapsedSecs = (60 * 15)>
			<cfset Request.urlPrefix = "">
			<cfset Request.default_htm = "default.cfm">
			<cfset Request.login_htm = "login.cfm">
			<cfset Request.webRoot = ListDeleteAt(CGI.CF_TEMPLATE_PATH, ListLen(CGI.CF_TEMPLATE_PATH, "\"), "\") & "\">
			<cfset Request.const_replacementSymbol = "%+++%">
			<cfset Request.const_alreadyLoggedInReasonType = '<p align="justify"><b>You are already logged in from another workstation or browser and cannot therefore be logged in again from your current location.  Kindly perform a logout from the browser or workstation you are already logged in at and then return here to try again.<br><br>You may try again #Request.const_replacementSymbol# of inactivity at which time your prior user session will be replaced by a new user session on a different workstation (<i>perhaps the workstation you are trying to use now</i>) however when you return to your prior instance of this application you may be required to wait up to an additional 15 minutes unless you perform a Logout to conclude each session of use.</b></p>'>
			<cfset Request.userSessionExpiredMsg = '<font color="blue"><small><b>(User Session has expired due to inactivity !)</b></small></font>'>
			<cfset Request.imagesPrefix = Request.urlPrefix & "images/">

			<cfscript>
				err_xmlCacheObj = false;
				err_xmlCacheObjMsg = '';
				err_context = -1;
				try {
				   Request.xmlCacheObj = CreateObject("component", ListGetAt(CGI.SCRIPT_NAME, ListLen(CGI.SCRIPT_NAME, "/") - 1, "/") & ".COM.weathernews.objectCache.xmlCache").init();
				} catch(Any e) {
					err_xmlCacheObj = true;
					err_context = e;
					err_xmlCacheObjMsg = '(1) The xmlCacheObj component has NOT been created.';
					writeOutput('<font color="red"><b>#err_xmlCacheObjMsg#</b></font><br>');
				}
			</cfscript>

			<cfif 0>
				<cfset _db = "">
				<cfif (IsDefined('Client.loginFailed'))>
					<cfset _db = "Client.loginFailed = [#Client.loginFailed#]">
				</cfif>
				<cflog file="#This.Name#" type="Information" text="_onRequestStart.2 :: IsDefined('Client.loginFailed') = [#IsDefined('Client.loginFailed')#] #_db#">
			</cfif>
			
			<cfif (NOT IsDefined("Client.loginFailed"))>
				<cfif (IsDefined("cookie.BeaconStats"))>
					<cfsavecontent variable="sql_getCredentialsFromCookie">
						<cfoutput>
							SELECT UserID, UserName, UserPassword, UserGreeting, LastLoginDate, ISNULL(isLoggedInActivityDate, CAST('01/01/#(Year(Now()) - 49)#' as datetime)) as 'isLoggedInActivityDate', ISNULL(isLoggedInAsCFToken, '') as 'isLoggedInAsCFToken', ISNULL(isLoggedIn, 0) as 'isLoggedIn'
							FROM AvnUsers
							WHERE (LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#')
								AND (isLoggedIn = 1)
						</cfoutput>
					</cfsavecontent>

					<cfquery NAME="getCredentialsFromCookie" DATASOURCE="#Request.INTRANET_DS#">
						#PreserveSingleQuotes(sql_getCredentialsFromCookie)#
					</cfquery>
				<cfelse>
					<cfset getCredentialsFromCookie = -1>
				</cfif>

				<cfif 0>
					<cflog file="#This.Name#" type="Information" text="_onRequestStart.3 :: getCredentialsFromCookie.recordCount = [#getCredentialsFromCookie.recordCount#], getCredentialsFromCookie.isLoggedInAsCFToken = [#getCredentialsFromCookie.isLoggedInAsCFToken#], sql = [#sql_getCredentialsFromCookie#]">
				</cfif>
				
				<cfif (IsQuery(getCredentialsFromCookie)) AND (getCredentialsFromCookie.recordCount gt 0)>
					<!--- BEGIN: If the user is currently logged-in determine how much time has passed since their last bit of activity --->

					<cfif 0>
						<cflog file="#This.Name#" type="Information" text="_onRequestStart.4 :: getCredentialsFromCookie.isLoggedInAsCFToken = [#getCredentialsFromCookie.isLoggedInAsCFToken#], Client.cftoken = [#Client.cftoken#] [#(getCredentialsFromCookie.isLoggedInAsCFToken neq Client.cftoken)#]">
					</cfif>

					<cfif (getCredentialsFromCookie.isLoggedInAsCFToken neq Client.cftoken)>
						<cfset _elapsedTimeSecs = DateDiff("s", getCredentialsFromCookie.isLoggedInActivityDate, Now())>
						<cfset _db = (FindNoCase("default.cfm", CGI.HTTP_REFERER) eq 0)>

						<cfif 0>
							<cflog file="#This.Name#" type="Information" text="_onRequestStart.4a :: _elapsedTimeSecs = [#_elapsedTimeSecs#], Time-Up? = [#(_elapsedTimeSecs gt _maxElapsedSecs)#], From default.cfm ? = [#_db#]">
						</cfif>

						<cfif (_elapsedTimeSecs gt _maxElapsedSecs)>  <!---  AND (FindNoCase("default.cfm", CGI.HTTP_REFERER) eq 0) --->
							<cfif (IsDefined("cookie.BeaconStats"))>
								<CFQUERY NAME="qClaimOwnershipUsingCurrentWorkstation" DATASOURCE="#Request.INTRANET_DS#">
									UPDATE AvnUsers
									SET isLoggedInActivityDate = GetDate(), isLoggedInAsCFToken = '#Client.cftoken#'
									WHERE (LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#')
										AND (Deleted = 0)
										AND (isLoggedIn = 1)
								</CFQUERY>
							</cfif>

							<cfif 0>
								<cflog file="#This.Name#" type="Information" text="_onRequestStart.4a2 :: _elapsedTimeSecs = [#_elapsedTimeSecs#], Time-Up? = [#(_elapsedTimeSecs gt _maxElapsedSecs)#], From default.cfm ? = [#_db#]">
							</cfif>
						<cfelse>
							<cfif 0>
								<cflog file="#This.Name#" type="Information" text="_onRequestStart.4a1 :: _elapsedTimeSecs = [#_elapsedTimeSecs#], Time-Up? = [#(_elapsedTimeSecs gt _maxElapsedSecs)#], From default.cfm ? = [#_db#]">
							</cfif>
							<!--- BEGIN: The user is not logged in so kick them back to the login page --->
							<cfset Client.loginFailed = 1>

							<cfset Request._moreTimeSecs = _maxElapsedSecs - _elapsedTimeSecs>
							<cfset _timeToWait = Ceiling(Request._moreTimeSecs / 60)>
							<cfset the_s = "s">
							<cfif (_timeToWait gte 0) AND (_timeToWait lte 1)>
								<cfset the_s = "">
							</cfif>
							<cfset Request.alreadyLoggedInReasonType = ReplaceNoCase(Request.const_alreadyLoggedInReasonType, Request.const_replacementSymbol, "after another #_timeToWait# minute#the_s#")>

							<!--- BEGIN: This user cannot access at this time so let him off the merry-go-round --->
							<cfinclude template="login.htm">
							<cfreturn False>
							<!--- END! This user cannot access at this time so let him off the merry-go-round --->
							<!--- END! The user is not logged in so kick them back to the login page --->
						</cfif>
					<cfelse>
						<cfif 0>
							<cflog file="#This.Name#" type="Information" text="_onRequestStart.4b :: getCredentialsFromCookie.isLoggedInAsCFToken = [#getCredentialsFromCookie.isLoggedInAsCFToken#], Client.cftoken = [#Client.cftoken#] [#(getCredentialsFromCookie.isLoggedInAsCFToken neq Client.cftoken)#]">
						</cfif>
						<!--- BEGIN: User has not expired their session via inactivity however they are doing things so update the activity flags --->
						<CFQUERY NAME="UpdateUserSessionActivity" DATASOURCE="#Request.INTRANET_DS#">
							UPDATE AvnUsers
							SET isLoggedInActivityDate = GetDate()
							WHERE (isLoggedInAsCFToken = '#Client.cftoken#')
								AND (Deleted = 0)
								AND (isLoggedIn = 1)
						</CFQUERY>
						<!--- END! User has not expired their session via inactivity however they are doing things so update the activity flags --->
					</cfif>
					<!--- END! If the user is currently logged-in determine how much time has passed since their last bit of activity --->
				<cfelseif 0>
					<!--- BEGIN: Perform the normal authentication here and resume processing --->
					<cfif 0>
						<cflog file="#This.Name#" type="Information" text="_onRequestStart.5 :: Perform the normal authentication here and resume processing...">
					</cfif>
					<cfinclude template="include/authentication.cfm">
					<cfreturn False>
					<!--- END! Perform the normal authentication here and resume processing --->
				</cfif>
			<cfelse>
				<!--- BEGIN: This user cannot access at this time so let him off the merry-go-round --->
				<cfif 0>
					<cflog file="#This.Name#" type="Information" text="_onRequestStart.6 :: This user cannot access at this time so let him off the merry-go-round...">
				</cfif>
				<cfinclude template="login.htm">
				<cfreturn False>
				<!--- END! This user cannot access at this time so let him off the merry-go-round --->
			</cfif>
		<cfelse>
			<cfset Request.urlPrefix = "/">
			<cfset Request.default_htm = "default.htm">
			<cfset Request.login_htm = "login.htm">
			<cfset Request.webRoot = "D:\Data\console\">
			<cfset Request.imagesPrefix = Request.urlPrefix & "images/">
		</cfif>

		<cfreturn True>
	</cffunction>

	<cffunction name="onRequestEnd" access="public">
		<cfargument name = "_targetPage" required=true/>

		<cfif 0>
			<cflog file="#This.Name#" type="Information" text="onRequestEnd :: [_targetPage=#_targetPage#]">
		</cfif>

	</cffunction>
</cfcomponent>
