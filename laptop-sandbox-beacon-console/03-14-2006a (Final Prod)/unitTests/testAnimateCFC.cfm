<html>
	<head>
		<title>Hi I test the animation cFC</title>
	</head>
	<body>
		<cfinvoke component="include.cfc.layerDataGateway" method="objToFlashAnimation" returnvariable="sctAni" />
	<cfdump var="#sctAni#">
	</body>
</html>