<cfcomponent hint="qryGetAIRMETS">
	<cffunction name="init" access="public" returntype="query">
		<!--- lat and long values default to the continental united states A set is first box --->
		<cfargument name="strWhereClause" type="string" required="yes" default="
			((maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67)
				  OR
				  (maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67)) OR
			((minLat BETWEEN 25 AND 49 AND
				  minLon BETWEEN -125 AND -67)
				  OR
				  (minLat BETWEEN 25 AND 49 AND
				  minLon BETWEEN -125 AND -67))" />
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<!--- Sigmet Type --->
		<cfargument name="arrAirmetType" type="array" required="yes" />
		<cfset qryAIRMETS = getAIRMETS(arguments.strWhereClause,
									   arguments.intPeriodFrom,arguments.intPeriodTo,arguments.arrAirmetType) />
		<cfreturn qryAIRMETS />
	</cffunction>
	<cffunction name="getAIRMETS" access="private" returntype="query">
		<!--- lat and long values default to the continental united states A set is first box --->
		<cfargument name="strWhereClause" type="string" required="yes" default="
			(((maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67)
				  OR
				  (maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67)) OR
			((minLat BETWEEN 25 AND 49 AND
				  minLon BETWEEN -125 AND -67)
				  OR
				  (minLat BETWEEN 25 AND 49 AND
				  minLon BETWEEN -125 AND -67)))" />
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<!--- Sigmet Type --->
		<cfargument name="arrAirmetType" type="array" required="yes" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="query.getAIRMETS" datasource="#AVNOPS_DS#">
			-- SET ROWCOUNT 20
			SELECT Col_1=bullName, Col_2=issueTime,Col_3=endTime,Col_4=rawMsg
			FROM airmet
			WHERE (issueTime <= DATEADD(hh,-#arguments.intPeriodFrom#,getdate())
							AND issueTime >= DATEADD(hh,-#arguments.intPeriodTo#,getdate())) AND (
				  <cfloop from="1" to="#ArrayLen(arguments.arrAirmetType)#" index="i">
				 		airType = '#arguments.arrAirmetType[i]#'
					 	<cfif ArrayLen(arguments.arrAirmetType) NEQ i>
							OR
						</cfif>
				  </cfloop> ) AND
				  (#PreserveSingleQuotes(arguments.strWhereClause)#)
			ORDER BY issueTime DESC
		</cfquery>
		<cfreturn query.getAIRMETS />
	</cffunction>
</cfcomponent>