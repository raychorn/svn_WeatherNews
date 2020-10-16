<cfsilent>
<cfset imgRoot = "<cfoutput>#Request.imagesPrefix#</cfoutput>products/">

<cfparam name="Region" default="ATL">
<cfparam name="repType" default="METAR">
<cfparam name="PeriodFrom" default="0">
<cfparam name="PeriodTo" default="6">
<cfparam name="Stations" default="">

<cfparam name="PageNum" default="1">

<cfset ProductList2 ="">
<cfset ProductList2 = ProductList2 & "ATL;Atlanta" & "|">
<cfset ProductList2 = ProductList2 & "SLC;Salt Lake City" & "|">
<cfset ProductList2 = ProductList2 & "CVG;Cincinnati" & "|">

<cfset ProductList2 = ProductList2 & "USNE;U.S. Northeast" & "|">
<cfset ProductList2 = ProductList2 & "USCE;U.S. Central" & "|">
<cfset ProductList2 = ProductList2 & "USWE;U.S. West" & "|">
<cfset ProductList2 = ProductList2 & "USSE;U.S. Southeast" & "|">
<cfset ProductList2 = ProductList2 & "CANA;Canada" & "|">
<cfset ProductList2 = ProductList2 & "CARB;Caribbean" & "|">
<cfset ProductList2 = ProductList2 & "CEAM;Central America" & "|">
<cfset ProductList2 = ProductList2 & "SOAM;South America" & "|">
<cfset ProductList2 = ProductList2 & "EURO;Europe" & "|">
<cfset ProductList2 = ProductList2 & "NATL;North Atlantic" & "|">
<cfset ProductList2 = ProductList2 & "PACI;Pacific" & "|">

<cfset ATL = "KATL,KFTY,KMGE,KPDK,KVPC,KCCO,KFFC,KLZV,KWDR,KAHN,KGVL,K47A,KRMG,KDMN,K4A9,KCHA">
<cfset SLC = "KSLC,KHIF,KOGD,KLGU,KMLD,KEVW,KFIR,KENV,KDPG,KPVU,KU24,KPUC,KVEL,KTWF,KBYI,KPIH,KJER">
<cfset CVG = "KCVG,KLUK,KHAO,KMGY,KILN,KFFO,KDAY,KFFT,KLEX,KSDF,KLOU,KBAK,KGEZ,KAID,KMIE,KIND,KEYE,KOKK,KGUS,KFWA,KAOH">

<cfset USNE = "KALB,KBDL,KBOS,KBUF,KBWI,KDCA,KEWR,KGSO,KHPN,KIAD,KISP,KJFK,KLGA,KMDT,KORF,KPHL,KPVD,KRDU,KRIC,KROC,KSWF,KSYR">
<cfset USCE = "KAZO,KBMI,KBNA,KCID,KCLE,KCLT,KCMH,KCMI,KCVG,KCWA,KDAY,KDBQ,KDSM,KDTW,KEVV,KFWA,KGRB,KGRR,KIND,KLAN,KLSE,KMCI,KMDW,KMEM,KMKE,KMLI,KMSN,KMSP,KMWA,KOMA,KORD,KPIA,KPIT,KRST,KSAW,KSBN,KSDF,KSGF,KSPI,KSTL,KTOL,KTVC">
<cfset USWE = "KABI,KABQ,KACT,KAEX,KAFW,KAMA,KAUS,KBFL,KBPT,KBTR,KBUR,KCLL,KCOS,KCRP,KCRQ,KDAL,KDEN,KDFW,KDRO,KEGE,KELP,KFAT,KGGG,KGUC,KHDN,KHOU,KHRL,KIAH,KICT,KILE,KJAC,KLAS,KLAW,KLAX,KLBB,KLCH,KLFT,KLGB,KLIT,KLRD,KMAF,KMFE,KMRY,KMSY,KOAK,KOKC,KONT,KPDX,KPHX,KPSP,KRNO,KSAN,KSAT,KSBA,KSBP,KSEA,KSFO,KSHV,KSJC,KSJT,KSLC,KSMF,KSNA,KSPS,KTUL,KTUS,KTXK,KTYR">			  
<cfset USSE = "KAPF,KATL,KBHM,KEYW,KFLL,KFSM,KFYV,KHSV,KJAN,KJAX,KMCO,KMEM,KMIA,KMTH,MYNN,KPBI,KRSW,KSFB,KSRQ,KTPA">
<cfset CANA = "CYEG,CYOW,CYUL,CYVR,CYWG,CYYC,CYYZ">
<cfset CARB = "TAPA,TNCA,TXKF,TBPB,TNCC,TFFF,TGPY,MUHA,MUHG,MKJP,MKJS,TJNR,SVMG,MDPP,TTPP,TFFR,MDSD,TJSJ,MDST,TIST,TISX,TNCM,TTCP">
<cfset CEAM = "MMAA,MMLO,MZBZ,MMUN,MMGL,MGGT,MMBT,MMLP,MMMX,MNMG,MMMD,MMMY,MMMZ,MPTO,MMPR,MSLP,MHLM,MROC,MHTG">
<cfset SOAM = "SCFA,SCAR,SGAS,SKBQ,SBBE,SKBO,SBBR,SBBV,SCIE,SVMI,SKCL,SBCF,SKCG,SPZO,SAEZ,SBGL,SBGR,SEGU,SPQT,SPIM,SLLP,SBEG,SVMC,KMDZ,SUMU,SPSO,SBPA,SBPV,SBRB,SARE,SACO,SCEL,SBSN,SEQU,SLVR">
<cfset EURO = "LEMG,EHAM,ESSA,ENBR,EBBR,LFPG,EDDK,EKCH,EDDL,EGPF,LSGG,EFHK,EGKK,EGLL,LEMD,EGCC,EDDM,LIMC,LFPO,EGSS,EFTU,EDDT,LEVC,LSZH">
<cfset NATL = "EIDW,EGPH,BIKF,EGPK,LPAZ,EINN,LPLA,CYFB,CYHZ,CYJT,CYQM,CYQX,CYYR,CYYT">
<cfset PACI = "PANC,RJCC,RJTT,PHNL,PHTO,RJBB,RJAA,PHOG">

