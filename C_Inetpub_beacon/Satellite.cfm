<META HTTP-EQUIV="REFRESH" CONTENT="300">

<cfparam name="Animate" default="0">

<cfset flashID = 3> 
<cfset cookieBBoxName = "BBOX_" & flashID>
<cfset cookieStageHName = "STAGEH">
<cfset cookieStageWName = "STAGEW">
<cfset cookieMapLayersName = "MAPLAYERS_" & flashID>

<cfif isDefined("cookie." & cookieBBoxName)>
	<cfset BBox = #Evaluate("cookie." & cookieBBoxName)#>
	<cfset StageH = #Evaluate("cookie." & cookieStageHName)#>
	<cfset StageW = #Evaluate("cookie." & cookieStageWName)#>
<cfelse>
	<cfset StageH = 400>
	<cfset StageW = 800>
</cfif>


<cfif isDefined("cookie." & cookieMapLayersName)>
	<cf_Layers2Text LayersIN=#Evaluate("cookie." & cookieMapLayersName)# Display=0>
	<cfset mapLayers = LayersOut>
<cfelse>
	<cfcookie name="#cookieMapLayersName#" value="#mapLayers#">
	<cf_Layers2Text LayersIN=#mapLayers# Display=0>
	<cfset mapLayers = LayersOut>
</cfif>

<cfif Animate EQ 0>
	<cfinclude template="include/MyFlightsProc.cfm">
<cfelse>
	
		<cfset AnimMapLayers = mapLayers>
		<cfif #ListFindNoCase(AnimMapLayers,"Counties")#>
			<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"Counties")) >
			<cfset AnimMapLayers = ListPrepend(AnimMapLayers,"Counties",",") >
		</cfif>		

 		<cfif #ListFindNoCase(AnimMapLayers,"Coastlines")#>
			<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"Coastlines")) >
			<cfset AnimMapLayers = ListPrepend(AnimMapLayers,"Coastlines",",") >
		</cfif>		
		<cfif #ListFindNoCase(AnimMapLayers,"Borders")#>
			<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"Borders")) >
			<cfset AnimMapLayers = ListPrepend(AnimMapLayers,"Borders",",") >
		</cfif>		
		<cfif #ListFindNoCase(AnimMapLayers,"Countries")#>
			<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"Countries")) >
		</cfif>		

	<cfif #ListFindNoCase(AnimMapLayers,"SatelliteIR")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"SatelliteIR")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"SatelliteIR_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"SatelliteIR_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"SatelliteIR_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"SatelliteIR_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"SatelliteIR_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"SatelliteIR_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"SatelliteVS")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"SatelliteVS")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"SatelliteVS_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"SatelliteVS_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"SatelliteVS_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"SatelliteVS_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"SatelliteVS_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"SatelliteVS_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"SatelliteWV")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"SatelliteWV")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"SatelliteWV_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"SatelliteWV_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"SatelliteWV_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"SatelliteWV_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"SatelliteWV_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"SatelliteWV_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"CONUSIR")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"CONUSIR")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"CONUSIR_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"CONUSIR_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"CONUSIR_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"CONUSIR_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"CONUSIR_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"CONUSIR_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"CONUSVS")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"CONUSVS")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"CONUSVS_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"CONUSVS_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"CONUSVS_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"CONUSVS_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"CONUSVS_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"CONUSVS_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"CONUSWV")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"CONUSWV")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"CONUSWV_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"CONUSWV_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"CONUSWV_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"CONUSWV_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"CONUSWV_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"CONUSWV_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"EUROPE_IR_NH")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"EUROPE_IR_NH")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"EUROPE_IR_NH_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"EUROPE_IR_NH_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"EUROPE_IR_NH_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"EUROPE_IR_NH_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"EUROPE_IR_NH_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"EUROPE_IR_NH_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"EUROPE_VS_NH")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"EUROPE_VS_NH")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"EUROPE_VS_NH_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"EUROPE_VS_NH_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"EUROPE_VS_NH_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"EUROPE_VS_NH_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"EUROPE_VS_NH_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"EUROPE_VS_NH_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"EUROPE_WV_NH")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"EUROPE_WV_NH")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"EUROPE_WV_NH_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"EUROPE_WV_NH_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"EUROPE_WV_NH_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"EUROPE_WV_NH_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"EUROPE_WV_NH_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"EUROPE_WV_NH_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"ASIA_IR_NH")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"ASIA_IR_NH")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"ASIA_IR_NH_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"ASIA_IR_NH_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"ASIA_IR_NH_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"ASIA_IR_NH_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"ASIA_IR_NH_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"ASIA_IR_NH_6",",") >
	<cfelseif #ListFindNoCase(AnimMapLayers,"ASIA_WV_NH")#>
		<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"ASIA_WV_NH")) >
		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"ASIA_WV_NH_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"ASIA_WV_NH_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"ASIA_WV_NH_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"ASIA_WV_NH_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"ASIA_WV_NH_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"ASIA_WV_NH_6",",") >
	<cfelse>
		<cfset AnimMapLayers1 = AnimMapLayers>
		<cfset AnimMapLayers2 = AnimMapLayers>
		<cfset AnimMapLayers3 = AnimMapLayers>
		<cfset AnimMapLayers4 = AnimMapLayers>
		<cfset AnimMapLayers5 = AnimMapLayers>
		<cfset AnimMapLayers6 = AnimMapLayers>
	</cfif>

