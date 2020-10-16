<cfparam name="DisplayMapType" default="1">
<cfparam name="UpdateTimesOnly" default="Satellite">
<!--- test --->

<cfif UpdateTimesOnly EQ "Radar">

	<cffile action="read" file="#Request.webRoot#include\conus_mosaic.txt" variable="RadarTimesTmp"> 
	<cfset RadarTimes = #REReplace(RadarTimesTmp,Chr(10),"|","ALL")#>
	<cfset RadarTimes = LEFT(RadarTimes,LEN(RadarTimes)-1)>

	<cfset RadarListTimes = '"'>
	<cfloop index="RadarIndex" from="6" to="1" step="-1">
		<cfset LatestFormat = ListGetAt(RadarTimes,RadarIndex,'|')>
		<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
		<cfset RadarListTimes = RadarListTimes & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT" & '","'>
	</cfloop>
	<cfset RadarListTimes = LEFT(RadarListTimes,LEN(RadarListTimes)-2)>
	<!--- Introduce two frames delay at the end --->
	<cfset RadarListTimes = RadarListTimes & ',"' & ListLast(RadarListTimes,'"') & '"'>
	<cfset RadarListTimes = RadarListTimes & ',"' & ListLast(RadarListTimes,'"') & '"'>

	<CFOUTPUT> 
	 <SCRIPT TYPE="TEXT/JAVASCRIPT"> 
		var timesArray = new Array(#RadarListTimes#);
		function getobject(obj){
		if (document.getElementById)
				return document.getElementById(obj)
		else if (document.all)
				return document.all[obj]
		}
		function UpdateTime(){
			getobject("_Curr_Times").innerHTML = timesArray[current];
			window.setTimeout("UpdateTime()", rotate_delay);
		}
	
	  </SCRIPT>
	</CFOUTPUT>

<cfelse>

	<cfset SatList = "">
	<cfset SatList = SatList & "GOESE-NH|out_east_conus.txt|GOESENHList|GOES East - Northern Hemisphere|1;">
	<cfset SatList = SatList & "GOESW-NH|out_west_conus.txt|GOESWNHList|GOES West - Northern Hemisphere|1;">
	<cfset SatList = SatList & "GOESE-FD|out_east_fd.txt|GOESEFDList|GOES East - Full Disk|2;">
	<cfset SatList = SatList & "GOESW-FD|out_west_fd.txt|GOESWFDList|GOES West - Full Disk|2;">
	<cfset SatList = SatList & "MET7-FD|out_met7_fd.txt|MET7FDList|MET7 - Full Disk|2;">
	<cfset SatList = SatList & "MET5-FD|out_met5_fd.txt|MET5FDList|MET5 - Full Disk|2;">
	<cfset SatList = SatList & "GMS5-FD|out_gms5_fd.txt|GMS5FDList|GMS5 - Full Disk|2;">
	
	<!--- <cffile action="read" file="#Request.webRoot#include\satellite_time.txt" variable="SatelliteTimesTmp"> 
	<cfset SatelliteTimes = #REReplace(SatelliteTimesTmp,Chr(10),"","ALL")#>
	<cfset SatelliteTimes = #REReplace(SatelliteTimes,Chr(13),"|","ALL")#>
	<cfset SatelliteTimes = #REReplace(SatelliteTimes,",","","ALL")#>
	<cfset SatelliteTimes = LEFT(SatelliteTimes,LEN(SatelliteTimes)-1)>
	
	<cfset SatelliteTimes1 = ListChangeDelims(SatelliteTimes,',','|')>
	<cfset SatelliteTimes1 = ListAppend(SatelliteTimes1,'Missing Time',',')>
	<cfset SatelliteTimes1 = ListQualify(SatelliteTimes1,'"',',','CHAR')>
	<!---  <cfoutput>#SatelliteTimes1#</cfoutput>  --->
	
	<CFSET newSatelliteTimes = #SatelliteTimes1#>
	
	 --->
	<cfset SatListTimes6 = '"'> 
	<cfset SatListTimes5 = '"'> 
	<cfset SatListTimes4 = '"'> 
	<cfset SatListTimes3 = '"'> 
	<cfset SatListTimes2 = '"'> 
	<cfset SatListTimes1 = '"'> 
	
	<cfset NiceFormat6 = ""> 
	<cfset NiceFormat5 = ""> 
	<cfset NiceFormat4 = ""> 
	<cfset NiceFormat3 = ""> 
	<cfset NiceFormat2 = ""> 
	<cfset NiceFormat1 = ""> 
<cfparam name="SatelliteTimes2" default="undefined" />
			
	<cfloop list="#SatList#" index="SatLoopIndex" delimiters=";">
		<cfset SatName = ListGetAt(SatLoopIndex,1,"|")>
		<cfset SatFileName = ListGetAt(SatLoopIndex,2,"|")>
		<cfset SatListName = ListGetAt(SatLoopIndex,3,"|")>
		<cfset SatFullName = ListGetAt(SatLoopIndex,4,"|")>
		<cfset SatListType = ListGetAt(SatLoopIndex,5,"|")>
		<!--- <cfoutput>
		<br />SatelliteTimes2 :: #SatelliteTimes2# :: in loop<br />
		<br />DisplayMapType EQ SatListType :: #DisplayMapType# EQ #SatListType#<br />
		</cfoutput>  --->
		
		<cfif DisplayMapType EQ SatListType>
			<!--- <cfoutput>SatelliteTimes2 :: #SatelliteTimes2# :: 1st if<br /></cfoutput>  --->
			<cffile action="read" file="#Request.webRoot#include\#SatFileName#" variable="SatelliteTimesTmp"> 
			<cfset SatelliteTimes2 = #REReplace(SatelliteTimesTmp,Chr(13),"|","ALL")#>
			<cfset SatelliteTimes2 = LEFT(SatelliteTimes2,LEN(SatelliteTimes2)-1)>
		
			<cfif DisplayMapType EQ 1> <!--- NH --->
				<cfif ListLen(SatelliteTimes2,'|')  GTE 1>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,1,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset NiceFormat6 = NiceFormat6 & NiceFormat & "|">
					<cfset SatListTimes6 = SatListTimes6 & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>

				<cfif ListLen(SatelliteTimes2,'|')  GTE 2>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,2,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset NiceFormat5 = NiceFormat5 & NiceFormat & "|">
					<cfset SatListTimes5 = SatListTimes5 & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 3>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,3,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset NiceFormat4 = NiceFormat4 & NiceFormat & "|">
					<cfset SatListTimes4 = SatListTimes4 & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 4>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,4,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset NiceFormat3 = NiceFormat3 & NiceFormat & "|">
					<cfset SatListTimes3 = SatListTimes3 & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 5>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,5,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset NiceFormat2 = NiceFormat2 & NiceFormat & "|">
					<cfset SatListTimes2 = SatListTimes2 & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 6>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,6,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset NiceFormat1 = NiceFormat1 & NiceFormat & "|">
					<cfset SatListTimes1 = SatListTimes1 & "#DateFormat(NiceFormat,'dd mmm, yyyy')#@#TimeFormat(NiceFormat,'HH:MM')#GMT | ">
				</cfif>

			<cfelse> <!--- FD --->
			<!--- <cfoutput>SatelliteTimes2 :: #SatelliteTimes2# :: in else<br /></cfoutput>  --->
			
			
<!--- 
			<cfoutput>#SatelliteTimes2#<br>#ListLen(SatelliteTimes2,"|")#<br></cfoutput>
			<cfset SatCounterAsc = 1>
			<cfloop index="SatCounterDesc" from="#ListLen(SatelliteTimes2,'|')#" to="1" step="-1">
				<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,SatCounterAsc,"|"))#>
				<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
				<cfif NOT IsDefined("SatListTimesName")>
					<cfset SatListTimesName = "SatListTimes" & #SatCounterDesc#>
				</cfif>
				<cfoutput>Before: #Satname#, #SatListTimesName#<br></cfoutput>
				<cfoutput>Before: #Evaluate(SatListTimesName)#<br></cfoutput>
				<cfset SatListTimesName = #Evaluate(SatListTimesName)# & #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & " " & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				<cfset SatCounterAsc = SatCounterAsc + 1>
				<cfoutput>After: #SatListTimesName#<br></cfoutput>
			</cfloop> --->

				<cfif ListLen(SatelliteTimes2,'|')  GTE 1>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,1,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset SatListTimes6 = SatListTimes6 & #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>

				<cfif ListLen(SatelliteTimes2,'|')  GTE 2>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,2,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset SatListTimes5 = SatListTimes5 & #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 3>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,3,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset SatListTimes4 = SatListTimes4 & #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 4>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,4,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset SatListTimes3 = SatListTimes3 & #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 5>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,5,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset SatListTimes2 = SatListTimes2 & #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
	
				<cfif ListLen(SatelliteTimes2,'|')  GTE 6>
					<cfset LatestFormat = #TRIM(ListGetAt(SatelliteTimes2,6,"|"))#>
					<cfset NiceFormat = CreatedateTime(LEFT(LatestFormat,4),MID(LatestFormat,5,2),MID(LatestFormat,7,2),MID(LatestFormat,9,2),MID(LatestFormat,11,2),0)>
					<cfset SatListTimes1 = SatListTimes1 & #TRIM(SatName)# & " " & #DateFormat(NiceFormat,'dd mmm, yyyy')# & "@" & #TimeFormat(NiceFormat,'HH:MM')# & "GMT | ">
				</cfif>
			</cfif> <!--- NH or FD --->
		 </cfif>
	</cfloop>
	<cfset SatListTimes6 = SatListTimes6 & '"'>
	<cfset SatListTimes5 = SatListTimes5 & '"'>
	<cfset SatListTimes4 = SatListTimes4 & '"'>
	<cfset SatListTimes3 = SatListTimes3 & '"'>
	<cfset SatListTimes2 = SatListTimes2 & '"'>
	<cfset SatListTimes1 = SatListTimes1 & '"'>
	
	<cfif DisplayMapType EQ 1> <!--- Keep Oldest time only --->
		<cfset SatListTimes6 = ReReplace(SatListTimes6,'"','','ALL')>
		<cfset SatListTimes5 = ReReplace(SatListTimes5,'"','','ALL')>
		<cfset SatListTimes4 = ReReplace(SatListTimes4,'"','','ALL')>
		<cfset SatListTimes3 = ReReplace(SatListTimes3,'"','','ALL')>
		<cfset SatListTimes2 = ReReplace(SatListTimes2,'"','','ALL')>
		<cfset SatListTimes1 = ReReplace(SatListTimes1,'"','','ALL')>
