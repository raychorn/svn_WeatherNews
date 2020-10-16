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
					WHEN 'KATL' THEN 1
					WHEN 'KSLC' THEN 2
					WHEN 'KCVG' THEN 3
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
					WHEN 'KATL' THEN 1
					WHEN 'KSLC' THEN 2
					WHEN 'KCVG' THEN 3
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


<!--- 	ORDER by #DE("Col_" & ColOrderBy)#  #ColOrderDir# --->
