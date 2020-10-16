<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html40/strict.dtd">
<html>
<head>
<title>Weathernews BEACON</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<cfif IsDefined("mID") AND mID EQ 1>
	<META http-equiv="Pragma" content="no-cache">
</cfif>
<link href="/include/css/text_attributes.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/include/javascript/macromediaJS.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/printWindow.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/menuImageFlipper.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/userLayerActions.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/fastMenuFunct.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/acordianMenu.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/popupMenuFunct.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/animationFunctions.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/xmlhttprequest.js" type="text/javascript" ></script>
<script language="JavaScript1.2" src="/include/javascript/wni_menuEditor.js" type="text/javascript"></script>
<script language="javascript" src="/include/javascript/imageFunct.js" type="text/javascript"></script>
</head>
<iframe id="generalPurpose" width="0" height="0" src="/include/ajax/ajaxDriver.cfm" style="display:none;">
	You are using a browser that doesn't support iFrames, please upgrade your browser
</iframe>
<body bgcolor="#333333" leftmargin="6" topmargin="6" marginwidth="12" marginheight="0" id="instrument" onLoad="MM_preloadImages('/images/bottom_nav_images/contact_button_ovr.gif','/images/bottom_nav_images/terms_of_use_button_ovr.gif','/images/bottom_nav_images/privacy_button_ovr.gif','/images/bottom_nav_images/disclaimer_button_ovr.gif','/images/animation_control_images/buttons_1_on.gif','/images/animation_control_images/buttons_2_on.gif','/images/animation_control_images/buttons_3_on.gif','/images/animation_control_images/buttons_4_on.gif','/images/animation_control_images/buttons_5_on.gif','/images/animation_control_images/buttons_6_on.gif','/images/animation_control_images/buttons_7_on.gif','/images/animation_control_images/buttons_1_off.gif','/images/animation_control_images/buttons_2_off.gif','/images/animation_control_images/buttons_3_off.gif','/images/animation_control_images/buttons_4_off.gif','/images/animation_control_images/buttons_5_off.gif','/images/animation_control_images/buttons_6_off.gif','/images/animation_control_images/speed_slider_1.gif','/images/animation_control_images/speed_slider_2.gif','/images/animation_control_images/speed_slider_4.gif','/images/animation_control_images/speed_slider_5.gif')">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td rowspan="2"><img src="/images/title_graphic.gif" alt="Weathernews BEACON" width="400" height="36"></td>
	<td class="whiteText" align="right" style="padding-bottom: 5px; font-size:9px" valign="bottom">&nbsp;&nbsp;</td>
  </tr>	
  <tr>
    <td class="whiteText" align="right" style="padding-bottom: 5px" valign="bottom"><cfif isdefined("cookie.initialized")><cfoutput><cfif (ListLen(cookie.BeaconStats,"|") gte 2)>#ListGetAt(cookie.BeaconStats,2,"|")#<cfelse><cflocation url="login.htm"></cfif></cfoutput></cfif>&nbsp;&nbsp;|&nbsp;<a href="/default.htm?mID=20" class="reversed">Preferences</a>&nbsp;|&nbsp;
				  <cfif not isdefined("cookie.initialized")>
				  	<cflocation url="/login.htm?logout&reason=2">

				  <cfif TopSection EQ "LOGIN">
						  Login
				  <cfelse>
						  <a class="reversed" href="/login.htm">Login</a>
				  </cfif>
			  <cfelse>
					<cfif cookie.initialized EQ 1>
						  <a class="reversed" href="/login.htm?logout&reason=2">Logout</a>
					<cfelse>
						  Login
				   </cfif>
			  </cfif>
	  &nbsp;</td>
  </tr>
</table>