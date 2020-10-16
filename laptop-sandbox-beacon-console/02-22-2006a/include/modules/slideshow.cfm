<!----------------------------------------------------------------------------------
	Name        : slideshow.cfm
	Author      : Rocky Madden
	Website     : http://www.coldfusion-mx.com
	Description : Simple slideshow automation tag
	Date Started: 2004.07.12
	Last Updated: 2004.09.14
	Version     : 1.00
	Attributes  :
								Path - (Default: Current Directory)
									The full path name to the directory you wish to make into a 
									slideshow.
								URLPath - (Default: Current Web Directory)
									The full URL to the image directory. This allows the tag to
									create valid web links to the images.
								TableWidth - (Default: 500)
									The width of the entire table. You can set it for pixels or
									a percentage.
								TableHeight - (Default: 200)
									The height of the entire table. You can set it for pixels or
									a percentage.
								PageColor - (Default: CCCCCC)
									The background color of the web page. Do NOT include pound signs.
								BorderColor - (Default: 000000)
									The color of the borders for the table and horizontal rules.
								  Do NOT include pound signs.
								TableColor - (Default: 999999)
									The background color of the table. Do NOT include pound signs.
								LinkColor - (Default: 333333)
									The link color. Do NOT include pound signs.
								HeaderColor - (Default: 000000)
									The header text color. Do NOT include pound signs.
----------------------------------------------------------------------------------->

<!----------------------------------------------------------------------------------
	***COPYRIGHT INFORMATION BELOW***
	
	Copyright (C) 2004  Fuse Design & Rocky Madden
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
----------------------------------------------------------------------------------->

<!----------------------------------------------------------------------------------
	Remove ability for web users to view the tag directly. Just incase the tag is in 
	a web viewable directory.
----------------------------------------------------------------------------------->
<cfif FindNoCase("slideshow.cfm", CGI.SCRIPT_NAME) NEQ 0>
	<center>Direct Tag Access Not Allowed</center>
	<cfabort>
</cfif>

<!----------------------------------------------------------------------------------
	Set tag attributes. Path is the only required attribute.
----------------------------------------------------------------------------------->
<cftry>
	<cfparam name="ATTRIBUTES.Path" type="string" default="#ExpandPath("./")#">
	<cfparam name="ATTRIBUTES.URLPath" type="string" default="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##Reverse(Mid(Reverse(CGI.SCRIPT_NAME),Find("/",Reverse(CGI.SCRIPT_NAME)),Len(CGI.SCRIPT_NAME)))#">
	<cfparam name="ATTRIBUTES.TableWidth" type="numeric" default="500">
	<cfparam name="ATTRIBUTES.TableHeight" type="numeric" default="200">
	<cfparam name="ATTRIBUTES.PageColor" type="string" default="CCCCCC">
	<cfparam name="ATTRIBUTES.BorderColor" type="string" default="000000">
	<cfparam name="ATTRIBUTES.TableColor" type="string" default="999999">
	<cfparam name="ATTRIBUTES.LinkColor" type="string" default="333333">
	<cfparam name="ATTRIBUTES.HeaderColor" type="string" default="000000">

<!----------------------------------------------------------------------------------
	Miscellaneous param variables. ID is image location in the list, and delay is the
	delay between refreshes during the slideshow automation.
----------------------------------------------------------------------------------->
	<cfparam name="URL.ID" type="numeric" default="1">
	<cfparam name="URL.Delay" type="numeric" default="3">
	
	<cfcatch type="any">
		<center>Invalid Parameter</center>
		<cfabort>
	</cfcatch>
</cftry>

<cfoutput>
#ATTRIBUTES.Path#<br>
#ATTRIBUTES.URLPath#<br>
#ATTRIBUTES.TableWidth#<br>
#ATTRIBUTES.TableHeight#<br>
#ATTRIBUTES.PageColor#<br>
#ATTRIBUTES.BorderColor#<br>

</cfoutput>
<!----------------------------------------------------------------------------------
	Retrieve all files/dirs from the directory specified. Note the use of cftry to 
	catch cfdirectory errors.
----------------------------------------------------------------------------------->
<cftry>
	<cfdirectory action="LIST" directory="#ATTRIBUTES.Path#" name="DirectoryListing" sort="type, name">
	
	<cfcatch type="any">
		<center>CFDIRECTORY Tag Disabled</center>
		<cfabort>
	</cfcatch>
</cftry>

<!----------------------------------------------------------------------------------
	Query of queries for the dataset returned by the cfdirectory tag. This query will 
	remove all sub-directories and display files with valid image file extentions.
	Throw an error if there are no images for the slide show.
