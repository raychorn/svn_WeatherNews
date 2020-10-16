<cfif Not IsDefined("form.Submit")>
	<cflocation url="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=6">
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

<cfswitch expression="#Form.RepType#">
	<cfcase value="1">
	
		<cfif ISDefined("DoWDDX") and IsDefined("wddxGetQuery")>
			<cfif IsWddx(wddxGetQuery)>
				<cfwddx action = "wddx2cfml" input = #wddxGetQuery# output = "getQuery">
			<cfelse>
				<cflocation url="<cfoutput>#Request.default_htm#</cfoutput>?mID=6">
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
						<cfquery name="getQuery" datasource="#Request.AVNOPS_DS#">
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
					
					<cfquery name="getQuery" datasource="#Request.AVNOPS_DS#">
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
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_13")>
						<cfset gErrString = "9">
						<cfset gErrStringText = "This feature is not implemented yet.">
				</cfif>
			</cfif>

		</cfif>	

	</cfcase>
	
	
	<cfcase value="2">
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
			<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S21")> <!--- US --->
				<cfif ListLen(FakeCheckBoxList) EQ 0 > <!--- Needs at least one subtype --->
					<cfset gErrString = "1">
				<cfelse>
					<cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" >
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_21")>
							<cfhttpparam type="formfield" name="ZULU" value="1">
						</cfif>	
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_22")>
							<cfhttpparam type="formfield" name="TANGO" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_23")>
							<cfhttpparam type="formfield" name="CONVECT" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_24")>
							<cfhttpparam type="formfield" name="ASH" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S218")>
							<cfhttpparam type="formfield" name="KBOS" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S219")>
							<cfhttpparam type="formfield" name="KCHI" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S220")>
							<cfhttpparam type="formfield" name="KDFW" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S221")>
							<cfhttpparam type="formfield" name="KSLC" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S222")>
							<cfhttpparam type="formfield" name="KSFO" value="1">
						</cfif>
					</cfhttp>		
					<cfset IsPHP = 1>
				</cfif>	
			<cfelse>
				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S23")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6440.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S24")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6441.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S25")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6442.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S26")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6443.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S27")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6444.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S28")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6445.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S29")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6446.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S210")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6447.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S211")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6448.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S212")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6449.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S213")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6450.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S214")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6451.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S215")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6452.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S216")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6453.txt" resolveurl="yes"></cfhttp>
				<cfelseif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S217")>
					<cfhttp url="http://aviationweather.gov/data/iffdp/6454.txt" resolveurl="yes"></cfhttp>
				</cfif>	
				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S218")>
						<cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" >
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_21")>
							<cfhttpparam type="formfield" name="ZULU" value="1">
						</cfif>	
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_22")>
							<cfhttpparam type="formfield" name="TANGO" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_23")>
							<cfhttpparam type="formfield" name="CONVECT" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_24")>
							<cfhttpparam type="formfield" name="ASH" value="1">
						</cfif>
					</cfhttp>		
					</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S219")>
							<cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" >
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_21")>
							<cfhttpparam type="formfield" name="ZULU" value="1">
						</cfif>	
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_22")>
							<cfhttpparam type="formfield" name="TANGO" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_23")>
							<cfhttpparam type="formfield" name="CONVECT" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_24")>
							<cfhttpparam type="formfield" name="ASH" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S218")>
							<cfhttpparam type="formfield" name="KBOS" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S219")>
							<cfhttpparam type="formfield" name="KCHI" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S220")>
							<cfhttpparam type="formfield" name="KDFW" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S221")>
							<cfhttpparam type="formfield" name="KSLC" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S222")>
							<cfhttpparam type="formfield" name="KSFO" value="1">
						</cfif>
					</cfhttp>		
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S220")>
							<cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" >
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_21")>
							<cfhttpparam type="formfield" name="ZULU" value="1">
						</cfif>	
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_22")>
							<cfhttpparam type="formfield" name="TANGO" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_23")>
							<cfhttpparam type="formfield" name="CONVECT" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_24")>
							<cfhttpparam type="formfield" name="ASH" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S218")>
							<cfhttpparam type="formfield" name="KBOS" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S219")>
							<cfhttpparam type="formfield" name="KCHI" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S220")>
							<cfhttpparam type="formfield" name="KDFW" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S221")>
							<cfhttpparam type="formfield" name="KSLC" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S222")>
							<cfhttpparam type="formfield" name="KSFO" value="1">
						</cfif>
					</cfhttp>		
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S221")>
							<cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" >
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_21")>
							<cfhttpparam type="formfield" name="ZULU" value="1">
						</cfif>	
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_22")>
							<cfhttpparam type="formfield" name="TANGO" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_23")>
							<cfhttpparam type="formfield" name="CONVECT" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_24")>
							<cfhttpparam type="formfield" name="ASH" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S218")>
							<cfhttpparam type="formfield" name="KBOS" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S219")>
							<cfhttpparam type="formfield" name="KCHI" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S220")>
							<cfhttpparam type="formfield" name="KDFW" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S221")>
							<cfhttpparam type="formfield" name="KSLC" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S222")>
							<cfhttpparam type="formfield" name="KSFO" value="1">
						</cfif>
					</cfhttp>		
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S222")>
							<cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" >
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_21")>
							<cfhttpparam type="formfield" name="ZULU" value="1">
						</cfif>	
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_22")>
							<cfhttpparam type="formfield" name="TANGO" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_23")>
							<cfhttpparam type="formfield" name="CONVECT" value="1">
						</cfif>
						<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_24")>
							<cfhttpparam type="formfield" name="ASH" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S218")>
							<cfhttpparam type="formfield" name="KBOS" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S219")>
							<cfhttpparam type="formfield" name="KCHI" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S220")>
							<cfhttpparam type="formfield" name="KDFW" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S221")>
							<cfhttpparam type="formfield" name="KSLC" value="1">
						</cfif>
						<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S222")>
							<cfhttpparam type="formfield" name="KSFO" value="1">
						</cfif>
					</cfhttp>		
						</cfif>
				<cfset IsPHP = 1>
			</cfif>
	
			<cfif NOT LEN(gErrString)>
				<cfif IsPHP EQ 1>
					<cfset RawText = #cfhttp.FileContent#>
					
					<cfset startpoint = #FindNoCase("<PRE>",RawText,1)#>
					<cfset endpoint = #FindNoCase("</PRE>",RawText,startpoint)#>
					<!--- #StartPoint#, #EndPoint# --->
					<cfset RawText2 = #MID(RawText,StartPoint+5,EndPoint-StartPoint+5)#>
				<cfelse>
					<cfset RawText = #cfhttp.FileContent#>
					<cfset RawText2 = "">
					<cfloop index="OneLine" list="#RawText#" delimiters="#Chr(10)##Chr(13)#">
						<cfif (LEFT(OneLine,9) NEQ "Document:") AND 
							(LEFT(OneLine,12) NEQ "Description:") AND 
							(LEFT(OneLine,3) NEQ "___")>
							<cfif (LEFT(OneLine,2) EQ "WS") >
								<cfset RawText2 = RawText2 &  "#Chr(10)##Chr(13)#">
							</cfif>	
							<cfset RawText2 = RawText2 & OneLine & "#Chr(13)#">
						</cfif>
					</cfloop>	
				</cfif>
			</cfif>
		</cfif>
	</cfcase>
	
	<cfcase value="3">
		<cfset gErrString = "9">
		<cfset gErrStringText = "This feature is not implemented yet.">
	</cfcase>
	
	<cfcase value="4">
		<cfloop list="#FIELDNAMES#" index="FIndex">
			<cfif FindNoCase("FAKECHECKBOX_4",Findex)>
				<cfset FakeCheckBoxList = ListAppend(FakeCheckBoxList,Findex)>	
			</cfif>
			<cfif FindNoCase("SUBFAKECHECKBOX_S4",Findex)>
				<cfset SubFakeCheckBoxList = ListAppend(SubFakeCheckBoxList,Findex)>	
			</cfif>
		</cfloop>
		
		<cfif (ListLen(FakeCheckBoxList) EQ 0) OR (ListLen(SubFakeCheckBoxList) EQ 0)>
			<cfset gErrString = "1">
		<cfelse>

			<cfhttp url="http://adds.aviationweather.gov/airmets/index.php" method="post" resolveurl="yes" >

				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_41")>
					<cfhttpparam type="formfield" name="ZULU" value="1">
				</cfif>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_42")>
					<cfhttpparam type="formfield" name="TANGO" value="1">
				</cfif>
				<cfif ListFindNoCase(FakeCheckBoxList,"FAKECHECKBOX_43")>
					<cfhttpparam type="formfield" name="SIERRA" value="1">
				</cfif>

				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S41")>
					<cfhttpparam type="formfield" name="KSFO" value="1">
				</cfif>
				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S42")>
					<cfhttpparam type="formfield" name="KSLC" value="1">
				</cfif>
				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S43")>
					<cfhttpparam type="formfield" name="KCHI" value="1">
				</cfif>
				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S44")>
					<cfhttpparam type="formfield" name="KBOS" value="1">
				</cfif>
				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S45")>
					<cfhttpparam type="formfield" name="KDFW" value="1">
				</cfif>
				<cfif ListFindNoCase(SubFakeCheckBoxList,"SUBFAKECHECKBOX_S46")>
					<cfhttpparam type="formfield" name="KMIA" value="1">
				</cfif>
			</cfhttp>
			<cfset RawText = #cfhttp.FileContent#>
			
			<cfset startpoint = #FindNoCase("<PRE>",RawText,1)#>
			<cfset endpoint = #FindNoCase("</PRE>",RawText,startpoint)#>
			<!--- #StartPoint#, #EndPoint# --->
			<cfset RawText2 = #MID(RawText,StartPoint+5,EndPoint-StartPoint+5)#>

		
			
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
				<cflocation url="<cfoutput>#Request.default_htm#</cfoutput>?mID=6">
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
					<cfinvokeargument name="strStationList" value="#PirepStationList#" />
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
				<cflocation url="<cfoutput>#Request.default_htm#</cfoutput>?mID=7">
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
				<cfquery name="getQuery" datasource="#Request.AVNOPS_DS#">
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
		<cfhttp url="http://www.fly.faa.gov/flyfaa/xmlAirportStatus.jsp" method="get" resolveurl="no"></cfhttp>
		<cfset myXMLDocument=XmlParse(CFHTTP.FileContent)>
	</cfcase>


	<cfdefaultcase>
	
	</cfdefaultcase>

</cfswitch>


</cfoutput>
