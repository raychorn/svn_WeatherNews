<cfparam name="Animate" default="0">

<cfset flashID = 5> 
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
                <td rowspan="1" background="/images/content_frame_images/content_frame_left.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
                <td width="100%" align="center" bgcolor="#FFFFFF">


				   <!--- Navigation Map --->
                  <table width="95%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td>
						<cfif Animate EQ 0>
							<cfoutput> 
							<cfinclude template="include/js_dosfcommand.cfm">
							<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0" ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
							 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0">
							 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
							 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
							 <PARAM NAME=menu VALUE="true">
							 <PARAM NAME=quality VALUE="high">
							 <PARAM NAME=scale VALUE="noscale">
							 <PARAM NAME=salign VALUE="LT">
							 <PARAM NAME=devicefont VALUE="true">
							 <PARAM NAME=swLiveConnect VALUE="true">
						 
							 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0" menu=true quality=autohigh scale=noscale wmode="opaque" salign=LT devicefont=true bgcolor=#mapBgColor# swLiveConnect=true  NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
							 </OBJECT>
						  </cfoutput>
							<!--- <cfinclude template="include/UpdateTimes.cfm"> --->
						<cfelse>
				 		  <cfoutput>
							<cf_img javacode rotatedelay="1000" slideshow="#SlideShowList#" NOSRC="/images/energy/noImage.jpg">
							<cf_img name="show" href="/#Request.const_default_htm#?mID=5" src="#ListFirst(SlideShowList,',')#" NOSRC="/images/energy/noImage.jpg" TITLE="Click on the image to Redefine Your Selection" ALT="Click on the image to Redefine Your Selection">
						 </cfoutput>		
						 	<script language="javascript">
							function do_onload2() {
							    //MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_on.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1);
								slideshow_status('Start')
							}
							
							if (window.addEventListener)
								window.addEventListener("load", do_onload2, false)
								else if (window.attachEvent)
								window.attachEvent("onload", do_onload2)
								else if (document.getElementById)
								window.onload=do_onload2

							</script>

						 </cfif>

                      </td>
                    </tr>
                    <tr>
                      <td align="right">&nbsp;</td>
                    </tr>
                  </table><!--- End of Navigation Map --->
                </td>
                <td rowspan="1" background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
              </tr>
<!---              <tr>
	  		    <td align="center" valign="bottom" class="navlink">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#000000">
					<tr>
						<td valign="top" align="left" nowrap style="font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px">


	<div id="content0" style="display: block">
						<cfset currRadarDT = CreateDateTime(LEFT(RadarTimes,4),MID(RadarTimes,5,2),MID(RadarTimes,7,2),MID(RadarTimes,9,2),MID(RadarTimes,11,2),0)>
						<span style="color: #CCE2FF;"> Radar Update Time: </span>
						<span style="color: #E3E6E8;">
						<cfoutput>&nbsp;<cf_formatDate inDate=#currRadarDT#> GMT&nbsp;</cfoutput></span>
    </div>						
	<div id="content1" style="display:none">
						<span style="color: #CCE2FF;"> Satellites Update Times: </span>
						<span style="color: #E3E6E8;">
						&nbsp;|&nbsp;
						<cfloop list="#SatelliteTimes#" index="LoopIndex" delimiters="|">
							<cfset currSatName = TRIM(ListGetAt(LoopIndex,1))>
							<cfset currSatUpdate = ListGetAt(LoopIndex,2)>
							<cfset currSatFrequency = ListGetAt(LoopIndex,3)>
							<cfoutput>#currSatName#:&nbsp;#currSatUpdate#&nbsp;(#currSatFrequency#&acute;)&nbsp;|&nbsp;</cfoutput>
						</cfloop>
						</span>

    </div>						
