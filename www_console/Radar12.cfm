<META HTTP-EQUIV="REFRESH" CONTENT="300">

<cfparam name="Animate" default="0">


<cfset flashID = 4> 
<cfset cookieBBoxName = "BBOX_" & flashID>
<cfset cookieStageHName = "STAGEH">
<cfset cookieStageWName = "STAGEW">
<cfset cookieMapLayersName = "MAPLAYERS_" & flashID>

<cfif isDefined("cookie." & cookieBBoxName)>
	<cfset BBox = #Evaluate("cookie." & cookieBBoxName)#>
	<cfset StageH = #Evaluate("cookie." & cookieStageHName)#>
	<cfset StageW = #Evaluate("cookie." & cookieStageWName)#>
<cfelse>
	<cfset BBox = "-130.496455586007,18.598539904507,-59.7473232373829,51.5157846843435">
	<cfset StageH = 400>
	<cfset StageW = 800>
</cfif>



<cfif isDefined("cookie." & cookieMapLayersName)>
	<cf_Layers2Text LayersIN=#Evaluate("cookie." & cookieMapLayersName)# Display=0>
	<cfset mapLayers = LayersOut>
<cfelse>
	<cfset tempMapLayers = #mapLayers# & ",23">
	<cfcookie name="#cookieMapLayersName#" value="#tempMapLayers#">
	<cf_Layers2Text LayersIN=#tempMapLayers# Display=0>
	<cfset mapLayers = LayersOut>
</cfif>

<cffile action="read" file="#Request.webRoot#include\conus_mosaic.txt" variable="RadarTimesTmp"> 
<cfset RadarTimes = #REReplace(RadarTimesTmp,Chr(13),"|","ALL")#>
<cfset RadarTimes = LEFT(RadarTimes,LEN(RadarTimes)-1)>

<cfif Animate EQ 0>
	<cfinclude template="include/MyFlightsProc.cfm">
<cfelse>
 	<cfif #ListFindNoCase(mapLayers,"CONUS Radar Mosaic")#>
	
		<cfset AnimMapLayers = ListDeleteAt(mapLayers,ListFindNoCase(mapLayers,"CONUS Radar Mosaic")) >

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
		<cfif #ListFindNoCase(AnimMapLayers,"Cell Tops/Motion")#>
			<cfset AnimMapLayers = ListDeleteAt(AnimMapLayers,ListFindNoCase(AnimMapLayers,"Cell Tops/Motion")) >
		</cfif>		

		<cfset AnimMapLayers1 = ListPrepend(AnimMapLayers,"conus_mosaic_1",",") >
		<cfset AnimMapLayers2 = ListPrepend(AnimMapLayers,"conus_mosaic_2",",") >
		<cfset AnimMapLayers3 = ListPrepend(AnimMapLayers,"conus_mosaic_3",",") >
		<cfset AnimMapLayers4 = ListPrepend(AnimMapLayers,"conus_mosaic_4",",") >
		<cfset AnimMapLayers5 = ListPrepend(AnimMapLayers,"conus_mosaic_5",",") >
		<cfset AnimMapLayers6 = ListPrepend(AnimMapLayers,"conus_mosaic_6",",") >
		
	<cfelse>
		<cfset AnimMapLayers1 = "conus_mosaic_1,Borders,Coastlines,US State Borders,Counties,Airports,VOR">
		<cfset AnimMapLayers2 = "conus_mosaic_2,Borders,Coastlines,US State Borders,Counties,Airports,VOR">
		<cfset AnimMapLayers3 = "conus_mosaic_3,Borders,Coastlines,US State Borders,Counties,Airports,VOR">
		<cfset AnimMapLayers4 = "conus_mosaic_4,Borders,Coastlines,US State Borders,Counties,Airports,VOR">
		<cfset AnimMapLayers5 = "conus_mosaic_5,Borders,Coastlines,US State Borders,Counties,Airports,VOR">
		<cfset AnimMapLayers6 = "conus_mosaic_6,Borders,Coastlines,US State Borders,Counties,Airports,VOR">
	</cfif>			
		
