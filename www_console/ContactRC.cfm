<!--- Contact RC --->
	<cfquery NAME="getRConDuty" DATASOURCE="#Request.AVNOPS_DS#">
		select FullName, PhoneNumber, OnDuty, Title, IMName, ImageName
		from admin..RConDuty
		where Deleted = 0
		order by FullName
	</cfquery>
	

        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="161" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_top.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="161" height="8" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
            <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="100%" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_top.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="8" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
          </tr>
          <tr>
            <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_left.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="300" alt=""></td>
            <td valign="top" bgcolor="#FFFFFF">
              <div align="center" style="padding-bottom: 6px"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>logo_left.gif" width="120" height="43"></div>
<!---               <div class="sideMenuBG"><span class="sideMenuFontLev1"><img src="images/MenuArrowOff.gif"><a href="javascript:void(0);" class="underline" onmouseover="this.T_WIDTH=150;this.T_STATIC=true;this.T_OPACITY=95;return escape('Instant Message a Risk Communicator (RC) on duty.<br>Coming Early Fall 2005.')">RCs on IM</a></span></div> --->
              <div class="sideMenuBG"><span class="sideMenuFontLev1"><img src="images/MenuArrowOff.gif"><a href="javascript:void(0);" class="underline" onmouseover="this.T_WIDTH=150;this.T_STATIC=true;this.T_OPACITY=95;return escape('View live and taped whiteboard briefings.<br>Coming Early Fall 2005.')">Briefings</a></span></div>
              <div align="center"><br><br><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>AVIATIONEMBLEM.jpg" width="161" height="139"> </div>
            </td>
            <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_right.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
            <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_left.gif" bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="6" alt=""></td>
            <td width="100%" align="left" valign="top" bgcolor="#FFFFFF">
              <div class="SearchMenuBG1" style="padding-right: 6px">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td><span class="sideMenuFontLev1">RCs On Duty | <cf_formatDate></span></td>
                  </tr>
                </table>
              </div>
			  
			  
              <div class="sideMenuBG2" style="padding: 2px 6px 3px 6px; border-left: #72828B 1px solid; border-bottom: #72828B 1px solid; margin-bottom: 6px">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top">
					
					
					<cfoutput query="getRConDuty">
						<cfif ( (getRConDuty.CurrentRow MOD CEILING(getRConDuty.RecordCount/2) ) EQ 1 ) AND (getRConDuty.CurrentRow NEQ 1)>
							</td><td width="12"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="12" height="1"></td>
		                    <td valign="top">
						</cfif>

                      <table width="100%" border="0" cellpadding="2" cellspacing="0">
                        <tr>
                          <td width="72"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="72" height="1"></td>
                          <td width="100%" nowrap><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="144" height="1"></td>
                        </tr>
                        <tr valign="top">
                          <td>
						  	<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>rconduty/#ImageName#.jpg" width="72" height="84" <cfif #OnDuty# EQ 0> style="filter:alpha(opacity=40);-moz-opacity:0.4" </cfif>>
						  </td>
                          <td nowrap>
                            <div style="position: relative; clear: both" id="RCinfo1">
                              <div class="sideMenuBG"><span class="sideMenuFontLev1">#FullName#</span></div>
                              <div style="border: none; padding: 3px 6px 3px 2px"><span class="sideMenuFontLev2">#Title#<br>
                                Tel: #PhoneNumber#<br>
                                <!--- Instant Message: #IMName# ---></span><br>
								<cfif #OnDuty# EQ 1>
 	                                <div style="float: left; width: 18px; position: absolute"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>rconduty/available.gif" width="18" height="18"></div>
    	                            <div style="position: absolute; padding: 3px 0 0 18px; text-align: left"><span class="sideMenuFontLev2">On Duty</span></div><br><br>


								<cfelse>
	                                <div style="float: left; width: 18px; position: absolute"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>rconduty/away.gif" width="18" height="18"></div>
    	                            <div style="position: absolute; padding: 3px 0 0 18px; text-align: left"><span class="sideMenuFontLev2">Away</span></div>
								</cfif>
                              </div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" height="1"></td>
                          <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" height="1"></td>
                        </tr>
                      </table>
					</cfoutput>
                    </td>
					
                  </tr>
                </table>
              </div>
            </td>
            <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_right.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
          </tr>
          <tr>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
            <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_bottom.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="7" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
            <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
            <td width="100%" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_bottom.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="7" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
          </tr>
        </table>
		

<!--- 


	<table width="100%" height="639" align="center"  border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
        <tr>
          <td rowspan="8" valign="top"><img src="images/spacer.gif" width="40" height="20" alt=""></td>
          <td height="20" colspan="4" valign="top"><img src="images/spacer.gif" height="20" alt=""></td>
          <td rowspan="8" valign="top"><img src="images/spacer.gif" width="40" height="20" alt=""></td>
        </tr>
        
		<tr>
          <td width="14%" height="110" valign="top"><img src="images/steve_abelman_s.jpg" width="108" height="108"></td>
          <td width="37%" valign="top"><p class="normaldark"><strong>Steve Abelman</strong><br>
			  SKY Risk Communicator - Shift Lead</p>          
    	      <p class="Mem11Norm">Phone: 405.310.2955<br>
			  Instant Message: WNIAbelman</p></td>
          <td width="14%" valign="top"><img src="images/shawn_rampy_s.jpg" width="108" height="108"></td>
          <td width="35%" valign="top"><p class="normaldark"><strong>Shawn Rampy</strong><br>
	     	  North America - Surface</p>
	          <p class="Mem11Norm">Phone: 405.310.2955<br>
	          Instant Message: WNIRampy</p></td>
        </tr>
        <tr>
          <td height="20" colspan="4" valign="top">&nbsp;</td>
        </tr>
		
        <tr>
          <td height="110" valign="top"><img src="images/marcia_otto_s.jpg" width="108" height="108"></td>
          <td valign="top"><p class="normaldark"><strong>Marcia Otto</strong><br>
            North America – Upper Air </p>
            <p class="Mem11Norm">Phone: 405.310.2955<br>
	        Instant Message: WNIOtto </p></td>
          <td valign="top"><img src="images/stan_grell_s.jpg" width="108" height="108"></td>
          <td valign="top"><p class="normaldark"><strong>Stan Grell</strong><br>
            International – Surface </p>
            <p class="Mem11Norm">Phone: 405.310.2955<br>
            Instant Message: WNIGrell</p></td>
        </tr>
        <tr>
          <td height="20" colspan="4" valign="top">&nbsp;</td>
        </tr>

        <tr>
          <td height="110" valign="top"><img src="images/travis_martin_s.jpg" width="108" height="108"></td>
          <td valign="top"><p class="normaldark"><strong>Travis Martin</strong><br>
            International – Upper Air </p>
            <p class="Mem11Norm">Phone: 405.310.2955<br>
            Instant Message: WNIMartin</p></td>
          <td colspan="2" valign="top">&nbsp;</td>
        </tr>
        <tr>
          <td height="15" colspan="4" valign="top">&nbsp;</td>
        </tr>
        <tr>
          <td height="107" colspan="4" valign="top"><img src="images/contact_rc_header.gif" width="860" height="88"></td>
        </tr>

    </table>
 --->