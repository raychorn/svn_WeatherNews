<cfparam name="attributes.FileIn" default="D:\Data\console\flash\xml\layers.xml">
<cfparam name="attributes.LayersIN" default="1">
<cfparam name="attributes.Display" default="1">

<cfinclude template="/include/GlobalParams.cfm" />

<cfset frmString = "">

<cfquery name="query.getLayerNames" datasource="#INTRANET_DS#" cachedwithin="#createTimeSpan(0,45,0,0)#">
	SELECT id, legacyID, layerName
	FROM AvnLayer
</cfquery>

<cfloop query="query.getLayerNames">

	<cfset currID = query.getLayerNames.legacyID />
	
	<cfif ListFindNoCase(attributes.layersIN,currID)>
		
		<cfset frmString = frmString & query.getLayerNames.layerName & "," />
	
	</cfif>

</cfloop>

<cfset frmString = LEFT(frmString,LEN(frmString)-1)>
<cfset caller.LayersOut = frmString>

<cfif attributes.Display EQ 1>
	<cfoutput>#frmString#</cfoutput>
</cfif>

