<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>

<cfif IsDefined("URL.mID")>
	<cfset mID = URL.mID>
<!--- <cfelseif IsDefined("FORM.FIELDNAMES")>
	<cfif FindNoCase("FFMID_", FORM.FIELDNAMES)>
			<cfset mID = #ListGetAt(ListGetAt(FORM.FIELDNAMES,FindNoCase("FFMID_", FORM.FIELDNAMES)),2,"_")# >
	</cfif>
 --->
</cfif>
<!--- Cfparam statments initialized from the iFrame request --->
<cfparam name="mID" default="#URL.mID#" />
<cfparam name="flashID" default="#URL.flashID#" />
<cfparam name="mapBgColor" default="##81B1E2">
<cfparam name="cookieBboxName" default="#URL.cookieBboxName#" />
<cfparam name="cookieStageHName" default="StageH" />
<cfparam name="cookieStageWName" default="StageW" />
<cfparam name="StageH" default="400" />
<cfparam name="StageW" default="800" />
<cfparam name="COOKIE.StageH" default="400" />
<cfparam name="COOKIE.StageW" default="800" />
<!--- Countries,Coastlines,Borders"> --->
<cfparam name="mapLayers" default="18,16,10,11,12">
<!--- <cfparam name="BBox"  default="-180,-90,180,90"> --->
<cfparam name="BBox"  default="-80.4719687092568,33.3011734028683,7.32203389830511,76.5058670143416">
<!--- <cfparam name="BBox"  default="-133.89305329831,4.01570250708934,13.7590472541694,72.9117974929107"> --->
<cfset localHostName = "http://" & #CGI.HTTP_HOST# & ":443/flashservices/gateway">

<cfset cookieBBoxName = "BBOX_" & flashID>
<cfset cookieMapLayersName = "MAPLAYERS_" & flashID>

<cfif isDefined("cookie." & cookieBBoxName)>
	<cfset BBox = #Evaluate("cookie." & cookieBBoxName)#>
	<cfset StageH = #Evaluate("cookie." & cookieStageHName)#>
	<cfset StageW = #Evaluate("cookie." & cookieStageWName)#>
<cfelse>
	<cfset StageH = 400>
	<cfset StageW = 800>
</cfif>

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
<cfoutput> 
						<!---http://su-extweb-d1:8080/WMS/wms.asp?energy_map1&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0<hr />--->
						<cfinclude template="include/js_dosfcommand.cfm">
						<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
						 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0">
						 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
						 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
						 <PARAM NAME=quality VALUE="high">
						 <PARAM NAME=scale VALUE="noscale">
						 <PARAM NAME=salign VALUE="LT">
						 <PARAM NAME=devicefont VALUE="true">
						 <PARAM NAME=swLiveConnect VALUE="true">
					 
						 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0" menu=false quality=autohigh scale=noscale salign=LT devicefont=true bgcolor=#mapBgColor# swLiveConnect=true NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
						 </OBJECT>
						 </cfoutput>
</body>
</html>
