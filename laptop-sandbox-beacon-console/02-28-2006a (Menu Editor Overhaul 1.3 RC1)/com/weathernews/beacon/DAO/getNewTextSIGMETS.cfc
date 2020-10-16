<cfcomponent hint="getNewTextSIGMETS.cfc - return text sigmets">
	<cffunction name="init" access="public" returntype="query">
		<cfargument name="arrRegions" type="array" required="true" />
		<cfargument name="arrSubTypes" type="array" required="true" />
		<cfargument name="strType" type="string" required="true" />
		<cfargument name="intStartOffset" type="numeric" required="true" />
		<cfargument name="intFinishOffset" type="numeric" required="true" />
		<cfset qrySigmets = getNewTextSIG(arguments.arrRegions,arguments.arrSubTypes,arguments.strType,arguments.intStartOffset,arguments.intFinishOffset) />
		<cfreturn qrySigmets />
	</cffunction>
	
	<cffunction name="getNewTextSIG" access="package" returntype="query">
		<cfargument name="arrRegions" type="array" required="true" />
		<cfargument name="arrSubTypes" type="array" required="true" />
		<cfargument name="strType" type="string" required="true" default="CNVC" />
		<cfargument name="intStartOffset" type="numeric" required="true" default="0" />
		<cfargument name="intFinishOffset" type="numeric" required="true" default="6" />
		<cfinclude template="../../../../include/GlobalParams.cfm" />
		<cfif arguments.intStartOffset GT arguments.intFinishOffset>
			<cfset start = "dateAdd(hh,-#arguments.intStartOffset#,getDate())" />
			<cfset finish = "dateAdd(hh,-#arguments.intFinishOffset#,getDate())" />
		<cfelse>
			<cfset start = "dateAdd(hh,-#arguments.intFinishOffset#,getDate())"  />
			<cfset finish = "dateAdd(hh,-#arguments.intStartOffset#,getDate())" />
		</cfif>
		<cfquery name="query.getTextSigmets" datasource="#BEACON_DS#">
			SELECT Col_1=mt.Header, Col_2=mt.IssueTime,Col_3=mt.Body, d.DomainID, d.SubDomain, d.Domain, mt.SubType, mt.StartTime, mt.EndTime
			FROM MSG_TEXT AS mt
			LEFT JOIN DOMAINS AS d ON d.DomainID = mt.DomainID AND (#start# < mt.EndTime AND #finish# > mt.StartTime)
			WHERE  ( <cfif ArrayLen(arguments.arrRegions) GT 1>
					<cfloop from="1" to="#ArrayLen(arguments.arrRegions)#" index="reg">
						<cfset queryArg = arguments.arrRegions[reg] />
						 ( d.Domain = #PreserveSingleQuotes(queryArg)# )
							<cfif ArrayLen(arguments.arrRegions) EQ reg>
								<!--- Do Nothing --->
							<cfelse>
								OR
							</cfif>
					</cfloop>
				  <cfelse>
				  	<cfset queryArg = arguments.arrRegions[1] />
				  	 ( d.Domain = #PreserveSingleQuotes(queryArg)# )
				  </cfif>
				  )
				  AND (mt.Type = '#arguments.strType#') AND 
				  (
				  <cfloop from="1" to="#ArrayLen(arguments.arrSubTypes)#" index="subTypes">
				  	mt.SubType = '#arguments.arrSubTypes[subTypes]#'
				  		<cfif ArrayLen(arguments.arrSubTypes) EQ subTypes>
				  			<!--- Do Nothing --->
				  		<cfelse>
				  			OR
				  		</cfif>
				  </cfloop>)
				  ORDER BY mt.IssueTime DESC
		</cfquery>
		<cfreturn query.getTextSigmets />
	</cffunction>
</cfcomponent>
			