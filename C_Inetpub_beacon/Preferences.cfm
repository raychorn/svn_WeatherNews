<!--- <cfloop index="LoopIndex" from="1" to="20">
	
	<cfset cookieBBoxName = "BBOX_" & LoopIndex>
	<cfset cookieMapLayersName = "MAPLAYERS_" & LoopIndex>
	<cfset cookieStageHName = "STAGEH_" & LoopIndex>
	<cfset cookieStageWName = "STAGEW_" & LoopIndex>
		
	<cfif isDefined("cookie." & cookieBBoxName)>
		<cfcookie name="#cookieBBoxName#" value="1" expires="now">
	</cfif>

	<cfif isDefined("cookie." & cookieStageHName)>
		<cfcookie name="#cookieStageHName#" value="1" expires="now">
	</cfif>

	<cfif isDefined("cookie." & cookieStageWName)>
		<cfcookie name="#cookieStageWName#" value="1" expires="now">
	</cfif>

	<cfif isDefined("cookie." & cookieMapLayersName)>
		<cfcookie name="#cookieMapLayersName#" value="1" expires="now">
	</cfif>

</cfloop>
 --->
<cfparam name="PageNum" default="1">

<cfif PageNum EQ 2>
	<cfinclude template="include/PreferencesProc.cfm">		
