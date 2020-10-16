<cfcomponent hint="qryGetSIGMETS">
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
		<cfargument name="arrSigmetType" type="array" required="yes" />
		<cfset qrySIGMETS = getSigmets(arguments.strWhereClause,
									   arguments.intPeriodFrom,arguments.intPeriodTo,arguments.arrSigmetType) />
		<cfreturn qrySIGMETS />
	</cffunction>
	<cffunction name="getSigmets" access="private" returntype="query">
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
		<cfargument name="arrSigmetType" type="array" required="yes" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="getSigmetsQuery" datasource="#AVNOPS_DS#">
			-- SET ROWCOUNT 20
			SELECT Col_1=bullName, Col_2=corFlag,Col_3=createdTime,Col_4=direction,Col_5=endTime,Col_6=flevel1,
				   Col_7=flevel2,Col_8=intensity,Col_9=issueTime,Col_10=lineDist,
			       Col_11=maxLat,Col_12=maxLon,Col_13=minLat,Col_14=minLon,Col_15=origin,Col_16=RawMsg,
				   Col_17=seqID,Col_18=sigmetID,Col_19=sigType,Col_20=speed,Col_21=startTime,Col_22=subtype,Col_24=PointList
			FROM sigmet
			WHERE #PreserveSingleQuotes(arguments.strWhereClause)#
				  AND
				  (issueTime <= DATEADD(hh,-#arguments.intPeriodFrom#,getdate())
							AND issueTime >= DATEADD(hh,-#arguments.intPeriodTo#,getdate())) AND (
				  <cfloop from="1" to="#ArrayLen(arguments.arrSigmetType)#" index="i">
				 		sigType = '#arguments.arrSigmetType[i]#'
					 	<cfif ArrayLen(arguments.arrSigmetType) NEQ i>
							OR
						</cfif>
				  </cfloop> )
			ORDER BY issueTime DESC
		</cfquery>
		<cfreturn getSigmetsQuery />
	</cffunction>
</cfcomponent>