<cfif IsDefined("FORM.from")>
	
			<!--- NOTAMS --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetNOTAMS" method="init" returnvariable="query">
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
			</cfinvoke>
		
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Notam Data QC Check</title>
<style>
	body {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:10px;
		background-color:#CCCCCC;
	}
	#query {
		width:100%;
		height:auto;
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
	#submit{
		font-size:9px;
		width:150px;
		font-family:"Courier New", Courier, mono;
		border-style:solid;
		border-width:1px;
		border-color:#000000;
	}
	#checkbox {
		width:10px;
		float:right;
		position:relative;
		top:-15px;
	}
	select {
		border-style:solid;
		border-width:1px;
		border-color:#000000;
		font-size:10px;
	}
	#form {
		width:150px;
	}
	p {
		padding:5px;
		border-bottom-style:dashed;
		border-bottom-width:1px;
		border-bottom-color:#000000;
	}
	#sigtable {
		width:100%;
	}
	#sigtable td {
		border-style:dashed;
		border-width:1px;
		border-color:#00CC00;
		padding:10px;
		font-family:"Courier New", Courier, mono;
		font-size:12px;
	}
</style>
</head>

<body>
	<h3>Please make selections below to view NOTAM Data.  This is for Data QC only</h3>
	<div id="form">
	<form name="notamQC" action="notamDataTest.cfm" method="post">
		
		<p>From:</p><p><select name="from">
					<option value="0">Current</option>
					<option value="1" <cfif IsDefined("FORM.from") AND (FORM.from EQ 1)>selected</cfif>>Past 1 hour</option>
					<option value="2" <cfif IsDefined("FORM.from") AND (FORM.from EQ 2)>selected</cfif>>Past 2 hours</option>
					<option value="3" <cfif IsDefined("FORM.from") AND (FORM.from EQ 3)>selected</cfif>>Past 3 hours</option>
					<option value="4" <cfif IsDefined("FORM.from") AND (FORM.from EQ 4)>selected</cfif>>Past 4 hours</option>
					<option value="5" <cfif IsDefined("FORM.from") AND (FORM.from EQ 5)>selected</cfif>>Past 5 hours</option>
					<option value="6" <cfif IsDefined("FORM.from") AND (FORM.from EQ 6)>selected</cfif>>Past 6 hours</option>
					<option value="12" <cfif IsDefined("FORM.from") AND (FORM.from EQ 12)>selected</cfif>>Past 12 hours</option>
					<option value="18" <cfif IsDefined("FORM.from") AND (FORM.from EQ 18)>selected</cfif>>Past 18 hours</option>
					<option value="24" <cfif IsDefined("FORM.from") AND (FORM.from EQ 24)>selected</cfif>>Past 24 hours</option>
					<option value="36" <cfif IsDefined("FORM.from") AND (FORM.from EQ 36)>selected</cfif>>Past 36 hours</option>
					<option value="48" <cfif IsDefined("FORM.from") AND (FORM.from EQ 48)>selected</cfif>>Past 48 hours</option>
					<option value="60" <cfif IsDefined("FORM.from") AND (FORM.from EQ 60)>selected</cfif>>Past 60 hours</option>
					<option value="72" <cfif IsDefined("FORM.from") AND (FORM.from EQ 72)>selected</cfif>>Past 72 hours</option>
				</select></p>
				<p>To:</p><p><select name="to">
					<option value="1" <cfif IsDefined("FORM.to") AND (FORM.to EQ 1)>selected</cfif>>Past 1 hour</option>
					<option value="2" <cfif IsDefined("FORM.to") AND (FORM.to EQ 2)>selected</cfif>>Past 2 hours</option>
					<option value="3" <cfif IsDefined("FORM.to") AND (FORM.to EQ 3)>selected</cfif>>Past 3 hours</option>
					<option value="4" <cfif IsDefined("FORM.to") AND (FORM.to EQ 4)>selected</cfif>>Past 4 hours</option>
					<option value="5" <cfif IsDefined("FORM.to") AND (FORM.to EQ 5)>selected</cfif>>Past 5 hours</option>
					<option value="6" <cfif IsDefined("FORM.to") AND (FORM.to EQ 6)>selected</cfif>>Past 6 hours</option>
					<option value="12" <cfif IsDefined("FORM.to") AND (FORM.to EQ 12)>selected</cfif>>Past 12 hours</option>
					<option value="18" <cfif IsDefined("FORM.to") AND (FORM.to EQ 18)>selected</cfif>>Past 18 hours</option>
					<option value="24" <cfif IsDefined("FORM.to") AND (FORM.to EQ 24)>selected</cfif>>Past 24 hours</option>
					<option value="36" <cfif IsDefined("FORM.to") AND (FORM.to EQ 36)>selected</cfif>>Past 36 hours</option>
					<option value="48" <cfif IsDefined("FORM.to") AND (FORM.to EQ 48)>selected</cfif>>Past 48 hours</option>
					<option value="60" <cfif IsDefined("FORM.to") AND (FORM.to EQ 60)>selected</cfif>>Past 60 hours</option>
					<option value="72" <cfif IsDefined("FORM.to") AND (FORM.to EQ 72)>selected</cfif>>Past 72 hours</option>
				</select></p>
				<p><input id="submit" name="submit" value="submit" type="submit" /></p>
	</form>
</div>
<cfif IsDefined("query")>
	<div id="query">
		<table id="sigtable">
			<tr>
				<td>Alt ID</td>
				<td>Created Time</td>
				<td>Current Time</td>
				<td>Notam ID</td>
				<td>Origin</td>
				<td>Origin Desc</td>
				<td>Type</td>
				<td>Message</td>
			</tr>
			<cfoutput query="query">
			<tr>
				<td>#query.Col_1#</td>
				<td>#query.Col_3#</td>
				<td>#query.Col_4#</td>
				<td>#query.Col_5#</td>
				<td>#query.Col_6#</td>
				<td>#query.Col_7#</td>
				<td>#query.Col_8#</td>
				<td>#query.Col_9#</td>
			</tr>
			</cfoutput>
		</table>
	</div>
</cfif>
</body>
</html>
