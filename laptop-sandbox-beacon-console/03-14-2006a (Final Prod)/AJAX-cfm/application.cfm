<cfapplication name="BEACON_AJAX">

<cffunction name="cf_dump" access="public">
	<cfargument name="_aVar_" type="any" required="yes">
	<cfargument name="_aLabel_" type="string" required="yes">
	<cfargument name="_aBool_" type="boolean" default="False">
	
	<cfif (_aBool_)>
		<cfdump var="#_aVar_#" label="#_aLabel_#" expand="Yes">
	<cfelse>
		<cfdump var="#_aVar_#" label="#_aLabel_#" expand="No">
	</cfif>
</cffunction>

<cfset err_ajaxCode = false>
<cfset err_ajaxCodeMsg = ''>
<cftry>
	<cfset Request.commonCode = CreateObject("component", "cfc.ajaxCode")>
	<cfcatch type="Any">
		<cfdump var="#cfcatch#" label="cfcatch" expand="No">
	</cfcatch>
</cftry>

<cfscript>
	Request.INTRANET_DS = 'INTRANETDB';

	Request.cf_dump = cf_dump;
	
	Request.const_Cr = Chr(13);
	Request.const_Lf = Chr(10);
	Request.const_Tab = Chr(9);
	Request.const_CrLf = Request.const_Cr & Request.const_Lf;
	Request.parentKeyword = 'parent.';
	Request.cf_html_container_symbol = "html_container";
	Request.const_jsapi_loading_image = "/images/loading.gif";
	Request.const_paper_color_light_yellow = '##FFFFBF';
	Request.const_color_light_blue = '##80FFFF';
</cfscript>
