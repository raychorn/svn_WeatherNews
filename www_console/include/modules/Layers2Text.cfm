<cfparam name="attributes.FileIn" default="#Request.webRoot#flash\xml\layers.xml">
<cfparam name="attributes.LayersIN" default="1">
<cfparam name="attributes.Display" default="1">

<cffile action="read" file="#Request.webRoot#flash\xml\layers.xml" variable="XMLFileText">
<cfset myXMLDocument=XmlParse(XMLFileText)>

<cfset frmString = "">

<cfloop index="LoopIndex" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#">
	<cfset currID = myXMLDocument.layers.layer[LoopIndex].ID.XmlText>
	<cfif ListFindNoCase(#attributes.LayersIN#,currID)>
		<cfset frmString = frmString & myXMLDocument.layers.layer[LoopIndex].Name.XmlText & ",">
	</cfif>
</cfloop>

<cfset frmString = LEFT(frmString,LEN(frmString)-1)>
<cfset caller.LayersOut = frmString>

<cfif attributes.Display EQ 1>
	<cfoutput>#frmString#</cfoutput>
</cfif>

