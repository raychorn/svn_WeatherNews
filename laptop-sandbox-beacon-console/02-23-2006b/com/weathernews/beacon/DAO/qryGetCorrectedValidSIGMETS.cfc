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
		
		<cfinvoke component="com.weathernews.beacon.DAO.qryGetSIGMETS" method="init" returnvariable="notCorrected">
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
		
		<cfset SIGS = QueryNew("col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8,
								col_9,col_10,col_11,col_12,col_13,col_14,col_15,col_16,col_17,col_18,
								col_19,col_20,col_21,col_22,col_24") />
		<cfloop query="notCorrected">
		
			<cfset QueryAddRow(SIGS) />
			<cfset variables.boolPresent = false />
			
			<cfloop query="corrected">
				<cfif Compare(notCorrected.seqID,corrected.seqID) EQ 0>
					<cfset variables.boolPresent = true />
				</cfif>
			</cfloop>
			
			<cfif (variables.boolPresent)>
				<cfset QuerySetCell(SIGS,"col_1","#corrected.col_1#") />
				<cfset QuerySetCell(SIGS,"col_2","#corrected.col_2#") />
				<cfset QuerySetCell(SIGS,"col_3","#corrected.col_3#") />
				<cfset QuerySetCell(SIGS,"col_4","#corrected.col_4#") />
				<cfset QuerySetCell(SIGS,"col_5","#corrected.col_5#") />
				<cfset QuerySetCell(SIGS,"col_6","#corrected.col_6#") />
				<cfset QuerySetCell(SIGS,"col_7","#corrected.col_7#") />
				<cfset QuerySetCell(SIGS,"col_8","#corrected.col_8#") />
				<cfset QuerySetCell(SIGS,"col_9","#corrected.col_9#") />
				<cfset QuerySetCell(SIGS,"col_10","#corrected.col_10#") />
				<cfset QuerySetCell(SIGS,"col_11","#corrected.col_11#") />
				<cfset QuerySetCell(SIGS,"col_12","#corrected.col_12#") />
				<cfset QuerySetCell(SIGS,"col_13","#corrected.col_13#") />
				<cfset QuerySetCell(SIGS,"col_14","#corrected.col_14#") />
				<cfset QuerySetCell(SIGS,"col_15","#corrected.col_15#") />
				<cfset QuerySetCell(SIGS,"col_16","#corrected.col_16#") />
				<cfset QuerySetCell(SIGS,"col_17","#corrected.col_17#") />
				<cfset QuerySetCell(SIGS,"col_18","#corrected.col_18#") />
				<cfset QuerySetCell(SIGS,"col_19","#corrected.col_19#") />
				<cfset QuerySetCell(SIGS,"col_20","#corrected.col_20#") />
				<cfset QuerySetCell(SIGS,"col_21","#corrected.col_21#") />
				<cfset QuerySetCell(SIGS,"col_22","#corrected.col_22#") />
				<cfset QuerySetCell(SIGS,"col_24","#corrected.col_24#") />
			<cfelse>
				<cfset QuerySetCell(SIGS,"col_1","#notCorrected.col_1#") />
				<cfset QuerySetCell(SIGS,"col_2","#notCorrected.col_2#") />
				<cfset QuerySetCell(SIGS,"col_3","#notCorrected.col_3#") />
				<cfset QuerySetCell(SIGS,"col_4","#notCorrected.col_4#") />
				<cfset QuerySetCell(SIGS,"col_5","#notCorrected.col_5#") />
				<cfset QuerySetCell(SIGS,"col_6","#notCorrected.col_6#") />
				<cfset QuerySetCell(SIGS,"col_7","#notCorrected.col_7#") />
				<cfset QuerySetCell(SIGS,"col_8","#notCorrected.col_8#") />
				<cfset QuerySetCell(SIGS,"col_9","#notCorrected.col_9#") />
				<cfset QuerySetCell(SIGS,"col_10","#notCorrected.col_10#") />
				<cfset QuerySetCell(SIGS,"col_11","#notCorrected.col_11#") />
				<cfset QuerySetCell(SIGS,"col_12","#notCorrected.col_12#") />
				<cfset QuerySetCell(SIGS,"col_13","#notCorrected.col_13#") />
				<cfset QuerySetCell(SIGS,"col_14","#notCorrected.col_14#") />
				<cfset QuerySetCell(SIGS,"col_15","#notCorrected.col_15#") />
				<cfset QuerySetCell(SIGS,"col_16","#notCorrected.col_16#") />
				<cfset QuerySetCell(SIGS,"col_17","#notCorrected.col_17#") />
				<cfset QuerySetCell(SIGS,"col_18","#notCorrected.col_18#") />
				<cfset QuerySetCell(SIGS,"col_19","#notCorrected.col_19#") />
				<cfset QuerySetCell(SIGS,"col_20","#notCorrected.col_20#") />
				<cfset QuerySetCell(SIGS,"col_21","#notCorrected.col_21#") />
				<cfset QuerySetCell(SIGS,"col_22","#notCorrected.col_22#") />
				<cfset QuerySetCell(SIGS,"col_24","#notCorrected.col_24#") />
			</cfif>
		</cfloop>
		<cfreturn SIGS />
	</cffunction>
</cfcomponent>