<cfif IsDefined("FORM.from")>
	<cfset variables.sigmetType = ArrayNew(1) />
	<cfif IsDefined("FORM.convection")>
		<cfset ArrayPrepend(variables.sigmetType,"CNVC") />
	</cfif>
	<cfif IsDefined("FORM.icing")>
		<cfset ArrayPrepend(variables.sigmetType,"ICNG") />
	</cfif>
	<cfif IsDefined("FORM.volcanic")>
		<cfset ArrayPrepend(variables.sigmetType,"VASH") />
	</cfif>
	<cfif IsDefined("FORM.turbulence")>
		<cfset ArrayPrepend(variables.sigmetType,"TURB") />
	</cfif>
	<cfswitch expression="#FORM.region#">
		<cfcase value="usa">
			<!--- USA --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="query">
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
				<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
			</cfinvoke>
		</cfcase>
		<cfcase value="neast">
			<!--- Northeast --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="query">
				<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 37 AND 48 AND
						  maxLon BETWEEN -85 AND -64)
						  OR
						  (maxLat BETWEEN 37 AND 49 AND
						  maxLon BETWEEN -85 AND -68))" />
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
				<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
			</cfinvoke>
		</cfcase>
		<cfcase value="seast">
			<!--- Southeast --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="query">
				<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 24 AND 37 AND
						  maxLon BETWEEN -90 AND -68)
						  OR
						  (maxLat BETWEEN 24 AND 37 AND
						  maxLon BETWEEN -90 AND -72))" />
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
				<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
			</cfinvoke>
		</cfcase>
		<cfcase value="ncent">
			<!--- North Central --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="query">
				<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 37 AND 49 AND
						  maxLon BETWEEN -105 AND -85)
						  OR
						  (maxLat BETWEEN 37 AND 49 AND
						  maxLon BETWEEN -105 AND -85))" />
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
				<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
			</cfinvoke>
		</cfcase>
		<cfcase value="scent">
			<!--- South Central --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="query">
				<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 25 AND 37 AND
						  maxLon BETWEEN -105 AND -90)
						  OR
						  (maxLat BETWEEN 25 AND 37 AND
						  maxLon BETWEEN -105 AND -90))" />
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
				<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
			</cfinvoke>
		</cfcase>
		<cfcase value="nwest">
			<!--- North West --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="query">
				<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 40 AND 49 AND
						  maxLon BETWEEN -125 AND -105)
						  OR
						  (maxLat BETWEEN 40 AND 49 AND
						  maxLon BETWEEN -125 AND -105))" />
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
				<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
			</cfinvoke>
		</cfcase>
		<cfcase value="swest">
			<!--- South West --->
			<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="query">
				<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 30 AND 40 AND
						  maxLon BETWEEN -125 AND -105)
						  OR
						  (maxLat BETWEEN 30 AND 40 AND
						  maxLon BETWEEN -125 AND -105))" />
				<cfinvokeargument name="intPeriodFrom" value="#FORM.from#" />
				<cfinvokeargument name="intPeriodTo" value="#FORM.to#" />
				<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
			</cfinvoke>
		</cfcase>
	</cfswitch>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Sigmet Data QC Check</title>
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
	<h3>Please make selections below to view SIGMET Data.  This is for Data QC only</h3>
	<div id="form">
	<form name="sigmetQC" action="sigmetDataTest.cfm" method="post">
		
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
				<hr />
				<h3>SIGMET Type</h3>
				<p>Icing: <input id="checkbox" name="icing" type="checkbox" value="ICNG" <cfif IsDefined("FORM.icing") AND (FORM.icing IS "ICNG")>checked</cfif> /></p>
				<p>Convection: <input id="checkbox" name="convection" type="checkbox" value="CNVC" <cfif IsDefined("FORM.convection") AND (FORM.convection IS "CNVC")>checked</cfif> /></p>
				<p>Turbulence: <input id="checkbox" name="turbulence" type="checkbox" value="TURB" <cfif IsDefined("FORM.turbulence") AND (FORM.turbulence IS "TURB")>checked</cfif> /></p>
				<p>Volcanic: <input id="checkbox" name="volcanic" type="checkbox" value="VASH" <cfif IsDefined("FORM.volcanic") AND (FORM.volcanic IS "VASH")>checked</cfif> /></p>
				<p>Region</p>
				<p>Entire U.S. <input id="checkbox" name="region" type="radio" value="usa" <cfif IsDefined("FORM.region") AND (FORM.region IS "usa")>checked</cfif> /></p>
				<p>North Eastern U.S. <input id="checkbox" name="region" type="radio" value="neast" <cfif IsDefined("FORM.region") AND (FORM.region IS "neast")>checked</cfif> /></p>
				<p>South Eastern U.S. <input id="checkbox" name="region" type="radio" value="seast" <cfif IsDefined("FORM.region") AND (FORM.region IS "seast")>checked</cfif>/></p>
				<p>North Central U.S. <input id="checkbox" name="region" type="radio" value="ncent" <cfif IsDefined("FORM.region") AND (FORM.region IS "ncent")>checked</cfif>/></p>
				<p>South Central U.S. <input id="checkbox" name="region" type="radio" value="scent" <cfif IsDefined("FORM.region") AND (FORM.region IS "scent")>checked</cfif>/></p>
				<p>North Western U.S. <input id="checkbox" name="region" type="radio" value="nwest" <cfif IsDefined("FORM.region") AND (FORM.region IS "nwest")>checked</cfif>/></p>
				<p>South Western U.S. <input id="checkbox" name="region" type="radio" value="swest" <cfif IsDefined("FORM.region") AND (FORM.region IS "swest")>checked</cfif> /></p>
				<p><input id="submit" name="submit" value="submit" type="submit" /></p>
	</form>
</div>
<cfif IsDefined("query")>
	<div id="query">
		<table id="sigtable">
			<tr>
				<td>Bulletin Name</td>
				<td>Created Time</td>
				<td>Direction</td>
				<td>End Time</td>
				<td>Flight Level 1</td>
				<td>Flight Level 2</td>
				<td>Intensity</td>
				<td>Issue Time</td>
				<td>Line Dist</td>
				<td>Max Lat</td>
				<td>Max Lon</td>
				<td>Min Lat</td>
				<td>Min Lon</td>
				<td>Origin</td>
				<td>Raw Msg</td>
				<td>Sigmet Type</td>
				<td>Speed</td>
				<td>Start Time</td>
				<td>Subtype</td>
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
				<td>#query.Col_10#</td>
				<td>#query.Col_11#</td>
				<td>#query.Col_12#</td>
				<td>#query.Col_13#</td>
				<td>#query.Col_14#</td>
				<td>#query.Col_15#</td>
				<td>#query.Col_16#</td>
				<td>#query.Col_19#</td>
				<td>#query.Col_20#</td>
				<td>#query.Col_21#</td>
				<td>#query.Col_22#</td>
			</tr>
			</cfoutput>
		</table>
	</div>
</cfif>
</body>
</html>
