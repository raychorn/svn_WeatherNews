<cfcomponent hint="qryGetCorrectedValidSIGMETS">
	<cffunction name="init" access="public" returntype="query">
		<cfset qryCorrSIGS = getCorrectedValidSIGMETS() />
		<cfreturn qryCorrSIGS />
	</cffunction>
	<cffunction name="getCorrectedValidSIGMETS" access="package" returntype="query">
		<cfset variables.sigmetType = ArrayNew(1) />
		<cfset ArrayPrepend(variables.sigmetType,"CNVC") />
		<cfset ArrayPrepend(variables.sigmetType,"ICNG") />
		<cfset ArrayPrepend(variables.sigmetType,"VASH") />
		<cfset ArrayPrepend(variables.sigmetType,"TURB") />
		
		<cfinvoke component="qryGetSIGMETS" method="init" returnvariable="notCorrected">
			<cfinvokeargument name="strWhereClause" value='endTime > getDate() AND corFlag = 0' />
			<cfinvokeargument name="intPeriodFrom" value="0" />
			<cfinvokeargument name="intPeriodTo" value="24" />
			<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
		</cfinvoke>
		
		<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="corrected">
			<cfinvokeargument name="strWhereClause" value='endTime > getDate() AND corFlag = 1' />
			<cfinvokeargument name="intPeriodFrom" value="0" />
			<cfinvokeargument name="intPeriodTo" value="24" />
			<cfinvokeargument name="arrSigmetType" value="#variables.sigmetType#" />
		</cfinvoke>
		
		<cfloop query="notCorrected">
			<cfloop query="corrected">
				<cfif Compare(notCorrected.seqID,corrected.seqID) EQ 0>
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
				<cfset QuerySetCell(notCorrected,"col_16","#corrected.col_16#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_17","#corrected.col_17#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_18","#corrected.col_18#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_19","#corrected.col_19#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_20","#corrected.col_20#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_21","#corrected.col_21#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_22","#corrected.col_22#",notCorrected.currentRow) />
				<cfset QuerySetCell(notCorrected,"col_24","#corrected.col_24#",notCorrected.currentRow) />
			</cfif>
			
		</cfloop>
		
		<cfreturn notCorrected />
	</cffunction>
</cfcomponent>