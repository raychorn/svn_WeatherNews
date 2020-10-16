<cffile action="read" file="#ExpandPath('flash\xml\layers.xml')#" variable="XMLFileText">
<cfset myXMLDocument=XmlParse(XMLFileText)>
 
<cffile action="read" file="#ExpandPath('flash\xml\layer_groups.xml')#" variable="XMLFileText2">
<cfset myGroupXMLDocument=XmlParse(XMLFileText2)>

<cfset WNILinksList = "">

<!--- <cfset WNILinksList = WNILinksList & "Tropical Weather;TropList;0;0;2" & "|"> <!--- Image no 3rd Menu with logic ---> --->
<cfset WNILinksList = WNILinksList & "Driftdown Icing Potential;undefined;655;600;1;6" & "|">
<!--- <cfset WNILinksList = WNILinksList & "Flt. Planning Guidance Maps;undefined;800;750;1;9" & "|"> --->
<cfset WNILinksList = WNILinksList & "Flt. Planning Guide Maps;FPGList;0;0;2" & "|">
<cfset WNILinksList = WNILinksList & "Freezing Level;undefined;655;600;1;7" & "|">
<cfset WNILinksList = WNILinksList & "Surface Analysis & Fcst;MSLPList;0;0;2" & "|">
<cfset WNILinksList = WNILinksList & "Fuel Freeze;undefined;655;600;1;5" & "|">
<cfset WNILinksList = WNILinksList & "Tropical Weather;TropList;800;500;1;4" & "|"> <!--- Image no 3rd Menu with logic --->
<cfset WNILinksList = WNILinksList & "Tropopause;undefined;655;600;1;8" & "|">
<cfset WNILinksList = WNILinksList & "Winds aloft w/ isotachs;list_winds_aloft_isotachs;0;0;2" & "|"> <!--- Image no 3rd Menu with logic --->
<cfset WNILinksList = WNILinksList & "Winds aloft w/ temp;list_winds_temp;0;0;2" & "|">
<cfset WNILinksList = WNILinksList & "Wx Watches/Warnings (US);/MCIDAS/charts/WATCH_WARN_NA.GIF;950;650;1;1" & "|"> <!--- Image no 3rd Menu --->

<!--- 
<cfset ExternalLinksList = "Name;URL/List;Width;Height;MapType;MapType2" & "|"> 
	MapType: 
			1 -- Live Link to external window
			2 -- 3rd menu Links to List
	MapType2: 
			1 -- Embedded image of URL
			2 -- cflocation to URL
			3 -- Embedded multiple image with navigation
--->
<cfset GovtLinksList = "">	
<!--- <cfset GovtLinksList = "Everything(test);http://www.google.com;800;600;1;2" & "|"> --->
<!--- <cfset GovtLinksList = GovtLinksList & "US AIRMETs/SIGMETs;http://adds.aviationweather.gov/data/airmets/airmets_ALL.gif;680;680;1;1" & "|"> <!--- Image no 3rd Menu ---> --->
<cfset GovtLinksList = GovtLinksList & "AIRMETs/SIGMETs;SigmentList;0;0;2" & "|"> <!--- 3rd menu images --->
<cfset GovtLinksList = GovtLinksList & "Freezing Level;FreezingList;0;0;2" & "|">
<cfset GovtLinksList = GovtLinksList & "SIGWX High Level;SigwxList;0;0;2" & "|"> <!--- 3rd menu images --->
<cfset GovtLinksList = GovtLinksList & "SIGWX Med Level;SigwxList2;0;0;2" & "|">
<cfset GovtLinksList = GovtLinksList & "SIGWX Low Level (US);SigwxList3;0;0;2" & "|">
<cfset GovtLinksList = GovtLinksList & "Stability Indices (US);/EXTERNAL/stability.png;1024;768;1;1" & "|"> <!--- Image no 3rd Menu --->
<cfset GovtLinksList = GovtLinksList & "Wx Depiction (US);/EXTERNAL/depiction.png;1024;768;1;1" & "|"> <!--- PDF --->

<cfset SigmentList = "">
<cfset SigmentList = SigmentList & "US<br>;http://adds.aviationweather.gov/data/airmets/airmets_ALL.gif;680;680;1" & "|">
<cfset SigmentList = SigmentList & "Pacific<br>;http://aviationweather.gov/data/products/sigmets/intl/pac_intl_sigmet.gif;550;409;1" & "|">
<cfset SigmentList = SigmentList & "Alaska<br>;http://aviationweather.gov/data/products/sigmets/intl/ak_intl_sigmet.gif;550;409;1" & "|">
<cfset SigmentList = SigmentList & "Western Atlantic;http://aviationweather.gov/data/products/sigmets/intl/atl_intl_sigmet.gif;550;409;1" & "|">
	

