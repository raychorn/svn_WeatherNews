<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<cfset flashID = 2 />
<cfinclude template="/include/js_dosfcommand.cfm" />
<cfoutput>
<SCRIPT LANGUAGE="VBScript">
<!-- 
// Catch FS Commands in IE, and pass them to the corresponding JavaScript function.

Sub MapSymbols#flashID#_FSCommand(ByVal command, ByVal args)
    call MapSymbols#flashID#_DoFSCommand(command, args)
end sub

// -->
</SCRIPT>

<object id="MapSymbols#flashID#" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,29,0" width="200" height="100">
  <param name="movie" value="../flash/fsTest.swf">
  <param name="quality" value="high">
  <embed name="MapSymbols#flashID#" src="../flash/fsTest.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="200" height="100" swLiveConnect="true"></embed>
</object>
</cfoutput>
</body>
</html>
