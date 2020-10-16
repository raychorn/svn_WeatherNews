<cfcomponent hint="qryGetNOTAMS">
	<cffunction name="init" access="public" returntype="query">
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<cfset qryNOTAMS = getNotams(arguments.intPeriodFrom,arguments.intPeriodTo) />
		<cfreturn qryNOTAMS />
	</cffunction>
	<cffunction name="getNotams" access="private" returntype="query">
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="getNotams" datasource="#Request.AVNOPS_DS#">
			-- SET ROWCOUNT 20
			SELECT Col_1=altID, Col_2=cancelFlag,Col_3=createdTime,Col_4=currentTime,Col_5=notamID,Col_6=origin,
				   Col_7=originDesc,Col_8=type,Col_9=msg
			FROM obsdb.dbo.NOTAM
			WHERE 
				  (createdTime <= DATEADD(hh,-#arguments.intPeriodFrom#,getdate())
							AND createdTime >= DATEADD(hh,-#arguments.intPeriodTo#,getdate())) 
			ORDER BY createdTime DESC
		</cfquery>
		<cfreturn getNotams />
	</cffunction>
</cfcomponent>