<!--- 	<table width="100%" height="639" align="center"  border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
        <tr>
          <td rowspan="2" valign="top"><img src="images/spacer.gif" width="40" height="20" alt=""></td>
          <td height="20" valign="top"><img src="images/spacer.gif" height="20" alt=""></td>
          <td rowspan="2" valign="top"><img src="images/spacer.gif" width="40" height="20" alt=""></td>
        </tr>
        <tr>
          <td height="20" valign="top" class="r"><cfoutput>#ListGetAt(ListgetAt(MenuList,mID,";"),2,"|")#</cfoutput></td>
        </tr>
	</table> --->
	

	<cfquery NAME="getMyFlightsIP" DATASOURCE="#INTRANET_DS#">
		select TOP 1 F.FlightID, F.FlightName, F.BBox, F.MapLayers, F.StageW, F.StageH
		from AvnUsers U, AvnFlights F
		where U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
				AND U.UserID = F.UserID
				AND F.SectionID = 2
				AND F.SetAsDefault = 1
		and U.Deleted = 0 and F.Deleted = 0
		order by F.FlightName
	</cfquery>


	<cfquery NAME="getMyFlightsSAT" DATASOURCE="#INTRANET_DS#">
		select TOP 1 F.FlightID, F.FlightName, F.BBox, F.MapLayers, F.StageW, F.StageH
		from AvnUsers U, AvnFlights F
		where U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
				AND U.UserID = F.UserID
				AND F.SectionID = 3
				AND F.SetAsDefault = 1
		and U.Deleted = 0 and F.Deleted = 0
		order by F.FlightName
	</cfquery>

	<cfquery NAME="getMyFlightsRADAR" DATASOURCE="#INTRANET_DS#">
		select TOP 1 F.FlightID, F.FlightName, F.BBox, F.MapLayers, F.StageW, F.StageH
		from AvnUsers U, AvnFlights F
		where U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
				AND U.UserID = F.UserID
				AND F.SectionID = 4
				AND F.SetAsDefault = 1
		and U.Deleted = 0 and F.Deleted = 0
		order by F.FlightName
	</cfquery>

	<cfquery NAME="getMyFlightsCHART" DATASOURCE="#INTRANET_DS#">
		select TOP 1 F.FlightID, F.FlightName, F.BBox, F.MapLayers, F.StageW, F.StageH
		from AvnUsers U, AvnFlights F
		where U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
				AND U.UserID = F.UserID
				AND F.SectionID = 5
				AND F.SetAsDefault = 1
		and U.Deleted = 0 and F.Deleted = 0
		order by F.FlightName
	</cfquery>


       					
<!--- 	      				<div style="cursor:hand; cursor:pointer;" onClick="redirect('default.htm?mid=2')">
						
						<p>&nbsp;</p>
      					  <p>&nbsp;</p>
						<cfoutput> 
						<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
						 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1">
						 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
						 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
						 <PARAM NAME=menu VALUE="false">
						 <PARAM NAME=quality VALUE="high">
						 <PARAM NAME=scale VALUE="noscale">
						 <PARAM NAME=salign VALUE="LT">
						 <PARAM NAME=devicefont VALUE="true">
						 <param name=wmode value="opaque">
						 <PARAM NAME=swLiveConnect VALUE="true">
					 
						 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1" menu=false quality=autohigh scale=noscale salign=LT devicefont=true bgcolor=#mapBgColor# swLiveConnect=true NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer" wmode="opaque"></EMBED>
						 </OBJECT>
					    </cfoutput>						 
						
					  		<h2>HELLO</h2>
					     </div>		
						 
						  --->
	  
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="/images/content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="161" background="/images/content_frame_images/content_frame_top.gif"><img src="/images/spacer.gif" width="161" height="8" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
            <td><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td bgcolor="#E3E6E8"><img src="/images/content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="100%" background="/images/content_frame_images/content_frame_top.gif"><img src="/images/spacer.gif" width="1" height="8" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
            <td><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="161" background="/images/content_frame_images/content_frame_top.gif"><img src="/images/spacer.gif" width="161" height="8" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
          </tr>
          <tr>
            <td background="/images/content_frame_images/content_frame_left.gif"><img src="/images/spacer.gif" width="6" height="300" alt=""></td>
            <td valign="top" bgcolor="#FFFFFF">
              <div align="center" style="padding-bottom: 6px"><img src="/images/logo_left.gif" width="120" height="43"></div>
             <!---  <div class="sideMenuBG"><span class="sideMenuFontLev1"><img src="images/MenuArrowOff.gif"><a href="javascript:void(0);" class="underline" onmouseover="this.T_WIDTH=150;this.T_STATIC=true;this.T_OPACITY=95;return escape('Tactical Alerts on actual conditions and forecasts.<br>Coming Early Fall 2005.')">My Alarms</a></span></div>
              <div class="sideMenuBG"><span class="sideMenuFontLev1"><img src="images/MenuArrowOff.gif"><a href="javascript:void(0);" class="underline" onmouseover="this.T_WIDTH=150;this.T_STATIC=true;this.T_OPACITY=95;return escape('Important News you should be aware of.<br>Coming Early Fall 2005.')">Headlines</a></span></div>
