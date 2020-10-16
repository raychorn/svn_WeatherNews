<!---
A collection of components to be using primary by the Mapworld Flash Application
--->

<cfcomponent>
<cfset variables.debug_file_path = "d:\Data\console\include\debug\">
<cfset variables.set_debug = '0'>
	
<!--- 	<cffunction access="remote" name="sayHello">
		<cfset TmpDate = DateAdd("h",Arguments.DaysIn,NOW())>
		<cfset tmp1 = Arguments.Greeting & "<BR>" & Arguments.DaysIn & " hours from now will be ">
		<cfset tmp1 = tmp1 & DateFormat(TmpDate, "dd mmm, yyyy") & " " & TimeFormat(TmpDate, "HH:MM")>
		<cfreturn tmp1>
	</cffunction>
 --->	

<!--- 
	<cffunction access="remote" name="sayBye">
		<cfset tmp2 = "Good Bye " & Arguments[1] & "!">
		<cfreturn tmp2>
	</cffunction>
 --->	
	

<!--- 	<cffunction access="remote" name="getLayers">
		<cfset TmpArray = ArraySort(Arguments.ArrayIn, "textnocase", "desc")>
		<cfset TmpArray = ArraytoList(Arguments.ArrayIn, ",")>
<!---  		<cfset TmpArray = ListDeleteAt(TmpArray,2)>
 --->		
		<cfreturn TmpArray>
	</cffunction>
 --->
 
 <!--- 	
	<cffunction access="remote" name="getCookie">
		<cfset flashID = Arguments.flashID> 
		<cfset cookieMapLayersName = "MAPLAYERS_" & flashID>
		
		<cfif isDefined("cookie." & cookieMapLayersName)>
			<cfset TmpCookieVal = Evaluate("cookie." & cookieMapLayersName)>
		<cfelse>
			<cfset TmpCookieVal = "18,16,11">
		</cfif>

		<cfreturn TmpCookieVal>
 	</cffunction>
	 --->
	 
	 
<!--- 	
	<cffunction access="remote" name="getBBox">
		<cfset BBox = #Arguments[1]#>
		<cfcookie name="BBox" value="#BBox#">
		<cfreturn BBox>
	</cffunction>
 --->
 
	<cffunction access="remote" name="setMapState">
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

		<!--- set the BBox cookie here --->		
		<cfif (flashID EQ 2) OR (flashID EQ 3) OR (flashID EQ 4) OR (flashID EQ 5)>
			<cfcookie name="#cookieBBoxName#" value="#bBox#">
			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="setting cookie cookieBBoxName=#cookieBBoxName#::value=#bBox#" />
			</cfif>			
			<cfif (flashID EQ 3) OR (flashID EQ 4)>
				<cfcookie name="#cookieStageHName#" value="#stageH#">
				<cfcookie name="#cookieStageWName#" value="#stageW#">
				<cfif variables.set_debug EQ 1>
					<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="setting cookie cookieStageHName=#cookieStageHName#::value=#stageH#">
					<cffile action="append" addnewline="yes" file="#variables.debug_file_path#setMapState.txt" output="setting cookie cookieStageWName=#cookieStageWName#::value=#stageW#">
				</cfif>			
			</cfif>
		
		</cfif>
		<!--- MapLayer cookie should have been set through the sidemenu --->		
		<cfif isDefined("cookie." & cookieMapLayersName)>
			<cfset mapLayers = Evaluate("cookie." & cookieMapLayersName)>
		<cfelse>
			<cfset mapLayers = "18,16,11">
		</cfif>

		<cfscript>
			   stArgs = structNew();
			   stArgs.bBox = bBox;
			   stArgs.flashID= flashID;
			   stArgs.mapLayers = mapLayers;
			   stArgs.stageH = stageH;
			   stArgs.stageW = stageW;
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
				
			
				
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#debuginfo.html" output="#debuginfo#">
		</cfcatch>
		
		</cftry>

		<cfreturn stArgs />
	</cffunction>

</cfcomponent>
