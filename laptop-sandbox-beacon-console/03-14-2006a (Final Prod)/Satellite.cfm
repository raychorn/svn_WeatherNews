<cfparam name="Animate" default="0">

<cfset flashID = 3> 

<cfinvoke component="com.weathernews.beacon.DAO.getBboxAndLayers" method="init" returnvariable="bboxAndLayers">
	<cfinvokeargument name="flashID" value="#flashID#" />
</cfinvoke>

<cf_Layers2Text LayersIN="#bboxAndLayers.layerString#" Display="0">
<cfset mapLayers = LayersOut>

<cfif isDefined("bboxAndLayers.layerString")>
	<cfset BBox = bBoxAndLayers.bBox>
	<cfset StageH = bBoxAndLayers.StageH>
	<cfset StageW = bBoxAndLayers.StageW>
<cfelse>
	<cfset BBox = "-130.496455586007,18.598539904507,-59.7473232373829,51.5157846843435">
	<cfset StageH = 400>
	<cfset StageW = 800>
</cfif>
<cfinclude template="include/MyFlightsProc.cfm" />
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
						
						<cfoutput>
							<iframe name="mapCall"
								frameborder="0" 
								align="top"
								src="/mapCall.cfm?mID=#mID#&flashid=#flashid#<cfif IsDefined("URL.fID")>&fID=#URL.fID#</cfif>" 
								id="mapCall" 
								width="100%" 
								height="400" 
								scrolling="no"
								marginheight="0">
							You must have a browser that supports frames
						</iframe>
						</cfoutput>
						

							<div class="navlink" style="background-color:#000000; font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px" align="left">
								<!--- <span style="color: #CCE2FF;"> Satellite Update Time: </span>
								<span style="color: #E3E6E8;"><SPAN id="_Curr_Times"> </SPAN></span><br>
								<span style="color: #E3E6E8;"><img src="/images/satellite_ir_legend.gif" border="0" alt="Satellite IR legend"></span> --->
								<cfinclude template="include/Legends.cfm" />
							</div>



                      </td>
                    </tr>
                    <tr>
                      <td align="right">&nbsp;</td>
                    </tr>
                  </table><!--- End of Navigation Map --->
				  

                </td>
                <td rowspan="1" background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
              </tr>
			  
              <tr>
                <td rowspan="1" background="/images/content_frame_images/content_frame_left.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
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
				<td rowspan="1" background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
              </tr>
			  
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
  					<cfinclude template="include/SatelliteMenu.cfm">
					<!--- Fast page load submit button --->
						<cfoutput>
							<input id="execute" name="submit" value="Display" type="button" onClick="reloadMap('#flashID#');enableAnimation();" /><br /><br />
							<input id="clear" name="clear" value="Clear" type="button" onClick="clearMenu('#flashID#');disableAnimation();" />
						</cfoutput>
						<div id="animationControl" align="center">
							<h3>Animation Control</h3>
	            			<input id="animate" name="animate" value="Animate" type="button" onClick="swapMovie('<cfoutput>#SESSION.flashID#</cfoutput>');" />
						</div>
					<div align="center"><a href="#" onClick="newPopupWindow('satCoverage','satelliteCoverage.cfm','310','480');">View Satellite Coverage </a><br><br></div>
				</td>
              </tr>
              <tr>
                <td><img src="/images/sidemenu_images/sidemenu_left_shadow4.gif" width="6" height="19" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_lower_left_corner.gif" width="6" height="19" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_bottom_tab.gif" width="138" height="19" alt=""></td>
                <td><img src="/images/sidemenu_images/sidemenu_right_lower_corner.gif" width="6" height="19" alt=""></td>
              </tr>
            </table>
			
 
 			
            <!-- End animation control -->
			</div>
				<script language="javascript" type="text/javascript">
					turnOffAnimation();
					disableAnimation();
				</script>
            <!--- End Right Side Window --->
	</td>
  </tr>
  </table>

