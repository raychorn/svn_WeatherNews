<cfcomponent hint="getLayers.cfc">
	<cffunction name="init" access="public" returntype="string">
		<cfargument name="flashID" type="numeric" required="yes" />

		<cfset myResult = getLayers(arguments.flashID) />
		<cfreturn myResult>
	</cffunction>
	<cffunction name="getLayers" access="package" returntype="string">
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
	<cfreturn getUserPosition.layerString />
	</cffunction>
</cfcomponent>