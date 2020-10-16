<cfcomponent hint="setLayers">
	<cffunction name="init" access="public" returntype="boolean">
		<cfargument name="flashID" type="numeric" required="yes" />
		<cfargument name="layers" type="string" required="yes" />
		<cfset response = setLayers(arguments.flashID,arguments.layers) />
		<cfreturn response />
	</cffunction>
	<cffunction name="setLayers" access="package" returntype="boolean">
		<cfargument name="flashID" type="numeric" required="yes" />
		<cfargument name="layers" type="string" required="yes" />
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
			<!--- See if user has a bBox entry for this particular flash id, if not
				  then create a new one --->
			<cfquery name="getIDFromBboxTable" datasource="#INTRANET_DS#">
				SELECT TOP 1 id,Bbox
				FROM AvnBoundingBox
				WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #flashID#
			</cfquery>
			<cfif getIDFromBboxTable.RecordCount NEQ 0>
			<!--- Create a transaction to update the bBox and the layers --->
			<cftransaction>
				
				<cfquery name="updateLayers" datasource="#INTRANET_DS#">
					UPDATE AvnUserLayerString
					SET layerString = '#arguments.layers#'
					WHERE AvnBoundingBoxID = '#getIDFromBboxTable.id#'
				</cfquery>
			
			</cftransaction>
			
			<cfelse>
			
				<!--- The user does not have an entry in the table --->
				<cftransaction>
					
					<cfquery name="createBbox" datasource="#INTRANET_DS#">
						INSERT INTO AvnBoundingBox (userID,flashID,bBox,stageH,stageW)
						VALUES (#SESSION.getUserIDFromLoginID.userID#,#flashID#,'-130.496455586007,18.598539904507,-59.7473232373829,51.5157846843435','400','800')
					</cfquery>
					
					<cfquery name="getIDFromBboxTable" datasource="#INTRANET_DS#">
						SELECT TOP 1 id
						FROM AvnBoundingBox
						WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #flashID#
					</cfquery>
					
					<cfquery name="createLayers" datasource="#INTRANET_DS#">
						INSERT INTO AvnUserLayerString (AvnBoundingBoxID,layerString)
						VALUES (#getIDFromBboxTable.id#,'#arguments.layers#')
					</cfquery>
				
				
				</cftransaction>
				
			</cfif>
			<cfreturn 1 />
	</cffunction>
</cfcomponent>
		