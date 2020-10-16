<html>
<head>
 <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<!--- <cfset currLoc = "3/01\">
<cfset currMaxFrame = "1">
<cfset currTitle = "Weathernews BEACON">
<cfset imgRoot = "/images/products/">
<cfset ImageList = "">
<cfset ImageNameList = "">
<cfset imgWidth = "720">
<cfset imgHeight = "540">
<cfset currMap = "1">
 --->
<cfparam name="PageNum" default="1">

<cfif IsDefined("URL.uTitle")>
	<cfset currTitle = "#URL.uTitle#">
</cfif>

<cfif IsDefined("URL.uLoc")>
	<cfset currLoc = "#URL.uLoc#">
</cfif>

<cfif IsDefined("URL.uMax")>
	<cfset currMaxFrame = "#URL.uMax#">
</cfif>

<cfif IsDefined("URL.uW")>
	<cfset imgWidth = "#URL.uW#">
</cfif>

<cfif IsDefined("URL.uH")>
	<cfset imgHeight = "#URL.uH#">
</cfif>

<cfif IsDefined("URL.uMap")>
	<cfset currMap = "#URL.uMap#">
</cfif>


<cfif PageNum EQ 1>

	<cfset winWidth = imgWidth + 60>  <!--- compensate for top navigation --->
	<cfset winHeight = imgHeight + 100>
	
	<cfset resWidth = imgWidth + 120>  <!--- compensate for top navigation --->
	<cfset resHeight = imgHeight + 180>
	
	<cfif winHeight GTE (750) >
		<cfset factor = (imgWidth / 650)>
		<cfset imgWidth = 650>
		<cfset imgHeight =  ROUND((imgHeight / factor))>
		<cfset winWidth = imgWidth + 60>  <!--- compensate for top navigation --->
		<cfset winHeight = imgHeight + 100>
	</cfif>

</cfif>


<title><cfoutput>#currTitle#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="/include/css/text_attributes.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
function MM_closeBrWindow() { //v3.0
   close();
}

function printit(){  
if (window.print) {
    window.print() ;  
} else {
    var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
	document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
    WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
}
}

//-->
</script>

<script language="JavaScript"> 
<!-- Begin
function Maximize(pW,pH) {
	
window.moveTo(0,0); 

if (pW < 100)
	sW = (screen.availWidth / 1.5);
else {
	if (pW >= screen.availWidth)
		sW = screen.availWidth;
	else 
		sW = pW;
	}

if (pH < 100)
	sH = (screen.availHeight / 1.5);
else {
	if (pH >= screen.availHeight)
		sH = screen.availHeight;
	else
		sH = pH;	
	}

if (document.all)  //IE 4+
	window.resizeTo(sW,sH); 	
else 
	if (document.layers||document.getElementById) //NS 4+
	{
		window.outerHeight = sH; 	
		window.outerWidth = sW; 	
	}
	
}
//  End -->
</script>
</head>

<cfoutput>
<cfif PageNum EQ 1>
	<body bgcolor="##ffffff" link="##99ccff" vlink="##99ccff" alink="##99ccff" marginheight="0" marginwidth="0" onLoad="Maximize(#resWidth#,#resHeight#);">
<cfelse>
	<body bgcolor="##ffffff" link="##99ccff" vlink="##99ccff" alink="##99ccff" marginheight="0" marginwidth="0">
</cfif>
</cfoutput>




<cfoutput>

