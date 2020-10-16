<cfsetting enablecfoutputonly="yes">

<!---NAME: errorCheck.cfm ACTION: error check form fields --->
<!---INPUTS: 
		list of fieldnames to check.
		list of type of each field. 
	OUTPUTS:
		errString - list of errors in ^-delimited list
		status - descr of any type
	HOW TO CALL:		
	<CFMODULE 
	   TEMPLATE="errorCheck.cfm"
	   fieldList=	"name,email,phone"
	   fieldTypes=	"name,email,phone">
--->
<!--- consts --->
<cfset variables.DELIMITER = ",">

<!--- validate inputted lists --->
<CFPARAM Name="Attributes.fieldList" Default="">
<CFPARAM Name="Attributes.fieldTypes" Default="">
<cfset caller.gErrString = "">
<cfset caller.status = "">

<!--- DEBUG
<cfoutput>ListLen(Attributes.fieldList, variables.DELIMITER)= #ListLen(Attributes.fieldList, variables.DELIMITER)#<BR></cfoutput>
<cfoutput>ListLen(Attributes.fieldTypes, variables.DELIMITER)= #ListLen(Attributes.fieldTypes, variables.DELIMITER)#<BR></cfoutput>
<cfoutput>Len(Attributes.fieldList)= #Len(Attributes.fieldList)#<BR></cfoutput>
<cfoutput>Len(Attributes.fieldTypes)= #Len(Attributes.fieldTypes)#<BR></cfoutput>
 --->
