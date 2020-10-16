<cfcomponent displayname="xmlCache" hint="xmlCache - read-thru cache to speed-up xml processing..." extends="primitiveCode">

	<cfscript>
		// Purpose: Cache's the contents of the xml file and the processing being done on that file in the Application Scope...
		// Processing is passed-in via a Struct pointer (this is how CF handles pointers to functions)...
		this.hasBeenInitialized = false;
	</cfscript>

	<cffunction name="initApplicationCache" access="private" returntype="boolean">
		<cfset Request.bool_isError = "False">
		<cftry>
			<cflock timeout="30" throwontimeout="No" type="EXCLUSIVE" scope="APPLICATION">
				<cfscript>
					if ( (NOT IsDefined("Application.xmlCache")) OR ( (IsDefined("URL.reinit")) AND (URL.reinit eq 1) ) ) {
						Application.xmlCache = StructNew();
						Application.xmlCache.filesQ = QueryNew('id, fName, fDate');
						Application.xmlCache.dataStore = StructNew(); // the key is the fName...
						Application.xmlCache.xmlStore = StructNew(); // the key is the fName...
writeOutput('<font color="blue"><b>INIT</b></font><br>');
					}
				</cfscript>
			</cflock>

			<cfcatch type="Any">
				<cfset Request.bool_isError = "True">

				<cfsavecontent variable="Request.initApplicationCacheErrorMsg">
					<cfoutput>
						#cfcatch.message#<br>
						#cfcatch.detail#
					</cfoutput>
				</cfsavecontent>
				<cfsavecontent variable="Request.initApplicationCacheFullErrorMsg">
					<cfdump var="#cfcatch#" label="cfcatch" expand="Yes">
				</cfsavecontent>
			</cfcatch>
		</cftry>
		
		<cfreturn Request.bool_isError>
	</cffunction>

	<cffunction name="isXMLFileCached" access="private" returntype="string">
		<cfargument name="fName" type="string" required="yes">
		<cfargument name="fDate" type="date" required="yes">
		
		<cfset var theData = "">
		<cfset var _fDate = CreateODBCDateTime(arguments.fDate)>
		<cfset var curRow = 0>
		
		<cfset Request.bool_isError = "False">
		<cftry>
			<cflock timeout="30" throwontimeout="No" type="EXCLUSIVE" scope="APPLICATION">
				<cfscript>
//writeOutput('(IsDefined("Application.xmlCache")) = [#(IsDefined("Application.xmlCache"))#]<br>');
					if (IsDefined("Application.xmlCache")) {
//writeOutput('(FileExists(arguments.fName)) = (#arguments.fName#) [#(FileExists(arguments.fName))#]<br>');
						if (FileExists(arguments.fName)) {
//writeOutput('IsDefined("Application.xmlCache.filesQ") = [#IsDefined("Application.xmlCache.filesQ")#]<br>');
							if (NOT IsDefined("Application.xmlCache.filesQ")) {
								Application.xmlCache.filesQ = QueryNew('id, fName, fDate');
							}
							if (NOT IsDefined("Application.xmlCache.dataStore")) {
								Application.xmlCache.dataStore = StructNew(); // the key is the fName...
							}
							safely_execSQL('this.qLocateCachedFile', '', "SELECT * FROM Application.xmlCache.filesQ WHERE (fName = '#arguments.fName#')"); //  AND (fDate >= #_fDate#)
//writeOutput('Request.dbError = [#Request.dbError#]<br>');
							if (NOT Request.dbError) {
//writeOutput('(IsQuery(this.qLocateCachedFile)) = [#(IsQuery(this.qLocateCachedFile))#]<br>');
								if (IsQuery(this.qLocateCachedFile)) {
//writeOutput('this.qLocateCachedFile.recordCount = [#this.qLocateCachedFile.recordCount#]<br>');
									if ( (this.qLocateCachedFile.recordCount eq 0) OR (this.qLocateCachedFile.fDate lt _fDate) ) {
										curRow = this.qLocateCachedFile.id;
										if (this.qLocateCachedFile.recordCount eq 0) {
											curRow = Application.xmlCache.filesQ.recordCount;
											QueryAddRow(Application.xmlCache.filesQ, 1);
											QuerySetCell(Application.xmlCache.filesQ, 'id', Application.xmlCache.filesQ.recordCount, Application.xmlCache.filesQ.recordCount);
											QuerySetCell(Application.xmlCache.filesQ, 'fName', arguments.fName, Application.xmlCache.filesQ.recordCount);
											Application.xmlCache.dataStore[arguments.fName] = cf_file(arguments.fName, 'READ');
											Application.xmlCache.xmlStore[arguments.fName] = XMLParse(Application.xmlCache.dataStore[arguments.fName]);
writeOutput('+++ #arguments.fName#<br>');
										} else if (this.qLocateCachedFile.fDate lt _fDate) {
											Application.xmlCache.dataStore[arguments.fName] = cf_file(arguments.fName, 'READ');
											Application.xmlCache.xmlStore[arguments.fName] = XMLParse(Application.xmlCache.dataStore[arguments.fName]);
writeOutput('*** #arguments.fName#<br>');
										}
										QuerySetCell(Application.xmlCache.filesQ, 'fDate', _fDate, curRow);
									}

									theData = Application.xmlCache.dataStore[this.qLocateCachedFile.fName];
								}
							}
						}
					}
				</cfscript>
			</cflock>

			<cfcatch type="Any">
				<cfset Request.bool_isError = "True">

				<cfsavecontent variable="Request.initApplicationCacheErrorMsg">
					<cfoutput>
						#cfcatch.message#<br>
						#cfcatch.detail#
					</cfoutput>
				</cfsavecontent>
				<cfsavecontent variable="Request.initApplicationCacheFullErrorMsg">
					<cfdump var="#cfcatch#" label="cfcatch" expand="Yes">
				</cfsavecontent>
			</cfcatch>
		</cftry>
		
		<cfreturn theData>
	</cffunction>

	<cffunction name="isXMLObjectCached" access="private" returntype="any">
		<cfargument name="fName" type="string" required="yes">
		<cfargument name="fDate" type="date" required="yes">

		<cfset var theDataObj = -1>

		<cflock timeout="30" throwontimeout="No" type="EXCLUSIVE" scope="APPLICATION">
			<cfscript>
				if (Len(Application.xmlCache.dataStore[arguments.fName]) gt 0) {
					theDataObj = Application.xmlCache.xmlStore[arguments.fName];
				}
			</cfscript>
		</cflock>

		<cfreturn theDataObj>
	</cffunction>

	<cfscript>
		function init() {
			initApplicationCache();
			this.hasBeenInitialized = true;
			return this;
		}
		
		function xmlCacheRead(fName, funcPtr, sArgs) {
			var sRet = StructNew();
			
			if (FileExists(fName)) {
				this.bool_isError = cf_directory('Request.qDir', GetDirectoryFromPath(fName), GetFileFromPath(fName));
				if (NOT this.bool_isError) {
					sRet.pName = Request.qDir.directory & '\' & Request.qDir.name;
					sRet.theData = isXMLFileCached(sRet.pName, Request.qDir.dateLastModified);
					if ( (IsCustomFunction(funcPtr)) AND (IsStruct(sArgs)) ) {
						sRet.sVals = funcPtr(sArgs, isXMLObjectCached(sRet.pName, Request.qDir.dateLastModified));
					}
				}
			}
			return sRet;
		}
	</cfscript>
	
</cfcomponent>