<!---               <div class="sideMenuBG"><span class="sideMenuFontLev1"><img src="images/MenuArrowOff.gif"><a href="javascript:void(0);" class="underline" onmouseover="this.T_WIDTH=150;this.T_STATIC=true;this.T_OPACITY=95;return escape('Instant Message a Risk Communicator (RC) on duty.<br>Coming Early Fall 2005.')">RCs on IM</a></span></div> --->
              <div class="sideMenuBG"><span class="sideMenuFontLev1"><img src="images/MenuArrowOff.gif"><a href="javascript:void(0);" class="underline" onmouseover="this.T_WIDTH=150;this.T_STATIC=true;this.T_OPACITY=95;return escape('View live and taped whiteboard briefings.<br>Coming Early Fall 2005.')">Briefings</a></span></div>
<!---               <div class="menuWrap" id="headlinewrap" style="height: 84px; background: #E3E6E8">
                <div class="sideMenuBG2" style="padding: 2 0; font-size: 9px"><a href="#" class="alarm">Turbulence
                    SIGMET for North Central U.S.</a></div>
                <div class="sideMenuBG2" style="padding: 2 0; font-size: 9px"><img src="/images/spacer.gif" height="12"></div>
              </div>
 --->
 --->              <div align="center"><br><br><img src="/images/AVIATIONEMBLEM.jpg" width="161" height="139"> </div>
            </td>
            <td background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td background="/images/content_frame_images/content_frame_left.gif" bgcolor="#E3E6E8"><img src="/images/spacer.gif" width="6" height="6" alt=""></td>
            <td width="100%" align="left" valign="top" bgcolor="#FFFFFF">
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td nowrap style="background-color: #CCE2FF; border-top: 1px solid #72828B; border-left: 1px solid #72828B; padding: 3px 0px 3px 5px"><span class="sideMenuFontLev1">
				  <cfoutput>
				  <cfif getMyFlightsIP.RecordCount EQ 1>
					  <a href="/default.htm?mID=2&fID=#getMyFlightsIP.FlightID#" class="underline">#getMyFlightsIP.FlightName#</a>
				  <cfelse>
					  <a href="/default.htm?mID=2" class="underline">Instrument Panel</a>
				  </cfif>
				  </cfoutput></span></td>
                  <td width="62" align="right" valign="middle" style="background-color: #CCE2FF; border-top: 1px solid #72828B; border-right: 1px solid #B6B8BA; padding: 3px 6px 3px 5px"><a href="/default.htm?mID=20"><img src="/images/preferences_icon.gif" width="9" height="9" border="0" onmouseover="this.T_WIDTH=100;this.T_STATIC=true;this.T_OPACITY=95;return escape('Configure the Instrument Panel')"></a> </td>
                </tr>

	<cfset flashID = 11> 
	<cfinvoke component="com.weathernews.beacon.DAO.getBboxAndLayers" method="init" returnvariable="bboxAndLayers">
		<cfinvokeargument name="flashID" value="#flashID#" />
	</cfinvoke>

<cfif isDefined("bboxAndLayers.layerString")>
	<cfset BBox = bBoxAndLayers.bBox>
	<cfset StageH = bBoxAndLayers.StageH>
	<cfset StageW = bBoxAndLayers.StageW>