<cfset SigwxList = "">
<cfset SigwxList = SigwxList & "00Z;http://aviationweather.gov/data/products/swh/PGIE07_00_CL_new.gif;1078;864;1" & "|">
<cfset SigwxList = SigwxList & "06Z;http://aviationweather.gov/data/products/swh/PGIE07_06_CL_new.gif;1078;864;1" & "|">
<cfset SigwxList = SigwxList & "12Z;http://aviationweather.gov/data/products/swh/PGIE07_12_CL_new.gif;1078;864;1" & "|">
<cfset SigwxList = SigwxList & "18Z;http://aviationweather.gov/data/products/swh/PGIE07_18_CL_new.gif;1078;864;1" & "|">

<cfset SigwxList2 = "">
<cfset SigwxList2 = SigwxList2 & "00Z;http://aviationweather.gov/data/products/swm/PGNE15_00_CL.gif;1078;778;1" & "|">
<cfset SigwxList2 = SigwxList2 & "06Z;http://aviationweather.gov/data/products/swm/PGNE15_06_CL.gif;1078;778;1" & "|">
<cfset SigwxList2 = SigwxList2 & "12Z;http://aviationweather.gov/data/products/swm/PGNE15_12_CL.gif;1078;778;1" & "|">
<cfset SigwxList2 = SigwxList2 & "18Z;http://aviationweather.gov/data/products/swm/PGNE15_18_CL.gif;1078;778;1" & "|">

<cfset SigwxList3 = "">
<cfset SigwxList3 = SigwxList3 & "00Z;http://aviationweather.gov/data/products/swl/ll_12_4_cl_new.gif;1024;625;1" & "|">
<cfset SigwxList3 = SigwxList3 & "06Z;http://aviationweather.gov/data/products/swl/ll_18_4_cl_new.gif;1024;625;1" & "|">
<cfset SigwxList3 = SigwxList3 & "12Z;http://aviationweather.gov/data/products/swl/ll_00_4_cl_new.gif;1024;625;1" & "|">
<cfset SigwxList3 = SigwxList3 & "18Z;http://aviationweather.gov/data/products/swl/ll_06_4_cl_new.gif;1024;625;1" & "|">


<cfset FreezingList = "">
<cfset FreezingList = FreezingList & "0-hr;http://adds.aviationweather.gov/data/icing/ruc00hr_lvl_frzg.gif;680;680;1"& "|">
<cfset FreezingList = FreezingList & "3-hr;http://adds.aviationweather.gov/data/icing/ruc03hr_lvl_frzg.gif;680;680;1"& "|">
<cfset FreezingList = FreezingList & "6-hr;http://adds.aviationweather.gov/data/icing/ruc06hr_lvl_frzg.gif;680;680;1"& "|">
<cfset FreezingList = FreezingList & "9-hr;http://adds.aviationweather.gov/data/icing/ruc09hr_lvl_frzg.gif;680;680;1"& "|">
<cfset FreezingList = FreezingList & "12-hr;http://adds.aviationweather.gov/data/icing/ruc12hr_lvl_frzg.gif;680;680;1"& "|">

<cfset list_winds_aloft_isotachs = "">
<cfset list_winds_aloft_isotachs = list_winds_aloft_isotachs & "US<br>;NA;950;650;3"& "|">
<cfset list_winds_aloft_isotachs = list_winds_aloft_isotachs & "Atlantic<br>;ATL;950;650;3"& "|">
<cfset list_winds_aloft_isotachs = list_winds_aloft_isotachs & "Europe<br>;EURO;950;650;3"& "|">

<cfset list_winds_temp = "">
<cfset list_winds_temp = list_winds_temp & "US<br>;NA;950;650;10"& "|">
<cfset list_winds_temp = list_winds_temp & "Atlantic<br>;ATL;950;650;10"& "|">
<cfset list_winds_temp = list_winds_temp & "Europe<br>;EURO;950;650;10"& "|">

