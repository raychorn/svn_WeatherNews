
<cfif (Request.bool_useNewMenu)>
	<form name="radioForm" action="#" method="post">
	<DIV class=menuWrap style="height:400px;">
	<cfset Request.menuUUID = "1139518732975790">
	<cfinclude template="cfinclude_newBeaconMenu.cfm">
	</DIV>
	</form>
<cfelse>
	<cffile action="read" file="#ExpandPath('../Console/flash/xml/')#layers.xml" variable="XMLFileText">
	<cfset myXMLDocument=XmlParse(XMLFileText)>
	
	<cffile action="read" file="#ExpandPath('../Console/flash/xml/')#layer_groups.xml" variable="XMLFileText2">
	<cfset myGroupXMLDocument=XmlParse(XMLFileText2)>
	
	<form name="radioForm" action="#" method="post">
	<DIV class=menuWrap style="height:400px;">
		<DIV class=sideMenuBG onClick="expandcontent(this, 'S_sc1')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class="sideMenuFontLev1">Satellite</SPAN></DIV>
	
		<div id="S_sc1" class="switchcontent" style="display:block">
	<cfoutput>
		<cfset CookieList = bboxAndLayers.layerString>
		<cfset RemoveCmd = "removeMapLayer('#mID#','1,22,25,26,27,30,31,32,35,37');">
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType1" name="SatelliteType" type="radio" value="USIR" onClick="removeAndAddLayer('#mID#',25,'18,16');" <cfif ListFind(CookieList,25)>checked</cfif>>US Infrared	
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType2" name="SatelliteType" type="radio" value="USVS" onClick="removeAndAddLayer('#mID#',26,'18,16');" <cfif ListFind(CookieList,26)>checked</cfif>>US Visible
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType3" name="SatelliteType" type="radio" value="USWV" onClick="removeAndAddLayer('#mID#',27,'18,16');" <cfif ListFind(CookieList,27)>checked</cfif>>US Water Vapor
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType4" name="SatelliteType" type="radio" value="EuropeIR" onClick="removeAndAddLayer('#mID#',30,'18,16');" <cfif ListFind(CookieList,30)>checked</cfif>>Europe Infrared
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType5" name="SatelliteType" type="radio" value="EuropeVS" onClick="removeAndAddLayer('#mID#',31,'18,16');" <cfif ListFind(CookieList,31)>checked</cfif>>Europe Visible
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType6" name="SatelliteType" type="radio" value="EuropeWV" onClick="removeAndAddLayer('#mID#',32,'18,16');" <cfif ListFind(CookieList,32)>checked</cfif>>Europe Water Vapor
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType7" name="SatelliteType" type="radio" value="AsiaIR" onClick="removeAndAddLayer('#mID#',35,'18,16');" <cfif ListFind(CookieList,35)>checked</cfif>>Asia Infrared
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType8" name="SatelliteType" type="radio" value="AsiaWV" onClick="removeAndAddLayer('#mID#',37,'18,16');" <cfif ListFind(CookieList,37)>checked</cfif>>Asia Water Vapor
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType9" name="SatelliteType" type="radio" value="IR" onClick="removeAndAddLayer('#mID#',1,'18,16');" <cfif ListFind(CookieList,1)>checked</cfif>>Infrared (IR)	
		</SPAN></DIV>
		<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
			<input id="SatelliteType10" name="SatelliteType" type="radio" value="WV" onClick="removeAndAddLayer('#mID#',22,'18,16');" <cfif ListFind(CookieList,22)>checked</cfif>>Water Vapor
		</SPAN></DIV>
		<!--- Set the time to the selected Radio Button --->
		
	</cfoutput>	
	
	 	</div>
		
	<cfset scID = 2>
	
	<cfloop index="LoopIndex" from="1" to="#ArrayLen(myGroupXMLDocument.groups.group)#" step="1">
		<cfoutput>
			<cfset currMainGroup = #myGroupXMLDocument.groups.group[LoopIndex].displayname.XmlText#>
			<cfif NOT CompareNoCase(currMainGroup,"Background Layers")>
			<DIV class=sideMenuBG onClick="expandcontent(this, 'S_sc#scID#')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>#currMainGroup#</SPAN></DIV>
				<div id="S_sc#scID#" class="switchcontent">
	
			<cfloop index="LoopIndex2" from="1" to="#ArrayLen(myGroupXMLDocument.groups.group[LoopIndex].subgroup)#" step="1">
				<cfset currSubGroup = #myGroupXMLDocument.groups.group[LoopIndex].subgroup[LoopIndex2].displayname.XmlText#>
				<cfif #ListLen(myGroupXMLDocument.groups.group[LoopIndex].subgroup[LoopIndex2].layers.XmlText)# EQ 1>
					<cfset currLayerID = #myGroupXMLDocument.groups.group[LoopIndex].subgroup[LoopIndex2].layers.XmlText#>
					<cfloop index="LoopIndex4" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#" step="1">
						<cfset currID = myXMLDocument.layers.layer[LoopIndex4].ID.XmlText>
						<cfif currLayerID EQ currID>
							<cfset currName = myXMLDocument.layers.layer[LoopIndex4].Name.XmlText>
							<cfset currDisplayName = myXMLDocument.layers.layer[LoopIndex4].DisplayName.XmlText>
							<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
								  <cfif ListFind(CookieList,currID)>
										<img src="/images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('#mID#',#currID#)">
								  <cfelse>
										<img src="/images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('#mID#',#currID#)">
								  </cfif>
								<cfif LEN(#currDisplayName#) GT 2>#currDisplayName#<cfelse>#currName#</cfif></SPAN></DIV>
						</cfif>
					</cfloop>
				<cfelse>
					<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>#currSubGroup#</SPAN></DIV>
					<cfloop index="LoopIndex3" from="1" to="#ListLen(myGroupXMLDocument.groups.group[LoopIndex].subgroup[LoopIndex2].layers.XmlText)#" step="1">
						<cfset currLayerID = #ListGetAt(myGroupXMLDocument.groups.group[LoopIndex].subgroup[LoopIndex2].layers.XmlText,LoopIndex3)#>
						<cfloop index="LoopIndex4" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#" step="1">
							<cfset currID = myXMLDocument.layers.layer[LoopIndex4].ID.XmlText>
							<cfif currLayerID EQ currID>
								<cfset currName = myXMLDocument.layers.layer[LoopIndex4].Name.XmlText>
								<cfset currDisplayName = myXMLDocument.layers.layer[LoopIndex4].DisplayName.XmlText>
								<DIV class=sideMenuBG3><SPAN class=sideMenuFontLev2>
									  <cfif ListFind(CookieList,currID)>
											<img src="/images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('#mID#',#currID#)">
									  <cfelse>
											<img src="/images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('#mID#',#currID#)">
									  </cfif>
								<cfif LEN(#currDisplayName#) GT 2>#currDisplayName#<cfelse>#currName#</cfif></SPAN></DIV>
							</cfif>
						</cfloop>
					</cfloop>
				</cfif>
			</cfloop>
	
				</div>
			</cfif>
				<cfset scID = scID + 1>
		</cfoutput>
	
	</cfloop>	
		
	</DIV>
	
	</form>
</cfif>