<cfswitch expression="#currMap#">
	<cfcase value="1">
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><img src="#currLoc#" alt="" border="0"></td>
		  </tr>	
		</table>
	</cfcase>
	<cfcase value="2">
		<cflocation url="#currLoc#">
	</cfcase>
	<cfcase value="3">
		<cfset TimesList = "0Z|00;6Z|06;12Z|12;18Z|18;24Z|24;30Z|30;36Z|36;42Z|42;48Z|48">
		<cfset FlightList = "050,100,180,240,300,340,390,450">
		<cfparam name="FltLevel" default="300">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
		  <form action="imgNav2.cfm" method="post">
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Flight Level:&nbsp;&nbsp;
			<cfloop list="#FlightList#" index="FLTLoopIndex">
			<cfoutput>
					<input type="radio" name="FltLevel" value="#FLTLoopIndex#" onClick="submit();" <cfif FltLevel EQ FLTLoopIndex>checked</cfif>>#FLTLoopIndex#
			</cfoutput>			
			</cfloop>
			</td>
		  </tr>
		  <cfoutput>
		  	<input type="hidden" name="currLoc" value="#currLoc#">
		  	<input type="hidden" name="PageNum" value="2">
		  	<input type="hidden" name="currTitle" value="#currTitle#">
		  	<input type="hidden" name="currMap" value="#currMap#">
		  </cfoutput>
		  </form>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Forecast Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="TimesLoopIndex" delimiters=";">
			<cfset TimeFile = ListGetAt(TimesLoopIndex,1,"|")>
			<cfset TimeDisplay = ListGetAt(TimesLoopIndex,2,"|")>
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/MCIDAS/charts/UL_WINDS_FL_#FltLevel#_#TimeFile#_#currLoc#.gif'">#TimeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/MCIDAS/charts/UL_WINDS_FL_#FltLevel#_0Z_#currLoc#.GIF" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>
	<cfcase value="4">
		<cfset RegionsList = "GULF|Gulf of Mexico;TATL|Tropical Atlantic;WATL|Western Atlantic;WPAC|Western Pacific;CPAC|Central Pacific;EPAC|Eastern Pacific">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp;<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Region:&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#RegionsList#" index="RegionsLoopIndex" delimiters=";">
			<cfset RegionFile = ListGetAt(RegionsLoopIndex,1,"|")>
			<cfset RegionDisplay = ListGetAt(RegionsLoopIndex,2,"|")>
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/INTERNAL/TROP_#RegionFile#.jpg'">#RegionDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/INTERNAL/TROP_#ListFirst(RegionFile)#.jpg" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>
	
	<cfcase value="5">
		<cfset TimesList = "00,06,12,18,24">
		<cfset FlightList = "300,340,390">
		<cfparam name="FltLevel" default="300">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp;<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
		  <form action="imgNav2.cfm" method="post">
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Flight Level:&nbsp;&nbsp;
			<cfloop list="#FlightList#" index="FLTLoopIndex">
			<cfoutput>
					<input type="radio" name="FltLevel" value="#FLTLoopIndex#" onClick="submit();" <cfif FltLevel EQ FLTLoopIndex>checked</cfif>>#FLTLoopIndex#
			</cfoutput>			
			</cfloop>
			</td>
		  </tr>
		  <cfoutput>
		  	<input type="hidden" name="currLoc" value="#currLoc#">
		  	<input type="hidden" name="PageNum" value="2">
		  	<input type="hidden" name="currTitle" value="#currTitle#">
		  	<input type="hidden" name="currMap" value="#currMap#">
		  </cfoutput>
		  </form>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Valid Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="timeDisplay">
			
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/INTERNAL/FUEL_FRZ_TATL_#FltLevel#_#timeDisplay#.jpg'">#timeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/INTERNAL/FUEL_FRZ_TATL_#FltLevel#_00.jpg" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>
	
	<cfcase value="6">
		<cfset TimesList = "00,06,12,18,24">
		<cfset FlightList = "100">
		<cfparam name="FltLevel" default="100">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp;<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
		  <form action="imgNav2.cfm" method="post">
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Flight Level:&nbsp;&nbsp;
			<cfloop list="#FlightList#" index="FLTLoopIndex">
			<cfoutput>
					<input type="radio" name="FltLevel" value="#FLTLoopIndex#" onClick="submit();" <cfif FltLevel EQ FLTLoopIndex>checked</cfif>>#FLTLoopIndex#
			</cfoutput>			
			</cfloop>
			</td>
		  </tr>
		  <cfoutput>
		  	<input type="hidden" name="currLoc" value="#currLoc#">
		  	<input type="hidden" name="PageNum" value="2">
		  	<input type="hidden" name="currTitle" value="#currTitle#">
		  	<input type="hidden" name="currMap" value="#currMap#">
		  </cfoutput>
		  </form>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Valid Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="timeDisplay">
			
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/INTERNAL/DD_ICING_TATL_#FltLevel#_#timeDisplay#.jpg'">#timeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/INTERNAL/DD_ICING_TATL_#FltLevel#_00.jpg" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>

	<cfcase value="7">
		<cfset TimesList = "00,06,12,18,24">
		<cfset FlightList = "100">
		<cfparam name="FltLevel" default="100">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp;<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
