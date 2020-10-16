<cfset DisplayMore = 1>
<a name="res"></a>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
	<td width="6"><img src="/images/content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
	<td width="100%" background="/images/content_frame_images/content_frame_top.gif"><img src="/images/spacer.gif" width="1" height="8" alt=""></td>
	<td width="6"><img src="/images/content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
  </tr>
  <tr>
	<td background="/images/content_frame_images/content_frame_left.gif"><img src="/images/spacer.gif" width="6" height="11" alt=""></td>
	<td width="100%" bgcolor="#FFFFFF" class="serverMessageSub">

	 <cfif gErrString EQ "1">
	  <div align="center">&nbsp;<br>
		<img src="/images/main_table_images/alert_icon.gif" width="25" height="24" align="middle"> Sorry! I could not complete your search.<img src="/images/spacer.gif" width="25" height="24" align="top"><br>
		<span class="serverMessageSub">Please complete all required fields (indicated with an &quot;*&quot;) in the search form above and try again.<br>&nbsp; </span> </div>
		<cfset DisplayMore = 0>
	 <cfelseif gErrString EQ "2">
		  <div align="center">&nbsp;<br><img src="/images/main_table_images/alert_icon.gif" width="25" height="24" align="middle"> Sorry, there are no records that match your search criteria.<br>&nbsp; </div>
		<cfset DisplayMore = 0>
	 <cfelseif gErrString EQ "3">
		  <div style="MARGIN-BOTTOM: 0.5em" align=left><cfoutput>#getQuery.RecordCount# records match your criteria. Only the first #MaxRecords# are displayed.</cfoutput>&nbsp; </div>
	 <cfelseif gErrString EQ "9">
		<div align="center">&nbsp;<br>
		<img src="/images/main_table_images/alert_icon.gif" width="25" height="24" align="middle"><cfoutput>#gErrStringText#</cfoutput><img src="/images/spacer.gif" width="25" height="24" align="top"></div>
		<cfset DisplayMore = 0>
	 </cfif>


<cfif DisplayMore EQ 1>
			 
