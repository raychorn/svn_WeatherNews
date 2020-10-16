<script type="text/javascript">
/***********************************************
* Switch Content script- © Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use. Last updated April 2nd, 2005.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

var enablepersist="on" //Enable saving state of content structure using session cookies? (on/off)
var collapseprevious="yes" //Collapse previously open content when opening present? (yes/no)

//var contractsymbol='\\/ ' //HTML for contract symbol. For image, use: <img src="whatever.gif">
//var expandsymbol='-> ' //HTML for expand symbol.
var contractsymbol='<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>MenuArrowOn.gif">'
var expandsymbol='<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>MenuArrowOff.gif">'

//if (document.getElementById){
//document.write('<style type="text/css">')
//document.write('.switchcontent{display:none;}')
//document.write('</style>')
//}

function getElementbyClass(rootobj, classname){
var temparray=new Array()
var inc=0
for (i=0; i<rootobj.length; i++){
if (rootobj[i].className==classname)
temparray[inc++]=rootobj[i]
}
return temparray
}

function sweeptoggle(ec){
var thestate=(ec=="expand")? "block" : "none"
var inc=0
while (ccollect[inc]){
ccollect[inc].style.display=thestate
inc++
}
revivestatus()
}


function contractcontent(omit){
var inc=0
while (ccollect[inc]){
	if (ccollect[inc].id != "omit") {
		ccollect[inc].style.display="none";
	}	
inc++
}
}

function expandcontent(curobj, cid){
var spantags=curobj.getElementsByTagName("SPAN")
var showstateobj=getElementbyClass(spantags, "showstate")
if (ccollect.length>0){
if (collapseprevious=="yes") {
	contractcontent(cid);
}
document.getElementById(cid).style.display=(document.getElementById(cid).style.display!="block")? "block" : "none"
if (showstateobj.length>0){ //if "showstate" span exists in header
if (collapseprevious=="no") {
	showstateobj[0].innerHTML=(document.getElementById(cid).style.display=="block")? contractsymbol : expandsymbol
}
else {
	revivestatus()
}
}
}
}

function revivecontent(){
contractcontent("omitnothing")
selectedItem=getselectedItem()
selectedComponents=selectedItem.split("|")
for (i=0; i<selectedComponents.length-1; i++)
document.getElementById(selectedComponents[i]).style.display="block"
}

function revivestatus(){
	var inc=0
	while (statecollect[inc]){
		if (ccollect[inc].style.display=="block") statecollect[inc].innerHTML=contractsymbol
		else statecollect[inc].innerHTML=expandsymbol
	inc++
	}
}

function get_cookie(Name) { 
	var search = Name + "="
	var returnvalue = "";
	if (document.cookie.length > 0) {
		offset = document.cookie.indexOf(search)
		if (offset != -1) { 
			offset += search.length
			end = document.cookie.indexOf(";", offset);
			if (end == -1) end = document.cookie.length; returnvalue=unescape(document.cookie.substring(offset, end))
		//alert("cookie returnvalue:" + returnvalue + Name);
		}
	}
	return returnvalue;
}

function getselectedItem(){
	if (get_cookie("ceTEXT") != ""){
		selectedItem=get_cookie("ceTEXT")
		return selectedItem
	}
	else return ""
}

function saveswitchstate(){
	var inc=0, selectedItem=""
	while (ccollect[inc]){
		if (ccollect[inc].style.display=="block") selectedItem+=ccollect[inc].id+"|"
		inc++
	}
	//document.cookie=window.location.pathname+"="+selectedItem
	document.cookie="ceTEXT="+selectedItem
	//alert("saved state with cookie ce:" + get_cookie("contractexpand"));
}

function do_onload(){
//uniqueidn=window.location.pathname+"firsttimeload"
	uniqueidn="firsttimeload"
	var alltags=document.all? document.all : document.getElementsByTagName("*")
	ccollect=getElementbyClass(alltags, "switchcontent")
	ccollect2=getElementbyClass(alltags, "region")
	statecollect=getElementbyClass(alltags, "showstate")
	if (enablepersist=="on" && ccollect.length>0){
		document.cookie=(get_cookie(uniqueidn)=="")? uniqueidn+"=1" : uniqueidn+"=0" 
		firsttimeload=(get_cookie(uniqueidn)==1)? 1 : 0 //check if this is 1st page load
		if (!firsttimeload)
			revivecontent()
	}
	if (ccollect.length>0 && statecollect.length>0) revivestatus()
}

if (window.addEventListener)
window.addEventListener("load", do_onload, false)
else if (window.attachEvent)
window.attachEvent("onload", do_onload)
else if (document.getElementById)
window.onload=do_onload

if (enablepersist=="on" && document.getElementById) window.onunload=saveswitchstate
</script>

<script type="text/javascript">


function switchRegion(rID){
var inc=0
while (ccollect2[inc]){
	if (ccollect2[inc].id == rID) {
		ccollect2[inc].style.display="block";
	}
	else
		ccollect2[inc].style.display="none";
		
inc++
}
}
</script>


 
<cfparam name="Region" default="USNE">
<cfparam name="repType" default="0">
<cfparam name="PeriodFrom" default="0">
<cfparam name="PeriodTo" default="6">
<cfparam name="Stations" default="">

<cfparam name="pType" default="s61">
<cfparam name="intensity" default="s6B2">

<cfparam name="PrintVer" default="0">
<cfparam name="PageNum" default="1">

<cfset RepTypeList = "">
<cfset RepTypeList = RepTypeList & "1;METARs/TAFs/NOTAMs" & "|" >
<cfset RepTypeList = RepTypeList & "2;TAFs" & "|" >
<cfset RepTypeList = RepTypeList & "3;NOTAMs" & "|" >

<cfset ProductList1 ="">
<cfset ProductList1 = ProductList1 & "11;METAR;METARs" & "|">
<cfset ProductList1 = ProductList1 & "12;TAF;TAFs" & "|">
<cfset ProductList1 = ProductList1 & "13;NOTAM;NOTAMs" & "|">

<cfset ProductList2 ="">
<cfset ProductList2 = ProductList2 & "21;Icing" & "|">
<cfset ProductList2 = ProductList2 & "22;Turbulence" & "|">
<cfset ProductList2 = ProductList2 & "23;Convective" & "|">
<cfset ProductList2 = ProductList2 & "24;Volcanic Ash" & "|">
 
<cfset ProductList3 ="">
<cfset ProductList3 = ProductList3 & "USSWW;US Severe Weather Watches" & "|">
<cfset ProductList3 = ProductList3 & "USCO;US Convective Outlook" & "|">

<cfset ProductList4 ="">
<cfset ProductList4 = ProductList4 & "41;Icing" & "|">
<cfset ProductList4 = ProductList4 & "42;Turbulence" & "|">
<cfset ProductList4 = ProductList4 & "43;IFR" & "|">

<cfset ProductList5 ="">
<cfset ProductList5 = ProductList5 & "6HR;6 Hour Forecast" & "|">
<cfset ProductList5 = ProductList5 & "12HR;12 Hour Forecast" & "|">
<cfset ProductList5 = ProductList5 & "24HR;24 Hour Forecast" & "|">



<cfset SubProductList1 ="">
<cfset SubProductList1 = SubProductList1 & "s11;Airport ID/ICAO Station" & "|">
<cfset SubProductList1 = SubProductList1 & "s12;State" & "|">
<cfset SubProductList1 = SubProductList1 & "s13;US Region" & "|">
<cfset SubProductList1 = SubProductList1 & "s14;Intl. Region" & "|">

<cfset SubProductList2 ="">
<cfset subProductList2 = subProductList2 & "s21;United States of America" & "|">
<!--- <cfset subProductList2 = subProductList2 & "s22;U.S. Non-Convective" & "|">--->
<cfset subProductList2 = subProductList2 & "s218;North Eastern U.S." & "|">
<cfset subProductList2 = subProductList2 & "s219;South Eastern U.S." & "|">
<cfset subProductList2 = subProductList2 & "s220;North Central U.S." & "|">
<cfset subProductList2 = subProductList2 & "s221;South Central U.S." & "|">
<cfset subProductList2 = subProductList2 & "s222;Western U.S." & "|">
<cfset subProductList2 = subProductList2 & "s223;Pacific North and Southwestern U.S." & "|">
<cfset subProductList2 = subProductList2 & "s23;Canada" & "|">
<cfset subProductList2 = subProductList2 & "s24;Mexico" & "|">
<cfset subProductList2 = subProductList2 & "s25;Caribbean and Central America" & "|">
<cfset subProductList2 = subProductList2 & "s26;Europe" & "|">
<cfset subProductList2 = subProductList2 & "s27;Mediterranean Sea" & "|">
<cfset subProductList2 = subProductList2 & "s28;Near and Middle East" & "|">
<cfset subProductList2 = subProductList2 & "s29;Far East" & "|">
<cfset subProductList2 = subProductList2 & "s210;South America" & "|">
<cfset subProductList2 = subProductList2 & "s211;Africa" & "|">
<cfset subProductList2 = subProductList2 & "s212;Australia and New Zealand" & "|">
<cfset subProductList2 = subProductList2 & "s213;Asia" & "|">
<cfset subProductList2 = subProductList2 & "s214;Indian Ocean" & "|">
<cfset subProductList2 = subProductList2 & "s215;Antarctica" & "|">
<cfset subProductList2 = subProductList2 & "s216;Atlantic International" & "|">
<cfset subProductList2 = subProductList2 & "s217;Pacific International" & "|">


<cfset SubProductList4 ="">
<cfset SubProductList4 = SubProductList4 & "s41;SFO" & "|">
<cfset SubProductList4 = SubProductList4 & "s42;SLC" & "|">
<cfset SubProductList4 = SubProductList4 & "s43;CHI" & "|">
<cfset SubProductList4 = SubProductList4 & "s44;BOS" & "|">
<cfset SubProductList4 = SubProductList4 & "s45;DFW" & "|">
<cfset SubProductList4 = SubProductList4 & "s46;MIA" & "|">

<cfset SubProductList6 ="">
<cfset SubProductList6 = SubProductList6 & "s61;Turbulence;TURBULENCE,TURBC,TURB,TB" & "|">
<cfset SubProductList6 = SubProductList6 & "s62;Icing;ICING,ICG,IC" & "|">
<cfset SubProductList6 = SubProductList6 & "s63;Low Level Wind Shear;LOW LEVEL WIND SHEAR,LLWS" & "|">
<cfset SubProductList6 = SubProductList6 & "s64;Volcanic Ash;VOLCANIC ASH,VA ,VOLC ASH,VOLCANO,ASH" & "|">
<cfset SubProductList6 = SubProductList6 & "s65;Cloud Tops;CLOUD TOPS,TOPS,TOP" & "|">

<cfset SubProductList6B ="">
<cfset SubProductList6B = SubProductList6B & "s6B1;Include All; " & "|">
<cfset SubProductList6B = SubProductList6B & "s6B2;Smooth;SMOOTH,NIL,TB 0,NONE" & "|">
<cfset SubProductList6B = SubProductList6B & "s6B3;Light;LIGHT,LGT,LT" & "|">
<cfset SubProductList6B = SubProductList6B & "s6B4;Moderate;MODERATE,MDT,MO" & "|">
<cfset SubProductList6B = SubProductList6B & "s6B5;Severe;SEVERE,SEV,SVR,HVY,HEAVY" & "|">

<cfset SubProductList6C ="">
<cfset SubProductList6C = SubProductList6C & "s6C1;United States of America;USA" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C2;Northeastern U.S.;neast" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C3;Southeastern U.S.;seast" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C4;North Central U.S.;ncent" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C5;South Central U.S.;scent" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C6;Northwestern U.S.;nwest" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C7;Southwestern U.S.;swest" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C8;Alaska;alaska" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C9;Hawaii;hawaii" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C10;Western Canada;wcan" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C11;Eastern Canada;ecan" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C12;Western Atlantic;watl" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C13;Eastern Pacific;epac" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C14;South America;samer" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C15;Mexico;mexico" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C16;Central America;centam" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C17;Carribean;carib" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C18;Northern Pacific;npac" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C19;Europe;euro" & "|">
<cfset SubProductList6C = SubProductList6C & "s6C20;Asia;asia" & "|">

<cfset SubProductList7 ="">
<cfset SubProductList7 = SubProductList7 & "s71;Eastern Asia/Western Pacific (Tokyo VAAC);TOKYO" & "|">
<cfset SubProductList7 = SubProductList7 & "s72;Southeast Asia/Australia (Darwin VAAC);DARWIN" & "|">
<cfset SubProductList7 = SubProductList7 & "s73;Southcentral Pacific/New Zealand (Wellington VAAC);NULL" & "|">
<cfset SubProductList7 = SubProductList7 & "s74;North Pacific/Alaska (Anchorage VAAC);ANCHORAGE" & "|">
<cfset SubProductList7 = SubProductList7 & "s75;Canada/Northwestern Atlantic (Montreal VAAC);MONTREAL" & "|">
<cfset SubProductList7 = SubProductList7 & "s76;America/Central and Eastern Pacific (Washington VAAC);WASHINGTON" & "|">
<cfset SubProductList7 = SubProductList7 & "s77;Southern South America (Buenos Aires VAAC);BUENOS" & "|">
<cfset SubProductList7 = SubProductList7 & "s78;North Atlantic (London VAAC);LONDON" & "|">
<cfset SubProductList7 = SubProductList7 & "s79;Europe/Africa/Western Asia (Toulouse VAAC);NULL" & "|">
<!--- 
<cfset SubProductList7 = SubProductList7 & "s76;US/Mexico/Caribbean/Western;NULL" & "|">
<cfset SubProductList7 = SubProductList7 & "s77;Atlantic/Central and Eastern;NULL" & "|">
<cfset SubProductList7 = SubProductList7 & "s78;Pacific/Central America/Northern South;NULL" & "|">
<cfset SubProductList7 = SubProductList7 & "s79;America (Washington VAAC);WASHINGTON" & "|"> --->


<cfset StationList ="">
<!--- <cfset StationList = StationList & "JFK;New York" & "|">
<cfset StationList = StationList & "SLC;Salt Lake City" & "|">
<cfset StationList = StationList & "CVG;Cincinnati" & "|">
 --->
<cfset StationList = StationList & "USNE;U.S. Northeast" & "|">
<cfset StationList = StationList & "USCE;U.S. Central" & "|">
<cfset StationList = StationList & "USWE;U.S. West" & "|">
<cfset StationList = StationList & "USSE;U.S. Southeast" & "|">
<cfset StationList = StationList & "CANA;Canada" & "|">
<cfset StationList = StationList & "CARB;Caribbean" & "|">
<cfset StationList = StationList & "CEAM;Central America" & "|">
<cfset StationList = StationList & "SOAM;South America" & "|">
<cfset StationList = StationList & "EURO;Europe" & "|">
<cfset StationList = StationList & "NATL;North Atlantic" & "|">
<cfset StationList = StationList & "PACI;Pacific" & "|">

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
	<cfinclude template="TextProc.cfm">
</cfif>


	<cfif PrintVer EQ 1>
			<!--- Results --->		
		<cfif PageNum EQ 2>
			<cfinclude template="TextResults.cfm">
		</cfif>

	
	
	<cfelse>
	
	    <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_left.gif" width="6" height="8" alt=""></td>
            <td width="100%" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_top.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="8" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_top_right.gif" width="6" height="8" alt=""></td>
          </tr>
          <tr>
            <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_left.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
            <td width="100%" bgcolor="#FFFFFF">
              <!-- start text search form -->
              <form name="searchForm" action="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>" method="post">
			  <div align="right"><A href="javascript:void(0);" onClick="expandcontent(this, 'omit')"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>show-hide.gif" width="84" height="24" border="0" alt="Show/Hide Search Panel"></A><br>&nbsp;</div>
<!--- 			<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>main_table_images/alert_icon.gif" onClick="expandcontent(this, 'omit')" style="cursor:hand; cursor:pointer" alt="Hide/Show Search Criteria"> --->
						  
	<div id="omit" class="switchcontent" style="display:block" style="background-color:#FFFFFF">
			  
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">

<!---                 <table width="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF"> --->

<!--- 
    <td width="36%" rowspan="2" valign="top" class="formTableBorder">
      <div class="menuWrap" style="height: 250px">
        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Record Type*</span></div>
        <!-- here is the div -->
        <div class="SearchMenuBG2" style="padding-top: 3px"><span class="sideMenuFontLev2">
          <input type="radio" name="repType" value="1" checked onClick="expandcontent(this, 'sc1');switchRegion('region1');" style="cursor:hand; cursor:pointer;">
          METARs/TAFs/NOTAMs</span></div>
        <!-- open .switchcontent div -->
        <div id="sc1" class="switchcontent" style="display:block">
          <div class="SearchMenuBG3"><span class="sideMenuFontLev2"><img src="images/checkBox_off.gif" name="FakeCheckBox_METAR" id="FakeCheckBox_METAR" onClick="changeImages2('FakeCheckBox_METAR');">&nbsp;METARs</span></div>
          <div style="display:none">
            <input type="checkbox" name="FakeCheckBox_METAR" id="FakeCheckBox_METAR" value="METAR" >
          </div>
          <div class="SearchMenuBG3"><span class="sideMenuFontLev2"> <img src="images/checkBox_off.gif" name="FakeCheckBox_TAF" id="FakeCheckBox_TAF" onClick="changeImages2('FakeCheckBox_TAF');">&nbsp;TAFs</span></div>
          <div style="display:none">
            <input type="checkbox" name="FakeCheckBox_TAF" id="FakeCheckBox_TAF" value="TAF" >
          </div>
          <div class="SearchMenuBG3"><span class="sideMenuFontLev2"> <img src="images/checkBox_off.gif" name="FakeCheckBox_NOTAM" id="FakeCheckBox_NOTAM" onClick="changeImages2('FakeCheckBox_NOTAM');">&nbsp;NOTAMs</span></div>
          <div style="display:none">
            <input type="checkbox" name="FakeCheckBox_NOTAM" id="FakeCheckBox_NOTAM" value="NOTAM" >
          </div>
        </div>
        <!-- close .switchcontent div -->
        <div class="SearchMenuBG2"><span class="sideMenuFontLev2">
          <input type="radio" name="repType" value="2"   onClick="expandcontent(this, 'sc2');switchRegion('region2');" style="cursor:hand; cursor:pointer;">
          SIGMETs</span></div>
        <div id="sc2" class="switchcontent">
          <table width="95%" border="0">
 --->
                  <tr>
                    <td width="17%" rowspan="2" align="center" class="formTable" valign="top"><a href="http://weathernews.com/us/c"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>main_table_images/wni_logo.gif" alt="Weathernews Logo" width="114" height="43" border="0"></a></td>
                    <td width="36%" rowspan="2" valign="top" class="formTableBorder">
                      <div class="menuWrap" style="height: 250px">
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Record Type*</span></div>

						<!--- METAR/TAF/NOTAM --->
						<div class="SearchMenuBG2" style="padding-top: 3px"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="1" <cfif repType EQ "1">checked</cfif> onClick="expandcontent(this, 'sc1');switchRegion('region1');" style="cursor:hand; cursor:pointer;">METARs/TAFs/NOTAMs</span></div>
						<div id="sc1" class="switchcontent"  style="display:block">
							<cfloop list="#ProductList1#" index="LoopIndex" delimiters="|">
								<cfset currID = ListGetAt(LoopIndex,1,";")>
								<cfset currName = ListGetAt(LoopIndex,2,";")>
								<cfset attrName = "FakeCheckBox_" & #currID#>
									<cfoutput>
									<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
										<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
									<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
									</cfoutput>	
							</cfloop>
						</div>			

						<!--- SIGMETs --->
						<div class="SearchMenuBG2"  style="padding-top: 3px"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="2" <cfif repType EQ "2">checked</cfif>  onClick="expandcontent(this, 'sc2');switchRegion('region2');" style="cursor:hand; cursor:pointer;">SIGMETs</span></div>
						<div id="sc2" class="switchcontent">


<!--- 						<div class="SearchMenuBG3"><span class="sideMenuFontLev2">For U.S. only, select:</span></div> --->
<!--- 						<table width="93%" border="0">
							<tr align="left" valign="top">
								<td>
 --->
 								<cfset LoopCounter = 1>
								<cfloop list="#ProductList2#" index="LoopIndex" delimiters="|">
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "FakeCheckBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3" style="border-right-style:none;"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
										<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
										</cfoutput>	
									<cfset LoopCounter = LoopCounter + 1>
									<cfif (LoopCounter MOD CEILING(ListLen(ProductList2,"|")/2) ) EQ 1>
<!--- 										</td><td>  --->
									</cfif>
								</cfloop>
<!--- 								</td>
							</tr>
						</table>
 --->			
 						</div>			

						<!--- US Weather Watches/Convective Outlooks --->
						<div class="SearchMenuBG2" style="padding-top: 3px"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="3" <cfif repType EQ "3">checked</cfif> onClick="expandcontent(this, 'sc3');switchRegion('region3');" style="cursor:hand; cursor:pointer;">US Weather Watches/Convective Outlooks</span></div>
						<div id="sc3" class="switchcontent">
							<cfloop list="#ProductList3#" index="LoopIndex" delimiters="|">
								<cfset currID = ListGetAt(LoopIndex,1,";")>
								<cfset currName = ListGetAt(LoopIndex,2,";")>
								<cfset attrName = "FakeCheckBox_" & #currID#>
									<cfoutput>
									<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
										<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
									<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
									</cfoutput>	
							</cfloop>
						</div>			
<!--- save for later
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="4" <cfif repType EQ "4">checked</cfif> onClick="expandcontent(this, 'sc4')" style="cursor:hand; cursor:pointer;">US AIRMETs</span></div>
			<div id="sc4" class="switchcontent">
								<cfloop list="#ProductList4#" index="LoopIndex" delimiters="|">
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "FakeCheckBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
										<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
										</cfoutput>	
								</cfloop>
			</div>			

 --->
 						<!--- US AIRMETs --->
 						<div class="SearchMenuBG2"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="4" <cfif repType EQ "4">checked</cfif> onClick="expandcontent(this, 'sc4');switchRegion('region4');" style="cursor:hand; cursor:pointer;">US AIRMETs</span></div>
						<div id="sc4" class="switchcontent">
							<cfloop list="#ProductList4#" index="LoopIndex" delimiters="|">
								<cfset currID = ListGetAt(LoopIndex,1,";")>
								<cfset currName = ListGetAt(LoopIndex,2,";")>
								<cfset attrName = "FakeCheckBox_" & #currID#>
									<cfoutput>
									<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
										<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
									<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
									</cfoutput>	
							</cfloop>
						</div>			



						<!--- US Winds and Temps Aloft --->
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="5" <cfif repType EQ "5">checked</cfif> onClick="expandcontent(this, 'sc5');switchRegion('region5');" style="cursor:hand; cursor:pointer;">US Winds and Temps Aloft</span></div>
						<div id="sc5" class="switchcontent">
							<cfloop list="#ProductList5#" index="LoopIndex" delimiters="|">
								<cfset currID = ListGetAt(LoopIndex,1,";")>
								<cfset currName = ListGetAt(LoopIndex,2,";")>
								<cfset attrName = "FakeCheckBox_" & #currID#>
									<cfoutput>
									<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
										<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
									<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
									</cfoutput>	
							</cfloop>
						</div>			

						<!--- PIREPs --->
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="6" <cfif repType EQ "6">checked</cfif> onClick="expandcontent(this, 'sc6');switchRegion('region6');" style="cursor:hand; cursor:pointer;">PIREPs</span></div>
						<div id="sc6" class="switchcontent">
		                        <div class="sideMenuspacer">&nbsp;</div>
						</div>			

						<!--- Volcanic Ash Advisories --->
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="7" <cfif repType EQ "7">checked</cfif> onClick="expandcontent(this, 'sc7');switchRegion('region7');" style="cursor:hand; cursor:pointer;">Volcanic Ash Advisories</span></div>
						<div id="sc7" class="switchcontent">
		                        <div class="sideMenuspacer">&nbsp;</div>
						</div>			

						<!--- Volcanic Ash Advisories --->
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2"><input type="radio" name="repType" value="8" <cfif repType EQ "8">checked</cfif> onClick="expandcontent(this, 'sc8');switchRegion('region8');" style="cursor:hand; cursor:pointer;">Airport Status Information</span></div>
						<div id="sc8" class="switchcontent">
		                        <div class="sideMenuspacer">&nbsp;</div>
						</div>			


                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
                    </td>
                    <td width="34%" rowspan="2" valign="top" class="formTableBorder">
					
                      <div class="menuWrap"  style="height: 50px">
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Time Period
						<cfif repType EQ "1">*</cfif></span></div>
                        <span class="sideMenuBG2">
                          <span class="selectLabel">From:</span>
							<select name="PeriodFrom" size="1"  style="font-size: 10px">
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
								<option value="48" <cfif PeriodFrom EQ "48">selected</cfif>>Past 48 hours</option>
								<option value="60" <cfif PeriodFrom EQ "60">selected</cfif>>Past 60 hours</option>
								<option value="72" <cfif PeriodFrom EQ "72">selected</cfif>>Past 72 hours</option>
							</select>&nbsp;&nbsp;
                          <span class="selectLabel">To:</span>
							<select name="PeriodTo" size="1" style="font-size: 10px">
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
								<option value="48" <cfif PeriodTo EQ "48">selected</cfif>>Past 48 hours</option>
								<option value="60" <cfif PeriodTo EQ "60">selected</cfif>>Past 60 hours</option>
								<option value="72" <cfif PeriodTo EQ "72">selected</cfif>>Past 72 hours</option>
							</select>						  
                        </span>
                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>


			  <div id="region1" class="region" <cfif repType EQ "1">style="display:block" </cfif>>
			  
                      <div class="menuWrap"  style="height: 180px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Region*</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2">Search By:</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
						<cfoutput>
							<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
								<input type="radio" name="Region" value="UserDef" onClick="document.searchForm.Stations.focus();" <cfif Region EQ "UserDef">checked</cfif>>ICAO Stations
								<input type="text" name="Stations" size="15" maxlength="100" onFocus="document.searchForm.Region[0].checked = 1;" <cfif IsDefined("Stations")>value="#Stations#"</cfif>>
								<br>Comma separated (ex. KJFK,EGSS)
							</span></div>
						</cfoutput>	

						<cfloop list="#StationList#" index="LoopIndex" delimiters="|">
							<cfset currID = ListGetAt(LoopIndex,1,";")>
							<cfset currName = ListGetAt(LoopIndex,2,";")>
							<cfoutput>
								<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
								<input type="radio" name="Region" value="#currID#" <cfif Region EQ #currID#>checked</cfif>>#currName#
								</span></div>
							</cfoutput>	
						</cfloop>
						
						
						
<!---						
						SAVE FOR LATER
						
								<cfset LoopIndex = ListGetAt(SubProductList1,1,"|")>
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "SubFakeCheckBox_" & #currID#>
									<cfset attrName2 = "SubFakeTextBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName2#")><cfif LEN(Evaluate(attrName2))>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif><cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#:&nbsp;
											<input type="text" name="#attrName2#" size="15" maxlength="100" onFocus="changeImages2('#attrName#')" <cfif IsDefined("#attrName2#")>value="#EVALUATE(attrName2)#"</cfif>>
											</span></div>
<!--- 										<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div> --->
										</cfoutput>	

								<cfset LoopIndex = ListGetAt(SubProductList1,2,"|")>
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "SubFakeCheckBox_" & #currID#>
									<cfset attrName2 = "SubFakeTextBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName2#")><cfif LEN(Evaluate(attrName2))>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif><cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#:&nbsp;
											<input type="text" name="#attrName2#" size="15" maxlength="100" onFocus="changeImages2('#attrName#')" <cfif IsDefined("#attrName2#")>value="#EVALUATE(attrName2)#"</cfif>>
											</span></div>
										<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
										</cfoutput>	

								<cfset LoopIndex = ListGetAt(SubProductList1,3,"|")>
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "SubFakeCheckBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName#")><cfif LEN(Evaluate(attrName))>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif><cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#:&nbsp;
											<select name="#attrName#" size="1" onFocus="changeImages2('#attrName#')">
												<option value="" <cfif NOT IsDefined("#attrName#")>selected</cfif>></option>
												<option value="NorthEast" <cfif IsDefined("#attrName#")><cfif NOT CompareNoCase(Evaluate(attrName),'NorthEast')>selected</cfif></cfif> >Northeast</option>
												<option value="SouthEast" <cfif IsDefined("#attrName#")><cfif NOT CompareNoCase(Evaluate(attrName),'SouthEast')>selected</cfif></cfif> >Southeast</option>
												<option value="Northcentral" <cfif IsDefined("#attrName#")><cfif NOT CompareNoCase(Evaluate(attrName),'Northcentral')>selected</cfif></cfif> >North Central</option>
											</select> 
										</span></div>
										</cfoutput>	

								<cfset LoopIndex = ListGetAt(SubProductList1,4,"|")>
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "SubFakeCheckBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName#")><cfif LEN(Evaluate(attrName))>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif><cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#:&nbsp;
											<select name="#attrName#" size="1" onFocus="changeImages2('#attrName#')">
												<option value="" <cfif NOT IsDefined("#attrName#")>selected</cfif>></option>
												<option value="CentralAmerica" <cfif IsDefined("#attrName#")><cfif NOT CompareNoCase(Evaluate(attrName),'CentralAmerica')>selected</cfif></cfif>>Central America</option>
												<option value="Caribbean" <cfif IsDefined("#attrName#")><cfif NOT CompareNoCase(Evaluate(attrName),'Caribbean')>selected</cfif></cfif>>Caribbean</option>
												<option value="NorthernSouthAmerica" <cfif IsDefined("#attrName#")><cfif NOT CompareNoCase(Evaluate(attrName),'NorthernSouthAmerica')>selected</cfif></cfif>>Northern South America</option>
											</select> 
										</span></div>
										</cfoutput>	

--->

                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region1 --->	


			  <div id="region2" class="region" <cfif repType EQ "2">style="display:block" </cfif>>
			  
                      <div class="menuWrap"  style="height: 180px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Region*</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>

								<cfloop list="#SubProductList2#" index="LoopIndex" delimiters="|">
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "SubFakeCheckBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
										<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
										</cfoutput>	
								</cfloop>

                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region2 --->	


			  <div id="region3" class="region" <cfif repType EQ "3">style="display:block" </cfif>>
			  
                      <div class="menuWrap"  style="height: 180px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">&nbsp;</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
							<div class="SearchMenuBG3" align="center"><span class="sideMenuFontLev2">This feature is not implemented yet!</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region3 --->	
						


<!----
			<div id="region3" class="region" <cfif repType EQ "3">style="display:block" </cfif>>
					  
                      <div class="menuWrap"  style="height: 200px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Region</span></div>
                        <div class="sideMenuBG2"><span class="sideMenuFontLev2">Search
                            By:</span></div>
                        <div class="sideMenuBG2"><span class="sideMenuFontLev2">
                          <input name="regionsRadioGroup" type="radio" value="radiobutton" checked>
                          City</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" width="10" height="10">&nbsp;Atlanta</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif" width="10" height="10">&nbsp;Newark</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" width="10" height="10">&nbsp;Chicago</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>/checkBox_on.gif" width="10" height="10">&nbsp;Salt
                            Lake City</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuBG2"><span class="sideMenuFontLev2">
                          <input type="radio" name="regionsRadioGroup" value="radiobutton">
                          Station ID:</span></div>
                        <div class="sideMenuBG3">
                          <input name="textfield" type="text" class="myFlightsInput-box" size="35">
                          <br>
                          <span class="sideMenuFontLev2">Comma separated (i.e.
                          KATL, KFTY)</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuBG2"><span class="sideMenuFontLev2">
                          <input type="radio" name="RegionsRadioGroup" value="radiobutton">
                          Region</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" width="10" height="10">&nbsp;Region
                            1</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" width="10" height="10">&nbsp;Region
                            2</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" width="10" height="10">&nbsp;Region
                            3</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" width="10" height="10">&nbsp;Region
                            4</span></div>
                        <div class="sideMenuBG3"><span class="sideMenuFontLev2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif" width="10" height="10">&nbsp;Region
                            5</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region3 --->	

--->

					  
			  <div id="region4" class="region" <cfif repType EQ "4">style="display:block" </cfif>>
			  
                      <div class="menuWrap"  style="height: 180px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Region*</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
						
								<cfloop list="#SubProductList4#" index="LoopIndex" delimiters="|">
									<cfset currID = ListGetAt(LoopIndex,1,";")>
									<cfset currName = ListGetAt(LoopIndex,2,";")>
									<cfset attrName = "SubFakeCheckBox_" & #currID#>
										<cfoutput>
										<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
											<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
										<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
										</cfoutput>	
								</cfloop>

                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region4 --->	

			  <div id="region5" class="region" <cfif repType EQ "5">style="display:block" </cfif>>
			  
                      <div class="menuWrap"  style="height: 180px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">&nbsp;</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
							<div class="SearchMenuBG3" align="center"><span class="sideMenuFontLev2">This feature is not implemented yet!</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region5 --->	

			  <div id="region6" class="region" <cfif repType EQ "6">style="display:block" </cfif>>
                      <div class="menuWrap"  style="height: 180px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">Search By*</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2">Type:</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
						<cfloop list="#SubProductList6#" index="LoopIndex" delimiters="|">
							<cfset currID = ListGetAt(LoopIndex,1,";")>
							<cfset currName = ListGetAt(LoopIndex,2,";")>
							<cfoutput>
								<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
								<input type="radio" name="pType" value="#currID#" <cfif pType EQ #currID#>checked</cfif>>#currName#
								</span></div>
							</cfoutput>	
						</cfloop>
						<cfoutput>
							<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
								<input type="radio" name="pType" value="UserDef" onClick="document.searchForm.pTypeOther.focus();" <cfif pType EQ "UserDef">checked</cfif>>Other
								<input type="text" name="pTypeOther" size="15" maxlength="100" onFocus="document.searchForm.pType[#ListLen(SubProductList6,'|')#].checked = 1;" <cfif IsDefined("pTypeOther")>value="#pTypeOther#"</cfif>>
								<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Free Text (ex. TURBC)
							</span></div>
						</cfoutput>	
                        <div class="sideMenuspacer">&nbsp;</div>
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2">Intensity:</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
						<cfloop list="#SubProductList6B#" index="LoopIndex" delimiters="|">
							<cfset currID = ListGetAt(LoopIndex,1,";")>
							<cfset currName = ListGetAt(LoopIndex,2,";")>
							<cfoutput>
								<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
								<input type="radio" name="intensity" value="#currID#" <cfif intensity EQ #currID#>checked</cfif>>#currName#
								</span></div>
							</cfoutput>	
						</cfloop>
						 <div class="sideMenuspacer">&nbsp;</div>
						<div class="SearchMenuBG2"><span class="sideMenuFontLev2">Region:</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
						<cfloop list="#SubProductList6C#" index="LoopIndex" delimiters="|">
							<cfset currID = ListGetAt(LoopIndex,1,";")>
							<cfset currName = ListGetAt(LoopIndex,2,";")>
							<cfoutput>
								<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
								<input type="radio" name="region" value="#currID#" <cfif region EQ #currID#>checked</cfif>>#currName#
								</span></div>
							</cfoutput>	
						</cfloop>
                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region6 --->	

			  <!--- Region7 --->
			  <div id="region7" class="region" <cfif repType EQ "7">style="display:block" </cfif>>
					<div class="SearchMenuBG1"><span class="sideMenuFontLev1">Region*</span></div>
					<div class="sideMenuspacer">&nbsp;</div>
					
							<cfloop list="#SubProductList7#" index="LoopIndex" delimiters="|">
								<cfset currID = ListGetAt(LoopIndex,1,";")>
								<cfset currName = ListGetAt(LoopIndex,2,";")>
								<cfset attrName = "SubFakeCheckBox_" & #currID#>
									<cfoutput>
									<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
										<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
									<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
									</cfoutput>	
							</cfloop>
	
					<div class="sideMenuspacer">&nbsp;</div>
				  </div>
			  </div> <!--- Region7 --->	


			  <div id="region8" class="region" <cfif repType EQ "8">style="display:block" </cfif>>
			  
                      <div class="menuWrap"  style="height: 180px">
					  
                        <div class="SearchMenuBG1"><span class="sideMenuFontLev1">&nbsp;</span></div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                        <div class="sideMenuspacer">&nbsp;</div>
                      </div>
					  
			  </div> <!--- Region8 --->	

<!----

							<cfloop list="#ProductList6#" index="LoopIndex" delimiters="|">
								<cfset currID = ListGetAt(LoopIndex,1,";")>
								<cfset currName = ListGetAt(LoopIndex,2,";")>
								<cfset attrName = "FakeCheckBox_" & #currID#>
									<cfoutput>
									<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
										<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;#currName#</span></div>
									<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="#currID#" <cfif IsDefined("#attrName#")>checked</cfif>></div>
									</cfoutput>	
							</cfloop>
							<cfset attrName = "FakeCheckBox_66">
							<cfoutput>
							<div class="SearchMenuBG3"><span class="sideMenuFontLev2">
								<img <cfif IsDefined("#attrName#")>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif"<cfelse>src="<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif"</cfif> name="#attrName#" id="#attrName#" onClick="changeImages2('#attrName#');">&nbsp;
								<input type="text" name="pTypeOther" size="15" maxlength="100" onFocus="changeImages2('#attrName#');document.searchForm[#attrName#].checked = 1;" <cfif IsDefined("pTypeOther")>value="#pTypeOther#"</cfif>></span></div>
							<div style="display:none"><input type="checkbox" name="#attrName#" id="#attrName#" value="66" <cfif IsDefined("#attrName#")>checked</cfif>></div>
							</cfoutput>
--->


<!--- 					  
			  <div id="region7" class="region" <cfif repType EQ "7">style="display:block" </cfif>>
                        <div class="sideMenuspacer">&nbsp;</div>
			  </div> <!--- Region7 --->	
			  
 --->			  
                    </td>
                    <td width="15%" height="200" align="center" valign="top" class="formTableBorder">
										
                      <input type="submit" name="Submit" value="Search" class="submit-button">
					  <input type="hidden" name="mID" value="6">
					  <input type="hidden" name="pageNum" value="2">
                    </td>
                  </tr>
                  <tr class="formTable">
                    <td align="center" valign="top" nowrap class="formTableBorder" style="padding-right: 2; padding-bottom: 0"><span style="font-size: 9px"> [*]=Required Fields</span></td>
                  </tr>
                </table>
                <!-- End Text Search form -->
	  </div>
              </form>
            </td>
            <td background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_right.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="6" height="1" alt=""></td>
          </tr>
          <tr>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bot_left.gif" width="6" height="7" alt=""></td>
            <td width="100%" background="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_frame_bottom.gif"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="7" alt=""></td>
            <td><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>content_frame_images/content_corner_bottom_right.gif" width="6" height="7" alt=""></td>
          </tr>
        </table>
		
		
		<!--- Results --->		
		<cfif PageNum EQ 2>
			<cfinclude template="TextResults.cfm">
		</cfif>

</cfif>
     
