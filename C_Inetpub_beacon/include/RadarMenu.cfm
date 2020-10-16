<cffile action="read" file="#ExpandPath('flash\xml\layers.xml')#" variable="XMLFileText">
<cfset myXMLDocument=XmlParse(XMLFileText)>

<cffile action="read" file="#ExpandPath('flash\xml\layer_groups.xml')#" variable="XMLFileText2">
<cfset myGroupXMLDocument=XmlParse(XMLFileText2)>
<script language="javascript">
	var currentCookieValue = getCookie('MAPLAYERS_4');
	//alert(currentCookieValue.indexOf('38'));
	if (currentCookieValue.indexOf('38') != -1) {
		//document.getElementById('animationControl').style.display = 'none';
		hideAnimationDiv = true;
	}
	function turnOffAnimation() {
		//alert(document.getElementById("RadarType").value);
		var thisCookieVal = getCookie('MAPLAYERS_4');
		if (thisCookieVal.indexOf('38') != -1) {
			document.getElementById('animationControl').style.display = 'none';
		} else {
			document.getElementById('animationControl').style.display = 'block';
		}
	}
		
</script>

<form action="#" method="post">
<DIV class=menuWrap style="height:300px;">
	<DIV class=sideMenuBG onClick="expandcontent(this, 'R_sc1')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>Radar</SPAN></DIV>

	<div id="R_sc1" class="switchcontent" style="display:block">
<cfoutput>
	<cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
	<cfset RemoveCmd = "removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',23);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',28);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',38);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',108);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',39);">
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input id="RadarType" name="RadarType" type="radio" value="US" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',23);RadCurrTime('#TRIM(RadarTimesArray[1])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,23)>checked</cfif>>US Reflectivity	
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input id="RadarType" name="RadarType" type="radio" value="EUROPE" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',28);RadCurrTime('#TRIM(RadarTimesArray[2])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,28)>checked</cfif>>Europe Reflectivity
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input id="RadarType" name="RadarType" type="radio" value="COMPOSITE" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',38);RadCurrTime('#TRIM(RadarTimesArray[3])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,38)>checked</cfif>>US Radar Summary
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input id="RadarType" name="RadarType" type="radio" value="WINTER" <cfif Animate EQ 0>onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',39);RadCurrTime('#TRIM(RadarTimesArray[4])#');"<cfelse>disabled</cfif> <cfif ListFind(CookieList,39)>checked</cfif>>Winter Mosaic
	</SPAN></DIV>
	<!--- Set the time to the selected Radio Button --->
	<cfif Animate EQ 0>
		<cfif ListFind(CookieList,23)>
			<script language="JavaScript1.2">RadCurrTime('#TRIM(RadarTimesArray[1])#');</script>
		<cfelseif ListFind(CookieList,28) >
			<script language="JavaScript1.2">RadCurrTime('#TRIM(RadarTimesArray[2])#');</script>
		<cfelseif ListFind(CookieList,38) >
			<script language="JavaScript1.2">RadCurrTime('#TRIM(RadarTimesArray[3])#');</script>
		<cfelseif ListFind(CookieList,39) >
			<script language="JavaScript1.2">RadCurrTime('#TRIM(RadarTimesArray[4])#');</script>
		</cfif>
	</cfif>
</cfoutput>	

<!--- <cfloop list="7" index="RadarOnly">
	<cfloop index="LoopIndex1" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#" step="1">
	<cfoutput>
		<cfset currID = myXMLDocument.layers.layer[LoopIndex1].ID.XmlText>
		<cfif currID EQ RadarOnly>
			<cfset currName = myXMLDocument.layers.layer[LoopIndex1].Name.XmlText>
			<cfset currDisplayName = myXMLDocument.layers.layer[LoopIndex1].DisplayName.XmlText>
			<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
				  <cfif ListFind(CookieList,currID)>
						<img src="/images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
				  <cfelse>
						<img src="/images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
				  </cfif>
				<cfif LEN(#currDisplayName#) GT 2>#currDisplayName#<cfelse>#currName#</cfif></SPAN></DIV>
		</cfif>
	 </cfoutput>	
	</cfloop>
</cfloop> --->
 	</div>

	<cfset scID = 2>

	<cfloop index="LoopIndex" from="1" to="#ArrayLen(myGroupXMLDocument.groups.group)#" step="1">
		<cfoutput>
			<cfset currMainGroup = #myGroupXMLDocument.groups.group[LoopIndex].displayname.XmlText#>
			<cfif NOT CompareNoCase(currMainGroup,"Background Layers")>
			<DIV class=sideMenuBG onClick="expandcontent(this, 'R_sc#scID#')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>#currMainGroup#</SPAN></DIV>
				<div id="R_sc#scID#" class="switchcontent">
	
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
										<img src="/images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
								  <cfelse>
										<img src="/images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
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
											<img src="/images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
									  <cfelse>
											<img src="/images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
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


