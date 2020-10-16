<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<cfif NOT IsDefined("APPLICATION.lyr")>
	<cfobject name="APPLICATION.lyr" component="com.weathernews.beacon.layerIdToName" />
</cfif>
<cfset variables.strVar = APPLICATION.lyr.init() />

</head>

<body>
<cfdump var="#variables.strVar#" />
</body>
</html>