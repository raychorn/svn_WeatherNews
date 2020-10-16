<cfif Not IsDefined("form.Submit")>
	<cflocation url="/default.htm?mID=6">
	<cfabort>
</cfif>

<!--- 
<cfset sFN="eMail,eMail,phone,commentsArea,FeatureID,CarrierID,HandsetID">
<cfset sFT="null,email,rdayPhone,null,null,null,null">

<cf_errorCheck fieldList = "#sFN#" fieldTypes= "#sFT#">


 --->





<cfoutput>
<!--- #FIELDNAMES# --->

<cfset FakeCheckBoxList = "">
<cfset SubFakeCheckBoxList = "">

<cfparam name="MaxRecords" default="200">
<cfif Not IsDefined("FORM.repType")>
	<cfset FORM.repType = "I did not get initalized" />
</cfif>
<cfswitch expression="#Form.RepType#">
	<cfcase value="1">
		<cfif ISDefined("DoWDDX") and IsDefined("wddxGetQuery")>
			<cfif IsWddx(wddxGetQuery)>
				<cfwddx action = "wddx2cfml" input = #wddxGetQuery# output = "getQuery">
			<cfelse>
				<cflocation url="default.htm?mID=6">
				<cfabort>	
			</cfif>
		<cfelse>
			
			<cfloop list="#FIELDNAMES#" index="FIndex">
				<cfif FindNoCase("FAKECHECKBOX_1",Findex)>
					<cfset FakeCheckBoxList = ListAppend(FakeCheckBoxList,Findex)>	
				</cfif>
			</cfloop>
			
			<cfif (ListLen(FakeCheckBoxList)) EQ 0>
				<cfset gErrString = "1">
			<cfelse>
				<cfif Region EQ "UserDef">
					<cfif Len(Stations) GTE 4>
						<cfif NOT LSIsNumeric(Stations)>
							<cfset newList = "">
							<cfloop list="#Stations#" delimiters="," index="ii">
								<cfset newList = ListAppend(newList,UCASE(TRIM(ii)),",")>
							</cfloop>
							<cfset qualifiedStations = ListQualify(newList,"'",",","CHAR")>
						<cfelse>
							<cfset gErrString = "9">
							<cfset gErrStringText = "The ICAO airport abbreviation is not valid">
						</cfif>
					<cfelse>
						<cfset gErrString = "9">
						<cfset gErrStringText = "No station was specified, or the ICAO airport abbreviation is not valid">
					</cfif>
				<cfelse>	
					<cfset qualifiedStations = ListQualify(#Evaluate(Region)#,"'",",","CHAR")>
				</cfif>
			</cfif>	
			
			<cfif NOT LEN(gErrString)>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_11")>
						<cfquery name="getQuery" datasource="#AVNOPS_DS#">
							SELECT 
									Col_1=M.icaoID, 
									Col_2=convert(Char(5),M.oTime,1) + ' ' +  convert(Char(5),M.oTime,8) + 'Z', ---M.oTime, 
									Col_3=M.rawMsg, 
									Col_4=M.id, 
									Col_5=M.lat, 
									Col_6=M.lon, 
									Col_7=M.status, 
									MyOrder = CASE M.icaoID
												WHEN 'KJFK' THEN 1
												WHEN 'EGSS' THEN 2
												ELSE 9
												END
							FROM obsdb..METAR M
							WHERE 1=1
								AND M.icaoID IN (#PreserveSingleQuotes(qualifiedStations)#)
								AND M.oTime <= DATEADD(hh,-#PeriodFrom#,getdate())
								AND M.oTime >= DATEADD(hh,-#PeriodTo#,getdate())
							ORDER BY MyOrder, M.icaoID, M.oTime DESC    
						</cfquery>
						<cfset ColNameList = "ICAO;Time;METAR"> 		

						<cfif getQuery.RecordCount EQ 0>
							<cfset gErrString = "2">
						<cfelseif getQuery.RecordCount GT MaxRecords>
							<cfset gErrString = "3">
						</cfif>
			
						<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
						<cfset wddxGetQuery = #wddxText#>
					
				</cfif>	
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_12")>
					
					<cfquery name="getQuery" datasource="#AVNOPS_DS#">
					SELECT 
							Col_1=M.icaoID, 
							Col_2=convert(Char(5),M.iTime,1) + ' ' +  convert(Char(5),M.iTime,8) + 'Z', ---M.iTime, 
							Col_3=M.origin, 
							Col_4=convert(varchar(2500),M.rawMsg), 
							Col_5=M.id, 
							Col_6=M.lat, 
							Col_7=M.lon, 
							Col_8=M.status,
							Col_9=M.iTime,
							MyOrder = CASE M.icaoID
										WHEN 'KJFK' THEN 1
										WHEN 'EGSS' THEN 2
										ELSE 9
									END,
							MyOrder2 = CASE M.origin
									WHEN 'KWNI' THEN 1
									ELSE 9
									END
					FROM avnfcstdb..TAF M
					where 1=1
						AND M.icaoID IN (#PreserveSingleQuotes(qualifiedStations)#)
						AND M.iTime <= DATEADD(hh,-#PeriodFrom#,getdate())
						AND M.iTime >= DATEADD(hh,-#PeriodTo#,getdate())
    					AND M.status = 0
					    AND M.origin = 'KWBC'

					UNION	

					SELECT 
							Col_1=M.icaoID, 
							Col_2=convert(Char(5),M.iTime,1) + ' ' +  convert(Char(5),M.iTime,8) + 'Z', ---M.iTime, 
							Col_3=M.origin, 
							Col_4=convert(varchar(2500),M.rawMsg), 
							Col_5=M.id, 
							Col_6=M.lat, 
							Col_7=M.lon, 
							Col_8=M.status,
							Col_9=M.iTime,
							MyOrder = CASE M.icaoID
										WHEN 'KJFK' THEN 1
										WHEN 'EGSS' THEN 2
										ELSE 9
									END,
							MyOrder2 = CASE M.origin
									WHEN 'KWNI' THEN 1
									ELSE 9
									END
					FROM avnfcstdb..TAF M
					WHERE 1=1
						AND M.icaoID IN (#PreserveSingleQuotes(qualifiedStations)#)
						AND M.iTime <= DATEADD(hh,-#PeriodFrom#,getdate())
						AND M.iTime >= DATEADD(hh,-#PeriodTo#,getdate())
					    AND M.origin <> 'KWBC'
    					AND M.status = 2
					    AND M.iTime NOT IN (SELECT iTime FROM avnfcstdb..TAF
											where 1=1
											AND icaoID IN (#PreserveSingleQuotes(qualifiedStations)#)
											AND iTime <= DATEADD(hh,-#PeriodFrom#,getdate())
											AND iTime >= DATEADD(hh,-#PeriodTo#,getdate())
					    					AND status = 0
										    AND origin = 'KWBC')
---					ORDER BY M.MyOrder2,M.MyOrder,M.icaoID,M.iTime DESC    
					ORDER BY M.MyOrder,M.icaoID,M.MyOrder2,M.iTime DESC    
				</cfquery>
				<cfset ColNameList = "ICAO;Time;Origin;TAF"> 
				<cfset SpecialCol = 3>

						<cfif getQuery.RecordCount EQ 0>
							<cfset gErrString = "2">
						<cfelseif getQuery.RecordCount GT MaxRecords>
							<cfset gErrString = "3">
						</cfif>
			
						<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
						<cfset wddxGetQuery = #wddxText#>
				</cfif>	
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_13") OR ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_3")>
						<!--- NOTAMS --->
						<cfinvoke component="com.weathernews.beacon.DAO.qryGetNOTAMS" method="init" returnvariable="getQuery">
							<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
							<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
							<cfif Not IsDefined("pType") OR pType EQ "">
								<cfinvokeargument name="notamType" value="all" />
							<cfelse>
								<cfinvokeargument name="notamType" value="#nType#" />
							</cfif>
							<cfif IsDefined("Notam_Stations") AND Notam_Stations NEQ "">
								<cfinvokeargument name="icaoSearch" value="#Notam_Stations#" />
							</cfif>
						</cfinvoke>
						<cfset ColNameList = "Notam ID;Type;Created Time;Origin;Message"> 
						<cfset SpecialCol = 3>

						<cfif getQuery.RecordCount EQ 0>
							<cfset gErrString = "2">
						<cfelseif getQuery.RecordCount GT MaxRecords>
							<cfset gErrString = "3">
						</cfif>
			
						<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
						<cfset wddxGetQuery = #wddxText#>
				</cfif>
			</cfif>

		</cfif>	

	</cfcase>
	
	
	<cfcase value="2">
		<cfif ISDefined("DoWDDX") and IsDefined("wddxGetQuery")>
			<cfif IsWddx(wddxGetQuery)>
				<cfwddx action = "wddx2cfml" input = #wddxGetQuery# output = "getQuery">
			<cfelse>
				<cflocation url="default.htm?mID=6">
				<cfabort>	
			</cfif>
		<cfelse>
		
		
		<cfloop list="#FIELDNAMES#" index="FIndex">
			<cfif FindNoCase("FAKECHECKBOX_2",Findex)>
				<cfset FakeCheckBoxList = ListAppend(FakeCheckBoxList,Findex)>	
			</cfif>
			<cfif FindNoCase("SUBFAKECHECKBOX_S2",Findex)>
				<cfset SubFakeCheckBoxList = ListAppend(SubFakeCheckBoxList,Findex)>	
			</cfif>
		</cfloop>
		<cfif ListLen(SubFakeCheckBoxList) EQ 0 >
			<cfset gErrString = "1">
		<cfelse>
			<cfif ListLen(FakeCheckBoxList) EQ 0 > <!--- Needs at least one subtype --->
				<!--- <cfoutput>fakecheckboxlist is not defined</cfoutput> --->
				<cfset gErrString = "1">
			</cfif>
			<cfset variables.arrTypes = ArrayNew(1) />
			<cfset variables.arrRegions = ArrayNew(1) />

				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_21")>
					<cfset ArrayPrepend(variables.arrTypes,"ICNG") />
				</cfif>	
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_22")>
					<cfset ArrayPrepend(variables.arrTypes,"TURB") />
				</cfif>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_23")>
					<cfset ArrayPrepend(variables.arrTypes,"CNVC") />
				</cfif>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_24")>
					<cfset ArrayPrepend(variables.arrTypes,"VASH") />
				</cfif>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_25")>
					<cfset ArrayPrepend(variables.arrTypes,"SAND") />
				</cfif>
				
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S21")>
				<!--- Entire US --->
				<cfset ArrayAppend(variables.arrRegions,"'USA'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S218")>
				<!--- Eastern US --->
				<cfset ArrayAppend(variables.arrRegions,"'USA' AND d.SubDomain='' ) OR (d.Domain = 'USA' AND d.SubDomain = 'Eastern USA' ") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S219")>
				<!--- Central US --->
				<cfset ArrayAppend(variables.arrRegions,"'USA' AND d.SubDomain='' ) OR (d.Domain = 'USA' AND d.SubDomain = 'Central USA' ") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S220")>
				<!--- Western US --->
				<cfset ArrayAppend(variables.arrRegions,"'USA' AND d.SubDomain='' ) OR (d.Domain = 'USA' AND d.SubDomain = 'Western USA' ") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S221")>
				<!--- Eastern Canada --->
				<cfset ArrayAppend(variables.arrRegions,"'Canada' AND d.SubDomain='' ) OR (d.Domain = 'Canada' AND d.SubDomain = 'Eastern Canada' ") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S222")>
				<!--- Western Canada --->
				<cfset ArrayAppend(variables.arrRegions,"'Canada' AND d.SubDomain='' ) OR (d.Domain = 'Canada' AND d.SubDomain = 'Western Canada' ") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S223")>
				<!--- Alaska --->
				<cfset ArrayAppend(variables.arrRegions,"'Alaska'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S224")>
				<!--- Caribbean --->
				<cfset ArrayAppend(variables.arrRegions,"'Caribbean'") />
				<cfset ArrayAppend(variables.arrRegions,"'Gulf of Mexico'") />
				<cfset ArrayAppend(variables.arrRegions,"'Caribbean / Gulf of Mexico'") />
				<cfset ArrayAppend(variables.arrRegions,"'Cuba'") />
				<cfset ArrayAppend(variables.arrRegions,"'Dominican Republic'") />
				<cfset ArrayAppend(variables.arrRegions,"'Netherlands Antilles'") />
				<cfset ArrayAppend(variables.arrRegions,"'Trinidad and Tobago'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S225")>
				<!--- Central America --->
				<cfset ArrayAppend(variables.arrRegions,"'Central America'") />
				<cfset ArrayAppend(variables.arrRegions,"'Caribbean / Central America'") />
				<cfset ArrayAppend(variables.arrRegions,"'Guatemala'") />
				<cfset ArrayAppend(variables.arrRegions,"'Honduras'") />
				<cfset ArrayAppend(variables.arrRegions,"'Mexico'") />
				<cfset ArrayAppend(variables.arrRegions,"'Panama'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S226")>
				<!--- South America --->
				<cfset ArrayAppend(variables.arrRegions,"'Argentina'") />
				<cfset ArrayAppend(variables.arrRegions,"'South America'") />
				<cfset ArrayAppend(variables.arrRegions,"'Brazil'") />
				<cfset ArrayAppend(variables.arrRegions,"'Bolivia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Chile'") />
				<cfset ArrayAppend(variables.arrRegions,"'Colombia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Equador'") />
				<cfset ArrayAppend(variables.arrRegions,"'French Guiana'") />
				<cfset ArrayAppend(variables.arrRegions,"'Guyana'") />
				<cfset ArrayAppend(variables.arrRegions,"'Paraguay'") />
				<cfset ArrayAppend(variables.arrRegions,"'Peru'") />
				<cfset ArrayAppend(variables.arrRegions,"'Suriname'") />
				<cfset ArrayAppend(variables.arrRegions,"'Uruguay'") />
				<cfset ArrayAppend(variables.arrRegions,"'Venezuela'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S227")>
				<!--- Western Europe --->
				<cfset ArrayAppend(variables.arrRegions,"'Western Europe'") />
				<cfset ArrayAppend(variables.arrRegions,"'Mediterranean'") />
				<cfset ArrayAppend(variables.arrRegions,"'Central Mediterranean'") />
				<cfset ArrayAppend(variables.arrRegions,"'Europe'") />
				<cfset ArrayAppend(variables.arrRegions,"'Austria'") />
				<cfset ArrayAppend(variables.arrRegions,"'Belgium / Luxembourg'") />
				<cfset ArrayAppend(variables.arrRegions,"'Denmark'") />
				<cfset ArrayAppend(variables.arrRegions,"'France'") />
				<cfset ArrayAppend(variables.arrRegions,"'Germany'") />
				<cfset ArrayAppend(variables.arrRegions,"'Ireland'") />
				<cfset ArrayAppend(variables.arrRegions,"'Italy'") />
				<cfset ArrayAppend(variables.arrRegions,"'Netherlands'") />
				<cfset ArrayAppend(variables.arrRegions,"'Norway'") />
				<cfset ArrayAppend(variables.arrRegions,"'Portugal'") />
				<cfset ArrayAppend(variables.arrRegions,"'Spain'") />
				<cfset ArrayAppend(variables.arrRegions,"'Sweden'") />
				<cfset ArrayAppend(variables.arrRegions,"'Switzerland'") />
				<cfset ArrayAppend(variables.arrRegions,"'UK'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S228")>
				<!--- Eastern Europe --->
				<cfset ArrayAppend(variables.arrRegions,"'Eastern Europe'") />
				<cfset ArrayAppend(variables.arrRegions,"'Mediterranean'") />
				<cfset ArrayAppend(variables.arrRegions,"'Eastern Mediterranean'") />
				<cfset ArrayAppend(variables.arrRegions,"'Europe'") />
				<cfset ArrayAppend(variables.arrRegions,"'Eastern Europe'") />
				<cfset ArrayAppend(variables.arrRegions,"'Belarus'") />
				<cfset ArrayAppend(variables.arrRegions,"'Bulgaria'") />
				<cfset ArrayAppend(variables.arrRegions,"'Croatia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Cyprus'") />
				<cfset ArrayAppend(variables.arrRegions,"'Czech Republic'") />
				<cfset ArrayAppend(variables.arrRegions,"'Estonia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Finland'") />
				<cfset ArrayAppend(variables.arrRegions,"'Greece'") />
				<cfset ArrayAppend(variables.arrRegions,"'Hungary'") />
				<cfset ArrayAppend(variables.arrRegions,"'Latvia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Lithuania'") />
				<cfset ArrayAppend(variables.arrRegions,"'Macedonia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Moldova'") />
				<cfset ArrayAppend(variables.arrRegions,"'Poland'") />
				<cfset ArrayAppend(variables.arrRegions,"'Romania'") />
				<cfset ArrayAppend(variables.arrRegions,"'Slovakia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Slovenia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Yugoslavia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Western Russia'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S229")>
				<!--- Middle East --->
				<cfset ArrayAppend(variables.arrRegions,"'Middle East'") />
				<cfset ArrayAppend(variables.arrRegions,"'Eastern Mediterranean'") />
				<cfset ArrayAppend(variables.arrRegions,"'Near East'") />
				<cfset ArrayAppend(variables.arrRegions,"'Bahrain'") />
				<cfset ArrayAppend(variables.arrRegions,"'Israel'") />
				<cfset ArrayAppend(variables.arrRegions,"'Iran'") />
				<cfset ArrayAppend(variables.arrRegions,"'Lebanon'") />
				<cfset ArrayAppend(variables.arrRegions,"'Oman'") />
				<cfset ArrayAppend(variables.arrRegions,"'Saudi Arabia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Turkey'") />
				<cfset ArrayAppend(variables.arrRegions,"'Yemen'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S230")>
				<!--- Central Asia --->
				<cfset ArrayAppend(variables.arrRegions,"'Bangladesh'") />
				<cfset ArrayAppend(variables.arrRegions,"'India'") />
				<cfset ArrayAppend(variables.arrRegions,"'Pakistan'") />
				<cfset ArrayAppend(variables.arrRegions,"'Singapore'") />
				<cfset ArrayAppend(variables.arrRegions,"'Sri Lanka'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S231")>
				<!--- Kazakhstan / Russia --->
				<cfset ArrayAppend(variables.arrRegions,"'Kazakhstan'") />
				<cfset ArrayAppend(variables.arrRegions,"'Western Russia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Eastern Russia'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S232")>
				<!--- Eastern Asia --->
				<cfset ArrayAppend(variables.arrRegions,"'Eastern Asia'") />
				<cfset ArrayAppend(variables.arrRegions,"'China'") />
				<cfset ArrayAppend(variables.arrRegions,"'Japan'") />
				<cfset ArrayAppend(variables.arrRegions,"'Korea'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S233")>
				<!--- Southeast Asia --->
				<cfset ArrayAppend(variables.arrRegions,"'Southeast Asia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Hong Kong'") />
				<cfset ArrayAppend(variables.arrRegions,"'Indonesia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Singapore'") />
				<cfset ArrayAppend(variables.arrRegions,"'South China Sea'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S234")>
				<!--- Australia / New Zealand --->
				<cfset ArrayAppend(variables.arrRegions,"'Australia'") />
				<cfset ArrayAppend(variables.arrRegions,"'New Zealand'") />
				<cfset ArrayAppend(variables.arrRegions,"'Fiji'") />
				<cfset ArrayAppend(variables.arrRegions,"'French Polynesia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Oceania'") />
				<cfset ArrayAppend(variables.arrRegions,"'Papua New Guinea'") />
				<cfset ArrayAppend(variables.arrRegions,"'South China Sea'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S235")>
				<!--- Africa --->
				<cfset ArrayAppend(variables.arrRegions,"'Africa'") />
				<cfset ArrayAppend(variables.arrRegions,"'West Africa'") />
				<cfset ArrayAppend(variables.arrRegions,"'Central Africa'") />
				<cfset ArrayAppend(variables.arrRegions,"'Algeria'") />
				<cfset ArrayAppend(variables.arrRegions,"'Botswana'") />
				<cfset ArrayAppend(variables.arrRegions,"'Chad'") />
				<cfset ArrayAppend(variables.arrRegions,"'Congo'") />
				<cfset ArrayAppend(variables.arrRegions,"'Egypt'") />
				<cfset ArrayAppend(variables.arrRegions,"'Malawi'") />
				<cfset ArrayAppend(variables.arrRegions,"'Morocco'") />
				<cfset ArrayAppend(variables.arrRegions,"'Senegal'") />
				<cfset ArrayAppend(variables.arrRegions,"'Somalia'") />
				<cfset ArrayAppend(variables.arrRegions,"'South Africa'") />
				<cfset ArrayAppend(variables.arrRegions,"'Sudan'") />
				<cfset ArrayAppend(variables.arrRegions,"'Tunisia'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S236")>
				<!--- North Atlantic --->
				<cfset ArrayAppend(variables.arrRegions,"'North Atlantic'") />
				<cfset ArrayAppend(variables.arrRegions,"'Atlantic'") />
				<cfset ArrayAppend(variables.arrRegions,"'Azores'") />
				<cfset ArrayAppend(variables.arrRegions,"'Iceland'") />
				<cfset ArrayAppend(variables.arrRegions,"'Greenland'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S237")>
				<!--- Western Atlantic --->
				<cfset ArrayAppend(variables.arrRegions,"'North Atlantic' AND d.SubDomain='' ) OR (d.Domain = 'North Atlantic' AND d.SubDomain = 'New York Oceanic'  ") />
				<cfset ArrayAppend(variables.arrRegions,"'Caribbean / Gulf of Mexico' AND d.SubDomain='' ) OR (d.Domain = 'Caribbean / Gulf of Mexico' AND d.SubDomain = 'Miami Oceanic FIR'  ") />
				<cfset ArrayAppend(variables.arrRegions,"'Caribbean / Gulf of Mexico' AND d.SubDomain='' ) OR (d.Domain = 'Caribbean / Gulf of Mexico' AND d.SubDomain = 'San Juan FIR'  ") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S238")>
				<!--- Central Atlantic --->
				<cfset ArrayAppend(variables.arrRegions,"'Atlantic'") />
				<cfset ArrayAppend(variables.arrRegions,"'North Atlantic' AND d.SubDomain='' ) OR (d.Domain = 'North Atlantic' AND d.SubDomain = 'New York Oceanic FIR'  ") />
				<cfset ArrayAppend(variables.arrRegions,"'Azores' AND d.SubDomain='' ) OR (d.Domain = 'Azores' AND d.SubDomain = 'Santa Maria FIR'  ") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S239")>
				<!--- South Atlantic --->
				<cfset ArrayAppend(variables.arrRegions,"'Atlantic'") />
				<cfset ArrayAppend(variables.arrRegions,"'South Atlantic'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S240")>
				<!--- North Pacific --->
				<cfset ArrayAppend(variables.arrRegions,"'North Pacific'") />
				<cfset ArrayAppend(variables.arrRegions,"'Pacific'") />
				<cfset ArrayAppend(variables.arrRegions,"'Western North Pacific'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S241")>
				<!--- Central Pacific --->
				<cfset ArrayAppend(variables.arrRegions,"'Pacific'") />
				<cfset ArrayAppend(variables.arrRegions,"'North Pacific' AND d.SubDomain='' ) OR (d.Domain = 'North Pacific' AND d.SubDomain = 'Oakland Oceanic FIR'  ") />
				<cfset ArrayAppend(variables.arrRegions,"'Western North Pacific'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S242")>
				<!--- South Pacific --->
				<cfset ArrayAppend(variables.arrRegions,"'South Pacific'") />
				<cfset ArrayAppend(variables.arrRegions,"'Pacific'") />
				<cfset ArrayAppend(variables.arrRegions,"'South China Sea'") />
				<cfset ArrayAppend(variables.arrRegions,"'Fiji'") />
				<cfset ArrayAppend(variables.arrRegions,"'French Polynesia'") />
				<cfset ArrayAppend(variables.arrRegions,"'Oceania'") />
				<cfset ArrayAppend(variables.arrRegions,"'Papua New Guinea'") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S243")>
				<!--- Indian Ocean --->
				<cfset ArrayAppend(variables.arrRegions,"'Indian Ocean'") />
				<cfset ArrayAppend(variables.arrRegions,"'South China Sea'") />
			</cfif>
			<cfif NOT IsDefined("gErrString") OR gErrString NEQ 1>
				<cfinvoke component="com.weathernews.beacon.DAO.getNewTextSIGMETS" method="init" returnvariable="getQuery">
						<cfinvokeargument name="arrRegions" value="#variables.arrRegions#" />
						<cfinvokeargument name="intStartOffset" value="#PeriodFrom#" />
						<cfinvokeargument name="intFinishOffset" value="#PeriodTo#" />
						<cfinvokeargument name="arrSubTypes" value="#variables.arrTypes#" />
						<cfinvokeargument name="strType" value="SIGMET" />
				</cfinvoke>
			<cfelse>
				<cfset gErrString = 1 />
				<cfset getQuery.RecordCount = 2 />
			</cfif>
				<cfset ColNameList = "Name;Issued;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
		</cfif>
		</cfif>
	</cfcase>
	
	<cfcase value="3">
		<cfset gErrString = "9">
		<cfset gErrStringText = "This feature is not implemented yet.">
	</cfcase>
	
	<cfcase value="4">
		<cfif ISDefined("DoWDDX") and IsDefined("wddxGetQuery")>
			<cfif IsWddx(wddxGetQuery)>
				<cfwddx action = "wddx2cfml" input = #wddxGetQuery# output = "getQuery">
			<cfelse>
				<cflocation url="default.htm?mID=6">
				<cfabort>	
			</cfif>
		<cfelse>
		
		
		<cfloop list="#FIELDNAMES#" index="FIndex">
			<cfif FindNoCase("FAKECHECKBOX_4",Findex)>
				<cfset FakeCheckBoxList = ListAppend(FakeCheckBoxList,Findex)>	
			</cfif>
			<cfif FindNoCase("SUBFAKECHECKBOX_S4",Findex)>
				<cfset SubFakeCheckBoxList = ListAppend(SubFakeCheckBoxList,Findex)>	
			</cfif>
		</cfloop>
		<cfif ListLen(SubFakeCheckBoxList) EQ 0 >
			<cfset gErrString = "1">
		<cfelse>
			<cfif ListLen(FakeCheckBoxList) EQ 0 > <!--- Needs at least one subtype --->
				<cfset gErrString = "1">
			</cfif>
			<cfset variables.airmetType = ArrayNew(1) />
			<cfset variables.strWhereClause = ArrayNew(1) />
			<!--- <cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" > --->
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_41")>
					<cfset ArrayPrepend(variables.airmetType,"ICNG") />
				</cfif>	
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_42")>
					<cfset ArrayPrepend(variables.airmetType,"TURB") />
				</cfif>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_43")>
					<cfset ArrayPrepend(variables.airmetType,"CNVC") />
				</cfif>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_44")>
					<cfset ArrayPrepend(variables.airmetType,"VASH") />
				</cfif>
				
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S41")>
				<!--- Entire US --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
							((maxLat BETWEEN 25 AND 49 AND
							  maxLon BETWEEN -125 AND -67)
							  OR
							  (maxLat BETWEEN 25 AND 49 AND
							  maxLon BETWEEN -125 AND -67)) OR 
							 ((minLat BETWEEN 25 AND 49 AND
							  minLon BETWEEN -125 AND -67)
							  OR
							  (minLat BETWEEN 25 AND 49 AND
							  minLon BETWEEN -125 AND -67))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 25 AND 49 AND
							  maxLon BETWEEN -125 AND -67)
							  OR
							  (maxLat BETWEEN 25 AND 49 AND
							  maxLon BETWEEN -125 AND -67)) OR 
							 ((minLat BETWEEN 25 AND 49 AND
							  minLon BETWEEN -125 AND -67)
							  OR
							  (minLat BETWEEN 25 AND 49 AND
							  minLon BETWEEN -125 AND -67))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S42")>
				<!--- Northeast --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
							((maxLat BETWEEN 37 AND 48 AND
							  maxLon BETWEEN -85 AND -64)
							  OR
							  (maxLat BETWEEN 37 AND 49 AND
							  maxLon BETWEEN -85 AND -68)) OR
							 ((minLat BETWEEN 37 AND 48 AND
							  minLon BETWEEN -85 AND -64)
							  OR
							  (minLat BETWEEN 37 AND 49 AND
							  minLon BETWEEN -85 AND -68))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 37 AND 48 AND
							  maxLon BETWEEN -85 AND -64)
							  OR
							  (maxLat BETWEEN 37 AND 49 AND
							  maxLon BETWEEN -85 AND -68)) OR
							 ((minLat BETWEEN 37 AND 48 AND
							  minLon BETWEEN -85 AND -64)
							  OR
							  (minLat BETWEEN 37 AND 49 AND
							  minLon BETWEEN -85 AND -68))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S43")>
				<!--- Southeast --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
							((maxLat BETWEEN 24 AND 37 AND
							  maxLon BETWEEN -90 AND -68)
							  OR
							  (maxLat BETWEEN 24 AND 37 AND
							  maxLon BETWEEN -90 AND -72)) OR
							 ((minLat BETWEEN 24 AND 37 AND
							  minLon BETWEEN -90 AND -68)
							  OR
							  (minLat BETWEEN 24 AND 37 AND
							  minLon BETWEEN -90 AND -72))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 24 AND 37 AND
							  maxLon BETWEEN -90 AND -68)
							  OR
							  (maxLat BETWEEN 24 AND 37 AND
							  maxLon BETWEEN -90 AND -72)) OR
							 ((minLat BETWEEN 24 AND 37 AND
							  minLon BETWEEN -90 AND -68)
							  OR
							  (minLat BETWEEN 24 AND 37 AND
							  minLon BETWEEN -90 AND -72))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S44")>
				<!--- North Central --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
							((maxLat BETWEEN 37 AND 49 AND
							  maxLon BETWEEN -105 AND -85)
							  OR
							  (maxLat BETWEEN 37 AND 49 AND
							  maxLon BETWEEN -105 AND -85)) OR
							 ((minLat BETWEEN 37 AND 49 AND
							  minLon BETWEEN -105 AND -85)
							  OR
							  (minLat BETWEEN 37 AND 49 AND
							  minLon BETWEEN -105 AND -85))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 37 AND 49 AND
							  maxLon BETWEEN -105 AND -85)
							  OR
							  (maxLat BETWEEN 37 AND 49 AND
							  maxLon BETWEEN -105 AND -85)) OR
							 ((minLat BETWEEN 37 AND 49 AND
							  minLon BETWEEN -105 AND -85)
							  OR
							  (minLat BETWEEN 37 AND 49 AND
							  minLon BETWEEN -105 AND -85))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S45")>
				<!--- South Central --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
							((maxLat BETWEEN 25 AND 37 AND
							  maxLon BETWEEN -105 AND -90)
							  OR
							  (maxLat BETWEEN 25 AND 37 AND
							  maxLon BETWEEN -105 AND -90)) OR
							 ((minLat BETWEEN 25 AND 37 AND
							  minLon BETWEEN -105 AND -90)
							  OR
							  (minLat BETWEEN 25 AND 37 AND
							  minLon BETWEEN -105 AND -90))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 25 AND 37 AND
							  maxLon BETWEEN -105 AND -90)
							  OR
							  (maxLat BETWEEN 25 AND 37 AND
							  maxLon BETWEEN -105 AND -90)) OR
							 ((minLat BETWEEN 25 AND 37 AND
							  minLon BETWEEN -105 AND -90)
							  OR
							  (minLat BETWEEN 25 AND 37 AND
							  minLon BETWEEN -105 AND -90))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S46")>
				<!--- North West --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
							((maxLat BETWEEN 40 AND 49 AND
							  maxLon BETWEEN -125 AND -105)
							  OR
							  (maxLat BETWEEN 40 AND 49 AND
							  maxLon BETWEEN -125 AND -105)) OR
							 ((minLat BETWEEN 40 AND 49 AND
							  minLon BETWEEN -125 AND -105)
							  OR
							  (minLat BETWEEN 40 AND 49 AND
							  minLon BETWEEN -125 AND -105))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 40 AND 49 AND
							  maxLon BETWEEN -125 AND -105)
							  OR
							  (maxLat BETWEEN 40 AND 49 AND
							  maxLon BETWEEN -125 AND -105)) OR
							 ((minLat BETWEEN 40 AND 49 AND
							  minLon BETWEEN -125 AND -105)
							  OR
							  (minLat BETWEEN 40 AND 49 AND
							  minLon BETWEEN -125 AND -105))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S47")>
				<!--- South West --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 30 AND 40 AND
						  maxLon BETWEEN -125 AND -105)
						  OR
						  (maxLat BETWEEN 30 AND 40 AND
						  maxLon BETWEEN -125 AND -105)) OR
						 ((minLat BETWEEN 30 AND 40 AND
						  minLon BETWEEN -125 AND -105)
						  OR
						  (minLat BETWEEN 30 AND 40 AND
						  minLon BETWEEN -125 AND -105))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 30 AND 40 AND
						  maxLon BETWEEN -125 AND -105)
						  OR
						  (maxLat BETWEEN 30 AND 40 AND
						  maxLon BETWEEN -125 AND -105)) OR
						 ((minLat BETWEEN 30 AND 40 AND
						  minLon BETWEEN -125 AND -105)
						  OR
						  (minLat BETWEEN 30 AND 40 AND
						  minLon BETWEEN -125 AND -105))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S48")>
				<!--- Western Canada --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 48 AND 70 AND
						  maxLon BETWEEN -141 AND -95)
						  OR
						  (maxLat BETWEEN 48 AND 83 AND
						  maxLon BETWEEN -141 AND -95)) OR
						 ((minLat BETWEEN 48 AND 70 AND
						  minLon BETWEEN -141 AND -95)
						  OR
						  (minLat BETWEEN 48 AND 83 AND
						  minLon BETWEEN -141 AND -95))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 48 AND 70 AND
						  maxLon BETWEEN -141 AND -95)
						  OR
						  (maxLat BETWEEN 48 AND 83 AND
						  maxLon BETWEEN -141 AND -95)) OR
						 ((minLat BETWEEN 48 AND 70 AND
						  minLon BETWEEN -141 AND -95)
						  OR
						  (minLat BETWEEN 48 AND 83 AND
						  minLon BETWEEN -141 AND -95))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S49")>
				<!--- Eastern Canada --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 46 AND 48 AND
						  maxLon BETWEEN -95 AND -50)
						  OR
						  (maxLat BETWEEN 41 AND 85 AND
						  maxLon BETWEEN -82 AND -60)
						  OR
						  (maxLat BETWEEN 46 AND 83 AND
						  maxLon BETWEEN -95 AND -50)) OR
						 ((minLat BETWEEN 46 AND 48 AND
						  minLon BETWEEN -95 AND -50)
						  OR
						  (minLat BETWEEN 41 AND 85 AND
						  minLon BETWEEN -82 AND -60)
						  OR
						  (minLat BETWEEN 46 AND 83 AND
						  minLon BETWEEN -95 AND -50))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 46 AND 48 AND
						  maxLon BETWEEN -95 AND -50)
						  OR
						  (maxLat BETWEEN 41 AND 85 AND
						  maxLon BETWEEN -82 AND -60)
						  OR
						  (maxLat BETWEEN 46 AND 83 AND
						  maxLon BETWEEN -95 AND -50)) OR
						 ((minLat BETWEEN 46 AND 48 AND
						  minLon BETWEEN -95 AND -50)
						  OR
						  (minLat BETWEEN 41 AND 85 AND
						  minLon BETWEEN -82 AND -60)
						  OR
						  (minLat BETWEEN 46 AND 83 AND
						  minLon BETWEEN -95 AND -50))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S490")>
				<!--- Alaska --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 52 AND 72 AND
						  maxLon BETWEEN -172 AND -140)
						  OR
						  (maxLat BETWEEN 52 AND 72 AND
						  maxLon BETWEEN -172 AND -130)) OR
						 ((minLat BETWEEN 52 AND 72 AND
						  minLon BETWEEN -172 AND -140)
						  OR
						  (minLat BETWEEN 52 AND 72 AND
						  minLon BETWEEN -172 AND -130))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 52 AND 72 AND
						  maxLon BETWEEN -172 AND -140)
						  OR
						  (maxLat BETWEEN 52 AND 72 AND
						  maxLon BETWEEN -172 AND -130)) OR
						 ((minLat BETWEEN 52 AND 72 AND
						  minLon BETWEEN -172 AND -140)
						  OR
						  (minLat BETWEEN 52 AND 72 AND
						  minLon BETWEEN -172 AND -130))") />
			</cfif>
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S491")>
				<!--- Hawaii --->
				<!--- <cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="
						((maxLat BETWEEN 18 AND 23 AND
						  maxLon BETWEEN -161 AND -154)) OR
						 ((minLat BETWEEN 18 AND 23 AND
						  minLon BETWEEN -161 AND -154))" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
				</cfinvoke>
				<cfset ColNameList = "Name;Issued;Valid;Message">

				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif> --->
				<cfset ArrayAppend(variables.strWhereClause,"((maxLat BETWEEN 18 AND 23 AND
						  maxLon BETWEEN -161 AND -154)) OR
						 ((minLat BETWEEN 18 AND 23 AND
						  minLon BETWEEN -161 AND -154))") />
			</cfif>
			<cfset strAggregateWhereClause = ArrayToList(variables.strWhereClause,"OR") />
			<cfif NOT IsDefined("gErrString") OR gErrString NEQ 1>
				<cfinvoke component="com.weathernews.beacon.DAO.qryGetAIRMETS" method="init" returnvariable="getQuery">
					<cfinvokeargument name="strWhereClause" value="#strAggregateWhereClause#" />
					<cfinvokeargument name="intPeriodFrom" value="#PeriodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#PeriodTo#" />
					<cfinvokeargument name="arrAirmetType" value="#variables.airmetType#" />
				</cfinvoke>
			<cfelse>
				<cfset gErrString = 1 />
				<cfset getQuery.RecordCount = 2 />
			</cfif>
				<cfset ColNameList = "Name;Issued;Valid;Message">
			
				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
		</cfif>
		</cfif>
	</cfcase>
	
	<cfcase value="5">
		<cfset gErrString = "9">
		<cfset gErrStringText = "This feature is not implemented yet.">
	</cfcase>

	<cfcase value="6">

		<cfif ISDefined("DoWDDX") and IsDefined("wddxGetQuery")>
			<cfif IsWddx(wddxGetQuery)>
				<cfwddx action = "wddx2cfml" input = #wddxGetQuery# output = "getQuery">
			<cfelse>
				<cflocation url="default.htm?mID=6">
				<cfabort>	
			</cfif>
		<cfelse>
			
			<cfif pType EQ "UserDef">
				<cfif Len(pTypeOther) LTE 2>
					<cfset gErrString = "9">
					<cfset gErrStringText = "No Specific conditions were defined (A minimum of three characters are required)">
				</cfif>
			<cfelse>	
				<cfset PirepStationList = ListGetAt(ListGetAt(SubProductList6,ListContainsNoCase(SubProductList6,pType,"|"),"|"),3,";")>
			</cfif>
			<cfset PirepIntensityList = ListGetAt(ListGetAt(SubProductList6B,ListContainsNoCase(SubProductList6B,intensity,"|"),"|"),3,";")>

			<cfif NOT LEN(gErrString)>
			<!---<cfdump var="#region#">
			<cfabort>--->
				<cfinvoke component="com.weathernews.beacon.DAO.qryGetPIREPS" method="init" returnvariable="getQuery">
					<!--- Bring in the time period --->
					<cfinvokeargument name="intPeriodFrom" value="#periodFrom#" />
					<cfinvokeargument name="intPeriodTo" value="#periodTo#" />
					<!--- Station List and Intensity List --->
					<cfif pType NEQ "UserDef">
						<cfinvokeargument name="strStationList" value="#PirepStationList#" />
					</cfif>
					<cfinvokeargument name="strIntensityList" value="#PirepIntensityList#" />
					<!--- User defined --->
					<cfinvokeargument name="pType" value="#pType#" />
					<cfinvokeargument name="pTypeOther" value="#pTypeOther#" />
					<cfif IsDefined("region")>
						<cfinvokeargument name="region" value="#region#" />
					</cfif>
				</cfinvoke>
				<cfset ColNameList = "Origin;Time;PIREP"> 
				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#>
			</cfif>

		</cfif>	

	</cfcase>

