<cfcomponent hint="qryGetNOTAMS">
	<cffunction name="init" access="public" returntype="query">
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<cfargument name="notamType" type="string" required="yes" default="" />
		<cfargument name="icaoSearch" type="string" required="no" />
		<cfif NOT IsDefined("arguments.icaoSearch")>
			<cfset qryNOTAMS = getNotams(arguments.intPeriodFrom,arguments.intPeriodTo,arguments.notamType) />
		<cfelse>
			<cfset qryNOTAMS = getNotams(arguments.intPeriodFrom,arguments.intPeriodTo,arguments.notamType,arguments.icaoSearch) />
		</cfif>
		<cfreturn qryNOTAMS />
	</cffunction>
	<cffunction name="getNotams" access="private" returntype="query">
		<!--- Bring in the time period --->
		<cfargument name="intPeriodFrom" type="numeric" required="yes" default="6" />
		<cfargument name="intPeriodTo" type="numeric" required="yes" default="0" />
		<cfargument name="notamType" type="string" required="yes" default="" />
		<cfargument name="icaoSearch" type="string" required="no" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="query.getNotams" datasource="#AVNOPS_DS#">
			-- SET ROWCOUNT 20
			SELECT Col_3=createdTime,Col_2=type,Col_1=notamID,Col_4=originDesc,Col_5=msg
			FROM obsdb.dbo.NOTAM
			WHERE 
				<cfif arguments.notamType NEQ "all">
				  type = '#arguments.notamType#' AND 
				 </cfif>
				 <cfif IsDefined("arguments.icaoSearch") AND arguments.icaoSearch NEQ "">
				 	<cfloop list="#arguments.icaoSearch#" index="icao">
						origin = '#Ucase(icao)#' <cfif ListLast(arguments.icaoSearch,",") NEQ icao>OR</cfif>
					</cfloop> AND
				</cfif>
				  (createdTime <= DATEADD(hh,-#arguments.intPeriodFrom#,getdate())
							AND createdTime >= DATEADD(hh,-#arguments.intPeriodTo#,getdate())) 
			ORDER BY createdTime DESC
		</cfquery>
		<cfreturn query.getNotams />
	</cffunction>
</cfcomponent>