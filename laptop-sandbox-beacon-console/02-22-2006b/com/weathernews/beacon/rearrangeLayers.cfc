<cfcomponent hint="rearrangeLayers.cfc">
	<cffunction name="init" access="public" returntype="string">
		<cfargument name="strLayers" type="string" required="yes" />
		<cfset fixedLayers = rearrLayers(arguments.strLayers) />
		<cfreturn fixedLayers />
	</cffunction>
	<cffunction name="rearrLayers" access="package" returntype="string">
		<cfargument name="strLayers" type="string" required="yes" />
		<cfset arrLayersToMove = ArrayNew(1) />
		<cfset ArrayPrepend(arrLayersToMove,"Borders") />
		<cfset ArrayPrepend(arrLayersToMove,"US State Borders") />
		<cfset ArrayPrepend(arrLayersToMove,"Counties") />
		<cfset ArrayPrepend(arrLayersToMove,"Airports") />
		<cfset ArrayPrepend(arrLayersToMove,"Highways") />
		<cfset ArrayPrepend(arrLayersToMove,"Coastlines") />
		<cfset ArrayPrepend(arrLayersToMove,"Cities") />
		<cfset newList = arguments.strLayers />
		<cfloop from="1" to="#ArrayLen(arrLayersToMove)#" index="i">
			<cfset position = ListFindNoCase(newList,arrLayersToMove[i]) />
			<cfif position NEQ 0>
				<cfset holder = ListGetAt(newList,position) />
				<cfset newList = ListAppend(newList,holder) />
				<cfset newList = ListDeleteAt(newList,position) />
			<cfelse>
				<!--- Layer not found, do nothing --->
			</cfif>
		</cfloop>
		<cfreturn newList />
	</cffunction>
</cfcomponent>