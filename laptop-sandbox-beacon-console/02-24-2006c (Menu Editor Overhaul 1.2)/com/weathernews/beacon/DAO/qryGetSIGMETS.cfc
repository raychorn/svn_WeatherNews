<cfcomponent hint="qryGetSIGMETS">
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
		<cfargument name="arrSigmetType" type="array" required="yes" />
		<cfset qrySIGMETS = getSigmets(arguments.strWhereClause,
									   arguments.intPeriodFrom,arguments.intPeriodTo,arguments.arrSigmetType) />
		<cfreturn qrySIGMETS />
	</cffunction>
	<cffunction name="getSigmets" access="private" returntype="query">
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
		<cfargument name="arrSigmetType" type="array" required="yes" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="query.getSigmets" datasource="#AVNOPS_DS#">
			-- SET ROWCOUNT 20
			SELECT Col_1=bullName, Col_2=issueTime,Col_3=endTime,Col_4=rawMsg
			FROM sigmet
			WHERE #PreserveSingleQuotes(arguments.strWhereClause)#
				  AND
				  (issueTime <= DATEADD(hh,-#arguments.intPeriodFrom#,getdate()))
							AND (issueTime >= DATEADD(hh,-#arguments.intPeriodTo#,getdate())) AND (
				  <cfloop from="1" to="#ArrayLen(arguments.arrSigmetType)#" index="i">
				 		sigType = '#arguments.arrSigmetType[i]#'
					 	<cfif ArrayLen(arguments.arrSigmetType) NEQ i>
							OR
						</cfif>
				  </cfloop> )
			ORDER BY issueTime DESC
		</cfquery>
		<cfreturn query.getSigmets />
	</cffunction>
</cfcomponent>