<!--- 	Debug:
 	<cfoutput>MapLayer For Animation Is: #AnimMapLayers1#<br>#ListGetAt(cookie.BeaconStats,1,"|")#<br>
	#RIGHT(ListGetAt(cookie.BeaconStats,1,"|"),10)#<br>
	http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers6#&format=GIF<br>
	</cfoutput>
 --->

	<cfset imageName = "sat_" & #RIGHT(ListGetAt(cookie.BeaconStats,1,"|"),10)#>
	
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers6#&format=GIF" path="D:\Data\Console\UserMaps" file="#imageName#_6.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers5#&format=GIF" path="D:\Data\Console\UserMaps" file="#imageName#_5.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers4#&format=GIF" path="D:\Data\Console\UserMaps" file="#imageName#_4.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers3#&format=GIF" path="D:\Data\Console\UserMaps" file="#imageName#_3.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers2#&format=GIF" path="D:\Data\Console\UserMaps" file="#imageName#_2.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers1#&format=GIF" path="D:\Data\Console\UserMaps" file="#imageName#_1.gif" resolveurl="yes" getasbinary="yes"></cfhttp>

<cfscript>
function FileSizeCom(path)
{
  Var fso  = CreateObject("COM", "Scripting.FileSystemObject");
  Var theFile = fso.GetFile(path);
  Return theFile.Size;
}
</cfscript>

	<cfset Filename1 = "D:\Data\Console\UserMaps\" & #imageName# & "_6.gif">
	<cfset Filename2 = "D:\Data\Console\UserMaps\" & #imageName# & "_5.gif">
	<cfset Filename3 = "D:\Data\Console\UserMaps\" & #imageName# & "_4.gif">
	<cfset Filename4 = "D:\Data\Console\UserMaps\" & #imageName# & "_3.gif">
	<cfset Filename5 = "D:\Data\Console\UserMaps\" & #imageName# & "_2.gif">
	<cfset Filename6 = "D:\Data\Console\UserMaps\" & #imageName# & "_1.gif">

	<cfset SlideShowList = "">
	<cfloop index="ImgIndex" from="6" to="1" step="-1">
		<cfset Filename = "D:\Data\Console\UserMaps\" & #imageName# & "_" & #ImgIndex# &".gif">
		<cfif FileExists(#Filename#)>
			<cfset SlideShowList = SlideShowList & "/UserMaps/" & #imageName# & "_" & #ImgIndex# &".gif,">
			<!--- Introduce two frames delay at the end --->
			<cfif ImgIndex EQ 1>
				<cfset SlideShowList = SlideShowList & "/UserMaps/" & #imageName# & "_" & #ImgIndex# &".gif,">
				<cfset SlideShowList = SlideShowList & "/UserMaps/" & #imageName# & "_" & #ImgIndex# &".gif">
			</cfif>
		</cfif>
	</cfloop>
	<cfset SlideShowList2 = ListQualify(SlideShowList,'"')>
<!---
 	<!--- Introduce two frames delay at the end --->
	<cfset SlideShowList = "/UserMaps/#imageName#_6.gif,/UserMaps/#imageName#_5.gif,/UserMaps/#imageName#_4.gif,/UserMaps/#imageName#_3.gif,/UserMaps/#imageName#_2.gif,/UserMaps/#imageName#_1.gif,/UserMaps/#imageName#_1.gif,/UserMaps/#imageName#_1.gif">
	<cfset SlideShowList2 = ListQualify(SlideShowList,'"')>
 --->

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
							<iframe name="mapCall"
								frameborder="0" 
								align="top"
								src="/mapCall.cfm?mID=#mID#&flashid=#flashid#&cookieBboxName=#cookieBboxName#&cookieMapLayersName=#cookieMapLayersName#" 
								id="mapCall" 
								width="100%" 
								height="400" 
								scrolling="no"
								marginheight="0">
							You must have a browser that supports frames
						</iframe>
						</cfoutput>
							<!---<cfoutput> 
							<cfinclude template="include/js_dosfcommand.cfm">
							<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
							 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
							 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0">
							 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
							 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
							 <PARAM NAME=transparent VALUE=false>
							 <PARAM NAME=menu VALUE="true">
							 <PARAM NAME=quality VALUE="high">
							 <PARAM NAME=scale VALUE="noscale">
							 <PARAM NAME=salign VALUE="LT">
							 <PARAM NAME=devicefont VALUE="true">
							 <PARAM NAME=swLiveConnect VALUE="true">
							 <PARAM NAME="wmode" VALUE="opaque">
						 
							 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0" menu=true quality=autohigh scale=noscale wmode="opaque" salign=LT devicefont=true bgcolor=#mapBgColor# swLiveConnect=true NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
							 </OBJECT>
							 </cfoutput>--->
							 <cfset UpdateTimesOnly = "Satellite">
							 <cfinclude template="include/UpdateTimes.cfm">
						<cfelse>
							 <cfif #ListContainsNoCase(mapLayers,"CONUS")#>
								 <cfset DisplayMapType = 1>
							 <cfelseif #ListContainsNoCase(mapLayers,"EUROPE")#>
								 <cfset DisplayMapType = 2>
							 <cfelseif #ListContainsNoCase(mapLayers,"ASIA")#>
								 <cfset DisplayMapType = 3>
							 <cfelse>
								 <cfset DisplayMapType = 4>
							 </cfif>

 							 <cfinclude template="include/UpdateTimesSatellite.cfm">
							 
							 <a href="/#Request.const_default_htm#?mID=3"><img id="_Ath_Slide" onload="OnImgLoad()" border="0"></a>

							<div class="navlink" style="background-color:#000000; font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px" align="left">
								<span style="color: #CCE2FF;"> Satellite Update Time: </span>
								<span style="color: #E3E6E8;"><SPAN id="_Curr_Times"> </SPAN></span><br>
								<span style="color: #E3E6E8;"><img src="/images/satellite_ir_legend.gif" border="0" alt="Satellite IR legend"></span>
							</div>

<cfoutput>
<script language="JavaScript1.2">
g_fPlayMode = 0;
g_iimg = -1;
g_imax = 0;
g_ImageTable = new Array();
g_Manual = 0;

function ChangeImage(fFwd) {
	if (fFwd) {
		if (++g_iimg==g_imax)
			g_iimg=0;
	}
	else {
		if (g_iimg==0)
			g_iimg=g_imax;
	g_iimg--;
	}
	Update();
}

function setDelay2(Delay) {
	g_dwTimeOutSec = Delay;
}

function getobject(obj) {
	if (document.getElementById)
		return document.getElementById(obj)
	else if (document.all)
		return document.all[obj]
}

function Update(){
	getobject("_Ath_Slide").src = g_ImageTable[g_iimg][0];
	getobject("_Curr_Times").innerHTML = g_ImageTable[g_iimg][1];
}


function Play() {
	g_fPlayMode = !g_fPlayMode;
	if (g_fPlayMode) {
		Next(g_Manual);
	}
}

function OnImgLoad() {
	if (g_fPlayMode)
		window.setTimeout("Tick()", g_dwTimeOutSec);
}

function Tick() {
	if (g_fPlayMode)
		Next();
}

function Prev() {
	if (g_iimg==0)
		g_iimg=(g_imax-3);
	ChangeImage(false);
}

function Next(Manual)	{
	if (Manual) {
		if (g_iimg>=g_imax-3)
			g_iimg=g_imax-1;
	}		
	ChangeImage(true);
}


////configure below variables/////////////////////////////

//configure the below images and description to your own. 
mySize = #FileSizeCom(Filename1)#;
if (mySize >= 1000) {
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,1)#, #SatListTimes1#);
}