<cfswitch expression="#Form.RepType#">
	<cfcase value="2">
		<cfif NOT LEN(gErrString)>
			<cfoutput><PRE style="font-size:14px">#RawText2#</PRE></cfoutput>
		</cfif>	 
	</cfcase>
	<cfcase value="4">
		<cfif NOT LEN(gErrString)>
			<cfoutput><PRE style="font-size:14px">#RawText2#</PRE></cfoutput>
		</cfif>	 
	</cfcase>
	<cfcase value="8">
		<cfif NOT LEN(gErrString)>
			<cfset bgColor = "white">
			<cfset bgColorAlt = "whitesmoke">
			<cfset tdColor = bgColor>
			<cfoutput>
				<cfloop index="LoopIndex" from="1" to="#ArrayLen(myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type)#">
					<cfswitch expression="#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].XmlName#">
						<cfcase value="Airport_Closure_List">
						<div align=left class="body">&nbsp;AIRPORT CLOSURES</div>
						  <table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr bgcolor="##CCE2FF">
								<cfloop list="Airport,Reason,Start,Reopen" delimiters="," index="ColName">
								<cfoutput>
									<td class="dataTable" nowrap><a href="javascript:void(0)" class="tabular">#ColName#</a></td>
								</cfoutput>
								</cfloop>
							</tr>	
							<cfloop index="LoopIndex2" from="1" to="#ArrayLen(myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Airport)#" step="1">
							<cfif tdColor EQ bgcolor>
								<cfset tdColor = bgColorAlt>
							<cfelse>
								<cfset tdColor = bgColor>
							</cfif>
							<tr>
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Airport[LoopIndex2].ARPT.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Airport[LoopIndex2].Reason.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Airport[LoopIndex2].Start.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Airport[LoopIndex2].Reopen.XmlText#
								</td> 
							</tr>	
							</cfloop>
						  </table>
						</cfcase>

						<cfcase value="Ground_Stop_List">
						<div align=left class="body">&nbsp;GROUND STOP</div>
						  <table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr bgcolor="##CCE2FF">
								<cfloop list="Airport,Reason,End Time" delimiters="," index="ColName">
								<cfoutput>
									<td class="dataTable" nowrap><a href="javascript:void(0)" class="tabular">#ColName#</a></td>
								</cfoutput>
								</cfloop>
							</tr>	
							<cfloop index="LoopIndex2" from="1" to="#ArrayLen(myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Program)#" step="1">
							<cfif tdColor EQ bgcolor>
								<cfset tdColor = bgColorAlt>
							<cfelse>
								<cfset tdColor = bgColor>
							</cfif>
							<tr>
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Program[LoopIndex2].ARPT.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Program[LoopIndex2].Reason.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Program[LoopIndex2].End_Time.XmlText#
								</td> 
							</tr>	
							</cfloop>
						  </table>
						</cfcase>
						<cfcase value="Ground_Delay_List">
						<div align=left class="body">&nbsp;GROUND DELAYS</div>
						  <table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr bgcolor="##CCE2FF">
								<cfloop list="Airport,Reason,Average,Maximum" delimiters="," index="ColName">
								<cfoutput>
									<td class="dataTable" nowrap><a href="javascript:void(0)" class="tabular">#ColName#</a></td>
								</cfoutput>
								</cfloop>
							</tr>	
							<cfloop index="LoopIndex2" from="1" to="#ArrayLen(myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Ground_Delay)#" step="1">
							<cfif tdColor EQ bgcolor>
								<cfset tdColor = bgColorAlt>
							<cfelse>
								<cfset tdColor = bgColor>
							</cfif>
							<tr>
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Ground_Delay[LoopIndex2].ARPT.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Ground_Delay[LoopIndex2].Reason.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Ground_Delay[LoopIndex2].Avg.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Ground_Delay[LoopIndex2].Max.XmlText#
								</td> 
							</tr>	
							</cfloop>
						  </table>
						</cfcase>
						<cfcase value="Arrival_Departure_Delay_List">
						<div align=left class="body">&nbsp;ARRIVAL/DEPARTURE DELAYS</div>
						  <table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr bgcolor="##CCE2FF">
								<cfloop list="Airport,Reason, Details (Arrival/Departure Min Max Trend)" delimiters="," index="ColName">
								<cfoutput>
									<td class="dataTable" nowrap><a href="javascript:void(0)" class="tabular">#ColName#</a></td>
								</cfoutput>
								</cfloop>
							</tr>	
							<cfloop index="LoopIndex2" from="1" to="#ArrayLen(myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Delay)#" step="1">
							<cfif tdColor EQ bgcolor>
								<cfset tdColor = bgColorAlt>
							<cfelse>
								<cfset tdColor = bgColor>
							</cfif>
							<tr>
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Delay[LoopIndex2].ARPT.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Delay[LoopIndex2].Reason.XmlText#
								</td> 
								<td class="dataTable" bgcolor="#tdColor#">
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Delay[LoopIndex2].Arrival_Departure.XmlAttributes.Type#
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Delay[LoopIndex2].Arrival_Departure.Min.XmlText# to 
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Delay[LoopIndex2].Arrival_Departure.Max.XmlText# and
									#myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].Delay[LoopIndex2].Arrival_Departure.Trend.XmlText#
								</td> 
							</tr>	
							</cfloop>
						  </table>
						</cfcase>
						<cfdefaultcase>List not found: #myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type[LoopIndex].XmlChildren[2].XmlName#<br></cfdefaultcase>
					</cfswitch>
					<div align=left class="body">&nbsp;</div>
				</cfloop>
				<div align=left class="body">&nbsp;&nbsp;Update Time: #myXMLDocument.AIRPORT_STATUS_INFORMATION.Update_Time.XmlText#</div>
			</cfoutput>			
		</cfif>	 
	</cfcase>

	<cfdefaultcase>

		<cfparam name="Export" default="0">
		<cfparam name="PrintVer" default="0">
		<cfparam name="ShowAll" default="0">
		
		
		<cfparam name="PageNum_getQuery" default="1">
		<cfparam name="MaxRows_getQuery" default="20">
		<cfparam name="LinkedCol" default="">
		<cfparam name="LinkedLoc" default="">
		<cfparam name="ColOrderBy" default="1">
		<cfparam name="ColOrderDir" default="ASC">
		
		
		
		<cfset StartRow_getQuery=Min((PageNum_getQuery-1)*MaxRows_getQuery+1,Max(getQuery.RecordCount,1))>
		<cfset EndRow_getQuery=Min(StartRow_getQuery+MaxRows_getQuery-1,getQuery.RecordCount)>
		<cfset TotalPages_getQuery=Ceiling(getQuery.RecordCount/MaxRows_getQuery)>

