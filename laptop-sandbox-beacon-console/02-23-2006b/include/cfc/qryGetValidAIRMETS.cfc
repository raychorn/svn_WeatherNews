<cfcomponent hint="qryGetCorrectedValidAIRMETS">
	<cffunction name="init" access="public" returntype="query">
		<cfset qryCorrSIGS = getCorrectedValidAIRMETS() />
		<cfreturn qryCorrSIGS />
	</cffunction>
	<cffunction name="getCorrectedValidAIRMETS" access="package" returntype="query">
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfset variables.airmetType = ArrayNew(1) />
		<cfset ArrayPrepend(variables.airmetType,"CNVC") />
		<cfset ArrayPrepend(variables.airmetType,"ICNG") />
		<cfset ArrayPrepend(variables.airmetType,"VASH") />
		<cfset ArrayPrepend(variables.airmetType,"TURB") />
		<!--- <cfset StructClear(APPLICATION) /> --->
		<cfif Not IsDefined("APPLICATION.common.Airmets")>
			<cfset APPLICATION.common.Airmets = CreateObject("component","qryGetAIRMETS") />
		</cfif>
		
		<!--- <cfinvoke component="#APPLICATION.Airmets#" method="init" returnvariable="notCorrected">
			<cfinvokeargument name="strWhereClause" value='endTime > getDate()' />
			<cfinvokeargument name="intPeriodFrom" value="0" />
			<cfinvokeargument name="intPeriodTo" value="72" />
			<cfinvokeargument name="arrAirmetType" value="#variables.airmetType#" />
		</cfinvoke> --->
		<cfset notCorrected = APPLICATION.common.Airmets.init('endTime > getDate()',0,72,'#variables.airmetType#') />
		
		<!--- <cfinvoke component="APPLICATION.qryGetAirmets" method="init" returnvariable="corrected">
			<cfinvokeargument name="strWhereClause" value='endTime > getDate() AND corFlag = 1' />
			<cfinvokeargument name="intPeriodFrom" value="0" />
			<cfinvokeargument name="intPeriodTo" value="72" />
			<cfinvokeargument name="arrAirmetType" value="#variables.airmetType#" />
		</cfinvoke> --->
		
		<cfquery name="corrected" datasource="#AVNOPS_DS#">
			SELECT bullName, origin, issueTime, airType, subtype, seqID, endTime
			FROM airmet 
			WHERE endTime > getDate() 
			GROUP BY bullName, origin, issueTime, airType, subtype, seqID, endTime
			ORDER BY issueTime DESC 
		</cfquery>
		
		<cfloop query="notCorrected">
			<cfloop query="corrected">
				<cfif Compare(notCorrected.Col_26,corrected.seqID) EQ 0 AND
					  Compare(notCorrected.Col_1,corrected.bullName) EQ 0 AND
					  Compare(notCorrected.Col_11,corrected.origin) EQ 0 AND
					  Compare(notCorrected.Col_6,corrected.issueTime) EQ 0 AND
					  Compare(notCorrected.Col_13,corrected.airType) EQ 0 AND
					  Compare(notCorrected.Col_15,corrected.subtype) EQ 0 AND
					  (notCorrected.Col_3 LT corrected.endTime)>
					<cfset variables.boolHere = true />
				</cfif>
			</cfloop>
			<cfif IsDefined("variables.boolHere") AND (variables.boolHere)>
				<cfset QuerySetCell(notCorrected,"col_1","#corrected.col_1#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_2","#corrected.col_2#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_3","#corrected.col_3#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_4","#corrected.col_4#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_5","#corrected.col_5#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_6","#corrected.col_6#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_7","#corrected.col_7#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_8","#corrected.col_8#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_9","#corrected.col_9#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_10","#corrected.col_10#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_11","#corrected.col_11#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_12","#corrected.col_12#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_13","#corrected.col_13#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_14","#corrected.col_14#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_15","#corrected.col_15#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_24","#corrected.col_24#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_25","#corrected.col_25#",notCorrected.currentRow) />
			</cfif>
			
		</cfloop>
		
		<cfreturn notCorrected />
	</cffunction>
</cfcomponent>