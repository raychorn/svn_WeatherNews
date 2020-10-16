<cfparam name="DisplayMapType" default="1">

	<cfset RadarList = "">
	<cfset RadarList = RadarList & " |conus_mosaic_time.txt|USList|US Radar|1;">
	<cfset RadarList = RadarList & " |europe_mosaic_time.txt|EUROList|European Radar|2;">
	<cfset RadarList = RadarList & " |CONUS_COMP_mosaic_time.txt|COMPOSITEList|US Composite Radar|3;">
	<cfset RadarList = RadarList & " |CONUS_WIN_mosaic_time.txt|WINTERList|Winter Mosaic Radar|4;">


	<cfset RadarTimesArray = ArrayNew(2)> <!--- [Radar index 1-N][Time from Latest to Newest] --->
	<cfset RadarIndex = 0>
	<cfset MaxRadarLoop = 12>
	<cfloop index="ArrayIndex1" from="1" to="#ListLen(RadarList,';')#">
		<cfloop index="ArrayIndex2" from="1" to="#MaxRadarLoop#">
			<cfset RadarTimesArray[ArrayIndex1][ArrayIndex2] = "Missing Info | ">
		</cfloop>
	</cfloop>

	<cfloop list="#RadarList#" index="RadarLoopIndex" delimiters=";">
		<cfset RadarName = ListGetAt(RadarLoopIndex,1,"|")>
		<cfset RadarFileName = ListGetAt(RadarLoopIndex,2,"|")>
		<cfset RadarListName = ListGetAt(RadarLoopIndex,3,"|")>
		<cfset RadarFullName = ListGetAt(RadarLoopIndex,4,"|")>
		<cfset RadarListType = ListGetAt(RadarLoopIndex,5,"|")>
 		
		<cfif DisplayMapType EQ RadarListType>
			<cffile action="read" file="D:\Data\console\include\#RadarFileName#" variable="RadarTimesTmp"> 
			<cfset RadarTimes2 = #REReplace(RadarTimesTmp,Chr(10),"|","ALL")#>
			<cfset RadarTimes2 = LEFT(RadarTimes2,LEN(RadarTimes2)-1)>

			<cfset RadarIndex = RadarIndex + 1>
			
			<cfloop index="TimeIndex" from="1" to="#ListLen(RadarTimes2,'|')#">
				<cfset LatestFormat = #TRIM(ListGetAt(RadarTimes2,TimeIndex,"|"))#>
				<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
				<cfset RadarTimesArray[RadarIndex][TimeIndex] = #TRIM(RadarName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
			</cfloop>
		</cfif>

	</cfloop>
<!--- debug:
 	<cfoutput>
 		 <cfloop index="ArrayIndex1" from="1" to="#RadarIndex#">
				[#ArrayIndex1#]:[1] :: #RadarTimesArray[ArrayIndex1][1]#<br>
				[#ArrayIndex1#]:[2] :: #RadarTimesArray[ArrayIndex1][2]#<br>
				[#ArrayIndex1#]:[3] :: #RadarTimesArray[ArrayIndex1][3]#<br>
				[#ArrayIndex1#]:[4] :: #RadarTimesArray[ArrayIndex1][4]#<br>
				[#ArrayIndex1#]:[5] :: #RadarTimesArray[ArrayIndex1][5]#<br>
				[#ArrayIndex1#]:[6] :: #RadarTimesArray[ArrayIndex1][6]#<br>
			</cfloop>
	</cfoutput>
<cfabort> --->

	<cfset RadarListTimes1 = '"'>
	<cfset RadarListTimes2 = '"'>
	<cfset RadarListTimes3 = '"'>
	<cfset RadarListTimes4 = '"'>
	<cfset RadarListTimes5 = '"'>
	<cfset RadarListTimes6 = '"'>

	<cfif DisplayMapType EQ 1>
		<cfloop index="ArrayIndex1" from="1" to="#RadarIndex#">
			<cfset RadarListTimes1 = RadarListTimes1 & RadarTimesArray[ArrayIndex1][2]>
			<cfset RadarListTimes2 = RadarListTimes2 & RadarTimesArray[ArrayIndex1][4]>
			<cfset RadarListTimes3 = RadarListTimes3 & RadarTimesArray[ArrayIndex1][6]>
			<cfset RadarListTimes4 = RadarListTimes4 & RadarTimesArray[ArrayIndex1][8]>
			<cfset RadarListTimes5 = RadarListTimes5 & RadarTimesArray[ArrayIndex1][10]>
			<cfset RadarListTimes6 = RadarListTimes6 & RadarTimesArray[ArrayIndex1][12]>
		</cfloop>
	<cfelse>
		<cfloop index="ArrayIndex1" from="1" to="#RadarIndex#">
			<cfset RadarListTimes1 = RadarListTimes1 & RadarTimesArray[ArrayIndex1][1]>
			<cfset RadarListTimes2 = RadarListTimes2 & RadarTimesArray[ArrayIndex1][2]>
			<cfset RadarListTimes3 = RadarListTimes3 & RadarTimesArray[ArrayIndex1][3]>
			<cfset RadarListTimes4 = RadarListTimes4 & RadarTimesArray[ArrayIndex1][4]>
			<cfset RadarListTimes5 = RadarListTimes5 & RadarTimesArray[ArrayIndex1][5]>
			<cfset RadarListTimes6 = RadarListTimes6 & RadarTimesArray[ArrayIndex1][6]>
		</cfloop>
	</cfif>

	<cfset RadarListTimes1 = RadarListTimes1 & '"'>
	<cfset RadarListTimes2 = RadarListTimes2 & '"'>
	<cfset RadarListTimes3 = RadarListTimes3 & '"'>
	<cfset RadarListTimes4 = RadarListTimes4 & '"'>
	<cfset RadarListTimes5 = RadarListTimes5 & '"'>
	<cfset RadarListTimes6 = RadarListTimes6 & '"'>

<!--- DEBUG: 
<cfoutput>
#RadarListTimes1#<br>
#RadarListTimes2#<br>
#RadarListTimes3#<br>
#RadarListTimes4#<br>
#RadarListTimes5#<br>
#RadarListTimes6#<br>
</cfoutput>
--->