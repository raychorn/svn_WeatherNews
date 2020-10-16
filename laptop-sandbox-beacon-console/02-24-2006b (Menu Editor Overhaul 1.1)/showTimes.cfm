<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Show Times</title>
<style>
	body{
		color:#FFFFFF;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:10px;
		background-color:#000000;
		width:91%;
	}
	#timeData {
	}
	#timeHeader {
		position:relative;
		top:-10px;
		padding:0px;
	}
</style>
<script type="text/javascript" language="javascript">
//enter refresh time in "minutes:seconds" Minutes should range from 0 to inifinity. Seconds should range from 0 to 59
function getNewText() {
	// here is where the remoting call should be made
	document.getElementById('remoting').src = "/jsRemotingPage.cfm";
	var timeInfo = stringData;
	document.getElementById('textdata').innerHTML = timeInfo;
	executed = true;
}

//-->
</script>
</head>

<body>
<div id="timeHeader">
	Time Information
</div>
<div id="textdata">
</div>
<iframe id="remoting" width="0" height="0" frameborder="0" src="/jsRemotingPage.cfm" style="display:none;">
	Your Browser does not support iframes.  Please download IE 6+
</iframe>
</body>
</html>
