<cfparam name="attributes.inDate" default="#now()#">
<cfparam name="attributes.TimeDiff" default="0">
<cfparam name="attributes.LongShort" default="long">  <!--- options: long, short --->

<cfset lDate = DateAdd("h", attributes.TimeDiff, attributes.inDate)>
<cfif attributes.LongShort EQ "long">
	<cfset frmString = DateFormat(lDate, "dd mmm, yyyy") & " " & TimeFormat(lDate, "HH:MM")>
<cfelse>
	<cfset frmString = DateFormat(lDate, "dd mmm, yyyy")>
</cfif>

<cfoutput>#frmString#</cfoutput>
