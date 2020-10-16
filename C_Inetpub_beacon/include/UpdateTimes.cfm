<cfparam name="UpdateTimesOnly" default="Satellite">

<cfoutput>
<script language="JavaScript1.2">
function getobject(obj) {
	if (document.getElementById)
		return document.getElementById(obj)
	else if (document.all)
		return document.all[obj]
}

function RadCurrTime(TimeArray){
	getobject("_Rad_Curr_Times").innerHTML = TimeArray;
}

function SatCurrTime(TimeArray){
	getobject("_Sat_Curr_Times").innerHTML = TimeArray;
}

</script>
</cfoutput>


<cfset RadarList = "">
<cfset RadarList = RadarList & "Radar: US|conus_mosaic_time.txt|USList|US Radar|1;">
<cfset RadarList = RadarList & "Radar: EUROPE|europe_mosaic_time.txt|EUROList|European Radar|2;">
<cfset RadarList = RadarList & "Radar: US|CONUS_COMP_mosaic_time.txt|COMPOSITEList|US Composite Radar|3;">
<cfset RadarList = RadarList & "Radar: US|CONUS_WIN_mosaic_time.txt|WINTERList|Winter Mosaic Radar|4;">

<cfset SatList = "">
<cfset SatList = SatList & "Satellite: US|out_east_conus.txt|USList|US Coverage|1;">
<!--- <cfset SatList = SatList & "GOESW|out_west_nh.txt|GOESWNHList|GOES West|1;"> --->
<cfset SatList = SatList & "Satellite: EUROPE|out_europe.txt|EUROPEList|European Coverage|2;">
<cfset SatList = SatList & "Satellite: ASIA|out_asia.txt|ASIAList|Asian Coverage|3;">
<cfset SatList = SatList & "GOESW|out_west_nh.txt|GLOBALList|GOESW|4;">
<cfset SatList = SatList & "GOESE|out_east_nh.txt|GLOBALList|GOESE|4;">
<cfset SatList = SatList & "MET8|out_msg1_fd.txt|GLOBALList|MET8|4;">
<cfset SatList = SatList & "MET5|out_met5_fd.txt|GLOBALList|MET5|4;">
<cfset SatList = SatList & "GMS5|out_gms5_fd.txt|GLOBALList|GMS5|4;">


<div class="navlink" style="background-color:#000000; font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px" align="left">

	<cfif UpdateTimesOnly EQ "Radar">
	<div id="RadarTimes" style="display: block">

		<cfset RadarTimesArray = ArrayNew(1)> <!--- [Radar index 1-N] --->
		<cfset RadarIndex = 0>
		<cfloop list="#RadarList#" index="RadarLoopIndex" delimiters=";">
			<cfset RadarListType = ListGetAt(RadarLoopIndex,5,"|")>
			<cfset RadarTimesArray[RadarListType] = "">
		</cfloop>

		<cfloop list="#RadarList#" index="RadarLoopIndex" delimiters=";">
			<cfset RadarName = ListGetAt(RadarLoopIndex,1,"|")>
			<cfset RadarFileName = ListGetAt(RadarLoopIndex,2,"|")>
			<cfset RadarListName = ListGetAt(RadarLoopIndex,3,"|")>
			<cfset RadarFullName = ListGetAt(RadarLoopIndex,4,"|")>
			<cfset RadarListType = ListGetAt(RadarLoopIndex,5,"|")>
 		
			<cffile action="read" file="#ExpandPath('include\#RadarFileName#')#" variable="RadarTimesTmp"> 
			<cfset RadarTimes2 = #REReplace(RadarTimesTmp,Chr(10),"|","ALL")#>
			<cfset RadarTimes2 = LEFT(RadarTimes2,LEN(RadarTimes2)-1)>

			<cfset LatestFormat = #TRIM(ListLast(RadarTimes2,"|"))#>
			<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
			<cfset NiceValue = #TRIM(RadarName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
			<cfset RadarTimesArray[RadarListType] = RadarTimesArray[RadarListType] & NiceValue >
		</cfloop>
<!--- 		<span style="color: #CCE2FF;"> Radar Images Updated at: </span> --->
		<span style="color: #E3E6E8; cursor:hand; cursor:pointer"><SPAN id="_Rad_Curr_Times"> </SPAN></span><br>
		<span style="color: #E3E6E8;"><img src="/images/radar_legend.gif" border="0" alt="Radar legend"></span>

	</div>	
	<cfelse>
	<div id="SatelliteTimes" style="display: block">

		<cfset SatTimesArray = ArrayNew(1)> <!--- [Satellite index 1-N] --->
		<cfset SatIndex = 0>
		<cfloop list="#SatList#" index="SatLoopIndex" delimiters=";">
			<cfset SatListType = ListGetAt(SatLoopIndex,5,"|")>
			<cfset SatTimesArray[SatListType] = "">
		</cfloop>
	
		<cfloop list="#SatList#" index="SatLoopIndex" delimiters=";">
			<cfset SatName = ListGetAt(SatLoopIndex,1,"|")>
			<cfset SatFileName = ListGetAt(SatLoopIndex,2,"|")>
			<cfset SatListName = ListGetAt(SatLoopIndex,3,"|")>
			<cfset SatFullName = ListGetAt(SatLoopIndex,4,"|")>
			<cfset SatListType = ListGetAt(SatLoopIndex,5,"|")>
 		
			<cffile action="read" file="#ExpandPath('include\#SatFileName#')#" variable="SatelliteTimesTmp"> 
			<cfset SatelliteTimes2 = #REReplace(SatelliteTimesTmp,Chr(13),"|","ALL")#>
			<cfset SatelliteTimes2 = LEFT(SatelliteTimes2,LEN(SatelliteTimes2)-1)>

			<cfset LatestFormat = #TRIM(Listlast(SatelliteTimes2,"|"))#>
			<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
			<cfset NiceValue = #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
			<cfset SatTimesArray[SatListType] = SatTimesArray[SatListType] & NiceValue >
		</cfloop>
<!--- 		<span style="color: #CCE2FF;"> <SPAN id="_Sat_Curr_Names"> </SPAN> </span> --->
		<span style="color: #E3E6E8; cursor:hand; cursor:pointer"><SPAN id="_Sat_Curr_Times"> </SPAN></span><br>
		<span style="color: #E3E6E8;"><img src="/images/satellite_ir_legend.gif" border="0" alt="Satellite IR legend"></span>
 
	</div>						
 	</cfif>

</div>
