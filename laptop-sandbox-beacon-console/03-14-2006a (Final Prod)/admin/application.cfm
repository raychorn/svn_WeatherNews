<cfapplication name="Beacon_Menu_Editor">

<cffunction name="cf_log" access="public">
	<cfargument name="_someText_" type="string" required="yes">
	
	<cflog file="#Application.applicationName#" type="Information" text="#_someText_#">
</cffunction>

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

<cfinclude template="/include/ajax/includes/cfinclude_explainError.cfm">

<cfscript>
	err_ajaxCode = false;
	err_ajaxCodeMsg = '';
	errorExplanation = '';
</cfscript>

<cfscript>
	Request.cf_log = cf_log;
	Request.cf_dump = cf_dump;
	Request.explainError = explainError;
	Request.explainObject = explainError;
	Request._explainError = _explainError;
	Request.explainErrorWithStack = explainErrorWithStack;
</cfscript>

<cfscript>
	Request.INTRANET_DS = 'INTRANETDB';
	
	Request.bool_useNewMenu = (CGI.REMOTE_ADDR eq "172.18.201.166");
	
	Request.const_Cr = Chr(13);
	Request.const_Lf = Chr(10);
	Request.const_Tab = Chr(9);
	Request.const_CrLf = Request.const_Cr & Request.const_Lf;
	Request.parentKeyword = 'parent.';
	Request.cf_html_container_symbol = "html_container";
	Request.const_jsapi_loading_image = "images/loading.gif";
	Request.const_paper_color_light_yellow = '##FFFFBF';
	Request.const_color_light_blue = '##80FFFF';
	
	Request.cf_div_floating_debug_menu = 'div_floating_debug_menu';
	
	Request.AUTH_USER = 'admin';

	err_ajaxCode = false;
	err_ajaxCodeMsg = '';
	try {
	   Request.commonCode = CreateObject("component", "ajax-cfm.cfc.ajaxCode");
	} catch(Any e) {
		err_ajaxCode = true;
		err_ajaxCodeMsg = '(1) The ajaxCode component has NOT been created.';
		writeOutput('<font color="red"><b>#err_ajaxCodeMsg# | Reason: [#e.message#] [#e.detail#]</b></font><br>');
	}
	if (err_ajaxCode) {
		Request.cf_log(Application.applicationname, 'Error', '[#err_ajaxCodeMsg#]');
	}

	Request._cfm_path = "/ajax-cfm/";
	Request.cfm_gateway_process_html = "#Request._cfm_path#AJAX_functions.cfm";
</cfscript>
