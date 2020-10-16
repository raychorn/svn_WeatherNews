<cfcomponent name="getTimeFileForAnimation" hint="I get the time file for the animation and then turn it into a string">
	<cffunction name="init" access="public" returntype="array">
		<cfargument name="timeFileName" type="string" required="true" />
		<cfset variables.arrTimeStrings = getTimeStringArray(arguments.timeFileName) />
		<cfreturn variables.arrTimeStrings />	
	</cffunction>
	
	<cffunction name="getTimeStringArray" access="package" returntype="array">
		<cfargument name="timeFileName" type="string" required="true" />
			<cfset var tempTimeArray = ArrayNew(1) />
			<cfset var arrayInitalized = 0 />
			<cfloop list="#arguments.timeFileName#" delimiters="," index="variables.fileName">
				<cffile action="read" 
							file="#ExpandPath('/include/')##variables.fileName#"
							variable="variables.times" />
				
				<!--- <cfset variables.times = Left(variables.times,Len(variables.times) - 1) /> --->
				<cfset variables.times = ReplaceNoCase(variables.times,chr(13),",","all") />
				<cfset variables.times = ReplaceNoCase(variables.times,chr(10),",","all") />
				<cfset timesArray = ListToArray( variables.times ) />	
				<cfset finalTimeArray = ArrayNew(1) />
				<cfset fileName = variables.fileName />
				
				<cfset arguments.strFileName = variables.fileName />
				
				<cfloop from="1" to="#ArrayLen(timesArray)#" index="y">
					<cfset variables.fullString = "" />		
					<cfset variables.timesList = timesArray[y] />		

					<!--- <cfset variables.timesList = Right(variables.timesList,Len(variables.timesList) - 2) />
					<cfset variables.singleTime = ListLast(variables.timesList,',') /> --->
					<cfset variables.singleTime = variables.timesList />
					<!---<cfoutput>#variables.singleTime#</cfoutput>--->
					<!---<cfset variables.title = ListFirst(arguments.strFileName,':') />--->
					<cfset variables.txtYear = Left(variables.singleTime,4) />
					<cfset variables.txtMonth = Mid(variables.singleTime,5,2) />
					<cfset variables.txtDay = Mid(variables.singleTime,7,2) />
					<cfset variables.txtHour = Mid(variables.singleTime,9,2) />
					<cfset variables.txtMinutes = Mid(variables.singleTime,11,2) />
					<cfif fileName EQ "out_west_nh.txt">
						<cfset variables.title = "GOESW" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "out_east_nh.txt">
						<cfset variables.title = "GOESE" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "out_msg1_fd.txt">
						<cfset variables.title = "MET8" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "out_met5_fd.txt">
						<cfset variables.title = "MET5" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "out_gms5_fd.txt">
						<cfset variables.title = "GMS5" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "CONUS_WIN_mosaic_time.txt">
						<cfset variables.title = "CONUS" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "CONUS_COMP_mosaic_time.txt">
						<cfset variables.title = "CONUS" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "CONUS_mosaic_time.txt">
						<cfset variables.title = "CONUS" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "EUROPE_mosaic_time.txt">
						<cfset variables.title = "MET8" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "out_east_conus.txt">
						<cfset variables.title = "GOESE" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "out_europe.txt">
						<cfset variables.title = "MET8" />
						<cfset variables.sat = true />
					</cfif>
					<cfif fileName EQ "out_asia.txt">
						<cfset variables.title = "GMS5" />
						<cfset variables.sat = true />
					</cfif>
					<cfif NOT IsDefined("variables.title")>
						<cfset variables.title = "" />
					</cfif>
						<cfset variables.fullString = variables.title & ":" & variables.fullString & " " & " " & variables.txtYear & "/" & variables.txtMonth & "/" & variables.txtDay & " " & variables.txtHour & ":" & variables.txtMinutes  />
					
					
					<cfset finalTimeArray[y] = variables.fullString />
					
				</cfloop>
				<cfif arrayInitalized EQ 1>
					<!--- Do Nothing --->
				<cfelse>
					<cfset ArraySet(tempTimeArray,1,ArrayLen(finalTimeArray),"") />
					<cfset arrayInitalized = 1>
				</cfif>
				<cfloop from="1" to="#ArrayLen(finalTimeArray)#" index="z">
					<cfset tempTimeArray[z] = tempTimeArray[z] & " " & finalTimeArray[z] />
				</cfloop>
			</cfloop>
			<cfreturn tempTimeArray />
		
		
	</cffunction>
</cfcomponent>