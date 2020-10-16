<cfcomponent hint="qryAvnDS.cfc">
	<cffunction name="init" access="public" returntype="query">
		<cfargument name="strQueryString" type="string" required="yes" />
		<cfset qryQuery = qryAvn(arguments.strQueryString) />
		<cfreturn qryQuery />
	</cffunction>
	<cffunction name="qryAvn" access="package" returntype="query">
		<cfargument name="strQueryString" type="string" required="yes" />
		<cfinclude template="/include/GlobalParams.cfm" />
		<cfquery name="qryAvn" datasource="#Request.AVNOPS_DS#">
			#PreserveSingleQuotes(arguments.strQueryString)#
		</cfquery>
		<cfreturn qryAvn />
	</cffunction>
</cfcomponent>