<cfif (ListLen(Attributes.fieldList, variables.DELIMITER) EQ ListLen(Attributes.fieldTypes, variables.DELIMITER)) AND Len(Attributes.fieldList) GT 0 AND Len(Attributes.fieldTypes) GT 0>
	<cfset variables.i = 1>
	<!--- loop thru fieldnames --->

	<cfloop index="fieldName" list="#Attributes.fieldList#" delimiters="#variables.DELIMITER#">
		<cfset variables.m_fieldType = ListGetAt(Attributes.fieldTypes, variables.i , variables.DELIMITER)>

		<cfswitch expression="#lcase(variables.m_fieldType)#">
			<!--- NUMBER --->			
			<cfcase value="number">
				<cfset m_err = 0>
				<cfif len(evaluate("form.#fieldName#"))>
					<cfset m_err = REFind("([[:alpha:]])|([[:punct:]])|( )", evaluate("form.#fieldName#"), 1) >
				</cfif>
				<cfif m_err>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase><!--- number --->
			<!--- PHONE --->			
 			<cfcase value="regularPhone" delimiters=",">
				<cfset nocharPhone = REReplaceNoCase(evaluate("form.#fieldName#"), "[^0-9]", "", "ALL")>
				<cfif len(nocharPhone) NEQ 10>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase> <!--- PHONE --->
			<cfcase value="dayphone">
				<cfset phone = form.dayarea & form.dayprefix & form.daysuffix>
				<cfset nocharPhone = REReplaceNoCase(phone, "[^0-9]", "", "ALL")>
				<cfif len(nocharPhone) NEQ 10 and len(nocharPhone) gt 0>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				<cfelseif REFind("[^0-9]", phone) and len(phone)>
					<!--- found non-num, send error --->
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>		
				</cfif>
			</cfcase>			
			<cfcase value="evephone">
				<cfset phone = form.evearea & form.eveprefix & form.evesuffix>
				<cfset nocharPhone = REReplaceNoCase(phone, "[^0-9]", "", "ALL")>
				<cfif len(nocharPhone) NEQ 10 and len(nocharPhone) gt 0>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				<cfelseif REFind("[^0-9]", phone) and len(phone)>
					<!--- found non-num, send error --->
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>		
				</cfif>
			</cfcase>	
			<cfcase value="fax">
				<cfset phone = form.faxarea & form.faxprefix & form.faxsuffix>
				<cfset nocharPhone = REReplaceNoCase(phone, "[^0-9]", "", "ALL")>
				<cfif len(nocharPhone) NEQ 10 and len(nocharPhone) gt 0>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				<cfelseif REFind("[^0-9]", phone) and len(phone)>
					<!--- found non-num, send error --->
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>		
				</cfif>
			</cfcase>	
			<cfcase value="rdayphone" delimiters=",">
				<cfset phone = form.dayarea & form.dayprefix & form.daysuffix>
				<cfset nocharPhone = REReplaceNoCase(phone, "[^0-9]", "", "ALL")>
				<cfif len(nocharPhone) NEQ 10>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase>			
			<cfcase value="revephone" delimiters=",">
				<cfset phone = form.evearea & form.eveprefix & form.evesuffix>
				<cfset nocharPhone = REReplaceNoCase(phone, "[^0-9]", "", "ALL")>
				<cfif len(nocharPhone) NEQ 10>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase>	
			<cfcase value="rfax" delimiters=",">
				<cfset phone = form.faxarea & form.faxprefix & form.faxsuffix>
				<cfset nocharPhone = REReplaceNoCase(phone, "[^0-9]", "", "ALL")>
				<cfif len(nocharPhone) NEQ 10>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase>
			<!--- MONTH --->
			<cfcase value="month" delimiters=",">
				<cfset month = evaluate("form.#fieldName#")>
				<cfif NOT (Len(month) EQ 2 And month GTE 1 And month LTE 12 And IsNumeric(month))>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase>		
			<!--- DAY --->
			<cfcase value="day" delimiters=",">
				<cfset day = evaluate("form.#fieldName#")>
				<cfif NOT (len(day) EQ 2 And day GTE 1 And day LTE 31 And IsNumeric(day))>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase>													
			<!--- DATE --->
			<cfcase value="date" delimiters=",">
				<cfset date = evaluate("form.#fieldName#")>
				<cfif NOT ISDate(date)>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase>													
			<!--- NAME --->
			<cfcase value="name">
				<cfset m_err = 0>
				<cfif len(evaluate("form.#fieldName#"))>
					<cfset m_err = REFind("([0-9])|([\+\*\?\[\^\$\(\)\{\|\\""!##%&=};:<>}/])", evaluate("form.#fieldName#"), 1)>
				</cfif>
				<cfif m_err>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>			
			</cfcase><!--- name --->
			<!--- ZIP --->
			<cfcase value="zip">
				<cfif len(evaluate("form.#fieldName#"))>
					<cfset m_err = 0>
					<cfset zipStr=evaluate("form.#fieldName#")>
					<cfset zipStr = REREPLACE(zipstr, " ", "", "ALL")>
					<cfif len(zipStr) LT 5 OR len(zipStr) GT 6>
						<cfset m_err = 1>
					<cfelse>
						<cfif len(zipStr) EQ 5>
							<cfif (NOT REFind("^([0-9])([0-9])([0-9])([0-9])([0-9])", zipStr, 1))>
								<cfset m_err = 1>
							</cfif>				
						<cfelse><!--- EQ 6 --->
							<cfif (NOT REFind("([A-Za-z])([0-9])([A-Za-z])([0-9])([A-Za-z])([0-9])", zipStr, 1))>
								<cfset m_err = 1>
							</cfif>				
						</cfif>
					</cfif>
					<cfif m_err>
						<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>	
					</cfif>
				</cfif> 
			</cfcase><!--- zip --->
			<!--- URL --->
			<cfcase value="url">
				<cfset m_err = 0>
				<cfset URLStr=evaluate("form.#fieldName#")>
				<cfset URLStr = REREPLACE(URLStr, "[[:space:]]", "", "ALL")>
				<cfif len(URLStr) LT 10>
					<cfset m_err = 1>
				<cfelse>
					<cfif not findnocase("http://", URLStr)>
						<cfset m_err = 1>
					</cfif>
				</cfif>
				<cfif m_err>
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>	
				</cfif>
			</cfcase><!--- URL --->			
			<!--- EMAIL --->
			<cfcase value="email">
				<cfset m_err = 0>
				<cfif len(evaluate("form.#fieldName#"))>
					<cfif ReFind("((^@)|([A-Za-z0-9]+@+[A-Za-z0-9]+@+[A-Za-z0-9])|(\.[A-Za-z][A-Za-z][A-Za-z][A-Za-z]+$)|(@$)|(^\.)|(\.{2,})|(\.$)|([\+\*\?\[\^\$\(\)\{\|\\""~`'!##%&=};:<>},[:space:][:cntrl:]]))", evaluate("form.#fieldName#")) or (not ReFind("\.", evaluate("form.#fieldName#"))) or (not ReFind("@", evaluate("form.#fieldName#")))> 
						<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
					</cfif>
				</cfif>
			</cfcase><!--- email --->
			<!--- MONEY --->			
			<cfcase value="money">
				<cfif isdefined("form.#fieldName#")>
					<cfset m_tmpvarNum = ReReplace(evaluate("form.#fieldName#"), "[.]", "", "ONE")><!--- pull out one decimal point --->
					<cfif NOT isnumeric(ReReplace(m_tmpvarNum, "(^\$)|([,])", "", "ALL"))><!--- pull a leading $ out --->
						<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
					</cfif>
				<cfelse>
					<!--- not even defined, so prob is a chk or option that is null --->
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase><!--- /money --->
			<!--- FLOAT --->			
			<cfcase value="float">
				<cfif isdefined("form.#fieldName#")>
					<cfif NOT isnumeric(ReReplace(evaluate("form.#fieldName#"), "[.]", "", "ONE"))>
						<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
					</cfif>
				<cfelse>
					<!--- not even defined, so prob is a chk or option that is null --->
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase><!--- /float --->
			<!--- NULL --->			
			<cfcase value="null">
				<cfset m_err = 0>
				<cfif isdefined("form.#fieldName#")>
					<cfif NOT len(evaluate("form.#fieldName#"))>
						<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
					</cfif>
				<cfelse>
					<!--- not even defined, so prob is a chk or option that is null --->
					<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>
				</cfif>
			</cfcase><!--- null --->

			<cfdefaultcase><!--- checks len of field contents. variables.m_fieldType specifies len to check --->
				<cfif isnumeric(variables.m_fieldType)>
					<cfif len(evaluate("form.#fieldName#")) NEQ variables.m_fieldType>
						<cfset caller.gErrString = caller.gErrString & fieldname & variables.DELIMITER>					
					</cfif>
				</cfif>
			</cfdefaultcase>

		</cfswitch>
		
		
		
		<cfset i = i + 1>
	</cfloop>
<cfelse><!--- Len(Attributes.fieldList) GT 0 --->
	<!--- gErrString = null, and ... --->
	<cfset caller.status = "ERR_nothingPassedIn">
</cfif><!--- Len(Attributes.fieldList) = 0 --->

<!--- cut off trailing ", " --->
<cfif len(caller.gErrString) GT 1>
	<cfset caller.gErrString = Left(caller.gErrString, len(caller.gErrString)-1)>
</cfif>

<cfsetting enablecfoutputonly="no">