<cfif IsDefined("FORM.query")>
	<cfinvoke component="com.weathernews.beacon.DAO.qryAvnDS" returnvariable="query" method="init">
		<cfinvokeargument name="strQueryString" value="#FORM.query#" />
	</cfinvoke>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Perform General Queries on the AVN Datasource</title>
<style>
	body {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:11px;
		background-color:#CCCCCC;
	}
	#query {
		width:100%;
		height:350px;
		overflow:auto;
		background-color:#000000;
		font-size:9px;
		font-family:"Courier New", Courier, mono;
		color:#00CC00;
		border-type:solid;
		border-width:1px;
		border-color:#CCCCCC;
	}
	#frmQ {
		width:100%;
		height:300px;
		font-size:12px;
		font-family:"Courier New", Courier, mono;
		border-style:solid;
		border-width:1px;
		border-color:#DDDDDD;
		background-color:#000000;
		color:#FFFFFF;
	}
	input {
		font-size:9px;
		width:150px;
		font-family:"Courier New", Courier, mono;
		border-style:solid;
		border-width:1px;
		border-color:#000000;
	}
</style>
</head>

<body>
<h2>Perform General Queries on the AVN Sybase Datasource</h2>
<form name="avnQuery" action="#" method="post">
	<p>Enter Query String</p>
	<p><textarea id="frmQ" name="query"><cfif IsDefined("FORM.query")><cfoutput>#FORM.query#</cfoutput></cfif></textarea></p>
	<p><input type="submit" name="submit" value=" Execute Query " /></p>
</form>
<cfif IsDefined("query")>
	<div id="query">
		<cfdump var="#query#" />
	</div>
</cfif>
</body>
</html>
