<!--- SearchResults

Created: 24 June 2004 by Ioannis Kritikopoulos
Purpose:  Returns the results of any query formatted and with the ability to do one page or broken by pages.
		Also allows fro having one or mor ecolumsn linked.
		Added sorting also ASC and DESC on any column.

You have to set up the following prior to the call:
getQuery: the query name
ColNameList: a listof all the column names
COl_1, Col_2: the names of the columns of the query.

Optional:
MaxRows_getQuery: number of items on a page
LinkedCol: list of column numbers to be linked
LinkedLoc: list of linked locations
ColOrderBy: order by column
ColOrderDir: ASC or DESC
 --->
 

<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<cfparam name="PageNum_getQuery" default="1">
<cfparam name="MaxRows_getQuery" default="15">
<cfparam name="LinkedCol" default="">
<cfparam name="LinkedLoc" default="">
<cfparam name="ColOrderBy" default="1">
<cfparam name="ColOrderDir" default="ASC">

<cfset StartRow_getQuery=Min((PageNum_getQuery-1)*MaxRows_getQuery+1,Max(getQuery.RecordCount,1))>
<cfset EndRow_getQuery=Min(StartRow_getQuery+MaxRows_getQuery-1,getQuery.RecordCount)>
<cfset TotalPages_getQuery=Ceiling(getQuery.RecordCount/MaxRows_getQuery)>
<cfset QueryString_getQuery=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_getQuery,"PageNum_getQuery=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_getQuery=ListDeleteAt(QueryString_getQuery,tempPos,"&")>
</cfif>
<cfset tempPos2=ListContainsNoCase(QueryString_getQuery,"PageNum=","&")>
<cfif tempPos2 EQ 0>
  <cfset QueryString_getQuery=ListAppend(QueryString_getQuery,"PageNum=2","&")>
</cfif>
<cfset tempPos3=ListContainsNoCase(QueryString_getQuery,"ColOrderBy=","&")>
<cfif tempPos3 EQ 0>
  <cfset QueryString_getQuery=ListAppend(QueryString_getQuery,"ColOrderBy=#ColOrderBy#&ColOrderDir=ASC","&")>
</cfif>
<cfset tempPos4=ListContainsNoCase(QueryString_getQuery,"Stations=","&")>
<cfif tempPos4 EQ 0>
  <cfset QueryString_getQuery=ListAppend(QueryString_getQuery,"Stations=#Stations#","&")>
</cfif>
<cfset tempPos5=ListContainsNoCase(QueryString_getQuery,"Region=","&")>
<cfif tempPos5 EQ 0>
  <cfset QueryString_getQuery=ListAppend(QueryString_getQuery,"Region=#Region#","&")>
</cfif>
<cfset tempPos6=ListContainsNoCase(QueryString_getQuery,"repType=","&")>
<cfif tempPos6 EQ 0>
  <cfset QueryString_getQuery=ListAppend(QueryString_getQuery,"repType=#repType#","&")>
</cfif>
<cfset tempPos7=ListContainsNoCase(QueryString_getQuery,"PeriodFrom=","&")>
<cfif tempPos7 EQ 0>
  <cfset QueryString_getQuery=ListAppend(QueryString_getQuery,"PeriodFrom=#PeriodFrom#","&")>
</cfif>
<cfset tempPos8=ListContainsNoCase(QueryString_getQuery,"PeriodTo=","&")>
<cfif tempPos8 EQ 0>
  <cfset QueryString_getQuery=ListAppend(QueryString_getQuery,"PeriodTo=#PeriodTo#","&")>
</cfif>

<!--- <cfoutput>#ColOrderBy#<br>#QueryString_getQuery#<br></cfoutput> --->

<cfset MenuColorOn = "FFFF66">
<cfset MenuColorAvail = "FFFFFF">
<cfset MenuColorNotAvail = "CCCCCC">
<cfset ResultsBgColor = "Beige">
<cfset HeaderBgColor = "PaleGoldenrod">

<cfset bgColor = "white">
<cfset bgColorAlt = "whitesmoke">
<cfset tdColor = bgColor>