<!--- 		<cfoutput> DEBUG:<br>
		#ListGetAt(SatListTimes6,1,"|")# -- #ListGetAt(SatListTimes6,2,"|")# -- #ListGetAt(NiceFormat6,1,"|")# -- #ListGetAt(NiceFormat6,2,"|")#
		#DateCompare(ListGetAt(NiceFormat6,1,"|"),ListGetAt(NiceFormat6,2,"|"))#<br>
		#ListGetAt(SatListTimes5,1,"|")# -- #ListGetAt(SatListTimes5,2,"|")# -- #ListGetAt(NiceFormat5,1,"|")# -- #ListGetAt(NiceFormat5,2,"|")#
		#DateCompare(ListGetAt(NiceFormat5,1,"|"),ListGetAt(NiceFormat5,2,"|"))#<br>
		#ListGetAt(SatListTimes4,1,"|")# -- #ListGetAt(SatListTimes4,2,"|")# -- #ListGetAt(NiceFormat4,1,"|")# -- #ListGetAt(NiceFormat4,2,"|")#
		#DateCompare(ListGetAt(NiceFormat4,1,"|"),ListGetAt(NiceFormat4,2,"|"))#<br>
		#ListGetAt(SatListTimes3,1,"|")# -- #ListGetAt(SatListTimes3,2,"|")# -- #ListGetAt(NiceFormat3,1,"|")# -- #ListGetAt(NiceFormat3,2,"|")#
		#DateCompare(ListGetAt(NiceFormat3,1,"|"),ListGetAt(NiceFormat3,2,"|"))#<br>
		#ListGetAt(SatListTimes2,1,"|")# -- #ListGetAt(SatListTimes2,2,"|")# -- #ListGetAt(NiceFormat2,1,"|")# -- #ListGetAt(NiceFormat2,2,"|")#
		#DateCompare(ListGetAt(NiceFormat2,1,"|"),ListGetAt(NiceFormat2,2,"|"))#<br>
		#ListGetAt(SatListTimes1,1,"|")# -- #ListGetAt(SatListTimes1,2,"|")# -- #ListGetAt(NiceFormat1,1,"|")# -- #ListGetAt(NiceFormat1,2,"|")#
		#DateCompare(ListGetAt(NiceFormat1,1,"|"),ListGetAt(NiceFormat1,2,"|"))#<br>
		</cfoutput>
 --->		
 		<cftry>
		<cfif DateCompare(ListGetAt(NiceFormat6,1,"|"),ListGetAt(NiceFormat6,2,"|")) GTE 0>
			<cfset SatListTimes6 = '"' & TRIM(ListGetAt(SatListTimes6,2,"|")) & '"'>
		<cfelse>
			<cfset SatListTimes6 = '"' & TRIM(ListGetAt(SatListTimes6,1,"|")) & '"'>
		</cfif>
		<cfif DateCompare(ListGetAt(NiceFormat5,1,"|"),ListGetAt(NiceFormat5,2,"|")) GTE 0>
			<cfset SatListTimes5 = '"' & TRIM(ListGetAt(SatListTimes5,2,"|")) & '"'>
		<cfelse>
			<cfset SatListTimes5 = '"' & TRIM(ListGetAt(SatListTimes5,1,"|")) & '"'>
		</cfif>
		<cfif DateCompare(ListGetAt(NiceFormat4,1,"|"),ListGetAt(NiceFormat4,2,"|")) GTE 0>
			<cfset SatListTimes4 = '"' & TRIM(ListGetAt(SatListTimes4,2,"|")) & '"'>
		<cfelse>
			<cfset SatListTimes4 = '"' & TRIM(ListGetAt(SatListTimes4,1,"|")) & '"'>
		</cfif>
		<cfif DateCompare(ListGetAt(NiceFormat3,1,"|"),ListGetAt(NiceFormat3,2,"|")) GTE 0>
			<cfset SatListTimes3 = '"' & TRIM(ListGetAt(SatListTimes3,2,"|")) & '"'>
		<cfelse>
			<cfset SatListTimes3 = '"' & TRIM(ListGetAt(SatListTimes3,1,"|")) & '"'>
		</cfif>
		<cfif DateCompare(ListGetAt(NiceFormat2,1,"|"),ListGetAt(NiceFormat2,2,"|")) GTE 0>
			<cfset SatListTimes2 = '"' & TRIM(ListGetAt(SatListTimes2,2,"|")) & '"'>
		<cfelse>
			<cfset SatListTimes2 = '"' & TRIM(ListGetAt(SatListTimes2,1,"|")) & '"'>
		</cfif>
		
		
		<cfif DateCompare(ListGetAt(NiceFormat1,1,"|"),ListGetAt(NiceFormat1,2,"|")) GTE 0>
			<cfset SatListTimes1 = '"' & TRIM(ListGetAt(SatListTimes1,2,"|")) & '"'>
		<cfelse>
			<cfset SatListTimes1 = '"' & TRIM(ListGetAt(SatListTimes1,1,"|")) & '"'>
		</cfif>
		
			<cfcatch type="expression">
				<!--- <cfthrow message=" 
				error on 2nd listgetat(), NiceFormat1: #listLen(NiceFormat1)# :: SatelliteTimes2: #listLen(SatelliteTimes2)#
				<br />
				DisplayMapType EQ SatListType :: #DisplayMapType# EQ #SatListType#
				<br />
				SatListTimes2 :: #SatListTimes2#
				" /> --->
			</cfcatch>
		</cftry>
		
	
	</cfif> <!--- Keep Oldest time only --->

	<cfif find('"', SatListTimes1) EQ 0>
		<cfset SatListTimes1 = '"' & SatListTimes1 & '"'>
	</cfif>



	<CFOUTPUT> 
	 <SCRIPT TYPE="TEXT/JAVASCRIPT"> 
	 	// Introduce two frames delay at the end
		var timesArray = new Array(#SatListTimes6#,#SatListTimes5#,#SatListTimes4#,#SatListTimes3#,#SatListTimes2#,#SatListTimes1#,#SatListTimes1#,#SatListTimes1#);
		function getobject(obj){
		if (document.getElementById)
				return document.getElementById(obj)
		else if (document.all)
				return document.all[obj]
		}
		function UpdateTime(){
			getobject("_Curr_Times").innerHTML = timesArray[current];
			window.setTimeout("UpdateTime()", rotate_delay);
		}
	
	  </SCRIPT>
	</CFOUTPUT>

</cfif>
  


<cfparam name="UpdateTimesOnly" default="">

<cfif UpdateTimesOnly EQ "Radar">
<div class="navlink" style="background-color:#000000; font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px" align="left">
 			<span style="color: #CCE2FF;"> Radar Update Time: </span>
			<span style="color: #E3E6E8;"><SPAN id="_Curr_Times"> </SPAN></span><br>
			<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>radar_legend.gif" border="0" alt="Radar legend"></span>		
</div>
</cfif>
<cfif UpdateTimesOnly EQ "Satellite">
<div class="navlink" style="background-color:#000000; font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px" align="left">
 			<span style="color: #CCE2FF;"> Satellite Updated at: </span>
			<span style="color: #E3E6E8;"><SPAN id="_Curr_Times"> </SPAN></span>
</div>
</cfif>
