<!--- CF_FONT_R required form field --->


<cfparam name="attributes.b" default="class=""formLabel""">
<cfparam name="attributes.r" default="class=""formLabelRed""">
<cfparam name="attributes.fn" default="">
<cfparam name="attributes.gErrString" default="">

<CFSWITCH expression="#ThisTag.ExecutionMode#">
	<CFCASE value='start'>
		<!--- Start tag processing --->
		<cfif listfindnocase(attributes.gErrString, attributes.fn)>
			<cfoutput><label #attributes.r#></cfoutput>
		<cfelse>
			<cfoutput><label #attributes.b#></cfoutput>
		</cfif>
    </CFCASE>
	<CFCASE value='end'>
		<cfoutput></label></cfoutput>
	</CFCASE>
</CFSWITCH>