<cfelse>
	<cfset BBox = "-130.496455586007,18.598539904507,-59.7473232373829,51.5157846843435">
	<cfset StageH = 400>
	<cfset StageW = 800>
</cfif>

	<cfset mapLayers = "18,16,10,11,12,1">
	<cf_Layers2Text LayersIN="#bboxAndLayers.layerString#" Display="0">
	<cfset mapLayers = LayersOut>

	<cfset BBox = "-89.367077534962,26.384414812451,9.17156168675659,61.3750881774843">

	<cfif getMyFlightsIP.RecordCount EQ 1>
		<cfset BBox = #getMyFlightsIP.BBox#>
		<cfset CreateObject("component","com.weathernews.beacon.DAO.setLayers").init(flashID,getMyFlightsIP.mapLayers) />
		<cfset CreateObject("component","com.weathernews.beacon.DAO.setBbox").init(flashID,getMyFlightsIP.bBox) />
		<cf_Layers2Text LayersIN=#getMyFlightsIP.mapLayers# Display=0>
		<cfset mapLayers = LayersOut>
	</cfif>
				
                <tr>
<!---                   <td valign="top" style="height: 416px; border-left: 1px solid #72828B; border-right: 1px solid #B6B8BA; border-bottom: 3px solid #72828B" colspan="2"> --->
                  <td valign="top" colspan="2">
				  
						<cfoutput> 						
						<cfinclude template="include/js_dosfcommand.cfm">
						<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
						 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&Server=#demisLocation#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1&SLO=1">
						 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
						 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
						 <PARAM NAME=menu VALUE="false">
						 <PARAM NAME=quality VALUE="high">
						 <PARAM NAME=wmode VALUE="opaque">
						 <PARAM NAME=scale VALUE="noscale">
						 <PARAM NAME=salign VALUE="LT">
						 <PARAM NAME=devicefont VALUE="true">
						 <PARAM NAME=swLiveConnect VALUE="true">
					 
						 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&Server=#demisLocation#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1&SLO=1" menu=false quality=autohigh scale=noscale salign=LT devicefont=true bgcolor=#mapBgColor# swLiveConnect=true wmode=opaque NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
						 </OBJECT>
					    </cfoutput>						 
<!---
						
						<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=7,0,19,0"
						 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
						 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1">
						 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
						 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
						 <PARAM NAME=quality VALUE="low">
						 <PARAM NAME=wmode VALUE="opaque">
 						 <PARAM NAME=menu VALUE="false">
						 <PARAM NAME=scale VALUE="noscale">
						 <PARAM NAME=salign VALUE="LT">
						 <PARAM NAME=devicefont VALUE="true">
 						 <PARAM NAME=swLiveConnect VALUE="true"> 
					 
						 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1" bgcolor="#mapBgColor#" quality="low" wmode="opaque" NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer" ></EMBED>


menu=false  scale=noscale salign=LT devicefont=true  swLiveConnect=true						 
						 --->
                  </td>
                </tr>
              </table>
              <table width="100%" cellpadding="0" cellspacing="0" border="0">
              </table>
            </td>
            <td background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td></td>
            <td background="/images/content_frame_images/content_frame_left.gif"><img src="/images/spacer.gif" width="6" height="6" alt=""></td>
            <td valign="top" bgcolor="#FFFFFF">
  				<cfinclude template="include/smallSat.cfm">
				<cfinclude template="include/smallRadar.cfm">
				<cfinclude template="include/smallChart.cfm">
              <p align="center">&nbsp;</p>
            </td>
            <td background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
          </tr>
          <tr>
            <td><img src="/images/content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
            <td background="/images/content_frame_images/content_frame_bottom.gif"><img src="/images/spacer.gif" width="1" height="7" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
            <td><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td bgcolor="#E3E6E8"><img src="/images/content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
            <td width="100%" background="/images/content_frame_images/content_frame_bottom.gif"><img src="/images/spacer.gif" width="1" height="7" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
            <td></td>
            <td><img src="/images/content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
            <td background="/images/content_frame_images/content_frame_bottom.gif"><img src="/images/spacer.gif" width="1" height="7" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
          </tr>
        </table>
						 