<cfif PageNum EQ 2>


	<cfif Region EQ "UserDef">
		<cfif Len(Stations) GTE 4>
			<cfif NOT LSIsNumeric(Stations)>
				<cfset newList = "">
				<cfloop list="#Stations#" delimiters="," index="ii">
					<cfset newList = ListAppend(newList,UCASE(TRIM(ii)),",")>
				</cfloop>
				<cfset qualifiedStations = ListQualify(newList,"'",",","CHAR")>
			<cfelse>
				<cfset gErrString = "The ICAO airport abbreviation is not valid">
			</cfif>
		<cfelse>
			<cfset gErrString = "No station was specified, or the ICAO airport abbreviation is not valid">
		</cfif>
	<cfelse>	
		<cfset qualifiedStations = ListQualify(#Evaluate(Region)#,"'",",","CHAR")>
	</cfif>

	<cfif Len(gErrString) EQ 0>

			<cfif (repType EQ "METAR")>
				<cfinclude template="queries/getMetar.cfm">
			<cfelseif (repType EQ "TAF")>
				<cfinclude template="queries/getTAF.cfm">
			<cfelse>
				<!--- Nothing yet.  Reserved for METAR AND TAF --->
			
			</cfif>
	</cfif>

</cfif>
</cfsilent>
<cfoutput>
<table cellpadding="3" cellspacing="5" width="100%" border="0" align="center" bgcolor="##FFFFFF" style="border: medium double ##CCCCCC;">
<form action="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=#mID#" method="post" name="myForm">

	<tr>
		<td align="left" valign="top" width="10" rowspan="2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="10" height="10" alt=""></td>
		<td align="left" valign="top" width="10%"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="100%" height="10" alt=""></td>
		<td align="left" valign="top" width="20%"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="100%" height="10" alt=""></td>
		<td align="left" valign="top"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="100%" height="10" alt=""></td>
		<td align="left" valign="top" width="10" rowspan="2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="10" height="10" alt=""></td>
	</tr>
	<tr>
		<td align="left" valign="top"><!--- Type --->
			<table cellpadding="0" cellspacing="0" width="100%" border="0" align="center" bgcolor="##FFFFFF">
				<tr align="left" valign="top">
					<td class="rB">Type</td>
				</tr>
				<tr align="left" valign="middle">
					<td class="s"><input type="radio" name="repType" value="METAR" <cfif repType EQ "METAR">checked</cfif>>METARs<br>
						<input type="radio" name="repType" value="TAF" <cfif repType EQ "TAF">checked</cfif>>TAFs</td>
				</tr>
			</table>
		</td>
		<td align="left" valign="top"><!--- Period --->
			<table cellpadding="0" cellspacing="0" width="100%" border="0" align="center" bgcolor="##FFFFFF">
				<tr align="left" valign="top">
					<td class="rB" colspan="2">Period</td>
				</tr>
				<tr align="left" valign="middle">
					<td class="s">From:</td>
					<td class="s" align="left">
					<select name="PeriodFrom" size="1">
						<option value="0" <cfif PeriodFrom EQ "0">selected</cfif>>Current</option>
						<option value="1" <cfif PeriodFrom EQ "1">selected</cfif>>Past 1 hour</option>
						<option value="2" <cfif PeriodFrom EQ "2">selected</cfif>>Past 2 hours</option>
						<option value="3" <cfif PeriodFrom EQ "3">selected</cfif>>Past 3 hours</option>
						<option value="4" <cfif PeriodFrom EQ "4">selected</cfif>>Past 4 hours</option>
						<option value="5" <cfif PeriodFrom EQ "5">selected</cfif>>Past 5 hours</option>
						<option value="6" <cfif PeriodFrom EQ "6">selected</cfif>>Past 6 hours</option>
						<option value="12" <cfif PeriodFrom EQ "12">selected</cfif>>Past 12 hours</option>
						<option value="18" <cfif PeriodFrom EQ "18">selected</cfif>>Past 18 hours</option>
						<option value="24" <cfif PeriodFrom EQ "24">selected</cfif>>Past 24 hours</option>
						<option value="36" <cfif PeriodFrom EQ "36">selected</cfif>>Past 36 hours</option>
						<option value="72" <cfif PeriodFrom EQ "72">selected</cfif>>Past 72 hours</option>
					</select></td>
				</tr>
				<tr align="left" valign="middle">
					<td class="s">To:</td>
					<td class="s" align="left">
					<select name="PeriodTo" size="1">
						<option value="1" <cfif PeriodTo EQ "1">selected</cfif>>Past 1 hour</option>
						<option value="2" <cfif PeriodTo EQ "2">selected</cfif>>Past 2 hours</option>
						<option value="3" <cfif PeriodTo EQ "3">selected</cfif>>Past 3 hours</option>
						<option value="4" <cfif PeriodTo EQ "4">selected</cfif>>Past 4 hours</option>
						<option value="5" <cfif PeriodTo EQ "5">selected</cfif>>Past 5 hours</option>
						<option value="6" <cfif PeriodTo EQ "6">selected</cfif>>Past 6 hours</option>
						<option value="12" <cfif PeriodTo EQ "12">selected</cfif>>Past 12 hours</option>
						<option value="18" <cfif PeriodTo EQ "18">selected</cfif>>Past 18 hours</option>
						<option value="24" <cfif PeriodTo EQ "24">selected</cfif>>Past 24 hours</option>
						<option value="36" <cfif PeriodTo EQ "36">selected</cfif>>Past 36 hours</option>
						<option value="72" <cfif PeriodTo EQ "72">selected</cfif>>Past 72 hours</option>
					</select></td>			
				</tr>
			</table>
		</td>
		<td align="left" valign="top"><!--- Region --->
			<table cellpadding="0" cellspacing="0" width="100%" border="0" align="center" bgcolor="##FFFFFF">
				<tr align="left" valign="top">
					<td class="rB" colspan="4">Region</td>
				</tr>
				<tr align="left">
					<td class="s"><input type="radio" name="Region" value="UserDef" onClick="document.myForm.Stations.focus();" <cfif Region EQ "UserDef">checked</cfif>>ICAO Stations</td>
					<td class="r" align="left" colspan="3" valign="middle"><input type="text" name="Stations" size="50" maxlength="100" onFocus="document.myForm.Region[0].checked = 1;" <cfif IsDefined("Stations")>value="#Stations#"</cfif>><br>
					<span class="s">Comma separated (ex. KATL,KFTY)</span></td>
				</tr>
				<tr align="left" valign="top">
					<td class="s">
					<cfset LoopCounter = 1>
					<cfloop list="#ProductList2#" index="LoopIndex" delimiters="|">
						<cfset currID = ListGetAt(LoopIndex,1,";")>
						<cfset currName = ListGetAt(LoopIndex,2,";")>
							<input type="radio" name="Region" value="#currID#" <cfif Region EQ #currID#>checked</cfif>>#currName#<br>
						<cfset LoopCounter = LoopCounter + 1>
						<cfif (LoopCounter MOD CEILING(ListLen(ProductList2,"|")/4) ) EQ 1>
							</td><td class="s"> 
						</cfif>
					</cfloop>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td align="left" valign="top" width="10"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="10" height="10" alt=""></td>
		<td align="left" valign="top" colspan="2">&nbsp;</td>
		<td align="left" valign="top" colspan="1"><input type="submit" name="submit" value="Search&nbsp;&gt;&gt;">
			<input type="hidden" name="mID" value="#mID#">
			<input type="hidden" name="pageNum" value="2">
		</td>
		<td align="left" valign="top" width="10"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="10" height="10" alt=""></td>
	</tr>

<!---	
		<tr align="left" valign="top">
			<td class="rB" colspan="2">Region</td>
		</tr>
		<tr align="left" valign="middle">
			<td class="s" colspan="2"><input type="radio" name="Region" value="UserDef" onClick="document.myForm.Stations.focus();" <cfif Region EQ "UserDef">checked</cfif>>ICAO Stations</td>
		</tr>
		<tr align="left" valign="top">
			<td class="r">&nbsp;</td>
			<td class="r" align="left"><input type="text" name="Stations" size="15" maxlength="100" onFocus="document.myForm.Region[0].checked = 1;" <cfif IsDefined("Stations")>value="#Stations#"</cfif>></td>
		</tr>
		<tr align="left" valign="top">
			<td class="r">&nbsp;</td>
			<td class="s" align="left">Comma separated<br>(ex. KATL,KFTY)</td>
		</tr>
		<cfloop list="#ProductList2#" index="LoopIndex" delimiters="|">
			<cfset currID = ListGetAt(LoopIndex,1,";")>
			<cfset currName = ListGetAt(LoopIndex,2,";")>
		<tr align="left" valign="middle">
			<td class="s" colspan="2"><input type="radio" name="Region" value="#currID#" <cfif Region EQ #currID#>checked</cfif>>#currName#</td>
		</tr>
		</cfloop>
		

		<tr align="left" valign="top"><td class="rB" colspan="2">&nbsp;</td></tr>

		<tr align="left" valign="top">
			<td class="rB" colspan="2">Type</td>
		</tr>
		<tr align="left" valign="middle">
			<td class="s" colspan="2"><input type="radio" name="repType" value="METAR" <cfif repType EQ "METAR">checked</cfif>>METARs&nbsp;
			<input type="radio" name="repType" value="TAF" <cfif repType EQ "TAF">checked</cfif>>TAFs</td>
		</tr>
<!--- 		<tr align="left" valign="middle">
			<td class="s" colspan="2"><input type="radio" name="repType" value="METARs/TAFs" <cfif repType EQ "METARs/TAF">checked</cfif>>METARs &amp; TAFs</td>
		</tr>
 --->
		<tr align="left" valign="top"><td class="rB" colspan="2">&nbsp;</td></tr>

		<tr align="left" valign="top">
			<td class="rB" colspan="2">Period</td>
		</tr>
		<tr align="left" valign="middle">
			<td class="s">From:</td>
			<td class="s" align="left">
			<select name="PeriodFrom" size="1">
				<option value="0" <cfif PeriodFrom EQ "0">selected</cfif>>Current</option>
				<option value="1" <cfif PeriodFrom EQ "1">selected</cfif>>Past 1 hour</option>
				<option value="2" <cfif PeriodFrom EQ "2">selected</cfif>>Past 2 hours</option>
				<option value="3" <cfif PeriodFrom EQ "3">selected</cfif>>Past 3 hours</option>
				<option value="4" <cfif PeriodFrom EQ "4">selected</cfif>>Past 4 hours</option>
				<option value="5" <cfif PeriodFrom EQ "5">selected</cfif>>Past 5 hours</option>
				<option value="6" <cfif PeriodFrom EQ "6">selected</cfif>>Past 6 hours</option>
				<option value="12" <cfif PeriodFrom EQ "12">selected</cfif>>Past 12 hours</option>
				<option value="18" <cfif PeriodFrom EQ "18">selected</cfif>>Past 18 hours</option>
				<option value="24" <cfif PeriodFrom EQ "24">selected</cfif>>Past 24 hours</option>
				<option value="36" <cfif PeriodFrom EQ "36">selected</cfif>>Past 36 hours</option>
				<option value="72" <cfif PeriodFrom EQ "72">selected</cfif>>Past 72 hours</option>
			</select></td>
		</tr>
		<tr align="left" valign="middle">
			<td class="s">To:</td>
			<td class="s" align="left">
			<select name="PeriodTo" size="1">
				<option value="1" <cfif PeriodTo EQ "1">selected</cfif>>Past 1 hour</option>
				<option value="2" <cfif PeriodTo EQ "2">selected</cfif>>Past 2 hours</option>
				<option value="3" <cfif PeriodTo EQ "3">selected</cfif>>Past 3 hours</option>
				<option value="4" <cfif PeriodTo EQ "4">selected</cfif>>Past 4 hours</option>
				<option value="5" <cfif PeriodTo EQ "5">selected</cfif>>Past 5 hours</option>
				<option value="6" <cfif PeriodTo EQ "6">selected</cfif>>Past 6 hours</option>
				<option value="12" <cfif PeriodTo EQ "12">selected</cfif>>Past 12 hours</option>
				<option value="18" <cfif PeriodTo EQ "18">selected</cfif>>Past 18 hours</option>
				<option value="24" <cfif PeriodTo EQ "24">selected</cfif>>Past 24 hours</option>
				<option value="36" <cfif PeriodTo EQ "36">selected</cfif>>Past 36 hours</option>
				<option value="72" <cfif PeriodTo EQ "72">selected</cfif>>Past 72 hours</option>
			</select></td>			
		</tr>

		<tr align="left" valign="top"><td class="rB" colspan="2">&nbsp;</td></tr>

		<tr><td colspan="2" align="center"><input type="submit" name="submit" value="Search&nbsp;&gt;&gt;"></td></tr>

	<input type="hidden" name="mID" value="#mID#">
	<input type="hidden" name="pageNum" value="2">
--->	
	
</form>
</table>
</cfoutput>



<cfif PageNum EQ 2> <!--- Show Results --->

<!--- 	<cfif IsDefined("URL.ColOrderBy")>
		<cfset ColOrderBy = #URL.ColOrderBy#>
	<cfelse>
		<cfset ColOrderBy = ListFindNoCase(SearchValueList,SearchBy,';')>
	</cfif>
	
	<cfif IsDefined("URL.ColOrderDir")>
		<cfset ColOrderDir = #URL.ColOrderDir#>
	<cfelse>
		<cfset ColOrderDir = "ASC">
	</cfif>
 	
	<cfif IsDefined("URL.SearchBy")>
		<cfset SearchBy = #URL.SearchBy#>
	<cfelse>
		<cfset SearchBy = "#form.SearchBy#">
	</cfif>

	<cfif IsDefined("URL.SearchText")>
		<cfset SearchText = #URL.SearchText#>
	<cfelse>
		<cfset SearchText = "#form.SearchText#">
	</cfif>

	<CFSWITCH expression="#prod#">
		<cfcase value="O"> <!--- Orion --->
			<cfset MaxRows_getQuery = 15>
			<cfset LinkedCol = "1">
			<cfset LinkedLoc = "Orion.wni?Menu=2&sMenu=0&func=M">
	
			<cfinclude template="queries/getOrionClient.cfm">
		</cfcase>
		<cfcase value="P"> <!--- Polaris --->
			<cfset MaxRows_getQuery = 20>
			<cfset LinkedCol = "1">
			<cfset LinkedLoc = "Polaris.wni?Menu=3&sMenu=0&func=M">
		
			<cfinclude template="queries/getPolarisClient.cfm">
		</cfcase>
		<cfcase value="F"> <!--- FMS --->
			<cfset MaxRows_getQuery = 20>
			<cfset LinkedCol = "1">
			<cfset LinkedLoc = "Fms.wni?Menu=4&sMenu=0&func=M">
		
			<cfinclude template="queries/getFmsClient.cfm">
		</cfcase>
	</CFSWITCH>
--->
	
	<cfif IsDefined("URL.Export")>
		<CF_query2excel Query="getQuery" AlternatColor = "ff0000">
		<cfabort>
	</cfif>

	<cfinclude template="dbResults.cfm">

</cfif>