<!--- 		  <form action="imgNav2.cfm" method="post">
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Flight Level:&nbsp;&nbsp;
			<cfloop list="#FlightList#" index="FLTLoopIndex">
			<cfoutput>
					<input type="radio" name="FltLevel" value="#FLTLoopIndex#" onClick="submit();" <cfif FltLevel EQ FLTLoopIndex>checked</cfif>>#FLTLoopIndex#
			</cfoutput>			
			</cfloop>
			</td>
		  </tr>
		  <cfoutput>
		  	<input type="hidden" name="currLoc" value="#currLoc#">
		  	<input type="hidden" name="PageNum" value="2">
		  	<input type="hidden" name="currTitle" value="#currTitle#">
		  	<input type="hidden" name="currMap" value="#currMap#">
		  </cfoutput>
		  </form>
 --->		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Valid Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="timeDisplay">
			
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/INTERNAL/FRZLV_TATL_#timeDisplay#.jpg'">#timeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/INTERNAL/FRZLV_TATL_00.jpg" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>
	
	<cfcase value="8">
		<cfset TimesList = "00,06,12,18,24">
		<cfset FlightList = "100">
		<cfparam name="FltLevel" default="100">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp;<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
<!--- 		  <form action="imgNav2.cfm" method="post">
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Flight Level:&nbsp;&nbsp;
			<cfloop list="#FlightList#" index="FLTLoopIndex">
			<cfoutput>
					<input type="radio" name="FltLevel" value="#FLTLoopIndex#" onClick="submit();" <cfif FltLevel EQ FLTLoopIndex>checked</cfif>>#FLTLoopIndex#
			</cfoutput>			
			</cfloop>
			</td>
		  </tr>
		  <cfoutput>
		  	<input type="hidden" name="currLoc" value="#currLoc#">
		  	<input type="hidden" name="PageNum" value="2">
		  	<input type="hidden" name="currTitle" value="#currTitle#">
		  	<input type="hidden" name="currMap" value="#currMap#">
		  </cfoutput>
		  </form> --->
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Valid Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="timeDisplay">
			
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/INTERNAL/TROPO_TATL_#timeDisplay#.jpg'">#timeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/INTERNAL/TROPO_TATL_00.jpg" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>

	<cfcase value="9">
		<cfset TimesList = "06,12">
		<cfif NOT COMPARENOCASE(currLoc,"FPG_US")>
			<cfset TimesList = "03,06,09,12">
		</cfif>	
		<cfset FlightList = "100">
		<cfparam name="FltLevel" default="100">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp;<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