<!--- 		
	<cfset r = Randomize(#Int(TimeFormat(now(),"sslss"))#)>
	<cfset RandomNum = #Rand()# >
	<cfset imageName = "radar_" & #RIGHT(RandomNum,10)#>
 --->
	<cfset imageName = "radar_" & #RIGHT(ListGetAt(cookie.BeaconStats,1,"|"),10)#>

	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers6#&format=GIF" path="#Request.webRoot#UserMaps" file="#imageName#_6.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers5#&format=GIF" path="#Request.webRoot#UserMaps" file="#imageName#_5.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers4#&format=GIF" path="#Request.webRoot#UserMaps" file="#imageName#_4.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers3#&format=GIF" path="#Request.webRoot#UserMaps" file="#imageName#_3.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers2#&format=GIF" path="#Request.webRoot#UserMaps" file="#imageName#_2.gif" resolveurl="yes" getasbinary="yes"></cfhttp>
	<cfhttp url="http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers1#&format=GIF" path="#Request.webRoot#UserMaps" file="#imageName#_1.gif" resolveurl="yes" getasbinary="yes"></cfhttp>

<!--- for debug
<cfoutput>	http://localhost:83/WMS/wms.asp?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#BBox#&width=#stageW#&height=#stageH#&layers=#AnimMapLayers6#&format=GIF<br></cfoutput>
--->

	<!--- Introduce two frames delay at the end --->
	<cfset SlideShowList = "/UserMaps/#imageName#_6.gif,/UserMaps/#imageName#_5.gif,/UserMaps/#imageName#_4.gif,/UserMaps/#imageName#_3.gif,/UserMaps/#imageName#_2.gif,/UserMaps/#imageName#_1.gif,/UserMaps/#imageName#_1.gif,/UserMaps/#imageName#_1.gif">
	<cfset SlideShowList2 = ListQualify(SlideShowList,'"')>
</cfif>				  

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
          <td width="100%"><!--- Left Main Window --->
		  
            <table width="100%" border="0" cellpadding="0" cellspacing="0"> 
              <tr>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
                <td width="100%" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_top.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="8" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
              </tr>
              <tr>
                <td rowspan="1" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_left.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
                <td width="100%" align="center" bgcolor="#FFFFFF">


				   <!--- Navigation Map --->
                  <table width="95%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td>
						<cfif Animate EQ 0>
							<cfoutput> 
							<cfinclude template="include/js_dosfcommand.cfm">
							<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
							 ID="MapSymbols#flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
							 <PARAM NAME=flashvars VALUE="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0">
							 <PARAM NAME=movie VALUE="/flash/MapSymbols_4.swf">
							 <PARAM NAME=bgcolor VALUE="#mapBgColor#">
							 <PARAM NAME=menu VALUE="true">
							 <PARAM NAME=quality VALUE="high">
							 <PARAM NAME=scale VALUE="noscale">
							 <PARAM NAME=salign VALUE="LT">
							 <PARAM NAME=devicefont VALUE="true">
							 <PARAM NAME=swLiveConnect VALUE="true">
						 
							 <EMBED src="/flash/MapSymbols_4.swf"  WIDTH="100%" HEIGHT="400" autostart="false" flashvars="WMS=WorldMap4&localHostName=#localHostName#&FlashID=#flashID#&Layers=#mapLayers#&BBox=#BBox#&WrapDateline=true&Equidistant=true&ToolBarXY=0,0&SLO=0" menu=true quality=autohigh scale=noscale salign=LT devicefont=true bgcolor=#mapBgColor# swLiveConnect=true NAME=MapSymbols#flashID# TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
							 </OBJECT>
							 </cfoutput>
							 <cfset UpdateTimesOnly = "Radar">
							 <cfinclude template="include/UpdateTimes.cfm">
						<cfelse>
<!--- 				 		  <cfoutput>
							<cf_img javacode rotatedelay="1000" slideshow="#SlideShowList#" NOSRC="<cfoutput>#Request.imagesPrefix#</cfoutput>noImage.jpg">
							<cf_img name="show" href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=4" src="#ListFirst(SlideShowList,',')#" NOSRC="<cfoutput>#Request.imagesPrefix#</cfoutput>noImage.jpg" TITLE="Click on the image to Redefine Your Selection" ALT="Click on the image to Redefine Your Selection">
						 </cfoutput>		
						 	<script language="javascript">
							function do_onload2() {
								slideshow_status('Start');
								UpdateTime();
							}
							
							if (window.addEventListener)
								window.addEventListener("load", do_onload2, false)
								else if (window.attachEvent)
								window.attachEvent("onload", do_onload2)
								else if (document.getElementById)
								window.onload=do_onload2

							</script>
							 <cfset UpdateTimesOnly = "Radar">

 							 <cfinclude template="include/UpdateTimes2.cfm">
 --->
							 <cfset DisplayMapType = 1>
 							 <cfinclude template="include/UpdateTimesRadar.cfm">
							 
							 <a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=4"><img id="_Ath_Slide" onload="OnImgLoad()" border="0"></a>

							<div class="navlink" style="background-color:#000000; font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px" align="left">
								<span style="color: #CCE2FF;"> Radar Update Time: </span>
								<span style="color: #E3E6E8;"><SPAN id="_Curr_Times"> </SPAN></span><br>
								<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>radar_legend.gif" border="0" alt="Radar legend"></span>		
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
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,1)#, #RadarListTimes6#);
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,2)#, #RadarListTimes5#);
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,3)#, #RadarListTimes4#);
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,4)#, #RadarListTimes3#);
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,5)#, #RadarListTimes2#);
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,6)#, #RadarListTimes1#);
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,7)#, #RadarListTimes1#);
g_ImageTable[g_imax++] = new Array (#ListGetAt(SlideShowList2,8)#, #RadarListTimes1#);

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
                <td rowspan="1" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_right.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
              </tr>
			  <cfif Animate EQ 0>
              <tr>
                <td rowspan="1" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_left.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
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
				<td rowspan="1" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_right.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
              </tr>
			  </cfif>
              <tr>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
                <td width="100%" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_bottom.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="7" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
              </tr>
            </table>
          </td>
          <td width="180">
            <!--- Right Side Window --->
            <table width="156" border="0" cellpadding="0" cellspacing="0"><!--- Right Side Window --->
              <tr>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_left_shadow1.gif" width="6" height="15" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_upper_lt_corner.gif" width="6" height="15" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_toptab.gif" width="138" height="15" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_upper_rt_corner.gif" width="6" height="15" alt=""></td>
              </tr>
              <tr>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_left_shadow2.gif" width="6" height="35" alt=""></td>
                <td bgcolor="#FFFFFF"> <img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="35" alt=""></td>
                <td bgcolor="#FFFFFF" align="center"> <a href="http://weathernews.com/us/c"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/wni_logo.gif" alt="Weathernews Logo" width="118" height="35" border="0"></a></td>
                <td bgcolor="#FFFFFF"> <img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="35" alt=""></td>
              </tr>
              <tr>
                <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_left_shadow2.gif"></td>
                <td bgcolor="#FFFFFF" colspan="3">
	                <!--- observation menu goes here --->
  					<cfinclude template="include/RadarMenu.cfm">

<!--- 					<iframe src="include/observationMenu.cfm?FlashID=#FlashID#&mID=#mID#" name="obsMenu" width="130" height="457" scrolling="auto"></iframe> --->
				</td>
              </tr>
              <tr>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_left_shadow4.gif" width="6" height="19" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_lower_left_corner.gif" width="6" height="19" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_bottom_tab.gif" width="138" height="19" alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sidemenu_images/sidemenu_right_lower_corner.gif" width="6" height="19" alt=""></td>
              </tr>
            </table>
			
            <!-- start animation control (see image maps at end of HTML for hooks to add links) (popup_look.psd) -->
<!--- 			<cfif Animate EQ 0>

            <table width=130 border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF">
              <tr>
                <td bgcolor="#E3E6E8">
					<form action="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=3" method="post">
					<cfoutput>
<!--- 					<input type="submit" name="Animate" value="Animate" onClick="refreshMovie('MapSymbols#mID#',3)"> --->
					<input type="hidden" name="Animate" value="1">
					<input name="submit" type="image" value="1" src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_all_off.gif">
					</cfoutput>
					</form>
				</td>
              </tr>
            </table>
			<cfelse>			
 --->			
 
 			<div align="center">
            <!-- start animation control (see image maps at end of HTML for hooks to add links) (popup_look.psd) -->
            <table width=130 border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF">
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_top_left.gif" width=5 height=5 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_top_edge.gif" width=120 height=5 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_top_right.gif" width=5 height=5 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=8 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif" alt="" name="caption" width=120 height=8 id="caption"></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_right_edge.gif" width=5 height=8 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=17 alt=""></td>
                <td>
                  <!-- Start Button Bar (see www.walterzorn.com/tooltip/tooltip_e.htm for documentation on the script if you want to understand it better -->
<!--- 				  <a href="javascript: refreshMovie('MapSymbols4',3); return">refresh movie</a><br> --->
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
				<cfif Animate EQ 0>
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_dim.gif" name="button1" width="22" height="17" border="0" id="button1"></a></td> --->
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_dim.gif" name="button2" width="15" height="17" border="0" id="button2"></a></td>
                      <td><a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=4&Animate=1" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Play animation')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif" name="button3" width="15" height="17" border="0" id="button3" <!--- onclick="refreshMovie('MapSymbols4',3)"  --->></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_dim.gif" name="button4" width="15" height="17" border="0" id="button4"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_dim.gif" name="button5" width="14" height="17" border="0" id="button5"></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_dim.gif" name="button6" width="15" height="17" border="0" id="button6"></a></td>
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_dim.gif" name="button7" width="24" height="17" border="0" id="button7"></a></td> --->
				<cfelse>
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Rewind to first frame')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_on.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif',1);slideshow_first(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif" name="button1" width="22" height="17" border="0" id="button1"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step back one frame')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_on.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif',1);slideshow_previous(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif" name="button2" width="15" height="17" border="0" id="button2"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Play animation')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_on.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif',1);slideshow_status('Start');return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_on.gif" name="button3" width="15" height="17" border="0" id="button3"></span></a></td>
                      <td><a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=4" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Return to static map')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_on.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif',1); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif" name="button4" width="15" height="17" border="0" id="button4"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Pause animation')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_on.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif',1);slideshow_status('Stop'); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif" name="button5" width="14" height="17" border="0" id="button5"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step forward one frame')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_on.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif',1);slideshow_next(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif" name="button6" width="15" height="17" border="0" id="button6"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Advance to last frame')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_on.gif',1);slideshow_last(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif" name="button7" width="24" height="17" border="0" id="button7"></span></a></td>
 --->
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Rewind to first frame')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_on.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif',1);slideshow_first(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif" name="button1" width="22" height="17" border="0" id="button1"></span></a></td> --->
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step back one frame')"><span onClick="MM_swapImage('button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_on.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif',1);Prev(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif" name="button2" width="15" height="17" border="0" id="button2"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Play animation')"><span onClick="MM_swapImage('button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_on.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif',1);Play();return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_on.gif" name="button3" width="15" height="17" border="0" id="button3"></span></a></td>
                      <td><a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=4" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Return to static map')"><span onClick="MM_swapImage('button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_on.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif',1); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif" name="button4" width="15" height="17" border="0" id="button4"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Pause animation')"><span onClick="MM_swapImage('button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_on.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif',1);Play(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif" name="button5" width="14" height="17" border="0" id="button5"></span></a></td>
                      <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Step forward one frame')"><span onClick="MM_swapImage('button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_on.gif',1);Next(1); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif" name="button6" width="15" height="17" border="0" id="button6"></span></a></td>
