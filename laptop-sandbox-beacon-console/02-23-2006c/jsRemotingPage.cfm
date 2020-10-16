<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfinvoke component="com.weathernews.beacon.DAO.getBboxAndLayers" method="init" returnvariable="bboxAndLayers">
	<cfinvokeargument name="flashID" value="#URL.flashID#" />
</cfinvoke>
<cfobject name="variables.layer" component="com.weathernews.beacon.layerIdToName" />
<cfset variables.strVar = variables.layer.init(bboxAndLayers.layerString) />


<cfoutput>
	<p><strong>Times and Legends</strong><br />#variables.strVar#</p>
</cfoutput>
