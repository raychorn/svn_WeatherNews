	<cfset flashID = 12> 
	<cfset mapLayers = "18,16,10,25,1">
	<!---<cf_Layers2Text LayersIN="23,18,16,10,11" Display=0>  radar --->
	<cf_Layers2Text LayersIN=#mapLayers# Display=0>
	<cfset mapLayers = LayersOut>

	<cfset BBox = "-130.496455586007,18.5535464703456,-59.7473232373829,51.5607781185049">


	<cfif getMyFlightsSAT.RecordCount EQ 1>
		<cfset BBox = #getMyFlightsSAT.BBox#>
		<!--- <cfset mapLayers = #getMyFlightsSAT.MapLayers#> --->
		
		<cf_Layers2Text LayersIN=#getMyFlightsSAT.MapLayers# Display=0>
		<cfset mapLayers = LayersOut>
		
		
	</cfif>


              <table width="159" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 6px; border: 1px solid #72828B">
                <tr>
                  <td style="background-color: #CCE2FF; text-align: left; padding: 3px 0px 3px 5px"><span class="sideMenuFontLev1">
				  <cfoutput>
				  <cfif getMyFlightsSAT.RecordCount EQ 1>
					  <a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=3&fID=#getMyFlightsSAT.FlightID#" class="underline">#getMyFlightsSAT.FlightName#</a>
				  <cfelse>
					  <a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=3" class="underline">Satellite</a>
				  </cfif>
				  </cfoutput></span></td>
				  </td>
                  <td align="right" valign="top" style="background-color: #CCE2FF; text-align: right; padding: 3px 5px 3px 0px"><a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=20"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>preferences_icon.gif" width="9" height="9" border="0" onmouseover="this.T_WIDTH=100;this.T_STATIC=true;this.T_OPACITY=95;return escape('Configure Satellite')"></a></td>
                </tr>
				
                <tr>
                  <td colspan="2">
						<cfoutput> 						
						<cfinclude template="js_dosfcommand.cfm">
						<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="113" ALIGN="middle">
						 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=-1,-1&SLO=1">
						 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
						 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
						 <PARAM NAME=quality VALUE="low">
						 <PARAM NAME="wmode" VALUE="opaque">
 						 <PARAM NAME=menu VALUE="false">
<!---
						 <PARAM NAME=scale VALUE="noscale">
						 <PARAM NAME=salign VALUE="LT">
						 <PARAM NAME=devicefont VALUE="true">
menu=false  scale=noscale salign=LT devicefont=true  swLiveConnect=true						 
						 --->
					 
						 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="113" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&menu=false&ToolBarXY=-1,-1&SLO=1" bgcolor="#mapBgColor#" quality="low" wmode="opaque" NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer" scale=noscale salign=LT></EMBED>
						 </OBJECT>
					    </cfoutput>						 
				  </td>
                </tr>
              </table>