<!--- <cfoutput>#ColOrderBy#<br>RC:#getQuery.RecordCount#<br>S:#StartRow_getQuery#<br>E:#EndRow_getQuery#<br>T:#TotalPages_getQuery#<br></cfoutput> --->

	<cfif Export EQ 1>
		<CF_query2excel Query="getQuery" AlternatColor = "ff0000">
		<cfabort>
	</cfif>
	
	<cfif IsDefined("URL.ShowAll")>
		<cfset ShowAll = #URL.ShowAll#>
	</cfif>	

	<cfif ShowAll EQ 1>
		<cfset StartRow_getQuery = 1>
		<cfset EndRow_getQuery = getQuery.RecordCount>
	</cfif>	

	<cfif IsDefined("URL.PageNum_getQuery")>
		<cfset PageNum_getQuery = #URL.PageNum_getQuery#>
	</cfif>	


  
  <cfoutput>
  <form name="myForm" action="/#Request.const_default_htm#" method="post">
  
  
  <cfif PrintVer EQ 0>
  <div align=left>&nbsp; <BR>Showing #StartRow_getQuery#-#EndRow_getQuery# of #getQuery.RecordCount# | 
  
  
	<cfif (PageNum_getQuery GT 1) AND (ShowAll EQ 0)>
		  <span style="cursor:hand; cursor:pointer" onClick="myForm.action='/#Request.const_default_htm#?PageNum_getQuery=#Evaluate(PageNum_getQuery-1)###res';submit();">&lt; Prev</span> |
	<cfelse>
		<span style="color: ##666666">&lt; Prev</span> |  
	</cfif>

	<cfif (PageNum_getQuery LT TotalPages_getQuery) AND (ShowAll EQ 0)>
		  <span style="cursor:hand; cursor:pointer" onClick="myForm.action='/#Request.const_default_htm#?PageNum_getQuery=#Evaluate(PageNum_getQuery+1)###res';submit();">Next &gt;</span> |
	<cfelse>
		<span style="color: ##666666">Next &gt;</span> |  
	</cfif>
  
	
	<cfif ShowAll EQ 1>
		
		<cfset MaxRows_getQuery = getQuery.RecordCount>
		<span style="cursor:hand; cursor:pointer" onClick="myForm.action='/#Request.const_default_htm#?ShowAll=0##res';submit();">Show In Pages</span> |
	<cfelse>
		<span style="cursor:hand; cursor:pointer" onClick="myForm.action='/#Request.const_default_htm#?ShowAll=1##res';submit();">Show All</span> |
	</cfif>
			  
		  <span style="cursor:hand; cursor:pointer" onClick="myForm.action='/#Request.const_default_htm#?Export=1';submit();">Export to Excel</span> | 
		  
		  <span style="cursor:hand; cursor:pointer" onClick="myForm.action='/#Request.const_default_htm#?PrintVer=1';submit();">Printable Version</span> | <!--- added ShowAll=1##res --->
		  
		  <A href="##" onClick="expandcontent(this, 'omit')">Hide/Show Search Criteria</A>
  </div>
  
  
	<cfelse>
		<CFOUTPUT> 
		<cfif ShowAll EQ 1>
			<cfset MaxRows_getQuery = 200><!---TESTING --->
			 <cfset MaxRecords = getQuery.RecordCount><!---TESTING --->
		</cfif>
		<!--- <cfset MaxRows_getQuery = 200>TESTING --->
		<!--- <cfset MaxRecords = getQuery.RecordCount>TESTING --->
		<!--- SHOW ALL:#ShowAll# | MAX RECORDS:#MaxRecords# | START ROW:#StartRow_getQuery# | END ROW:#EndRow_getQuery# | MAX:#MaxRows_getQuery# TESTING --->
		<div align=left>
		&nbsp;<A class=navlink href="javascript:printit()">Click here to Print</a> |
		<span style="cursor:hand; cursor:pointer" onClick="myForm.action='/#Request.const_default_htm#?PrintVer=0';submit();">Return to Search</span>
		</div>
		</CFOUTPUT>
	</cfif>

		<input type="hidden" name="mID" value="#mID#">
		<input type="hidden" name="PAGENUM" value="#PAGENUM#">
		<input type="hidden" name="PERIODFROM" value="#PERIODFROM#">
		<input type="hidden" name="PERIODTO" value="#PERIODTO#">
		<input type="hidden" name="REPTYPE" value="#REPTYPE#">

		<input type="hidden" name="INTENSITY" value="#INTENSITY#">
		<input type="hidden" name="PTYPE" value="#PTYPE#">
		
		<cfif IsDefined("PTYPEOTHER")>
			<input type="hidden" name="PTYPEOTHER" value="#PTYPEOTHER#">
		</cfif>

		<input type="hidden" name="REGION" value="#REGION#">
		<input type="hidden" name="STATIONS" value="#STATIONS#">