<!---                       <td><a href="#" onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Advance to last frame')"><span onClick="MM_swapImage('button1','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','button2','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','button3','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','button4','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','button5','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','button6','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','button7','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_on.gif',1);slideshow_last(); return"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_off.gif" name="button7" width="24" height="17" border="0" id="button7"></span></a></td> --->
				</cfif>
                    </tr>
                  </table>
                </td>
                <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_right_edge.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=17 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=12 alt=""></td>
			<cfif Animate EQ 0>
                <td align="center"><span onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Animation has been stopped. Press PLAY to start it')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_minus.gif" width="45" height="12"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_control_dim.gif" alt="" name="slider" width=55 height=12 border="0" id="slider"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_plus.gif" width="20" height="12"></span></td>
			<cfelse>
                <td align="center"><span onmouseover="this.T_WIDTH=72;this.T_SHADOWWIDTH=3;this.T_TEMP=2500;return escape('Set speed')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_minus.gif" width="45" height="12"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_3.gif" alt="" name="slider" width=55 height=12 border="0" usemap="#sliderMap" id="slider"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_plus.gif" width="20" height="12"></span></td>
			</cfif>
                <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_right_edge.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=12 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_bottom_left.gif" width=5 height=4 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=120 height=4 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_bottom_right.gif" width=5 height=4 alt=""></td>
              </tr>
            </table>
            <!-- End animation control -->
			</div>
			