<!--- 	<cfcase value="7">
		<cfset gErrString = "9">
		<cfset gErrStringText = "This feature is not implemented yet.">
	</cfcase>
 --->
	<cfcase value="7">

		<cfif ISDefined("DoWDDX") and IsDefined("wddxGetQuery")>
			<cfif IsWddx(wddxGetQuery)>
				<cfwddx action = "wddx2cfml" input = #wddxGetQuery# output = "getQuery">
			<cfelse>
				<cflocation url="default.htm?mID=7">
				<cfabort>	
			</cfif>
		<cfelse>
		
		<cfloop list="#FIELDNAMES#" index="FIndex">
			<cfif FindNoCase("SUBFAKECHECKBOX_S7",Findex)>
				<cfset SubFakeCheckBoxList = ListAppend(SubFakeCheckBoxList,Findex)>	
			</cfif>
		</cfloop>
		
		<cfif ListLen(SubFakeCheckBoxList) EQ 0 >
			<cfset gErrString = "1">
		<cfelse>
			<cfset VASHList = "">
			<cfloop list="#SubFakeCheckBoxList#" index="SubIndex">
				<cfset VASHList = ListAppend(VASHList,ListGetAt(ListGetAt(SubProductList7,ListContainsNoCase(SubProductList7,Evaluate(SubIndex),"|"),"|"),3,";"))>
			</cfloop>
		</cfif>		

			<cfif NOT LEN(gErrString)>
				<cfquery name="getQuery" datasource="#AVNOPS_DS#">
					SELECT 
							Col_1=V.source, 
							Col_2=convert(Char(5),V.rTime,1) + ' ' +  convert(Char(5),V.rTime,8) + 'Z',
							Col_3=V.bulletin, 
							Col_4=V.name, 
							Col_5=V.lat, 
							Col_6=V.lon
					FROM obsdb..VOLCANO_BULL V
					WHERE 1=1
						
						AND	V.source IN (#ListQualify(VASHList,"'")#)

						AND V.rTime <= DATEADD(hh,-#PeriodFrom#,getdate())
						AND V.rTime >= DATEADD(hh,-#PeriodTo#,getdate())
					ORDER BY V.rTime DESC    
				</cfquery>
				<cfset ColNameList = "Source;Time;Volcanic Ash Advisory"> 
				<cfif getQuery.RecordCount EQ 0>
					<cfset gErrString = "2">
				<cfelseif getQuery.RecordCount GT MaxRecords>
					<cfset gErrString = "3">
				</cfif>
	
				<cfwddx action = "cfml2wddx" input = #getQuery# output = "wddxText" usetimezoneinfo="yes">
				<cfset wddxGetQuery = #wddxText#>
			</cfif>
		</cfif>	

	</cfcase>

	<cfcase value="8">
		<cftry>
			<cfhttp url="http://www.fly.faa.gov/flyfaa/xmlAirportStatus.jsp" method="get" resolveurl="no"></cfhttp>
			<cfcatch type="any">
				<cfset gErrString = "3" />
				<cfset getQuery.RecordCount = 0 />
			</cfcatch>
		</cftry>
		<cfset myXMLDocument=XmlParse(CFHTTP.FileContent)>
		<cfif IsDefined("myXMLDocument.AIRPORT_STATUS_INFORMATION.Delay_Type")>
			<!--- Do Nothing --->
		<cfelse>
			<cfset gErrString = "3" />
			<cfset getQuery.RecordCount = 0 />
		</cfif>
	</cfcase>


	<cfdefaultcase>
		<cfset gErrString = "1">
	</cfdefaultcase>

</cfswitch>


</cfoutput>
