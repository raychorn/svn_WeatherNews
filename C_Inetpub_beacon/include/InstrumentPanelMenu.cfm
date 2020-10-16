<cffile action="read" file="#ExpandPath('flash\xml\layers.xml')#" variable="XMLFileText">
<cfset myXMLDocument=XmlParse(XMLFileText)>

<cffile action="read" file="#ExpandPath('flash\xml\layer_groups.xml')#" variable="XMLFileText2">
<cfset myGroupXMLDocument=XmlParse(XMLFileText2)>

<form action="#" method="post">
<DIV class=menuWrap  style="height:350px;">

<cfset scID = 1>
<cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>

	<cfloop index="LoopIndex" from="1" to="#ArrayLen(myGroupXMLDocument.groups.group)#" step="1">
		<cfoutput>
<!--- 			#myGroupXMLDocument.groups.group[LoopIndex].displayname.XmlText#, #ArrayLen(myGroupXMLDocument.groups.group[LoopIndex].subgroup)# --->
			<cfset currMainGroup = #myGroupXMLDocument.groups.group[LoopIndex].displayname.XmlText#>
			<cfif (CompareNoCase(currMainGroup,"NOSHOW") NEQ 0) OR (CompareNoCase(CGI.SERVER_NAME,"beacon-dev.wni.com") EQ 0) ><!--- Display NO SHOW only on DEV --->

				<DIV class=sideMenuBG onClick="expandcontent(this, 'IP_sc#scID#')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>#currMainGroup#</SPAN></DIV>
					<div id="IP_sc#scID#" class="switchcontent">
		
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
											<img src="/images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#);">
									  <cfelse>
											<img src="/images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#);">
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
												<img src="/images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#);">
										  <cfelse>
												<img src="/images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#);">
										  </cfif>
										<cfif LEN(#currDisplayName#) GT 2>#currDisplayName#<cfelse>#currName#</cfif></SPAN></DIV>
								</cfif>
							</cfloop>
						</cfloop>
					</cfif>
				</cfloop>
					</div>
					<cfset scID = scID + 1>
			</cfif>		
		</cfoutput>
	
	</cfloop>	

<!---
<DIV class=sideMenuBG onClick="expandcontent(this, 'sc100')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>Observations 2</SPAN></DIV>

	<div id="sc100" class="switchcontent">
	
	
	<cfloop index="LoopIndex" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#" step="1">
	<cfoutput>
	<cfset currID = myXMLDocument.layers.layer[LoopIndex].ID.XmlText>
	<cfset currName = myXMLDocument.layers.layer[LoopIndex].Name.XmlText>
	<cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		  <cfif ListFind(CookieList,currID)>
				<img src="/images/sidemenu_images/checkBox_on.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
		  <cfelse>
				<img src="/images/sidemenu_images/checkBox_off.gif" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
		  </cfif>
		#currName#</SPAN></DIV>
	</cfoutput>
	</cfloop>
 	</div>
---->

</DIV>


</form>


