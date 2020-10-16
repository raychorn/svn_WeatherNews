<cfcomponent hint="getLayerArr.cfc">
	<cffunction name="init" access="remote" returntype="array">
		<cfset arrLayers = getLayers() />
		<cfreturn arrLayers />
	</cffunction>
	<cffunction name="getLayers" access="package" returntype="array">
	
		<!--- Include application global variables --->
		<cfinclude template="/include/GlobalParams.cfm" />
		
		<!--- Variable Declarations --->
		<cfset arrNames = ArrayNew(1) />
		<cfset arrLegacyID = ArrayNew(1) />
		<cfset arrFlashLayerArray = ArrayNew(2) />
		
		<!--- Query object to get the layers --->
		<cfquery name="query.getLayers" datasource="#INTRANET_DS#">
			SELECT layerName, legacyID
			FROM AvnLayer
		</cfquery>
		
		<!--- Convert query columns into lists --->
		<cfset listNames = ValueList(query.getLayers.layerName,",") />
		<cfset listLegacyID = ValueList(query.getLayers.legacyID,",") />
		
		<!--- Convert lists to arrays --->
		<cfset arrNames = ListToArray(listNames,",") />
		<cfset arrLegacyID = ListToArray(listLegacyID,",") />
		
		<!--- Loop over arrays and create a super array --->
			<cfloop from="1" to="#ArrayLen(arrNames)#" index="i">
				<cfset arrFlashLayerArray[i][2] = arrNames[i] />
				<cfset arrFlashLayerArray[i][1] = arrLegacyID[i] />
			</cfloop>
			
		<!--- Return the super array --->
		<cfreturn arrFlashLayerArray />
	</cffunction>
</cfcomponent>