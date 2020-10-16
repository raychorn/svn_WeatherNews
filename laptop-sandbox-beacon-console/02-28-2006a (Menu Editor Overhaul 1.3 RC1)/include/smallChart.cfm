	<cfset flashID = 14> 
	<!--- testing ... 7/13/2005 - K. Ensign
	<cf_Layers2Text LayersIN="18,16,10,11,111" Display=0>
	<cfset mapLayers = LayersOut>
	<cfset BBox = "-107.728328663896,37.5551222448394,12.8009263971679,73.3445425396502"> --->

	<cf_Layers2Text LayersIN="18,16,10,11,106" Display=0>
	<cfset mapLayers = LayersOut>
	<cfset BBox = "-87.95,33.73,21.30,58.05">


	<cfif getMyFlightsCHART.RecordCount EQ 1>
		<cfset BBox = #getMyFlightsCHART.BBox#>
		<cf_Layers2Text LayersIN=#getMyFlightsCHART.MapLayers# Display=0>
		<cfset mapLayers = LayersOut>
	</cfif>


                 <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 6px; border: 1px solid #72828B">
                <tr>
                  <td style="background-color: #CCE2FF; text-align: left; padding: 3px 0px 3px 5px"><span class="sideMenuFontLev1">
				  <cfoutput>
				  <cfif getMyFlightsCHART.RecordCount EQ 1>
					  <a href="/default.htm?mID=5&fID=#getMyFlightsCHART.FlightID#" class="underline">#getMyFlightsCHART.FlightName#</a>
				  <cfelse>
					  <a href="/default.htm?mID=5" class="underline">Chart</a>
				  </cfif>
				  </cfoutput></span></td>
				  </td>
<!---                   <td align="right" valign="top" style="background-color: #CCE2FF; text-align: right; padding: 3px 5px 3px 0px"><a href="/default.htm?mID=20"><img src="/images/preferences_icon.gif" width="9" height="9" border="0" onmouseover="this.T_WIDTH=100;this.T_STATIC=true;this.T_OPACITY=95;return escape('Configure Charts')"></a></td> --->
                </tr>
				
                <tr>
                  <td colspan="2">
					<cfoutput>
				 		<cfif getMyFlightsCHART.RecordCount EQ 1>
					  <a href="/default.htm?mID=5&fID=#getMyFlightsCHART.FlightID#" class="underline">
				  <cfelse>
					  <a href="/default.htm?mID=5" style="border-style:none;">
				  </cfif><img src="/MCIDAS/charts/UL_WINDS_FL_340_12Z_ATL_THUMB.jpg"  width="100%" height="113" alt="" style="border-style:none;" id="ul_winds_thumb" /></a>
				  
					</cfoutput>	<!--- 
						K. Ensign - 7/14/2005 
						flash chart is being replaced by static image.
						
						<cfoutput> 
						<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="113" ALIGN="middle">
						 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&Server=#demisLocation#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1&SLO=1">
						 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
						 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
						 <PARAM NAME=quality VALUE="low">
						 <PARAM NAME="wmode" VALUE="opaque">
<!---
 						 <PARAM NAME=menu VALUE="false">
						 <PARAM NAME=scale VALUE="noscale">
						 <PARAM NAME=salign VALUE="LT">
						 <PARAM NAME=devicefont VALUE="true">
menu=false  scale=noscale salign=LT devicefont=true  swLiveConnect=true						 
						 --->
					 
						 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="113" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&Server=#demisLocation#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1&SLO=1" bgcolor="#mapBgColor#" quality="low" wmode="opaque" NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer" scale=noscale salign=LT></EMBED>
						 </OBJECT>
					    </cfoutput>						 ---> 
				  </td>
                </tr>
              </table>
