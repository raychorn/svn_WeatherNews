<!--- CF_FONT_R required form field --->


<cfparam name="attributes.b" default="dir=""ltr""">
<cfparam name="attributes.r" default="color=""##FF0000""">
<cfparam name="attributes.fn" default="">
<cfparam name="attributes.gErrString" default="">

<CFSWITCH expression="#ThisTag.ExecutionMode#">
	<CFCASE value='start'>
		<!--- Start tag processing --->
		<cfif listfindnocase(attributes.gErrString, attributes.fn)>
			<cfoutput><font  #attributes.r#></cfoutput>
		<cfelse>
			<cfoutput><font #attributes.b#></cfoutput>
		</cfif>
    </CFCASE>
	<CFCASE value='end'>
		<cfoutput>*</font></cfoutput>
	</CFCASE>
</CFSWITCH>
