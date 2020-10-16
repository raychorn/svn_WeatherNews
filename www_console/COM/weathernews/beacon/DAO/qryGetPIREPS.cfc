<cfcomponent hint="qryGetPIREPS">
	<cffunction name="init" access="public" returntype="query">
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<!--- Station List and Intensity List --->
		<cfargument name="strStationList" type="string" required="yes" />
		<cfargument name="strIntensityList" type="string" required="yes" />
		<!--- User defined --->
		<cfargument name="pType" type="string" required="yes" />
		<cfargument name="pTypeOther" type="string" required="yes" />
		<!--- region --->
		<cfargument name="region" type="string" required="yes" default="USA" />
		<cfset qryPIREPS = getPIREPS(arguments.intPeriodFrom,arguments.intPeriodTo,arguments.strStationList,
									   arguments.strIntensityList,
									   arguments.pType,
									   arguments.pTypeOther,arguments.region) />
		<cfreturn qryPIREPS />
	</cffunction>
	<cffunction name="getPIREPS" access="private" returntype="query">
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<!--- Station List and Intensity List --->
		<cfargument name="strStationList" type="string" required="yes" />
		<cfargument name="strIntensityList" type="string" required="yes" />
		<!--- User defined --->
		<cfargument name="pType" type="string" required="yes" />
		<cfargument name="pTypeOther" type="string" required="yes" />
		<!--- Region --->
		<cfargument name="region" type="string" required="yes" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="getPIREPS" datasource="#Request.AVNOPS_DS#">
					SELECT 
							Col_1=P.origin, 
							Col_2=convert(Char(5),P.rTime,1) + ' ' +  convert(Char(5),P.rTime,8) + 'Z',
							Col_3=P.rawMsg, 
							Col_4=P.pirepID, 
							Col_5=P.lat, 
							Col_6=P.lon
					FROM obsdb..PIREP P
					WHERE 1=1
					    AND P.origin <> '-AMD'
					    --AND P.origin <> 'AA'
						
						AND	(

						<cfif (pType EQ "UserDef") AND (LEN(pTypeOther) GT 2)>
							UPPER(P.rawMsg) LIKE  '%#UCASE(pTypeOther)#%'
						<cfelse>	
							<cfloop list="#arguments.strStationList#" index="LoopIndex" delimiters=",">
								UPPER(P.rawMsg) LIKE  '%#LoopIndex#%'
								<cfif ListLast(arguments.strStationList) NEQ #LoopIndex#> OR </cfif>
							</cfloop>
						</cfif>
						)
						AND	(
						<cfloop list="#arguments.strIntensityList#" index="LoopIndex" delimiters=",">
							UPPER(P.rawMsg) LIKE  '%#LoopIndex#%'
							<cfif ListLast(arguments.strIntensityList) NEQ #LoopIndex#> OR </cfif>
						</cfloop>
						)

						AND P.rTime <= DATEADD(hh,-#arguments.intPeriodFrom#,getdate())
						AND P.rTime >= DATEADD(hh,-#arguments.intPeriodTo#,getdate())
			
						<cfif IsDefined("arguments.region")>
							<cfswitch expression="#arguments.region#">
								<cfcase value="s6C1">
								  AND ((lat BETWEEN 25 AND 49 AND
								  lon BETWEEN -125 AND -67)
								  OR
								  (lat BETWEEN 25 AND 49 AND
								  lon BETWEEN -125 AND -67))
							  </cfcase>
							  <cfcase value="s6C2">
							  	AND ((lat BETWEEN 37 AND 48 AND
									  lon BETWEEN -85 AND -64)
									  OR
									  (lat BETWEEN 37 AND 49 AND
									  lon BETWEEN -85 AND -68))
								 </cfcase>
								 <cfcase value="s6C3">
								 	AND ((lat BETWEEN 24 AND 37 AND
									  lon BETWEEN -90 AND -68)
									  OR
									  (lat BETWEEN 24 AND 37 AND
									  lon BETWEEN -90 AND -72))
								</cfcase>
								<cfcase value="s6C4">
								 	AND ((lat BETWEEN 37 AND 49 AND
									  lon BETWEEN -105 AND -85)
									  OR
									  (lat BETWEEN 37 AND 49 AND
									  lon BETWEEN -105 AND -85))
								</cfcase>
								<cfcase value="s6C5">
								 	AND ((lat BETWEEN 25 AND 37 AND
										  lon BETWEEN -105 AND -90)
										  OR
										  (lat BETWEEN 25 AND 37 AND
										  lon BETWEEN -105 AND -90))
								</cfcase>
								<cfcase value="s6C6">
								 	AND ((lat BETWEEN 40 AND 49 AND
										  lon BETWEEN -125 AND -105)
										  OR
										  (lat BETWEEN 40 AND 49 AND
										  lon BETWEEN -125 AND -105))
								</cfcase>
								<cfcase value="s6C7">
								 	AND ((lat BETWEEN 30 AND 40 AND
									  lon BETWEEN -125 AND -105)
									  OR
									  (lat BETWEEN 30 AND 40 AND
									  lon BETWEEN -125 AND -105))
								</cfcase>
								<cfcase value="s6C8">
								 	AND ((lat BETWEEN 52 AND 72 AND
									  lon BETWEEN -172 AND -140)
									  OR
									  (lat BETWEEN 52 AND 72 AND
									  lon BETWEEN -172 AND -130))
								</cfcase>
								<cfcase value="s6C9">
								 	AND ((lat BETWEEN 18 AND 23 AND
									  lon BETWEEN -161 AND -154)
									  OR
									  (lat BETWEEN 18 AND 23 AND
									  lon BETWEEN -161 AND -154))
								</cfcase>
								<cfcase value="s6C10">
								 	AND ((lat BETWEEN 48 AND 70 AND
									  lon BETWEEN -141 AND -95)
									  OR
									  (lat BETWEEN 48 AND 83 AND
									  lon BETWEEN -141 AND -95))
								</cfcase>
								<cfcase value="s6C11">
								 	AND ((lat BETWEEN 46 AND 48 AND
									  lon BETWEEN -95 AND -50)
									  OR
									  (lat BETWEEN 82 AND 85 AND
									  lon BETWEEN -82 AND -60)
									  OR
									  (lat BETWEEN 83 AND 85 AND
									   lon BETWEEN -95 AND -60))
								</cfcase>
								<cfcase value="s6C12">
								 	AND ((lat BETWEEN 25 AND 46 AND
									  lon BETWEEN -80 AND -53)
									  OR
									  (lat BETWEEN 20 AND 30 AND
									  lon BETWEEN -80 AND -60)
									  OR
									  (lat BETWEEN 25 AND 45 AND
									   lon BETWEEN -80 AND -65))
								</cfcase>
								<cfcase value="s6C13">
								 	AND ((lat BETWEEN 19 AND 60 AND
									  lon BETWEEN -180 AND -140)
									  OR
									  (lat BETWEEN 48 AND 64 AND
									  lon BETWEEN -180 AND -125)
									  OR
									  (lat BETWEEN 19 AND 60 AND
									   lon BETWEEN -140 AND -123))
								</cfcase>
								<cfcase value="s6C14">
								 	AND ((lat BETWEEN -60 AND 10 AND
									  lon BETWEEN -80 AND -30)
									  OR
									  (lat BETWEEN -60 AND 15 AND
									  lon BETWEEN -90 AND -40))
								</cfcase>
								<cfcase value="s6C15">
								 	AND ((lat BETWEEN 25 AND 33 AND
									  lon BETWEEN -120 AND -85)
									  OR
									  (lat BETWEEN 10 AND 28 AND
									  lon BETWEEN -95 AND -90)
									  OR
									  (lat BETWEEN 20 AND 25 AND
									   lon BETWEEN -110 AND -85)
									   OR
									   (lat BETWEEN 10 AND 20 AND
									    lon BETWEEN -110 AND -90))
								</cfcase>
								<cfcase value="s6C16">
								 	AND ((lat BETWEEN 10 AND 20 AND
									  lon BETWEEN -110 AND -75)
									  OR
									  (lat BETWEEN 05 AND 33 AND
									  lon BETWEEN -120 AND -80)
									  OR
									  (lat BETWEEN 20 AND 28 AND
									   lon BETWEEN -110 AND -95)
									   OR
									   (lat BETWEEN 25 AND 33 AND
									    lon BETWEEN -120 AND -85))
								</cfcase>
								<cfcase value="s6C17">
								 	AND ((lat BETWEEN 20 AND 28 AND
									  lon BETWEEN -85 AND -75)
									  OR
									  (lat BETWEEN 10 AND 25 AND
									  lon BETWEEN -85 AND -75)
									  OR
									  (lat BETWEEN 10 AND 20 AND
									   lon BETWEEN -85 AND -60)
									   OR
									   (lat BETWEEN 10 AND 20 AND
									    lon BETWEEN -75 AND -60))
								</cfcase>
								<cfcase value="s6C18">
								 	AND ((lat BETWEEN 15 AND 60 AND
									  lon BETWEEN -120 AND 130)
									  OR
									  (lat BETWEEN 20 AND 60 AND
									  lon BETWEEN -120 AND 130))
								</cfcase>
								<cfcase value="s6C19">
								 	AND ((lat BETWEEN 35 AND 72 AND
									  lon BETWEEN -10 AND 25)
									  OR
									  (lat BETWEEN 70 AND 72 AND
									  lon BETWEEN -25 AND -60)
									  OR
									  (lat BETWEEN 50 AND 72 AND
									   lon BETWEEN 25 AND 60)
									   OR
									   (lat BETWEEN 40 AND 72 AND
									    lon BETWEEN 50 AND 60)
										OR
										(lat BETWEEN 53 AND 50 AND
										lon BETWEEN 20 AND 60))
								</cfcase>
								<cfcase value="s6C20">
								 	AND ((lat BETWEEN 35 AND 72 AND
									  lon BETWEEN 20 AND 60)
									  OR
									  (lat BETWEEN 10 AND 50 AND
									  lon BETWEEN 40 AND 60)
									  OR
									  (lat BETWEEN 0 AND 35 AND
									   lon BETWEEN 20 AND 90)
									   OR
									   (lat BETWEEN 0 AND 10 AND
									    lon BETWEEN 40 AND 130)
										OR
										(lat BETWEEN 0 AND 30 AND
										lon BETWEEN 90 AND 150)
										OR
										(lat BETWEEN 0 AND 65 AND
										lon BETWEEN 130 AND 165)
										OR
										(lat BETWEEN 30 AND 80 AND
										lon BETWEEN 145 AND 150))
								</cfcase>
							 </cfswitch>
						</cfif>
					ORDER BY P.rTime DESC    
				</cfquery>
		<cfreturn getPIREPS />
	</cffunction>
</cfcomponent>