<!--- 		<input type="hidden" name="wddxGetQuery" value="#wddxGetQuery#"> --->
		<input type="hidden" name="Submit" value="#Submit#">
		<input type="hidden" name="COLNAMELIST" value="#COLNAMELIST#">
		<input type="hidden" name="DoWDDX" value="1">
		<input type="hidden" name="ShowAll" value="#ShowAll#">
		<input type="hidden" name="PageNum_getQuery" value="#PageNum_getQuery#">

		<cfif IsDefined("FAKECHECKBOX_11")>
			<input type="hidden" name="FAKECHECKBOX_11" value="#FAKECHECKBOX_11#">
		</cfif>
		<cfif IsDefined("FAKECHECKBOX_12")>
			<input type="hidden" name="FAKECHECKBOX_12" value="#FAKECHECKBOX_12#">
		</cfif>
		<cfif IsDefined("FAKECHECKBOX_13")>
			<input type="hidden" name="FAKECHECKBOX_13" value="#FAKECHECKBOX_13#">
		</cfif>

	</form>			  
	</cfoutput>




	
		<cfparam name="LinkedCol" default="">
		<cfparam name="LinkedLoc" default="">
		<cfparam name="SpecialCol" default="0">
		<cfset bgColor = "white">
		<cfset bgColorAlt = "whitesmoke">
		<cfset SpecialbgColorAlt = "##0099FF">
		<cfset tdColor = bgColor>

	  <table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr bgcolor="#CCE2FF">
			<cfloop list="#ColNameList#" delimiters=";" index="ColName">
			<cfoutput>
				  <td class="dataTable" nowrap><a href="##" class="tabular">#ColName#</a></td>

			</cfoutput>
			</cfloop>
		</tr>	

		<cfset NumColumns = ListLen(ColNameList, ";")>
		<cfoutput query="getQuery" startrow="#StartRow_getQuery#" maxrows="#MaxRows_getQuery#">
			<cfif tdColor EQ bgcolor>
				<cfset tdColor = bgColorAlt>
			<cfelse>
				<cfset tdColor = bgColor>
			</cfif>
			<cfif SpecialCol GT 0>
				<CFIF #Evaluate("getQuery.Col_" & SpecialCol)# EQ "KWNI">
					<cfset tdColor = SpecialbgColorAlt>
				</CFIF>
			</cfif>
			<tr>
			<cfloop index="ColNum" from="1" to="#NumColumns#">
				<td class="dataTable" bgcolor="#tdColor#">
					#Evaluate("getQuery.Col_" & ColNum)#
				</td> 
			</cfloop>
			</tr>	
		</cfoutput>
              </table>
<!--- 			  <cfoutput><div align=left>&nbsp; <BR>Showing 1-10 of 2000 | <span style="color: ##666666">&lt; Prev</span> | <A href="##">Next</A> <A href="##">&gt;</A> | 


	<cfif IsDefined("URL.ShowAll")>
		<cfset MaxRows_getQuery = getQuery.RecordCount>
		<cfset tempPos=ListContainsNoCase(QueryString_getQuery,"ShowAll=","&")>
		<cfset tempQueryString_getQuery=ListDeleteAt(QueryString_getQuery,tempPos,"&")>
		<a href="#CurrentPage#?#tempQueryString_getQuery#">Show In Pages</a> |
	<cfelse>
		<a href="#CurrentPage#?ShowAll=1#QueryString_getQuery#">Show All</a> |
	</cfif>
			  
			  
			  
			  
			  <A href="#CurrentPage#?Export=1#QueryString_getQuery#">Export to Excel</A> | <A href="##" onClick="expandcontent(this, 'omit')">Hide/Show Search Criteria</A></div></cfoutput>
 --->	
	</cfdefaultcase>

</cfswitch>
			  
</cfif>			  
            </td>
			
            <td background="/images/content_frame_images/content_frame_right.gif"><img src="/images/spacer.gif" width="6" height="1" alt=""></td>
          </tr>
          <tr>
            <td><img src="/images/content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
            <td width="100%" background="/images/content_frame_images/content_frame_bottom.gif"><img src="/images/spacer.gif" width="1" height="7" alt=""></td>
            <td><img src="/images/content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
          </tr>
        </table>