<!---			 
            <!-- start animation control (see image maps at end of HTML for hooks to add links) (popup_look.psd) -->
            <table width=130 border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF">
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_top_left.gif" width=5 height=5 alt=""></td>
                <td colspan=3><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_top_edge.gif" width=120 height=5 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_top_right.gif" width=5 height=5 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=8 alt=""></td>
                <td colspan=3><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif" alt="" name="caption" width=120 height=8 id="caption"></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_right_edge.gif" width=5 height=8 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=17 alt=""></td>
                <td colspan=3><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_all_off.gif" alt="" name="buttonBar" width=120 height=17 border="0" usemap="#buttonBarMap" id="buttonBar"></td>
                <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_right_edge.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=17 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=12 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_3.gif" alt="" name="slider" width=55 height=12 border="0" usemap="#sliderMap" id="slider"></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=9 height=12 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_no_1.gif" alt="" name="currFrame" width=56 height=12 border="0" usemap="#currFrameMap" id="currFrame"></td>
                <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_right_edge.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=5 height=12 alt=""></td>
              </tr>
              <tr>
                <td bgcolor="#E3E6E8"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=6 height=1 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_bottom_left.gif" width=5 height=4 alt=""></td>
                <td colspan=3><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/spacer.gif" width=120 height=4 alt=""></td>
                <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/ani_bottom_right.gif" width=5 height=4 alt=""></td>
              </tr>
            </table>
            <!-- End animation control -->