<!--- 		  <form action="imgNav2.cfm" method="post">
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Flight Level:&nbsp;&nbsp;
			<cfloop list="#FlightList#" index="FLTLoopIndex">
			<cfoutput>
					<input type="radio" name="FltLevel" value="#FLTLoopIndex#" onClick="submit();" <cfif FltLevel EQ FLTLoopIndex>checked</cfif>>#FLTLoopIndex#
			</cfoutput>			
			</cfloop>
			</td>
		  </tr>
		  <cfoutput>
		  	<input type="hidden" name="currLoc" value="#currLoc#">
		  	<input type="hidden" name="PageNum" value="2">
		  	<input type="hidden" name="currTitle" value="#currTitle#">
		  	<input type="hidden" name="currMap" value="#currMap#">
		  </cfoutput>
		  </form>
 --->		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Valid Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="timeDisplay">
			
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/INTERNAL/#currLoc#_#timeDisplay#.jpg'">#timeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/INTERNAL/#currLoc#_#ListFirst(TimesList)#.jpg" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>

	<cfcase value="10">
		<cfset TimesList = "0Z|00;6Z|06;12Z|12;18Z|18;24Z|24;30Z|30;36Z|36;42Z|42;48Z|48">
		<cfset FlightList = "050,100,180,240,300,340,390,450">
		<cfparam name="FltLevel" default="300">
			
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
		  <form action="imgNav2.cfm" method="post">
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Flight Level:&nbsp;&nbsp;
			<cfloop list="#FlightList#" index="FLTLoopIndex">
			<cfoutput>
					<input type="radio" name="FltLevel" value="#FLTLoopIndex#" onClick="submit();" <cfif FltLevel EQ FLTLoopIndex>checked</cfif>>#FLTLoopIndex#
			</cfoutput>			
			</cfloop>
			</td>
		  </tr>
		  <cfoutput>
		  	<input type="hidden" name="currLoc" value="#currLoc#">
		  	<input type="hidden" name="PageNum" value="2">
		  	<input type="hidden" name="currTitle" value="#currTitle#">
		  	<input type="hidden" name="currMap" value="#currMap#">
		  </cfoutput>
		  </form>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Forecast Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="TimesLoopIndex" delimiters=";">
			<cfset TimeFile = ListGetAt(TimesLoopIndex,1,"|")>
			<cfset TimeDisplay = ListGetAt(TimesLoopIndex,2,"|")>
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/MCIDAS/charts/UL_WIND_TMP_FL_#FltLevel#_#TimeFile#_#currLoc#.gif'">#TimeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/MCIDAS/charts/UL_WIND_TMP_FL_#FltLevel#_0Z_#currLoc#.GIF" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	
	</cfcase>

	<cfcase value="11">
		<cfset TimesList = "00,06,12,18,24,36,48">
		
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="##FFFFFF">
		  <tr>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
			<td width="196" align="left" colspan="2" rowspan="2"><img src="/images/login_images/title.gif" alt="Weathernews BEACON" width="485" height="72"></td>
			<td><img src="/images/spacer.gif" height="30" alt=""></td>
			<td width="5" rowspan="2"><img src="/images/spacer.gif" width="5" height="50" alt=""></td>
		  </tr>
		  <tr>
			<td align="right" valign="bottom">
			<A class=navlink href="javascript:printit()">Print</a>&nbsp;|&nbsp;<a class=navlink href="javascript:location.reload()">Refresh</a>&nbsp;|&nbsp;<a href="javascript:void(0);"  onMouseDown="MM_closeBrWindow();">Close</a></td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2">Valid Times (Hr):&nbsp;&nbsp;
			<span style="font-size:12px">
			<cfloop list="#TimesList#" index="timeDisplay">
			
			<cfoutput>
					<a href="javascript:void(0)" onMouseOver="document.bigDisplay.src='/INTERNAL/#currLoc#_#timeDisplay#.jpg'">#timeDisplay#</a>&nbsp;
			</cfoutput>			
			</cfloop>
			</span>
			</td>
		  </tr>
		  <tr>
			<td><img src="/images/spacer.gif" height="10" alt=""></td>
			<td colspan="2"><img src="/images/spacer.gif" height="10" alt=""></td>
		  </tr>
		  <tr>
			<td colspan="4" align="center"><cfoutput><img src="/INTERNAL/#currLoc#_#ListFirst(TimesList)#.jpg" alt="" border="0" name="bigDisplay"></cfoutput></td>
		  </tr>	
		</table>
	</cfcase>
	
	
	
	
	