<cfset FPGList = "">
<cfset FPGList = FPGList & "US<br>;FPG_US;800;750;9"& "|">
<cfset FPGList = FPGList & "North Atlantic<br>;FPG_NATL;800;750;9"& "|">
<cfset FPGList = FPGList & "Caribbean<br>;FPG_CARIB;800;750;9"& "|">
<cfset FPGList = FPGList & "Europe<br>;FPG_EURO;800;750;9"& "|">
<cfset FPGList = FPGList & "Asia<br>;FPG_ASIA;800;750;9"& "|">
<cfset FPGList = FPGList & "Korea<br>;FPG_KOREA;800;750;9"& "|">
<cfset FPGList = FPGList & "North Pacific<br>;FPG_NPAC;800;750;9"& "|">
<cfset FPGList = FPGList & "South America<br>;FPG_SAMER;650;800;9"& "|">

<cfset MSLPList = "">
<cfset MSLPList = MSLPList & "US<br>;MSLP_NAMER;800;550;11"& "|">
<cfset MSLPList = MSLPList & "North Atlantic<br>;MSLP_TATL;800;550;11"& "|">
<cfset MSLPList = MSLPList & "Europe<br>;MSLP_EURO;800;550;11"& "|">

<!--- <cfset TropList = "">
<cfset TropList = TropList & "US;NA;750;500;4"& "|"> --->



<form action="#" method="post">

<DIV class=menuWrap style="height:300px;">

<!---
	<DIV class=sideMenuBG onClick="expandcontent(this, 'C_sc1')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>Weathernews Charts (dynamic)</SPAN></DIV>
	<div id="C_sc1" class="switchcontent" style="display:block">
	
<cfoutput>
	<cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
	<cfset RemoveCmd = "removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',102);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',103);removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',111)">
 	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="ChartType" type="radio" value="None" onClick="#RemoveCmd#;refreshMovie('MapSymbols#mID#',3);" checked>None
	</SPAN></DIV>
 	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="ChartType" type="radio" value="METARs" onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',102);" <cfif ListFind(CookieList,102)>checked</cfif>>METARs	
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="ChartType" type="radio" value="PIREPs" onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',103);" <cfif ListFind(CookieList,103)>checked</cfif>>PIREPs	
	</SPAN></DIV>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		<input name="ChartType" type="radio" value="TropoPause" onClick="#RemoveCmd#;newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',111);" <cfif ListFind(CookieList,111)>checked</cfif>>Tropopause Height	
	</SPAN></DIV>
</cfoutput>	
 	</div>