<!---

						<td valign="top" nowrap style="font-family: Tahoma, Verdana, Arial, sans-serif; color: #CCE2FF; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px">Satellite Update Times: </td>
						<td width="100%" valign="top" align="center" style="font-family: Tahoma, Verdana, Arial, sans-serif; color: #E3E6E8; font-weight: bold; font-size: 9px; padding: 3px 6px 3px 0">
						&nbsp;|&nbsp;
						<cfloop list="#SatelliteTimes#" index="LoopIndex" delimiters="|">
							<cfset currSatName = TRIM(ListGetAt(LoopIndex,1))>
							<cfset currSatUpdate = ListGetAt(LoopIndex,2)>
							<cfset currSatFrequency = ListGetAt(LoopIndex,3)>
							<cfoutput>#currSatName#:&nbsp;#currSatUpdate#&nbsp;(#currSatFrequency#&acute;)&nbsp;|&nbsp;</cfoutput>
						</cfloop>
						</td>


						&nbsp;|&nbsp;
 						<cfloop list="#RadarTimes#" index="LoopIndex" delimiters="|">
							<cfset currRadarName = TRIM(ListGetAt(LoopIndex,1))>
							<cfset currRadarUpdate = ListGetAt(LoopIndex,2)>
							<cfset currRadarFrequency = ListGetAt(LoopIndex,3)>
							<cfoutput>#currRadarName#:&nbsp;#currRadarUpdate#&nbsp;(#currRadarFrequency#&acute;)&nbsp;|&nbsp;</cfoutput>
						</cfloop>
 --->
						</td>
					</tr>
				</table>
				</td>
              </tr>
			  ---->
              <tr>
                <td><img src="/images/content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
                <td width="100%" background="/images/content_frame_images/content_frame_bottom.gif"><img src="/images/spacer.gif" width="1" height="7" alt=""></td>
                <td><img src="/images/content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
              </tr>
            </table>
          </td>
          <td width="180">
            <!--- Right Side Window --->
            <table width="156" border="0" cellpadding="0" cellspacing="0"><!--- Right Side Window --->
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
   					<cfinclude template="include/ChartMenu.cfm">

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
			
 
<!---No Animation for now
  			<div align="center">
            <!-- start animation control (see image maps at end of HTML for hooks to add links) (popup_look.psd) -->
            <table width=130 border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF">
              <tr>
                <td bgcolor="#E3E6E8"><img src="/images/animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="/images/animation_control_images/ani_top_left.gif" width=5 height=5 alt=""></td>
                <td><img src="/images/animation_control_images/ani_top_edge.gif" width=120 height=5 alt=""></td>
                <td><img src="/images/animation_control_images/ani_top_right.gif" width=5 height=5 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="/images/animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="/images/animation_control_images/spacer.gif" width=5 height=8 alt=""></td>
                <td><img src="/images/animation_control_images/default_cap.gif" alt="" name="caption" width=120 height=8 id="caption"></td>
                <td><img src="/images/animation_control_images/ani_right_edge.gif" width=5 height=8 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="/images/animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="/images/animation_control_images/spacer.gif" width=5 height=17 alt=""></td>
                <td>
                  <!-- Start Button Bar (see www.walterzorn.com/tooltip/tooltip_e.htm for documentation on the script if you want to understand it better -->
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
				<cfif Animate EQ 0>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_1_dim.gif" name="button1" width="22" height="17" border="0" id="button1"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_2_dim.gif" name="button2" width="15" height="17" border="0" id="button2"></a></td>
                      <td><a href="/#Request.const_default_htm#?mID=5&Animate=1" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Play animation')"><img src="/images/animation_control_images/buttons_3_off.gif" name="button3" width="15" height="17" border="0" id="button3"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_4_dim.gif" name="button4" width="15" height="17" border="0" id="button4"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_5_dim.gif" name="button5" width="14" height="17" border="0" id="button5"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_6_dim.gif" name="button6" width="15" height="17" border="0" id="button6"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_7_dim.gif" name="button7" width="24" height="17" border="0" id="button7"></a></td>
				<cfelse>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Rewind to first frame')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_on.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1);slideshow_first();"><img src="/images/animation_control_images/buttons_1_off.gif" name="button1" width="22" height="17" border="0" id="button1"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step back one frame')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_on.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1);slideshow_previous();"><img src="/images/animation_control_images/buttons_2_off.gif" name="button2" width="15" height="17" border="0" id="button2"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Play animation')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_on.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1);slideshow_status('Start');"><img src="/images/animation_control_images/buttons_3_on.gif" name="button3" width="15" height="17" border="0" id="button3"></span></a></td>
                      <td><a href="/default.htm?mID=5" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Return to static map')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_on.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1)"><img src="/images/animation_control_images/buttons_4_off.gif" name="button4" width="15" height="17" border="0" id="button4"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Pause animation')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_on.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1);slideshow_status('Stop');"><img src="/images/animation_control_images/buttons_5_off.gif" name="button5" width="14" height="17" border="0" id="button5"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step forward one frame')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_on.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1);slideshow_next();"><img src="/images/animation_control_images/buttons_6_off.gif" name="button6" width="15" height="17" border="0" id="button6"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Advance to last frame')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_on.gif',1);slideshow_last();"><img src="/images/animation_control_images/buttons_7_off.gif" name="button7" width="24" height="17" border="0" id="button7"></span></a></td>
				</cfif>
                    </tr>
                  </table>
                </td>
                <td background="/images/animation_control_images/ani_right_edge.gif"><img src="/images/animation_control_images/spacer.gif" width=5 height=17 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="/images/animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="/images/animation_control_images/spacer.gif" width=5 height=12 alt=""></td>
			<cfif Animate EQ 0>
                <td align="center"><span onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/speed_minus.gif" width="45" height="12"><img src="/images/animation_control_images/speed_control_dim.gif" alt="" name="slider" width=55 height=12 border="0" id="slider"><img src="/images/animation_control_images/speed_plus.gif" width="20" height="12"></span></td>
			<cfelse>
                <td align="center"><span onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Set speed')"><img src="/images/animation_control_images/speed_minus.gif" width="45" height="12"><img src="/images/animation_control_images/speed_slider_3.gif" alt="" name="slider" width=55 height=12 border="0" usemap="#sliderMap" id="slider"><img src="/images/animation_control_images/speed_plus.gif" width="20" height="12"></span></td>
			</cfif>
                <td background="/images/animation_control_images/ani_right_edge.gif"><img src="/images/animation_control_images/spacer.gif" width=5 height=12 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="/images/animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="/images/animation_control_images/ani_bottom_left.gif" width=5 height=4 alt=""></td>
                <td><img src="/images/animation_control_images/spacer.gif" width=120 height=4 alt=""></td>
                <td><img src="/images/animation_control_images/ani_bottom_right.gif" width=5 height=4 alt=""></td>
              </tr>
            </table>
            <!-- End animation control -->
			</div>
 --->
 
            <!--- End Right Side Window --->
	</td>
  </tr>
  </table>
<map name="sliderMap">
<area shape="rect" coords="0,0,11,12" href="#" onClick="setDelay(5000);MM_swapImage('slider','','/images/animation_control_images/speed_slider_1.gif',1)">
<area shape="rect" coords="11,0,22,12" href="#" onClick="setDelay(3000);MM_swapImage('slider','','/images/animation_control_images/speed_slider_2.gif',1)">
<area shape="rect" coords="22,0,33,12" href="#" onClick="setDelay(2000);MM_swapImage('slider','','/images/animation_control_images/speed_slider_3.gif',0)">
<area shape="rect" coords="33,0,44,12" href="#" onClick="setDelay(1000);MM_swapImage('slider','','/images/animation_control_images/speed_slider_4.gif',1)">
<area shape="rect" coords="44,0,55,12" href="#" onClick="setDelay(200);MM_swapImage('slider','','/images/animation_control_images/speed_slider_5.gif',1)">
</map>