----------------------------------------------------------------------------------->
<cftry>
	<cfquery dbtype="query" name="VARIABLES.SlideShow">
		SELECT Type, Name
		FROM DirectoryListing
		WHERE Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="File">
		AND
		(  Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%.gif">
		OR Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%.jpg">
		OR Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%.bmp">
		OR Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%.png">)
		ORDER BY Name ASC
	</cfquery>
	
	<cfif VARIABLES.SlideShow.RecordCount EQ 0>
		<cfthrow type="custom_type" detail="No Images Found">
	</cfif>
	
	<cfcatch type="any">
		<center>No Images Found</center>
		<cfabort>
	</cfcatch>
</cftry>

<!----------------------------------------------------------------------------------
	The resulting query is now turned into a list for URL variable retrival. An image 
	count is also taken for error throwing (if the URL variable is too large).
----------------------------------------------------------------------------------->
<cfset VARIABLES.ImageNames = ValueList(VARIABLES.SlideShow.Name,",")>
<cfset VARIABLES.ImageCount = ListLen(VARIABLES.ImageNames,",")>

<!----------------------------------------------------------------------------------
	Retrieve the image file name corrisponding the URL variable. If the URL variable
	is too large or small they are redirected to the lower or upper limit.
----------------------------------------------------------------------------------->
<cftry>
	<cfset VARIABLES.CurrentImage = ListGetAt(VARIABLES.ImageNames,URL.ID,",")>
	
	<cfcatch type="any">
		<cfif URL.ID LT 1>
			<cflocation addtoken="no" url="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#VARIABLES.ImageCount#">
		<cfelseif URL.ID GT VARIABLES.ImageCount>
			<cflocation addtoken="no" url="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=1">
		</cfif>
	</cfcatch>
</cftry>

<!----------------------------------------------------------------------------------
	HTML output start.
----------------------------------------------------------------------------------->
<cfoutput>
	<html>
		<head>
			<title>Slide Show (#ATTRIBUTES.URLPath#)</title>
			<!----------------------------------------------------------------------------
				Use meta refresh for slideshow functionality.
			----------------------------------------------------------------------------->
			<cfif IsDefined("URL.Slideshow")>
				<META HTTP-EQUIV=Refresh CONTENT="#URL.Delay#;URL=http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#Evaluate('#URL.ID# + 1')#&slideshow=1&delay=#URL.Delay#">
			</cfif>
			<style>
				.contentblock 
				{
					background-color: ###ATTRIBUTES.TableColor#;
					border: 2px solid ###ATTRIBUTES.BorderColor#;
				}
				.link
				{
					color: ###ATTRIBUTES.LinkColor#;
					text-decoration:none;
					font-weight:bold;
					font-size:11;
					font-family:Arial, Helvetica, sans-serif;
				}
				.link:hover{text-decoration:underline;}
				.header
				{
					color: ###ATTRIBUTES.HeaderColor#;
					text-decoration:none;
					font-weight:normal;
					font-size:11;
					font-family:Arial, Helvetica, sans-serif;
				}
			</style>
		</head>
		<body bgcolor="#ATTRIBUTES.PageColor#">
			<table width="#ATTRIBUTES.TableWidth#" border="0" align="center" cellpadding="0" cellspacing="0" class="contentblock">
				<tr>
					<td align="center"><font class="header"><strong>#VARIABLES.CurrentImage#</strong></font></td>
				</tr>
				<tr>
					<td align="center"><font class="header">Image #URL.ID# of #VARIABLES.ImageCount#</font><hr noshade color="###ATTRIBUTES.BorderColor#"></td>
				</tr>
				<tr>
					<!------------------------------------------------------------------------
						Create an image link to the file.
					------------------------------------------------------------------------->
					<td align="center" height="#ATTRIBUTES.TableHeight#"><a href="#ATTRIBUTES.URLPath##VARIABLES.CurrentImage#"><img border="0" src="#ATTRIBUTES.URLPath##VARIABLES.CurrentImage#" alt="#VARIABLES.CurrentImage#"></a></td>
				</tr>
				<tr>
					<td><hr noshade color="###ATTRIBUTES.BorderColor#"></td>
				</tr>
				<tr>
					<!------------------------------------------------------------------------
						Navagation between images.
					------------------------------------------------------------------------->
					<td align="center">
						<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=1" title="Starting Image" class="link">&lt;&lt;</a>
						&nbsp;
						<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#Evaluate('#URL.ID# - 1')#" title="Previous Image" class="link">&lt;</a>
						&nbsp;
						<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#URL.ID#" title="Stop Slide Show" class="link">Stop</a>
						&nbsp;
						<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#Evaluate('#URL.ID# + 1')#" title="Next Image" class="link">&gt;</a>
						&nbsp;
						<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#VARIABLES.ImageCount#" title="Ending Image" class="link">&gt;&gt;</a>
					</td>
				</tr>
				<tr>
					<!------------------------------------------------------------------------
						Slide show controls.
					------------------------------------------------------------------------->
					<td align="center">
						<font class="header">
							<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#URL.ID#&slideshow=1&delay=10" title="Start Slow Slide Show" class="link">Slow</a>
							<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#URL.ID#&slideshow=1&delay=5" title="Start Medium Slide Show" class="link">Medium</a>
							<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#URL.ID#&slideshow=1&delay=2" title="Start Fast Slide Show" class="link">Fast</a>
							<a href="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##CGI.SCRIPT_NAME#?id=#URL.ID#&slideshow=1&delay=1" title="Start Instant Slide Show" class="link">Instant</a>
						</font>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</body>
	</html>
</cfoutput>
<!----------------------------------------------------------------------------------
	End slideshow.cfm
----------------------------------------------------------------------------------->