<cfcomponent hint="timeFileToString.cfc">


	<cffunction name="init" access="public" returntype="string">
		<cfargument name="strFileName" type="string" required="yes" />
		<cfset var timeString = pullTime(arguments.strFileName) />
		<cfreturn timeString />
	</cffunction>
	
	
	<cffunction name="pullTime" access="package" returntype="string">
		<cfargument name="strFileName" type="string" required="yes" />
			<cfswitch expression="#ListLast(ListGetAt(arguments.strFileName,2,':'),'.')#">
			
				<cfcase value="xml">
					<cfset variables.fullString = " " & ListFirst(arguments.strFileName,':')  & " ->"/>
					<cfloop list="#ListLast(arguments.strFileName,':')#" delimiters="," index="fileName">
						<cffile action="read" 
								file="#ExpandPath('/flash/xml/')##fileName#"
								variable="variables.times" />
						<cfset variables.parsedXML = XmlParse(variables.times) />
						<cfset variables.issuedTime = XmlSearch(variables.parsedXML,"/chart/description/issue") />
						<cfset variables.validTime = XmlSearch(variables.parsedXML,"/chart/description/valid") />
						<!---<cfset variables.fullString = ListFirst(arguments.strFileName,':') />--->
						<cfif CompareNoCase(variables.issuedTime[1].XmlText,variables.validTime[1].XmlText) EQ 0>
							<cfset variables.fullString = variables.fullString & " time: " & variables.issuedTime[1].XmlText />
						<cfelse>
							<cfset variables.fullString = variables.fullString & " issued: " & variables.issuedTime[1].XmlText & " valid: " & variables.validTime[1].XmlText />
						</cfif>
						<cfif fileName EQ ListLast(fileName,",")>
							<cfset variables.fullString = variables.fullString & " " />
						</cfif>
					</cfloop>
					<cfif Len(variables.fullString) GT 120>
							<cfset variables.fullString = "<br /> " & variables.fullString & "<br />" />
						<cfelse>
							<cfset variables.fullString = variables.fullString & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
						</cfif>
		<cfreturn variables.fullString />
				</cfcase>
				
				<cfcase value="txt">
					<cfset variables.fullString = " " & ListFirst(arguments.strFileName,':') & " ->" />
					<cfset variables.fileName = ListLast(arguments.strFileName,':') />
					
					<cfloop list="#ListLast(arguments.strFileName,':')#" delimiters="," index="fileName">
						<cffile action="read" 
									file="#ExpandPath('/include/')##variables.fileName#"
									variable="variables.times" />
									
						<cfset variables.timesList = ReplaceNoCase(variables.times,chr(13),",","all") />
						<cfset variables.timesList = ReplaceNoCase(variables.times,chr(10),",","all") />
						<cfset variables.timesList = Right(variables.timesList,Len(variables.timesList) - 2) />
						<cfset variables.singleTime = ListLast(variables.timesList,',') />
						<!---<cfoutput>#variables.singleTime#</cfoutput>--->
						<!---<cfset variables.title = ListFirst(arguments.strFileName,':') />--->
						<cfset variables.txtYear = Left(variables.singleTime,4) />
						<cfset variables.txtMonth = Mid(variables.singleTime,5,2) />
						<cfset variables.txtDay = Mid(variables.singleTime,7,2) />
						<cfset variables.txtHour = Mid(variables.singleTime,9,2) />
						<cfset variables.txtMinutes = Mid(variables.singleTime,11,2) />
						<cfif fileName EQ "out_west_nh.txt">
							<cfset variables.title = "<span style='color:##009900;'>GOESW" />
							<cfset variables.sat = true />
						</cfif>
						<cfif fileName EQ "out_east_nh.txt">
							<cfset variables.title = "<span style='color:##0099FF;'>GOESE" />
							<cfset variables.sat = true />
						</cfif>
						<cfif fileName EQ "out_msg1_fd.txt">
							<cfset variables.title = "<span style='color:##FFCC33;'>MET8" />
							<cfset variables.sat = true />
						</cfif>
						<cfif fileName EQ "out_met5_fd.txt">
							<cfset variables.title = "<span style='color:##CC3399;'>MET5" />
							<cfset variables.sat = true />
						</cfif>
						<cfif fileName EQ "out_gms5_fd.txt">
							<cfset variables.title = "<span style='color:##CC3333;'>GMS5" />
							<cfset variables.sat = true />
						</cfif>
						<cfif NOT IsDefined("variables.title")>
							<cfset variables.title = "" />
						</cfif>
						<cfif fileName EQ ListFirst(fileName,",")>
							<cfset variables.fullString = variables.fullString & " " & variables.title & " time: " & variables.txtYear & "/" & variables.txtMonth & "/" & variables.txtDay & "&nbsp;" & variables.txtHour & ":" & variables.txtMinutes />
						<cfelse>
							<cfset variables.fullString = variables.fullString & " " & " time: " & variables.txtYear & "/" & variables.txtMonth & "/" & variables.txtDay & "&nbsp;" & variables.txtHour & ":" & variables.txtMinutes  />
						</cfif>
						<cfif IsDefined("variables.sat") AND (variables.sat)>
							<cfset variables.fullString = variables.fullString & "</span>" />
						</cfif>
					</cfloop>
						<cfif Len(variables.fullString) GT 120>
							<cfset variables.fullString = "<br />" & variables.fullString & "<br />" />
						<cfelse>
							<cfset variables.fullString = variables.fullString & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
						</cfif>
							<!--- <cfloop from="1" to="20" index="spaceIndex">
								<cfset variables.fullString = variables.fullString & "&nbsp;" />
							</cfloop> --->
		<cfreturn variables.fullString />
				</cfcase>
			</cfswitch>
		</cffunction>
		
		
</cfcomponent>