--->
	<DIV class=sideMenuBG onClick="expandcontent(this, 'C_sc2')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>Weathernews Charts</SPAN></DIV>
	<div id="C_sc2" class="switchcontent">
  		<cfloop index="LoopIndex" list="#WNILinksList#" delimiters="|">
			<cfset currName = ListGetAt(LoopIndex,1,";")>
			<cfset currLoc = ListGetAt(LoopIndex,2,";")>
			<cfset currMapType =  ListGetAt(LoopIndex,5,";")>

			<cfif currMapType EQ 2>
			<cfoutput>
				<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>#currName#</SPAN></DIV>
				<DIV class=sideMenuBG3><SPAN class=sideMenuFontLev3>
				<cfloop index="LoopIndex2" list="#Evaluate(currLoc)#" delimiters="|">
					<cfset currName = ListGetAt(LoopIndex2,1,";")>
					<cfset currLoc = ListGetAt(LoopIndex2,2,";")>
					<cfset currWidth =  ListGetAt(LoopIndex2,3,";")>
					<cfset currHeight =  ListGetAt(LoopIndex2,4,";")>
					<cfset currMap =  ListGetAt(LoopIndex2,5,";")>
					<cfset uTitle = currName>
					<cfset wAdj = currWidth + 60>
					<cfset hAdj = currHeight + 100>
					<a href="javascript:void(0);" onclick="newWin=openWin('http://#CGI.SERVER_NAME#:83/include/imgNav2.cfm?uLoc=#URLEncodedFormat(currLoc)#&uW=#currWidth#&uH=#currHeight#&uTitle=#URlEncodedFormat(uTitle)#&uMap=#currMap#','WeathernewsBEACON','resizable=yes,status=no,scrollbars=yes,menubar=no,marginwidth=0,marginheight=0,width=#wAdj#,height=#hAdj#'); newWin.focus();">#currName#</a>
				</cfloop>
				</SPAN></DIV>
			</cfoutput>				
			<cfelse>
			<cfoutput>
				<cfset currWidth =  ListGetAt(LoopIndex,3,";")>
				<cfset currHeight =  ListGetAt(LoopIndex,4,";")>
				<cfset currMap =  ListGetAt(LoopIndex,6,";")>
				<cfset uTitle = #currName#>
				<cfset wAdj = #currWidth# + 60>
				<cfset hAdj = #currHeight# + 100>
				<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
					<a href="javascript:void(0);" onclick="newWin=openWin('http://#CGI.SERVER_NAME#:83/include/imgNav2.cfm?uLoc=#URLEncodedFormat(currLoc)#&uW=#currWidth#&uH=#currHeight#&uTitle=#URlEncodedFormat(uTitle)#&uMap=#currMap#','WeathernewsBEACON','resizable=yes,status=no,scrollbars=yes,menubar=no,marginwidth=0,marginheight=0,width=#wAdj#,height=#hAdj#'); newWin.focus();">#currName#</a>
				</SPAN></DIV>
			</cfoutput>				
			
			</cfif>

		</cfloop>	
 
	</div>


	<DIV class=sideMenuBG onClick="expandcontent(this, 'C_sc3')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>Government Charts</SPAN></DIV>
		<div id="C_sc3" class="switchcontent">

		<cfloop index="LoopIndex" list="#GovtLinksList#" delimiters="|">
			<cfset currName = ListGetAt(LoopIndex,1,";")>
			<cfset currLoc = ListGetAt(LoopIndex,2,";")>
			<cfset currMapType =  ListGetAt(LoopIndex,5,";")>

			<cfif currMapType EQ 2>
			<cfoutput>
				<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>#currName#</SPAN></DIV>
				<DIV class=sideMenuBG3><SPAN class=sideMenuFontLev3>
				<cfloop index="LoopIndex2" list="#Evaluate(currLoc)#" delimiters="|">
					<cfset currName = ListGetAt(LoopIndex2,1,";")>
					<cfset currLoc = ListGetAt(LoopIndex2,2,";")>
					<cfset currWidth =  ListGetAt(LoopIndex2,3,";")>
					<cfset currHeight =  ListGetAt(LoopIndex2,4,";")>
					<cfset currMap =  ListGetAt(LoopIndex2,5,";")>
					<cfset uTitle = #currName#>
					<cfset wAdj = #currWidth# + 60>
					<cfset hAdj = #currHeight# + 100>
					<a href="javascript:void(0);" onclick="newWin=openWin('http://#CGI.SERVER_NAME#:83/include/imgNav2.cfm?uLoc=#URLEncodedFormat(currLoc)#&uW=#currWidth#&uH=#currHeight#&uTitle=#URlEncodedFormat(uTitle)#&uMap=#currMap#','WeathernewsBEACON','resizable=yes,status=no,scrollbars=yes,menubar=no,marginwidth=0,marginheight=0,width=#wAdj#,height=#hAdj#'); newWin.focus();">#currName#</a>
				</cfloop>
				</SPAN></DIV>
			</cfoutput>				
			<cfelse>
			<cfoutput>
				<cfset currWidth =  ListGetAt(LoopIndex,3,";")>
				<cfset currHeight =  ListGetAt(LoopIndex,4,";")>
				<cfset currMap =  ListGetAt(LoopIndex,6,";")>
				<cfset uTitle = #currName#>
				<cfset wAdj = #currWidth# + 60>
				<cfset hAdj = #currHeight# + 100>
				<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
					<a href="javascript:void(0);" onclick="newWin=openWin('http://#CGI.SERVER_NAME#:83/include/imgNav2.cfm?uLoc=#URLEncodedFormat(currLoc)#&uW=#currWidth#&uH=#currHeight#&uTitle=#URlEncodedFormat(uTitle)#&uMap=#currMap#','WeathernewsBEACON','resizable=yes,status=no,scrollbars=yes,menubar=no,marginwidth=0,marginheight=0,width=#wAdj#,height=#hAdj#'); newWin.focus();">#currName#</a>
				</SPAN></DIV>
			</cfoutput>				
			
			</cfif>

		</cfloop>	
		</div>


<!--- 
 
<cfset scID = 2>

	<cfloop index="LoopIndex" from="1" to="#ArrayLen(myGroupXMLDocument.groups.group)#" step="1">
		<cfoutput>
			<cfset currMainGroup = #myGroupXMLDocument.groups.group[LoopIndex].displayname.XmlText#>
			<cfif NOT CompareNoCase(currMainGroup,"Physical Features")>
			<DIV class=sideMenuBG onClick="expandcontent(this, 'C_sc#scID#')" style="cursor:hand; cursor:pointer"><span class="showstate"></span><SPAN class=sideMenuFontLev1>#currMainGroup#</SPAN></DIV>
				<div id="C_sc#scID#" class="switchcontent">
	
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

 --->	

	
</DIV>

</form>


