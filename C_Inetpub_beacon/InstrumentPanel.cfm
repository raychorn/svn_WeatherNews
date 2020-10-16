<cfset flashID = 2> 
<cfset cookieBBoxName = "BBOX_" & flashID>
<cfset cookieMapLayersName = "MAPLAYERS_" & flashID>

<cfif isDefined("cookie." & cookieBBoxName)>
	<cfset BBox = #Evaluate("cookie." & cookieBBoxName)#>
</cfif>

<cfif isDefined("cookie." & cookieMapLayersName)>
	<cf_Layers2Text LayersIN=#Evaluate("cookie." & cookieMapLayersName)# Display=0>
	<cfset mapLayers = LayersOut>
<cfelse>
	<cfcookie name="#cookieMapLayersName#" value="#mapLayers#">
	<cf_Layers2Text LayersIN=#mapLayers# Display=0>
	<cfset mapLayers = LayersOut>
</cfif>

<cfinclude template="include/MyFlightsProc.cfm">

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
          <td width="100%"><!--- Left Main Window --->
		  
            <table width="100%" border="0" cellpadding="0" cellspacing="0"> 
              <tr>
                <td><img src="/images/content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
                <td width="100%" background="/images/content_frame_images/content_frame_top.gif"><img src="/images/spacer.gif" width="1" height="8" alt=""></td>
                <td><img src="/images/content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
              </tr>
              <tr>
                <td rowspan="2" background="/images/content_frame_images/content_frame_left.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
                <td width="100%" align="center" bgcolor="#FFFFFF">

				   <!--- Navigation Map --->
                  <table id="mainIPMovie" width="95%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td>
					  <cfoutput>
					  	<iframe name="mapCall"
								frameborder="0" 
								align="top"
								src="/mapCall.cfm?mID=#mID#&flashid=#flashid#&cookieBboxName=#cookieBboxName#&cookieMapLayersName=#cookieMapLayersName#" 
								id="mapCall" 
								width="100%" 
								height="400" 
								scrolling="no"
								marginheight="0">
							You must have a browser that supports frames
						</iframe>
						</cfoutput>
      					<!--- <cfoutput> 		
						<cfinclude template="include/js_dosfcommand.cfm">				
						<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
						 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0">
						 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
						 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
						 <PARAM NAME=quality VALUE="high">
						 <PARAM NAME=scale VALUE="noscale">
						 <PARAM NAME=salign VALUE="LT">
						 <PARAM NAME=devicefont VALUE="true">
						 <PARAM NAME=swLiveConnect VALUE="true">
					 
						 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0" menu=false quality=autohigh scale=noscale salign=LT devicefont=true bgcolor=#mapBgColor# swLiveConnect=true NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
						 </OBJECT>
						 </cfoutput> --->
						 <!--- For when you need to add timestamps
						 <cfset UpdateTimesOnly = "Satellite">
						 <cfinclude template="include/UpdateTimes.cfm">
						 <cfset UpdateTimesOnly = "Radar">
						 <cfinclude template="include/UpdateTimes.cfm"> --->
						 
 						 <cfinclude template="include/Legends.cfm">
                      </td>
                    </tr>
                    <tr>
                      <td align="right">&nbsp;</td>
                    </tr>
                  </table><!--- End of Navigation Map --->

                </td>
                <td rowspan="2" background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
              </tr>
              <tr>
                <td width="100%" align="center" bgcolor="#FFFFFF">

                  <table width="95%" border="0" cellpadding="0" cellspacing="0">
                    <tr style="padding: 2px 6px 3px 6px; border-left: #72828B 1px solid; border-bottom: #72828B 1px solid; margin-bottom: 6px">
                      <td><cfinclude template="include/MyFlightsMenu.cfm"></td>
                    </tr>
                    <tr>
                      <td align="right">&nbsp;</td>
                    </tr>
                  </table>
				</td>
              </tr>
              <tr>
                <td><img src="/images/content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
                <td width="100%" background="/images/content_frame_images/content_frame_bottom.gif"><img src="/images/spacer.gif" width="1" height="7" alt=""></td>
                <td><img src="/images/content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
              </tr>
            </table>
          </td>
          <td width="180">  <!--- Right Side Window --->
			<!--- IP Menu --->
            <table width="156" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/sidemenu_images/sidemenu_left_shadow1.gif" width="6" height="15" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_upper_lt_corner.gif" width="6" height="15" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_toptab.gif" width="138" height="15" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_upper_rt_corner.gif" width="6" height="15" alt=""></td>
              </tr>
              <tr>
                <td><img src="/images/sidemenu_images/sidemenu_left_shadow2.gif" width="6" height="35" alt=""></td>
                <td bgcolor="#FFFFFF"> <img src="/images/spacer.gif" width="6" height="35" alt=""></td>
                <td bgcolor="#FFFFFF" align="center"> <a href="http://weathernews.com/us/c"><img src="/images/sidemenu_images/wni_logo.gif" alt="Weathernews Logo" width="118" height="35" border="0"></a></td>
                <td bgcolor="#FFFFFF"> <img src="/images/spacer.gif" width="6" height="35" alt=""></td>
              </tr>
              <tr>
                <td background="/images/sidemenu_images/sidemenu_left_shadow2.gif"></td>
                <td bgcolor="#FFFFFF" colspan="3">
	                <!--- observation menu goes here --->
 					<cfinclude template="include/InstrumentPanelMenu.cfm">
					<div id="fpl">
						<!--- Fast page load submit button --->
						<cfoutput>
							<input id="execute" name="submit" value="Submit" type="button" onClick="reloadMap();"/><br /><br />
							<input id="clear" name="clear" value="Clear" type="button" onClick="clearInstrumentPanelMenu('#UCASE(cookieMapLayersName)#');" />
						</cfoutput>
					</div><br />
					<div align="center"><A href="javascript:void(0);" onClick="showHideRegion('legend');"><img src="/images/show-hide-legend.gif" width="84" height="24" border="0" alt="Show/Hide Search Panel"></A><br>&nbsp;</div>
								  
<!--- 					<iframe src="include/observationMenu.cfm?FlashID=#FlashID#&mID=#mID#" name="obsMenu" width="130" height="457" scrolling="auto"></iframe> --->
				</td>
              </tr>
              <tr>
                <td><img src="/images/sidemenu_images/sidemenu_left_shadow4.gif" width="6" height="19" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_lower_left_corner.gif" width="6" height="19" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_bottom_tab.gif" width="138" height="19" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_right_lower_corner.gif" width="6" height="19" alt=""></td>
              </tr>
            </table>
            
	</td><!--- End Right Side Window --->
  </tr>
  </table>