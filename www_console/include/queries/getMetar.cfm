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
					WHEN 'KATL' THEN 1
					WHEN 'KSLC' THEN 2
					WHEN 'KCVG' THEN 3
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


<!--- 	ORDER by #DE("Col_" & ColOrderBy)#  #ColOrderDir# --->
