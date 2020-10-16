<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Test Layer to Name</title>
</head>

<body bgcolor="#000000" style="color:#FFFFFF;">
<cfinvoke component="com.weathernews.beacon.layerIdToName" method="init" returnvariable="times">
	<cfinvokeargument name="strLayerCookie" value="12,18,11,1,143" />
	<cfinvokeargument name="strXmlFileName" value="/flash/xml/layers.xml" />
</cfinvoke>
<cfoutput>#times#</cfoutput>
</body>
</html>
