<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<cfif NOT IsDefined("APPLICATION.lyr")>
	<cfobject name="APPLICATION.lyr" component="com.weathernews.beacon.layerIdToName" />
</cfif>
<cfset variables.strVar = APPLICATION.lyr.init(COOKIE.MAPLAYERS_2,"/flash/xml/layers.xml") />

</head>

<body bgcolor="#000000">
<cfoutput>
	<!--- <div id="timeData">#variables.strVar#</div> --->
	<script type="text/javascript">
	// I feed the legends.cfm page its data and command the div to refresh
		window.parent.stringData = "<p>Time Information<br />#variables.strVar#</p>";
		window.parent.refreshTimes();
	</script>
</cfoutput>
</body>
</html>
