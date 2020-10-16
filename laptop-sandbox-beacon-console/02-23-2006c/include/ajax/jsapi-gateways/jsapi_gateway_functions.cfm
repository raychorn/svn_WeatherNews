<!--- BEGIN: This block of code sets-up the Request.qryObj which is a ColdFusion Query Object that holds the parms from the AJAX call --->
<!--- Request.qryStruct also contains the variables that were passed-in from the caller... --->
<cfinclude template="cfinclude_jsapi_gateway_abstractions.cfm">
<!--- END! This block of code sets-up the Request.qryObj which is a ColdFusion Query Object that holds the parms from the AJAX call --->

<!--- This is where you may code your ColdFusion code that processes the AJAX Function --->
<cfswitch expression="#Request.qryStruct.cfm#">
	<cfcase value="writeLayerData">
		<!--- Put the userID in the user's session so that we don't need to
				  repeatedly do this query --->
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
				SELECT TOP 1 id
				FROM AvnBoundingBox
				WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #flashID#
			</cfquery>
			
			<cfif getIDFromBboxTable.RecordCount NEQ 0>
			
			<!--- Create a transaction to update the bBox and the layers --->
			<cftransaction>
			
				<cfquery name="updateBbox" datasource="#INTRANET_DS#">
					UPDATE AvnBoundingBox
					SET bBox = '#bBox#', stageH = '#stageH#', stageW = '#stageW#'
					WHERE id = #getIDFromBboxTable.id#
				</cfquery>
				
				<cfquery name="updateLayers" datasource="#INTRANET_DS#">
					UPDATE AvnUserLayerString
					SET layerString = '#mapLayers#'
					WHERE AvnBoundingBoxID = #getIDFromBboxTable.id#
				</cfquery>
			
			</cftransaction>
			
			<cfelse>
			
				<!--- The user does not have an entry in the table --->
				<cftransaction>
					
					<cfquery name="createBbox" datasource="#INTRANET_DS#">
						INSERT INTO AvnBoundingBox (userID,flashID,bBox,stageH,stageW)
						VALUES (#SESSION.getUserIDFromLoginID.userID#,#flashID#,'#bBox#','#stageH#','#stageW#')
					</cfquery>
					
					<cfquery name="getIDFromBboxTable" datasource="#INTRANET_DS#">
						SELECT TOP 1 id
						FROM AvnBoundingBox
						WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #flashID#
					</cfquery>
					
					<cfquery name="createLayers" datasource="#INTRANET_DS#">
						INSERT INTO AvnUserLayerString (AvnBoundingBoxID,layerString)
						VALUES (#getIDFromBboxTable.id#,'#mapLayers#')
					</cfquery>
				
				
				</cftransaction>
				
			</cfif>
			
			<!--- Build Query object for return to code --->
			<cfset qObj = QueryNew('id,success') />
			<cfset QueryAddRow(qObj, 1) />
			<cfset QuerySetCell(qObj,'id',1) />
			<cfset QuerySetCell(qObj,'success',1) />
			
			
			<cfset Request.commonCode.registerQueryFromAJAX(qObj) /> <!--- this function is used to tell the AJAX system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... he CF Var named Request.qryData is used to hold an array of Query Objects... --->
		<cfbreak>
		</cfcase>
		<cfcase value="readLayerData">
			<cfinvoke component="com.weathernews.beacon.DAO.getBboxAndLayers" method="init" returnvariable="qObj"></cfcase>
	</cfswitch>

<cfdump var="#Request.qryStruct#" label="Request.qryStruct" expand="No">
<!--- the name of the cfm page is stored in the following variable: Request.qryObj.NAME["cfm"] --->

<!--- BEGIN: This block of code passes the Request.qryObj which is a ColdFusion Query Object back to the AJAX caller via a JavaScript object called qObj --->
<cfinclude template="cfinclude_jsapi_gateway_abstractions_finale.cfm">
<!--- END! This block of code passes the Request.qryObj which is a ColdFusion Query Object back to the AJAX caller via a JavaScript object called qObj --->
