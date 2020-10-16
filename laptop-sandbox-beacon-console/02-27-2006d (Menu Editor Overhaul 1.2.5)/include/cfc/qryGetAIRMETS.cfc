<cfcomponent hint="qryGetAIRMETS">
	<cffunction name="init" access="public" returntype="query">
		<!--- lat and long values default to the continental united states A set is first box --->
		<cfargument name="strWhereClause" type="string" required="yes" default="
			((maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67)
				  OR
				  (maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67))" />
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
			((maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67)
				  OR
				  (maxLat BETWEEN 25 AND 49 AND
				  maxLon BETWEEN -125 AND -67))" />
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<!--- Sigmet Type --->
		<cfargument name="arrAirmetType" type="array" required="yes" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="getAIRMETSQuery" datasource="#AVNOPS_DS#">
			-- SET ROWCOUNT 20
			SELECT Col_1=bullName, Col_2=createdTime,Col_3=endTime,Col_4=flevel1,
				   Col_5=flevel2,Col_6=issueTime,
			       Col_7=maxLat,Col_8=maxLon,Col_9=minLat,Col_10=minLon,Col_11=origin,Col_12=rawMsg,
				   Col_13=airType,Col_14=startTime,Col_15=subtype, Col_24=pointList, Col_25=corFlag, Col_26=seqID
			FROM airmet
			WHERE #PreserveSingleQuotes(arguments.strWhereClause)#
				  AND
				  (issueTime <= DATEADD(hh,-#arguments.intPeriodFrom#,getdate())
							AND issueTime >= DATEADD(hh,-#arguments.intPeriodTo#,getdate())) AND (
				  <cfloop from="1" to="#ArrayLen(arguments.arrAirmetType)#" index="i">
				 		airType = '#arguments.arrAirmetType[i]#'
					 	<cfif ArrayLen(arguments.arrAirmetType) NEQ i>
							OR
						</cfif>
				  </cfloop> )
			ORDER BY issueTime DESC
		</cfquery>
		<cfreturn getAIRMETSQuery />
	</cffunction>
</cfcomponent>