</cfif>

	
				<cfquery NAME="getCredentialsFromLoginID" DATASOURCE="#INTRANET_DS#">
					select UserID, UserName, UserGreeting, UserFname, UserLname, UserEmail
					from AvnUsers
					where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
					and Deleted = 0
				</cfquery>
				
				<cfquery NAME="getMyFlights" DATASOURCE="#INTRANET_DS#">
					select F.FlightID, F.FlightName, F.BBox, F.MapLayers, F.LastUpdated, F.SectionID, F.SetAsDefault
					from AvnUsers U, AvnFlights F
					where U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
							AND U.UserID = F.UserID
					and U.Deleted = 0 and F.Deleted = 0
					order by F.FlightName
				</cfquery>

	
	
	
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="/images/content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="161" background="/images/content_frame_images/content_frame_top.gif"><img src="/images/spacer.gif" width="161" height="8" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
            <td><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td bgcolor="#E3E6E8"><img src="/images/content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="100%" background="/images/content_frame_images/content_frame_top.gif"><img src="/images/spacer.gif" width="1" height="8" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
          </tr>
          <tr>
            <td background="/images/content_frame_images/content_frame_left.gif"><img src="/images/spacer.gif" width="6" height="300" alt=""></td>
            <td valign="top" bgcolor="#FFFFFF">
              <div align="center" style="padding-bottom: 6px"><img src="/images/logo_left.gif" width="120" height="43"></div>
              <div align="center">
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p><img src="/images/AVIATIONEMBLEM.jpg" width="161" height="139"> </p>
              </div>
            </td>
            <td background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
            <td background="/images/content_frame_images/content_frame_left.gif" bgcolor="#E3E6E8"><img src="/images/spacer.gif" width="6" height="6" alt=""></td>
            <td width="100%" align="left" valign="top" bgcolor="#FFFFFF">
			
              <div class="prefBGtop">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="left"><span class="sideMenuFontLev1">Preferences</span><td>
					<td align="right"><span style="font-size: 9px">[*]=Required Fields&nbsp;&nbsp;&nbsp;</span></td>
                  </tr>
                </table>
              </div>
			  
			  
              <div class="prefBG"><span class="sideMenuFontLev1">Account Preferences</span>
			  <cfif LEN(gErrString) AND ListFindNoCase(Form.Fieldnames, "ACCOUNTSUBMIT")>
			  		<cfif CompareNoCase(gErrString,"none") NEQ 0>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FF0000"><cfoutput>#gErrStringMessage#</cfoutput></span>
					<cfelse>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FFFFFF"><cfoutput>#gErrStringMessage#</cfoutput></span>
					</cfif>
			  </cfif>
			  </div>
			  
              <div class="prefBG2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top">
                      <form name="accountInfoForm" action="/#Request.const_default_htm#" method="post">
					    <cfoutput>
                        <table width="100%" border="0" cellspacing="0" style="padding: 4px 2px 0 0">
                          <tr>
                            <td align="right" class="sideMenuFontLev2" style="padding-bottom: 0">Name:&nbsp;</td>
                            <td width="300" style="padding-bottom: 0"><input name="FfirstName" type="text" class="input-box" size="30" maxlength="50" <cfif IsDefined("FfirstName")>value="#FfirstName#"<cfelse>value="#getCredentialsFromLoginID.UserFName#"</cfif>></td>
                            <td width="100%" style="padding-bottom: 0"><input name="FlastName" type="text" class="input-box" size="30" maxlength="50" <cfif IsDefined("FlastName")>value="#FlastName#"<cfelse>value="#getCredentialsFromLoginID.UserLName#"</cfif>></td>
                          </tr>
                          <tr>
                            <td align="right"><img src="/images/spacer.gif" width="1" height="16"></td>
                            <td valign="top" class="sideMenuFontLev2"><cf_font_r fn="FfirstName" gErrString="#gErrString#">First</cf_font_r></td>
                            <td width="100%" valign="top" class="sideMenuFontLev2"><cf_font_r fn="FlastName" gErrString="#gErrString#">Last</cf_font_r></td>
                          </tr>
                          <tr>
                            <td align="right" class="sideMenuFontLev2">Greeting:&nbsp;</td>
                            <td class="sideMenuFontLev2" colspan="2"><input name="Fgreeting" type="text" class="input-box" size="30" maxlength="50" <cfif IsDefined("Fgreeting")>value="#Fgreeting#"<cfelse>value="#getCredentialsFromLoginID.UserGreeting#"</cfif>></td>
                          </tr>
                           <tr>
                            <td align="right" class="sideMenuFontLev2"><cf_font_r fn="Femail" gErrString="#gErrString#">E-mail:</cf_font_r>&nbsp;</td>
                            <td class="sideMenuFontLev2" colspan="2"><input name="Femail" type="text" class="input-box" size="30" maxlength="100" <cfif IsDefined("Femail")>value="#Femail#"<cfelse>value="#getCredentialsFromLoginID.UserEmail#"</cfif>></td>
                          </tr>
                          <tr>
                            <td align="right" class="sideMenuFontLev2"><cf_font_r fn="Fusername" gErrString="#gErrString#">UserName:</cf_font_r>&nbsp;</td>
                            <td class="sideMenuFontLev2" colspan="2"><input name="Fusername" type="text" class="input-box" size="30" maxlength="50" <cfif IsDefined("Fusername")>value="#Fusername#"<cfelse>value="#getCredentialsFromLoginID.Username#"</cfif>></td>
                          </tr>
                          <tr>
                            <td align="right">&nbsp;</td>
                            <td>
							  <input type="hidden" name="mID" value="#mID#">
							  <input type="hidden" name="pageNum" value="2">
                              <input name="accountSubmit" type="submit" class="submit-button" value="Update">
                            </td>
                            <td width="100%">&nbsp;</td>
                          </tr>
                          <tr>
                            <td align="right">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td width="100%">&nbsp;</td>
                          </tr>
                        </table>
						</cfoutput>
                      </form>
                    </td>
                  </tr>
                </table>
              </div>
			  
			  
              <div class="prefBG"><span class="sideMenuFontLev1">Change Password</span>
			  <cfif LEN(gErrString) AND ListFindNoCase(Form.Fieldnames, "PASSSUBMIT")>
			  		<cfif CompareNoCase(gErrString,"none") NEQ 0>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FF0000"><cfoutput>#gErrStringMessage#</cfoutput></span>
					<cfelse>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FFFFFF"><cfoutput>#gErrStringMessage#</cfoutput></span>
					</cfif>
			  </cfif>
			  </div>
              <div class="prefBG2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top">
                      <form name="passChangeForm" action="/#Request.const_default_htm#" method="post">
					  <cfoutput>
                        <table width="100%" border="0" cellspacing="0" style="padding: 4px 2px 0 0">
                          <tr>
                            <td align="right" class="sideMenuFontLev2" nowrap><cf_font_r fn="FoldPass" gErrString="#gErrString#">Old Password:</cf_font_r>&nbsp;</td>
                            <td width="100%"><input name="FoldPass" type="password" class="input-box" size="30" maxlength="50" <cfif IsDefined("FoldPass")>value="#FoldPass#"</cfif>></td>
                          </tr>
                          <tr>
                            <td align="right" class="sideMenuFontLev2" nowrap><cf_font_r fn="FnewPass" gErrString="#gErrString#">New Password:</cf_font_r>&nbsp;</td>
                            <td width="100%"><input name="FnewPass" type="password" class="input-box" size="30" maxlength="50" <cfif IsDefined("FnewPass")>value="#FnewPass#"</cfif>></td>
                          </tr>
                          <tr>
                            <td align="right" class="sideMenuFontLev2" nowrap><cf_font_r fn="FnewPass2" gErrString="#gErrString#">Repeat New Password:</cf_font_r>&nbsp;</td>
                            <td width="100%"><input name="FnewPass2" type="password" class="input-box" size="30" maxlength="50" <cfif IsDefined("FnewPass2")>value="#FnewPass2#"</cfif>></td>
                          </tr>
                          <tr>
                            <td align="right">&nbsp; </td>
                            <td>
							  <input type="hidden" name="mID" value="#mID#">
							  <input type="hidden" name="pageNum" value="2">
                              <input name="passSubmit" type="submit" class="submit-button" value="Change">
                            </td>
                          </tr>
                        </table>
						</cfoutput>
                      </form>
                    </td>
                  </tr>
                </table>
              </div>
			  
			  
              <div class="prefBG"><span class="sideMenuFontLev1">Instrument Panel Preferences</span>
			  <cfif LEN(gErrString) AND ListFindNoCase(Form.Fieldnames, "IPSubmit")>
			  		<cfif CompareNoCase(gErrString,"none") NEQ 0>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FF0000"><cfoutput>#gErrStringMessage#</cfoutput></span>
					<cfelse>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FFFFFF"><cfoutput>#gErrStringMessage#</cfoutput></span>
					</cfif>
			  </cfif>
			  </div>
			  
              <div class="prefBG2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top">
                      <p><span class="sideMenuFontLev2">Add flights to this list from the <a href="/#Request.const_default_htm#?mID=2" class="underline">Instrument Panel</a> page.</span> </p>
                      <div class="prefBG3">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><img src="/images/spacer.gif" width="88" height="1" alt=""></td>
                            <td><img src="/images/spacer.gif" width="88" height="1" alt=""></td>
                            <td><img src="/images/spacer.gif" height="1" alt=""></td>
                          </tr>
                          <tr valign="bottom">
                            <td width="88" align="center" nowrap class="sideMenuFontLev2">Add to<br>Home Page</td>
                            <td width="88" align="center" class="sideMenuFontLev2">Delete</td>
                            <td align="left" class="sideMenuFontLev2">Flight Name</td>
                          </tr>
                        </table>
                      </div>
                      <div class="prefBG4">
                        <form name="IPChangeForm" action="/#Request.const_default_htm#" method="post">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding: 2px 0; border-bottom: 1px solid #72828B">
                            <tr>
								<td><img src="/images/spacer.gif" width="68" height="1" alt=""></td>
								<td><img src="/images/spacer.gif" width="68" height="1" alt=""></td>
								<td><img src="/images/spacer.gif" height="1" alt=""></td>
                            </tr>
							<cfloop query="getMyFlights">
							<cfif getMyFlights.SectionID EQ 2>
							<cfoutput>
								<tr valign="middle" <cfif SetAsDefault EQ 1> bgcolor="##FFFFFF"</cfif>>
								  <td width="10%" align="center" style="padding: 2px 0 0 0">
								  <input type="radio" name="IPradiobutton" value="#FlightID#" <cfif SetAsDefault EQ 1> checked</cfif>>
								  </td>
								  <td width="10%" align="center" class="sideMenuFontLev2" style="padding: 2px 0 0 0">
								  <input type="checkbox" name="IPcheckbox" value="#FlightID#">
								  </td>
								  <td width="80%" align="left" class="sideMenuFontLev2" style="padding: 2px 6px 0 0">#FlightName#</td>
								</tr>
							</cfoutput>
							</cfif>							
							</cfloop>
                            <tr valign="middle">
                              <td width="10%" align="center" style="padding: 2px 0 0 0">&nbsp; </td>
                              <td width="10%" align="center" class="sideMenuFontLev2" style="padding: 2px 0 0 0">&nbsp; </td>
                              <td width="80%" align="left" class="sideMenuFontLev2" style="padding: 2px 6px 0 0">
								<cfoutput>
								  <input type="hidden" name="mID" value="#mID#">
								  <input type="hidden" name="SectionID" value="2">
								  <input type="hidden" name="pageNum" value="2">
								  <input name="IPSubmit" type="submit" class="submit-button" value="Submit">
								</cfoutput>
                               </td>
                            </tr>
                          </table>
						</form>
                      </div>
                    </td>
                  </tr>
                </table>
              </div>
			  
			  
              <div class="prefBG"><span class="sideMenuFontLev1">Satellite Preferences</span>
			  <cfif LEN(gErrString) AND ListFindNoCase(Form.Fieldnames, "SATSubmit")>
			  		<cfif CompareNoCase(gErrString,"none") NEQ 0>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FF0000"><cfoutput>#gErrStringMessage#</cfoutput></span>
					<cfelse>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FFFFFF"><cfoutput>#gErrStringMessage#</cfoutput></span>
					</cfif>
			  </cfif>
			  </div>
			  
              <div class="prefBG2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top">
                      <p><span class="sideMenuFontLev2">Add flights to this list from the <a href="/#Request.const_default_htm#?mID=3" class="underline">Satellite</a> page.</span> </p>
                      <div class="prefBG3">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><img src="/images/spacer.gif" width="88" height="1" alt=""></td>
                            <td><img src="/images/spacer.gif" width="88" height="1" alt=""></td>
                            <td><img src="/images/spacer.gif" height="1" alt=""></td>
                          </tr>
                          <tr valign="bottom">
                            <td width="88" align="center" nowrap class="sideMenuFontLev2">Add to<br>Home Page</td>
                            <td width="88" align="center" class="sideMenuFontLev2">Delete</td>
                            <td align="left" class="sideMenuFontLev2">Flight Name</td>
                          </tr>
                        </table>
                      </div>
                      <div class="prefBG4">
                        <form name="SatChangeForm" action="/#Request.const_default_htm#" method="post">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding: 2px 0; border-bottom: 1px solid #72828B">
                            <tr>
								<td><img src="/images/spacer.gif" width="68" height="1" alt=""></td>
								<td><img src="/images/spacer.gif" width="68" height="1" alt=""></td>
								<td><img src="/images/spacer.gif" height="1" alt=""></td>
                            </tr>
							<cfloop query="getMyFlights">
							<cfif getMyFlights.SectionID EQ 3>
							<cfoutput>
								<tr valign="middle" <cfif SetAsDefault EQ 1> bgcolor="##FFFFFF"</cfif>>
								  <td width="10%" align="center" style="padding: 2px 0 0 0">
								  <input type="radio" name="IPradiobutton" value="#FlightID#" <cfif SetAsDefault EQ 1> checked</cfif>>
								  </td>
								  <td width="10%" align="center" class="sideMenuFontLev2" style="padding: 2px 0 0 0">
								  <input type="checkbox" name="IPcheckbox" value="#FlightID#">
								  </td>
								  <td width="80%" align="left" class="sideMenuFontLev2" style="padding: 2px 6px 0 0">#FlightName#</td>
								</tr>
							</cfoutput>
							</cfif>							
							</cfloop>
                            <tr valign="middle">
                              <td width="10%" align="center" style="padding: 2px 0 0 0">&nbsp; </td>
                              <td width="10%" align="center" class="sideMenuFontLev2" style="padding: 2px 0 0 0">&nbsp; </td>
                              <td width="80%" align="left" class="sideMenuFontLev2" style="padding: 2px 6px 0 0">
								<cfoutput>
								  <input type="hidden" name="mID" value="#mID#">
								  <input type="hidden" name="SectionID" value="3">
								  <input type="hidden" name="pageNum" value="2">
								  <input name="SATSubmit" type="submit" class="submit-button" value="Submit">
								</cfoutput>
                               </td>
                            </tr>
                          </table>
						</form>
                      </div>
                    </td>
                  </tr>
                </table>
              </div>
			  
			  
			  
			  
              <div class="prefBG"><span class="sideMenuFontLev1">Radar Preferences</span>
			  <cfif LEN(gErrString) AND ListFindNoCase(Form.Fieldnames, "RADSubmit")>
			  		<cfif CompareNoCase(gErrString,"none") NEQ 0>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FF0000"><cfoutput>#gErrStringMessage#</cfoutput></span>
					<cfelse>
					  	&nbsp;&nbsp;<span class="sideMenuFontLev2" style="color:#FFFFFF"><cfoutput>#gErrStringMessage#</cfoutput></span>
					</cfif>
			  </cfif>
			  </div>
			  
              <div class="prefBG2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top">
                      <p><span class="sideMenuFontLev2">Add flights to this list from the <a href="/#Request.const_default_htm#?mID=4" class="underline">Radar</a> page.</span> </p>
                      <div class="prefBG3">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><img src="/images/spacer.gif" width="88" height="1" alt=""></td>
                            <td><img src="/images/spacer.gif" width="88" height="1" alt=""></td>
                            <td><img src="/images/spacer.gif" height="1" alt=""></td>
                          </tr>
                          <tr valign="bottom">
                            <td width="88" align="center" nowrap class="sideMenuFontLev2">Add to<br>Home Page</td>
                            <td width="88" align="center" class="sideMenuFontLev2">Delete</td>
                            <td align="left" class="sideMenuFontLev2">Flight Name</td>
                          </tr>
                        </table>
                      </div>
                      <div class="prefBG4">
                        <form name="SatChangeForm" action="/#Request.const_default_htm#" method="post">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding: 2px 0; border-bottom: 1px solid #72828B">
                            <tr>
								<td><img src="/images/spacer.gif" width="68" height="1" alt=""></td>
								<td><img src="/images/spacer.gif" width="68" height="1" alt=""></td>
								<td><img src="/images/spacer.gif" height="1" alt=""></td>
                            </tr>
							<cfloop query="getMyFlights">
							<cfif getMyFlights.SectionID EQ 4>
							<cfoutput>
								<tr valign="middle" <cfif SetAsDefault EQ 1> bgcolor="##FFFFFF"</cfif>>
								  <td width="10%" align="center" style="padding: 2px 0 0 0">
								  <input type="radio" name="IPradiobutton" value="#FlightID#" <cfif SetAsDefault EQ 1> checked</cfif>>
								  </td>
								  <td width="10%" align="center" class="sideMenuFontLev2" style="padding: 2px 0 0 0">
								  <input type="checkbox" name="IPcheckbox" value="#FlightID#">
								  </td>
								  <td width="80%" align="left" class="sideMenuFontLev2" style="padding: 2px 6px 0 0">#FlightName#</td>
								</tr>
							</cfoutput>
							</cfif>							
							</cfloop>
                            <tr valign="middle">
                              <td width="10%" align="center" style="padding: 2px 0 0 0">&nbsp; </td>
                              <td width="10%" align="center" class="sideMenuFontLev2" style="padding: 2px 0 0 0">&nbsp; </td>
                              <td width="80%" align="left" class="sideMenuFontLev2" style="padding: 2px 6px 0 0">
								<cfoutput>
								  <input type="hidden" name="mID" value="#mID#">
								  <input type="hidden" name="SectionID" value="4">
								  <input type="hidden" name="pageNum" value="2">
								  <input name="RADSubmit" type="submit" class="submit-button" value="Submit">
								</cfoutput>
                               </td>
                            </tr>
                          </table>
						</form>
                      </div>
                    </td>
                  </tr>
                </table>
              </div>
			  
			  
			  
			  
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
          </tr>
        </table>
	