<cfcomponent hint="layerIdToName">


	<cffunction name="init" access="remote" returntype="string">
		<cfargument name="strLayerCookie" required="yes" type="string" default="18,16,10,11,12,1,2,22" />
			<cfset variables.sctNamesStruct = getLayerNames(arguments.strLayerCookie) />
			
			<cfset variables.arrKeys = StructKeyArray(variables.sctNamesStruct) />
			<cfset variables.times = "" />
			<cfif StructIsEmpty(variables.sctNamesStruct)>
				<cfset variables.times = "<br />Current Time" />
			<cfelse>
				<cfloop from="1" to="#StructCount(variables.sctNamesStruct)#" index="myIndex">
					<cfset variables.times = variables.times & getFileNames(StructFind(variables.sctNamesStruct,variables.arrKeys[myIndex])) />
				</cfloop>
			</cfif>
		<cfreturn variables.times />
	</cffunction>
	
	
	<cffunction name="getLayerNames" access="package" returntype="struct">
		<cfargument name="strLayerCookie" required="yes" type="string" />
		<cfinclude template="/include/GlobalParams.cfm" />
			<cfquery name="query.getLayerData" datasource="#INTRANET_DS#" cachedwithin="#createTimeSpan(0,0,45,0)#">
				SELECT legacyID AS ID, layerName, timeFileList AS layerTimeFiles,legendFileName,layerDisplayName
				FROM AvnLayer
			</cfquery>
			<cfset variables.sctLayerNames = StructNew() />
			<cfloop list="#arguments.strLayerCookie#" index="strLayerID">
				<cfquery name="query.getLayerNames" dbtype="query">
					SELECT ID, layerName, layerTimeFiles, legendFileName, layerDisplayName
					FROM query.getLayerData
					WHERE id = #strLayerID#
				</cfquery>
				<cfif query.getLayerNames.layerTimeFiles IS NOT "">
					<cfset StructInsert(variables.sctLayerNames,query.getLayerNames.id,query.getLayerNames.layerName & ":" & query.getLayerNames.layerTimeFiles & ":" & "<br />" & "<strong>Legend - #query.getLayerNames.layerDisplayName#</strong>" & 
																"<br /><img src='/images/legends/" & query.getLayerNames.legendFileName & "' alt='" & query.getLayerNames.layerDisplayName & "' />") />
				</cfif>
			</cfloop>
			<!--- <cfdump var="#variables.sctLayerNames#" />
			<cfabort /> --->
		<cfreturn variables.sctLayerNames />
	</cffunction>
	
	
	<cffunction name="getFileNames" access="package" returntype="string">
		<cfargument name="sctfileList" type="string" required="yes" />
			<cfobject component="timeFileToString" name="timeFileToString" />
			<cfset variables.timeString = timeFileToString.init(arguments.sctfileList) />
		<cfreturn variables.timeString />
	</cffunction>
	
	
</cfcomponent>