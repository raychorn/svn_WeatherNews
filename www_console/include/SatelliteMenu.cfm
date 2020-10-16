<cffile action="read" file="#Request.webRoot#flash\xml\layers.xml" variable="XMLFileText">
<cfset myXMLDocument=XmlParse(XMLFileText)>

<cffile action="read" file="#Request.webRoot#flash\xml\layer_groups.xml" variable="XMLFileText2">
<cfset myGroupXMLDocument=XmlParse(XMLFileText2)>


<form action="#" method="post">
<DIV class=menuWrap style="height:400px;">
	<DIV class=sideMenuBG onClick="expandcontent(this, 'S_sc1')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>Satellite</SPAN></DIV>

	<div id="S_sc1" class="switchcontent" style="display:block">
<cfoutput>
	<cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
	<cfset RemoveCmd = "removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',1);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',22);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',25);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',26);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',27);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',30);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',31);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',32);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',35);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',37)">
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="USIR" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',25);SatCurrTime('#TRIM(SatTimesArray[1])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,25)>checked</cfif>>US Infrared	
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="USVS" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',26);SatCurrTime('#TRIM(SatTimesArray[1])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,26)>checked</cfif>>US Visible
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="USWV" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',27);SatCurrTime('#TRIM(SatTimesArray[1])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,27)>checked</cfif>>US Water Vapor
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="EuropeIR" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',30);SatCurrTime('#TRIM(SatTimesArray[2])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,30)>checked</cfif>>Europe Infrared
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="EuropeVS" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',31);SatCurrTime('#TRIM(SatTimesArray[2])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,31)>checked</cfif>>Europe Visible
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="EuropeWV" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',32);SatCurrTime('#TRIM(SatTimesArray[2])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,32)>checked</cfif>>Europe Water Vapor
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="AsiaIR" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',35);SatCurrTime('#TRIM(SatTimesArray[3])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,35)>checked</cfif>>Asia Infrared
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="AsiaWV" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',37);SatCurrTime('#TRIM(SatTimesArray[3])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,37)>checked</cfif>>Asia Water Vapor
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="IR" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',1);SatCurrTime('#TRIM(SatTimesArray[4])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,1)>checked</cfif>>Infrared (IR)	
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="SatelliteType" type="radio" value="WV" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',22);SatCurrTime('#TRIM(SatTimesArray[4])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,22)>checked</cfif>>Water Vapor
	</SPAN></DIV>
	<!--- Set the time to the selected Radio Button --->
	<cfif Animate EQ 0>
		<cfif ListFind(CookieList,25) OR ListFind(CookieList,26) OR ListFind(CookieList,27) >
			<script language="JavaScript1.2">SatCurrTime('#TRIM(SatTimesArray[1])#');</script>
		<cfelseif ListFind(CookieList,30) OR ListFind(CookieList,31) OR ListFind(CookieList,32) >
			<script language="JavaScript1.2">SatCurrTime('#TRIM(SatTimesArray[2])#');</script>
		<cfelseif ListFind(CookieList,35) OR ListFind(CookieList,37)>
			<script language="JavaScript1.2">SatCurrTime('#TRIM(SatTimesArray[3])#');</script>
		<cfelseif ListFind(CookieList,1) OR ListFind(CookieList,22)>
			<script language="JavaScript1.2">SatCurrTime('#TRIM(SatTimesArray[4])#');</script>
		</cfif>
	</cfif>
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
										<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
								  <cfelse>
										<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
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
											<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
									  <cfelse>
											<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
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