</cfswitch>



</cfoutput>
<!--- 
			<cfset FilesDirectory = GetDirectoryFromPath(GetTemplatePath()) & "images\products\" & "#currLoc#">
<!--- 			<cfoutput>#FilesDirectory#</cfoutput> --->
			<cfdirectory directory="#GetDirectoryFromPath(FilesDirectory)#" 
				action="list" 
	   			name="myDirectory"
				sort="dateLastModified DESC">
				
  			<cfloop query="myDirectory" startrow="1" endrow="#currMaxFrame#">
					<cfset ImageList = ListPrepend(ImageList,"#imgRoot##currLoc##Name#")>
			</cfloop>
			
  			<cfloop list="#ImageList#" index="IL">
				<cfset ImageNameList = ListAppend(ImageNameList,MID(IL,Find("\",IL)+1,Len(IL)-Find("\",IL)-4))>
			</cfloop>

			
<CFIF ListLen(ImageList) GT 0>
<cfoutput>


<applet code="AniS.class" codebase="/java" width="#winWidth#" height="#winHeight#">
<cfif ListLen(ImageList) EQ 1> 
	<param name="controls" value="refresh, zoom, framelabel">
<cfelse>
	<param name="controls" value="startstop, step, speed, refresh, framelabel, toggle, zoom">
	<PARAM name="start_looping" value="false">
	<PARAM name="start_frame" value="#ListLen(ImageList)-1#">
	<PARAM name="rate" value="30">
	<PARAM name="minimum_dwell" value="30">
	<PARAM name="pause" value="1000">
</cfif>
<PARAM name="filenames" value="#ImageList#">
<PARAM name="frame_label" value="#ImageNameList#"> 
<PARAM name="frame_label_width" value="15">
<PARAM name="toggle_size" value="10,10,3">
<PARAM name="no_enh" value="true">

<PARAM name="image_window_size" value="#imgWidth#,#imgHeight#">

<!--- <PARAM name="active_zoom" value="x"> --->



<!--- <PARAM name="portal_locations" value="10 & 10 & 200 & 200">
<PARAM name="portal_filenames" value="#ListLast(ImageList)#">
 --->


</applet>
</cfoutput>

<!--- <TABLE border="0" cellspacing="0" cellpadding="0" width="600">
<TR><TD height="40"><p>&nbsp;</p></TD></TR>
<TR>
  <TD bgcolor="#FFFFFF" colspan="3"><cfoutput>
<!--- 			     <A href="javascript:Onetransport()"><IMG src="#imgRoot##currLoc##firstImage#" width="720" height="540" name="Oneshow" border="0"></A> --->
	 <IMG src="#imgRoot##currLoc##firstImage#" width="#imgWidth#" height="#imgHeight#" name="Oneshow" border="0" onMouseDown="myMouse=control_mouse_click(#imgWidth#,#imgHeight#);" onMouseUp="clearzoom();JSFX_StartEffects();">
			 </cfoutput></TD>
</TR>
</TABLE> --->

<CFELSE>  <!--- No Images available --->
<TABLE border="0" cellspacing="0" cellpadding="0" width="400" align="center" >
<TR><TD height="40"><p>&nbsp;</p></TD></TR>
<TR>
  <TD bgcolor="#FFFFFF" align="right">&nbsp;<a href="#" onMouseDown="MM_closeBrWindow()"><img src="/images/closewindow.gif" width="97" height="20" border="0" alt="close" name="Image1"></a></TD>
</TR>
<TR>
  <TD bgcolor="#FFFFFF" align="center">No Images are Available</TD>
</TR>
<TR>
  <TD bgcolor="#FFFFFF" align="center">Please try again later.</TD>
</TR>
</TABLE>
</CFIF>
 --->
</body>
</html>

