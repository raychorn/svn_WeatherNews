<cfparam name="DisplayMapType" default="1">
<!--- test --->

<cfset SatList = "">
<cfset SatList = SatList & " |out_east_conus.txt|USList|US Coverage|1;">
<!--- <cfset SatList = SatList & "GOESW|out_west_nh.txt|GOESWNHList|GOES West|1;"> --->
<cfset SatList = SatList & " |out_europe.txt|EUROPEList|European Coverage|2;">
<cfset SatList = SatList & " |out_asia.txt|ASIAList|Asian Coverage|3;">
<cfset SatList = SatList & "GOESW|out_west_nh.txt|GOESWNHList|GOESW|4;">
<cfset SatList = SatList & "GOESE|out_east_nh.txt|GOESENHList|GOESE|4;">
<cfset SatList = SatList & "MET8|out_msg1_fd.txt|MET8FDList|MET8|4;">
<cfset SatList = SatList & "MET5|out_met5_fd.txt|MET5FDList|MET5|4;">
<cfset SatList = SatList & "GMS5|out_gms5_fd.txt|GMS5FDList|GMS5|4;">


	<cfset SatTimesArray = ArrayNew(2)> <!--- [Satellite index 1-N][Time from Latest to Newest] --->
	<cfset SatIndex = 0>
	<cfset MaxSatLoop = 6>
	<cfloop index="ArrayIndex1" from="1" to="#ListLen(SatList,';')#">
		<cfloop index="ArrayIndex2" from="1" to="#MaxSatLoop#">
			<cfset SatTimesArray[ArrayIndex1][ArrayIndex2] = "Missing Info | ">
		</cfloop>
	</cfloop>

	
	<cfloop list="#SatList#" index="SatLoopIndex" delimiters=";">
		<cfset SatName = ListGetAt(SatLoopIndex,1,"|")>
		<cfset SatFileName = ListGetAt(SatLoopIndex,2,"|")>
		<cfset SatListName = ListGetAt(SatLoopIndex,3,"|")>
		<cfset SatFullName = ListGetAt(SatLoopIndex,4,"|")>
		<cfset SatListType = ListGetAt(SatLoopIndex,5,"|")>
 		
		<cfif DisplayMapType EQ SatListType>
			<cffile action="read" file="#Request.webRoot#include\#SatFileName#" variable="SatelliteTimesTmp"> 
			<cfset SatelliteTimes2 = #REReplace(SatelliteTimesTmp,Chr(13),"|","ALL")#>
			<cfset SatelliteTimes2 = LEFT(SatelliteTimes2,LEN(SatelliteTimes2)-1)>

			<cfset SatIndex = SatIndex + 1>
			
			<cfloop index="TimeIndex" from="1" to="#ListLen(SatelliteTimes2,'|')#">
				<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,TimeIndex,"|"))#>
				<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
				<cfset SatTimesArray[SatIndex][TimeIndex] = #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
			</cfloop>

		</cfif>

	</cfloop>


<!--- debug: 
 	<cfoutput>
 		<cfloop index="ArrayIndex1" from="1" to="#SatIndex#">
			<cfloop index="ArrayIndex2" from="1" to="#ArrayLen(SatTimesArray[ArrayIndex1])#">
				[#ArrayIndex1#]:[#ArrayIndex2#] :: #SatTimesArray[ArrayIndex1][ArrayIndex2]#<br>
			</cfloop>
		</cfloop>
	</cfoutput>
 --->

	<cfset SatListTimes1 = '"'>
	<cfset SatListTimes2 = '"'>
	<cfset SatListTimes3 = '"'>
	<cfset SatListTimes4 = '"'>
	<cfset SatListTimes5 = '"'>
	<cfset SatListTimes6 = '"'>

	<cfloop index="ArrayIndex1" from="1" to="#SatIndex#">
			<cfset SatListTimes1 = SatListTimes1 & SatTimesArray[ArrayIndex1][1]>
			<cfset SatListTimes2 = SatListTimes2 & SatTimesArray[ArrayIndex1][2]>
			<cfset SatListTimes3 = SatListTimes3 & SatTimesArray[ArrayIndex1][3]>
			<cfset SatListTimes4 = SatListTimes4 & SatTimesArray[ArrayIndex1][4]>
			<cfset SatListTimes5 = SatListTimes5 & SatTimesArray[ArrayIndex1][5]>
			<cfset SatListTimes6 = SatListTimes6 & SatTimesArray[ArrayIndex1][6]>
	</cfloop>

	<cfset SatListTimes1 = SatListTimes1 & '"'>
	<cfset SatListTimes2 = SatListTimes2 & '"'>
	<cfset SatListTimes3 = SatListTimes3 & '"'>
	<cfset SatListTimes4 = SatListTimes4 & '"'>
	<cfset SatListTimes5 = SatListTimes5 & '"'>
	<cfset SatListTimes6 = SatListTimes6 & '"'>


<!--- DEBUG:
<cfoutput>
#SatListTimes6#<br>
#SatListTimes5#<br>
#SatListTimes4#<br>
#SatListTimes3#<br>
#SatListTimes2#<br>
#SatListTimes1#<br>
</cfoutput>
 --->
