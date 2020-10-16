<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Untitled Document</title>
</head>
<script type="text/javascript">
		//window.parent.alert('hello');
		window.parent.enableFastPageLoadButton();
	</script>
<body>
<cfinclude template="/include/GlobalParams.cfm" />

<cfoutput> 
	<cfset flashID = SESSION.flashID />
	<cfinclude template="/include/js_dosfcommand.cfm">
	<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
	 ID="MapSymbols#SESSION.flashID#" WIDTH="100%" HEIGHT="400" ALIGN="middle">
	 <PARAM NAME=movie VALUE="/flash/animationViewer/aniMap2.swf?remotingURL=#ListFirst(CGI.HTTP_REFERER,":") & "://" & CGI.HTTP_HOST & "/flashservices/gateway"#">
	 <PARAM NAME=bgcolor VALUE="##000000">
	 <PARAM NAME=quality VALUE="high">
	 <PARAM NAME=scale VALUE="noscale">
	 <PARAM NAME=salign VALUE="LT">
	 <PARAM NAME=devicefont VALUE="true">
	 <PARAM NAME=swLiveConnect VALUE="true">
 
	 <EMBED src="/flash/animationViewer/aniMap2.swf?remotingURL=#ListFirst(CGI.HTTP_REFERER,':') & '://' & CGI.HTTP_HOST & '/flashservices/gateway'#"  WIDTH="100%" HEIGHT="400" autostart="false" menu="false" quality="autohigh" scale="noscale" salign="LT" devicefont="true" bgcolor="#mapBgColor#" swLiveConnect="true" NAME="MapSymbols#SESSION.flashID#" TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
	 </OBJECT>
</cfoutput>
</body>
</html>
