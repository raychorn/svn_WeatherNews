<!---
A collection of components to be using primary by the Mapworld Flash Application
--->

<cfcomponent>
<cfset variables.debug_file_path = "d:\Data\console\include\debug\">
<cfset variables.set_debug = '0'>
<cfscript>
//var stArgs = structNew();
</cfscript>
	<cffunction access="remote" name="setMapState">
		<cfscript>
		var stArgs = structNew();
		</cfscript>
		<cfinclude template="/include/GlobalParams.cfm" />
		<cftry>
		<cfset bBox = Arguments[1].bBox>
		<cfset flashID = Arguments[1].flashID>
		<cfset mapLayers = Arguments[1].mapLayers>
		<cfset stageH = Arguments[1].stageH>
		<cfset stageW = Arguments[1].stageW>
		
			
		<cfset list_args = "bBox=#bBox#, flashID=#flashID#, mapLayers=#mapLayers#, stageH=#stageH#,stageW=#stageW# ">
		
	
		<cfif variables.set_debug EQ 1>
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="
-----------------------------------------#chr(10)##chr(13)#
entered component, Arguments::#list_args#
		" />
		</cfif>

		<cfset cookieBBoxName = "BBOX_" & flashID>
		<cfset cookieStageHName = "STAGEH">
		<cfset cookieStageWName = "STAGEW">
		<cfset cookieMapLayersName = "MAPLAYERS_" & flashID>
		
		<cfif NOT IsDefined("SESSION.getUserIDFromLoginID")>
				<cflock scope="session" timeout="#CreateTimeSpan(0,8,0,0)#">
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
				SELECT TOP 1 id,bbox
				FROM AvnBoundingBox
				WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #flashID#
			</cfquery>
			
		<!--- <cfinvoke component="com.weathernews.beacon.DAO.getBboxAndLayers" method="init" returnvariable="bboxAndLayers">
			<cfinvokeargument name="flashID" value="#flashID#" />
		</cfinvoke>
		<cfset mapLayers = bboxAndLayers.layerString /> --->
		<!--- set the BBox cookie here --->		
		<cfif (flashID EQ 2) OR (flashID EQ 3) OR (flashID EQ 4) OR (flashID EQ 5)>
			<!--- <cfcookie name="#cookieBBoxName#" value="#bBox#"> --->
			<!--- Put the userID in the user's session so that we don't need to
				  repeatedly do this query --->
			
			
			<cfif getIDFromBboxTable.RecordCount NEQ 0>
				<cfif IsDefined("bBox") AND ReFindNoCase("[0-9]",bBox) NEQ 0>
					<!--- Do Nothing, Bbox is valid --->
				<cfelse>
					<cfset bBox = "-130.496455586007,18.598539904507,-59.7473232373829,51.5157846843435" />
				</cfif>
				<!--- Create a transaction to update the bBox and the layers --->
				<cftransaction>
				
					<cfquery name="updateBbox" datasource="#INTRANET_DS#">
						UPDATE AvnBoundingBox
						SET bBox = '#bBox#', stageH = '#stageH#', stageW = '#stageW#'
						WHERE id = #getIDFromBboxTable.id#
					</cfquery>
					
					<!--- <cfquery name="updateLayers" datasource="#INTRANET_DS#">
						UPDATE AvnUserLayerString
						SET layerString = '#mapLayers#'
						WHERE AvnBoundingBoxID = #getIDFromBboxTable.id#
					</cfquery> --->
				
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
					
					<!--- <cfquery name="createLayers" datasource="#INTRANET_DS#">
						INSERT INTO AvnUserLayerString (AvnBoundingBoxID,layerString)
						VALUES (#getIDFromBboxTable.id#,'#mapLayers#')
					</cfquery> --->
				
				
				</cftransaction>
				
			</cfif>
			
			
			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="setting cookie cookieBBoxName=#cookieBBoxName#::value=#bBox#" />
			</cfif>
			
						
			<cfif (flashID EQ 3) OR (flashID EQ 4)>
				<!--- <cfcookie name="#cookieStageHName#" value="#stageH#">
				<cfcookie name="#cookieStageWName#" value="#stageW#"> --->
				<!--- Put the userID in the user's session so that we don't need to
				  repeatedly do this query --->
			<cfif NOT IsDefined("SESSION.getUserIDFromLoginID")>
				<cflock scope="session" timeout="#CreateTimeSpan(0,8,0,0)#">
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
				SELECT TOP 1 id,bBox
				FROM AvnBoundingBox
				WHERE userID = #SESSION.getUserIDFromLoginID.userID# AND flashID = #flashID#
			</cfquery>
			
			<cfif getIDFromBboxTable.RecordCount NEQ 0>
			<!--- Make sure Bbox is a good value --->
			<cfif IsDefined("bBox") AND ReFindNoCase("[0-9]",bBox) NEQ 0>
					<!--- Do Nothing, Bbox is valid --->
				<cfelse>
					<cfset bBox = "-130.496455586007,18.598539904507,-59.7473232373829,51.5157846843435" />
				</cfif>
			<!--- Create a transaction to update the bBox and the layers --->
			<cftransaction>
			
				<cfquery name="updateBbox" datasource="#INTRANET_DS#">
					UPDATE AvnBoundingBox
					SET bBox = '#bBox#', stageH = '#stageH#', stageW = '#stageW#'
					WHERE id = #getIDFromBboxTable.id#
				</cfquery>
				
				<!--- <cfquery name="updateLayers" datasource="#INTRANET_DS#">
					UPDATE AvnUserLayerString
					SET layerString = '#mapLayers#'
					WHERE AvnBoundingBoxID = #getIDFromBboxTable.id#
				</cfquery> --->
			
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
						VALUES (#getIDFromBboxTable.id#,'#mapLayers#')
					</cfquery>
				
				
				</cftransaction>
				
			</cfif>
				<cfif variables.set_debug EQ 1>
					<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="setting cookie cookieStageHName=#cookieStageHName#::value=#stageH#">
					<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="setting cookie cookieStageWName=#cookieStageWName#::value=#stageW#">
				</cfif>			
			</cfif>
		
		</cfif>
		<!--- MapLayer cookie should have been set through the sidemenu --->		
		<!--- <cfif isDefined("cookie." & cookieMapLayersName)>
			<cfset mapLayers = Evaluate("cookie." & cookieMapLayersName)>
		<cfelse>
			<cfset mapLayers = "18,16,11">
		</cfif> --->
		
		<!--- Get newly updated layers from the table --->
		<cfquery name="mapLayers" datasource="#INTRANET_DS#">
			SELECT bbox.*,lay.*
			FROM AvnBoundingBox bbox
			LEFT JOIN AvnUserLayerString AS lay ON bbox.id = lay.AvnBoundingBoxID
			WHERE bbox.id = #getIDFromBboxTable.id#
		</cfquery>

		<cfscript>
			 
			   stArgs.functionName = "setMapState";
			   stArgs.bBox = mapLayers.bBox;
			   stArgs.flashID= mapLayers.flashID;
			   stArgs.mapLayers = mapLayers.layerString;
			   stArgs.stageH = mapLayers.stageH;
			   stArgs.stageW = mapLayers.stageW;
		</cfscript>
		
		<cfsavecontent variable="component_output" >
			<cfloop index="this_key" list="#structKeyList(stArgs)#">
				<cfoutput>#this_key#=#evaluate("stArgs." & this_key)#, </cfoutput>			
			</cfloop>
		</cfsavecontent>
		
		<cfif variables.set_debug EQ 1>
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="leaving component ::#component_output#">
		</cfif>
				
		<cfcatch>
				
			<cfsavecontent variable="debuginfo">
			<cfoutput>
			<div align="left">
			<table border="0" cellspacing="1" cellpadding="2" bgcolor="##999999" width="600" style="text-align:left; vertical-align:top; " border="1">
			<tr>
				<td ><strong>type</strong></td>
				<td bgcolor="##CCCCCC">Caught an exception, type = #CFCATCH.TYPE# </td>
			</tr>
			<tr>
				<td><strong>message</strong></td>
				<td bgcolor="##CCCCCC">#cfcatch.message#</td>
			</tr>
			<tr>
				<td><strong>detail</strong></td>
				<td bgcolor="##CCCCCC"> #cfcatch.detail#</td>
			</tr>
			<tr>
				<td><strong>tag stack</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.tagcontext#"></td>
			</tr>
			
			</table>
			</div> 
			</cfoutput>
			</cfsavecontent>	
				
			
			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#debuginfo.html" output="#debuginfo#">
			</cfif>
		</cfcatch>
		
		</cftry>

		<cfreturn stArgs />
	</cffunction>

</cfcomponent>
