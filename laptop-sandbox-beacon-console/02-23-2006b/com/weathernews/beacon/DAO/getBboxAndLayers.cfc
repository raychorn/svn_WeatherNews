<cfcomponent hint="getBboxAndLayers.cfc">
	<cffunction name="init" access="public" returntype="query">
		<cfargument name="flashID" type="numeric" required="yes" />

		<cfset myResult = getUserPositionPlusLayers(arguments.flashID) />
		<cfreturn myResult>
	</cffunction>
	<cffunction name="getUserPositionPlusLayers" access="package" returntype="query">
		<cfargument name="flashID" type="numeric" required="yes" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfif NOT IsDefined("SESSION.getUserIDFromLoginID")>
				<cflock scope="session" timeout="#CreateTimeSpan(0,0,0,45)#">
					<cfquery NAME="SESSION.getUserIDFromLoginID" DATASOURCE="#INTRANET_DS#">
							select UserID
							from AvnUsers
							where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
							and Deleted = 0
					</cfquery>
				</cflock>
			</cfif>
		<cfquery name="getUserPosition" datasource="#INTRANET_DS#">
			SELECT TOP 1 bbox.*, layers.*
			FROM AvnBoundingBox bbox
			LEFT JOIN AvnUserLayerString AS layers ON bbox.id = layers.AvnBoundingBoxID
			WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #arguments.flashID#
		</cfquery>
		<cfif getUserPosition.RecordCount EQ 0>
			<cfif flashID IS 11>
				<cfset layerString = "18,16,10,11,12,1" />
			<cfelse>
				<cfset layerString = "18,16,10,11,12" />
			</cfif>
			<cfset CreateObject("component","com.weathernews.beacon.DAO.setLayers").init(arguments.flashID,layerString) />
			<cfquery name="getUserPosition" datasource="#INTRANET_DS#">
				SELECT TOP 1 bbox.*, layers.*
				FROM AvnBoundingBox bbox
				LEFT JOIN AvnUserLayerString AS layers ON bbox.id = layers.AvnBoundingBoxID
				WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #arguments.flashID#
			</cfquery>
		</cfif>
	<cfreturn getUserPosition />
	</cffunction>
</cfcomponent>