--->			
            <!--- End Right Side Window --->
	</td>
  </tr>
  </table>
<!-- start image map for animation buttons (add your triggers for animation here?) -->
<!--- 
<map name="buttonBarMap">
<area shape="rect" coords="0,0,21,17" href="javascript: slideshow_first();" alt="rewind" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/rewind_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="21,0,35,17" href="javascript: slideshow_previous();" alt="step back" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/step_back_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="35,0,47,17" href="#" alt="reverse" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/reverse_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">

<cfif Animate EQ 0>
	<area shape="rect" coords="47,0,60,17" href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=3&Animate=1" alt="Play" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/start_ani_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<cfelse>
	<area shape="rect" coords="47,0,60,17" href="javascript: slideshow_status('Start');" alt="Play" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/start_ani_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
</cfif>

<area shape="rect" coords="60,0,74,17" href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=3" alt="stop animation" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/stop_ani_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="74,0,85,17" href="javascript: slideshow_status('Stop');" alt="pause animation" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/pause_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="85,0,99,17" href="javascript: slideshow_next();" alt="step forward" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/step_forward_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="99,0,120,17" href="javascript: slideshow_last();" alt="advance to end" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/advance_ff_cap.gif','buttonBar','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_8_on.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
</map>
 ---><!-- start image map for animation speed control (add your triggers for animation here?) -->
<!--- <map name="sliderMap">
<area shape="rect" coords="0,0,11,12" href="#" onClick="setDelay(5000);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_1.gif',1)" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_cap.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="11,0,22,12" href="#" onClick="setDelay(3000);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_2.gif',1)" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_cap.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="22,0,33,12" href="#"  onClick="setDelay(2000);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_3.gif',1)" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_cap.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="33,0,44,12" href="#"  onClick="setDelay(1000);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_4.gif',1)" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_cap.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="44,0,55,12" href="#"  onClick="setDelay(200);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_5.gif',1)" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_cap.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
</map>
 --->
<map name="sliderMap">
<area shape="rect" coords="0,0,11,12" href="#" onClick="setDelay2(4000);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_1.gif',1)">
<area shape="rect" coords="11,0,22,12" href="#" onClick="setDelay2(2000);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_2.gif',1)">
<area shape="rect" coords="22,0,33,12" href="#" onClick="setDelay2(1000);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_3.gif',0)">
<area shape="rect" coords="33,0,44,12" href="#" onClick="setDelay2(500);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_4.gif',1)">
<area shape="rect" coords="44,0,55,12" href="#" onClick="setDelay2(100);MM_swapImage('slider','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_5.gif',1)">
</map>

<!-- start image map for frame select buttons (add your triggers for animation here?) -->
<!--- <map name="currFrameMap">
<area shape="rect" coords="2,0,10,12" href="#" alt="frame 1" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_cap.gif','currFrame','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_no_1.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="10,0,19,12" href="#" alt="frame 2" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_cap.gif','currFrame','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_no_2.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="19,0,28,12" href="#" alt="frame 3" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_cap.gif','currFrame','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_no_3.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="28,0,37,12" href="#" alt="frame 4" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_cap.gif','currFrame','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_no_4.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="37,0,46,12" href="#" alt="frame 5" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_cap.gif','currFrame','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_no_5.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
<area shape="rect" coords="46,0,55,12" href="#" alt="frame 6" onMouseOver="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_cap.gif','currFrame','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/frame_no_6.gif',1)" onMouseOut="MM_swapImage('caption','','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/default_cap.gif',1)">
</map>
 --->  