mySize = #FileSizeCom(Filename2)#;
if (mySize >= 1000) {
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,2)#, #SatListTimes2#);
}

mySize = #FileSizeCom(Filename3)#;
if (mySize >= 1000) {
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,3)#, #SatListTimes3#);
}

mySize = #FileSizeCom(Filename4)#;
if (mySize >= 1000) {
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,4)#, #SatListTimes4#);
}

mySize = #FileSizeCom(Filename5)#;
if (mySize >= 1000) {
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,5)#, #SatListTimes5#);
}

mySize = #FileSizeCom(Filename6)#;
if (mySize >= 1000) {
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,6)#, #SatListTimes6#);
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,7)#, #SatListTimes6#);
	g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,8)#, #SatListTimes6#);
}
//extend the above list as desired
g_dwTimeOutSec=1000

// Example:
// simplePreload( '01.gif', '02.gif' ); 
function simplePreload()
{ 
  var args = simplePreload.arguments;
  document.imageArray = new Array(args.length);
  for(var i=0; i<args.length; i++)
  {
    document.imageArray[i] = new Image;
    document.imageArray[i].src = args[i];
  }
}

function do_onload() {
	simplePreload(#SlideShowList2#);
	Play();
}


if (document.getElementById||document.all)
//window.onload=Play
window.onload=do_onload
</script>
</cfoutput>
							 
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
			  <cfif Animate EQ 0>
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
			  </cfif>
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
							<input id="execute" name="submit" value="Submit" type="button" onClick="reloadMap();" /><br /><br />
							<input id="clear" name="clear" value="Clear" type="button" onClick="clearSatelliteMenu('#UCASE(cookieMapLayersName)#');" />
						</cfoutput><br /><br />
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
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_1_dim.gif" name="button1" width="22" height="17" border="0" id="button1"></a></td> --->
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_2_dim.gif" name="button2" width="15" height="17" border="0" id="button2"></a></td>
                      <td><a href="/#Request.const_default_htm#?mID=3&Animate=1" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Play animation')"><img src="/images/animation_control_images/buttons_3_off.gif" name="button3" width="15" height="17" border="0" id="button3" <!--- onclick="refreshMovie('MapSymbols4',3)"  --->></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_4_dim.gif" name="button4" width="15" height="17" border="0" id="button4"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_5_dim.gif" name="button5" width="14" height="17" border="0" id="button5"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_6_dim.gif" name="button6" width="15" height="17" border="0" id="button6"></a></td>
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="/images/animation_control_images/buttons_7_dim.gif" name="button7" width="24" height="17" border="0" id="button7"></a></td> --->
				<cfelse>
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Rewind to first frame')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_on.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_off.gif',1);slideshow_first(); return"><img src="/images/animation_control_images/buttons_1_off.gif" name="button1" width="22" height="17" border="0" id="button1"></span></a></td> --->
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step back one frame')"><span onClick="MM_swapImage('button2','','/images/animation_control_images/buttons_2_on.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif',1);Prev(); return"><img src="/images/animation_control_images/buttons_2_off.gif" name="button2" width="15" height="17" border="0" id="button2"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Play animation')"><span onClick="MM_swapImage('button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_on.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif',1);Play();return"><img src="/images/animation_control_images/buttons_3_on.gif" name="button3" width="15" height="17" border="0" id="button3"></span></a></td>
                      <td><a href="/#Request.const_default_htm#?mID=3" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Return to static map')"><span onClick="MM_swapImage('button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_on.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif',1); return"><img src="/images/animation_control_images/buttons_4_off.gif" name="button4" width="15" height="17" border="0" id="button4"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Pause animation')"><span onClick="MM_swapImage('button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_on.gif','button6','','/images/animation_control_images/buttons_6_off.gif',1);Play(); return"><img src="/images/animation_control_images/buttons_5_off.gif" name="button5" width="14" height="17" border="0" id="button5"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step forward one frame')"><span onClick="MM_swapImage('button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_on.gif',1);Next(1); return"><img src="/images/animation_control_images/buttons_6_off.gif" name="button6" width="15" height="17" border="0" id="button6"></span></a></td>
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Advance to last frame')"><span onClick="MM_swapImage('button1','','/images/animation_control_images/buttons_1_off.gif','button2','','/images/animation_control_images/buttons_2_off.gif','button3','','/images/animation_control_images/buttons_3_off.gif','button4','','/images/animation_control_images/buttons_4_off.gif','button5','','/images/animation_control_images/buttons_5_off.gif','button6','','/images/animation_control_images/buttons_6_off.gif','button7','','/images/animation_control_images/buttons_7_on.gif',1);slideshow_last(); return"><img src="/images/animation_control_images/buttons_7_off.gif" name="button7" width="24" height="17" border="0" id="button7"></span></a></td> --->
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
            <!--- End Right Side Window --->
	</td>
  </tr>
  </table>
<map name="sliderMap">
<area shape="rect" coords="0,0,11,12" href="#" onClick="setDelay2(4000);MM_swapImage('slider','','/images/animation_control_images/speed_slider_1.gif',1)">
<area shape="rect" coords="11,0,22,12" href="#" onClick="setDelay2(2000);MM_swapImage('slider','','/images/animation_control_images/speed_slider_2.gif',1)">
<area shape="rect" coords="22,0,33,12" href="#" onClick="setDelay2(1000);MM_swapImage('slider','','/images/animation_control_images/speed_slider_3.gif',0)">
<area shape="rect" coords="33,0,44,12" href="#" onClick="setDelay2(500);MM_swapImage('slider','','/images/animation_control_images/speed_slider_4.gif',1)">
<area shape="rect" coords="44,0,55,12" href="#" onClick="setDelay2(100);MM_swapImage('slider','','/images/animation_control_images/speed_slider_5.gif',1)">
</map>