<cfoutput>
<table cellpadding="3" cellspacing="0" border="0" width="100%" bgcolor="##FFFFFF">
	<tr>
		<td>
			<table cellpadding="3" cellspacing="0" border="0" width="98%" align="center">
				<tr align="right" valign="middle" bgcolor="#ResultsBgColor#">
				<td class="r">&nbsp;</td>
				<td class="r" width="15%">
						<a href="#CurrentPage#?Export=1#QueryString_getQuery#">Export-2-Excel</a>
				</td>
				<td class="r" width="15%">
					<cfif IsDefined("URL.ShowAll")>
						<cfset MaxRows_getQuery = getQuery.RecordCount>
						<cfset tempPos=ListContainsNoCase(QueryString_getQuery,"ShowAll=","&")>
						<cfset tempQueryString_getQuery=ListDeleteAt(QueryString_getQuery,tempPos,"&")>
						<a href="#CurrentPage#?#tempQueryString_getQuery#">Show In Pages</a>
					<cfelse>
						<a href="#CurrentPage#?ShowAll=1#QueryString_getQuery#">Show All</a>
					</cfif>
				</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table cellpadding="3" cellspacing="0" border="0" width="98%" align="center">
				<tr align="left" valign="middle" bgcolor="#HeaderBgColor#">
					<cfloop list="#ColNameList#" delimiters=";" index="ColName">
					<cfoutput>
						<td class="apixelBigger">
						<cfif ColOrderBy EQ ListFind(ColNameList,ColName,";")> <!--- Sort on column --->
							<cfif ColOrderDir EQ 'ASC'>
								<cfset goWhere = Replace(QueryString_getQuery,'ColOrderDir=ASC','ColOrderDir=DESC')>
								<a href="#CurrentPage#?#goWhere#">#ColName#</a> <img src="<cfoutput>#Request.imagesPrefix#</cfoutput>up.gif" border="0" align="absmiddle">
							<cfelse>
								<cfset goWhere = Replace(QueryString_getQuery,'ColOrderDir=DESC','ColOrderDir=ASC')>
								<a href="#CurrentPage#?#goWhere#">#ColName#</a> <img src="<cfoutput>#Request.imagesPrefix#</cfoutput>down.gif" border="0" align="absmiddle">
							</cfif>
						<cfelse>
							<cfset tempPos = ListContainsNoCase(QueryString_getQuery,"ColOrderBy=","&")>
							<cfif tempPos NEQ 0>
								<cfset goWhere = ListDeleteAt(QueryString_getQuery,tempPos,"&")>
								<cfset goWhere = ListAppend(goWhere,'ColOrderBy=#ListFind(ColNameList,ColName,";")#',"&")>
							<cfelse>
								<cfset goWhere = QueryString_getQuery & '&ColOrderBy=' & #ListFind(ColNameList,ColName,";")# & '&ColOrderDir=ASC' >
							</cfif>
							<a href="#CurrentPage#?#goWhere#">#ColName#</a>
						</cfif>
						</td>
					</cfoutput>
					</cfloop>
				</tr>	
				</cfoutput>
				<cfset NumColumns = ListLen(ColNameList, ";")>
				<cfoutput query="getQuery" startRow="#StartRow_getQuery#"  maxRows="#MaxRows_getQuery#">
					<cfif tdColor EQ bgcolor>
						<cfset tdColor = bgColorAlt>
					<cfelse>
						<cfset tdColor = bgColor>
					</cfif>
				<tr align="left" valign="middle">
					<cfloop index="ColNum" from="1" to="#NumColumns#">
						<td class="r" bgcolor="#tdColor#">
						<cfif ListFind(LinkedCol,ColNum)>
							<cfset goLink = #ListGetAt(LinkedLoc,ListFind(LinkedCol,ColNum))#>
							<cfset tempLink = "ID=" & #Evaluate("getQuery.Col_" & ColNum)#>
							<cfset goLink = #ListAppend(goLink,tempLink,"&")#>
							<a href="#goLink#">#Evaluate("getQuery.Col_" & ColNum)#</a>
						<cfelse>
							#Evaluate("getQuery.Col_" & ColNum)#
						</cfif>
						</td> 
					</cfloop>
				</cfoutput>
				</tr>
			</table>			
		</td>
	</tr>
	<tr>
		<td>
			<cfoutput>
			<cfif NOT IsDefined("URL.ShowAll")>
			<table border="0" width="50%" align="center">
				<tr><td colspan="5" height="10"></td></tr>
				<tr>
				  <td width="13%" align="center">
					<cfif PageNum_getQuery GT 1>
					  <a href="#CurrentPage#?PageNum_getQuery=1#QueryString_getQuery#"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>First.gif" border=0></a>
					</cfif>
				  </td>
				  <td width="13%" align="center">
					<cfif PageNum_getQuery GT 1>
					  <a href="#CurrentPage#?PageNum_getQuery=#Max(DecrementValue(PageNum_getQuery),1)##QueryString_getQuery#"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>Previous.gif" border=0></a>
					</cfif>
				  </td>
				  <td class="s" align="center">Records #StartRow_getQuery#-#EndRow_getQuery# of #getQuery.RecordCount#</td>
				  <td width="13%" align="center">
					<cfif PageNum_getQuery LT TotalPages_getQuery>
					  <a href="#CurrentPage#?PageNum_getQuery=#Min(IncrementValue(PageNum_getQuery),TotalPages_getQuery)##QueryString_getQuery#"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>Next.gif" border=0></a>
					</cfif>
				  </td>
				  <td width="13%" align="center">
					<cfif PageNum_getQuery LT TotalPages_getQuery>
					  <a href="#CurrentPage#?PageNum_getQuery=#TotalPages_getQuery##QueryString_getQuery#"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>Last.gif" border=0></a>
					</cfif>
				  </td>
				</tr>
			  </table>
			</cfif>		
		</td>
	</tr>
</table>
</cfoutput>



