<cfcomponent hint="layerIdToName">


	<cffunction name="init" access="public" returntype="string">
		<cfargument name="strLayerCookie" required="yes" type="string" />
		<cfargument name="strXmlFileName" required="yes" type="string" />
			<cfset variables.sctNamesStruct = getLayerNames(arguments.strLayerCookie,arguments.strXmlFileName) />
			
			<cfset variables.arrKeys = StructKeyArray(variables.sctNamesStruct) />
			<cfset variables.times = "" />
			<cfloop from="1" to="#StructCount(variables.sctNamesStruct)#" index="myIndex">
				<cfset variables.times = variables.times & getFileNames(StructFind(variables.sctNamesStruct,variables.arrKeys[myIndex])) />
			</cfloop>
			
		<cfreturn variables.times />
	</cffunction>
	
	
	<cffunction name="getLayerNames" access="package" returntype="struct">
		<cfargument name="strLayerCookie" required="yes" type="string" />
		<cfargument name="strXmlFileName" required="yes" type="string" />
			<cffile action="read" 
					file="#ExpandPath(arguments.strXmlFileName)#" 
					variable="filevar.xmlFileContents" />
			<cfset variables.myXmlDoc = XmlParse(filevar.xmlFileContents) />
			<cfset variables.xmlID = XmlSearch(variables.myXmlDoc,"/Layers/Layer/ID") />
			<cfset variables.xmlLayerNames = XmlSearch(variables.myXmlDoc,"/Layers/Layer/Name") />
			<cfset variables.xmlTimeFiles = XmlSearch(variables.myXmlDoc,"/Layers/Layer/Times") />
			<cfset variables.arrIDs = ArrayNew(1) />
			<cfset variables.arrNames = ArrayNew(1) />
			<cfset variables.arrTimes = ArrayNew(1) />
			<cfloop from="1" to="#ArrayLen(variables.xmlID)#" index="ids">
				<cfset variables.arrIDs[ids] = variables.xmlID[ids].XmlText />
				<cfset variables.arrNames[ids] = variables.xmlLayerNames[ids].XmlText />
				<cfset variables.arrTimes[ids] = variables.xmlTimeFiles[ids].XmlText />
			</cfloop>
			<cfset variables.qryLayers = QueryNew("") />
			<cfset QueryAddColumn(variables.qryLayers,'id',variables.arrIDs) />
			<cfset QueryAddColumn(variables.qryLayers,'layerNames',variables.arrNames) />
			<cfset QueryAddColumn(variables.qryLayers,'layerTimeFiles',variables.arrTimes) />
			<cfset variables.sctLayerNames = StructNew() />
			<cfloop list="#arguments.strLayerCookie#" index="strLayerID">
				<cfquery name="getLayerNames" dbtype="query">
					SELECT id, layerNames, layerTimeFiles
					FROM variables.qryLayers
					WHERE id = #strLayerID#
				</cfquery>
				<cfif getLayerNames.layerTimeFiles IS NOT "">
					<cfset StructInsert(variables.sctLayerNames,getLayerNames.id,getLayerNames.layerNames & ":" & getLayerNames.layerTimeFiles) />
				</cfif>
			</cfloop>
		<cfreturn variables.sctLayerNames />
	</cffunction>
	
	
	<cffunction name="getFileNames" access="package" returntype="string">
		<cfargument name="sctfileList" type="string" required="yes" />
			<cfobject component="timeFileToString" name="timeFileToString" />
			<cfset variables.timeString = timeFileToString.init(arguments.sctfileList) />
		<cfreturn variables.timeString />
	</cffunction>
	
	
</cfcomponent>