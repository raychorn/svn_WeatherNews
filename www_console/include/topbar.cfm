<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html40/strict.dtd">
<html>
<head>
<title>Weathernews BEACON</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="<cfoutput>#Request.urlPrefix#</cfoutput>include/css/text_attributes.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function printit(){  
if (window.print) {
    window.print() ;  
} else {
    var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
    WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
}
}

function printPage() { print(document); }

function openWin( windowURL, windowName, windowFeatures ) { 
		return window.open( windowURL, windowName, windowFeatures ) ; 
} 

function changeImages (imgId) {
	//alert("inside change Image2: " + document.images[imgId].src + "index is: " + document.images[imgId].src.indexOf("checkBox_on.gif") );
		if (document.images[imgId].src.indexOf("checkBox_on.gif") > 0 )
			document.images[imgId].src = "..<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif";
		else	
			document.images[imgId].src = "..<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif";
}

function changeImages2 (imgId) {
	//alert("inside change Image2: " + document.images[imgId].src + "index is: " + document.images[imgId].src.indexOf("checkBox_on.gif") );
		if (document.images[imgId].src.indexOf("checkBox_on.gif") > 0 ) {
			document.images[imgId].src = "..<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_off.gif";
			document.searchForm[imgId].checked = false;
		}
		else	{
			document.images[imgId].src = "..<cfoutput>#Request.imagesPrefix#</cfoutput>checkBox_on.gif";
			document.searchForm[imgId].checked = true;
		}	
}

function setDelay(Delay) {
	rotate_delay = Delay;
}

function clearInstrumentPanelMenu (cookie) {
	var existingLayers = getCookie(cookie);
	var myArray = new Array();
		myArray = existingLayers.split(",");
		//alert(myArray.length + '/' + existingLayers);
		for (i=1;i < myArray.length; i++) {
			if((myArray[i] == '18') ||
			   (myArray[i] == '16') ||
			   (myArray[i] == '10') ||
			   (myArray[i] == '11') ||
			   (myArray[i] == '12') ||
			   (myArray[i] == '108')) {
			   // do nothing
			 }else{
				changeImages('FakeCheckBox_' + myArray[i]);
				//alert('FakeCheckBox_' + myArray[i]);
			}
		}
		setCookie(cookie,"18,16,10,11,12");
		reloadMap();
	}
	
function clearSatelliteMenu (cookie) {
	var existingLayers = getCookie(cookie);
	var myArray = new Array();
		myArray = existingLayers.split(",");
		//alert(myArray.length + '/' + existingLayers);
		for (i=1;i < myArray.length; i++) {
			if((myArray[i] == '18') ||
			   (myArray[i] == '16') ||
			   (myArray[i] == '10') ||
			   (myArray[i] == '11') ||
			   (myArray[i] == '12') ||
			   (myArray[i] == '108') ||
			   (myArray[i] == '25') || 
			   (myArray[i] == '26') ||
			   (myArray[i] == '27') ||
			   (myArray[i] == '30') ||
			   (myArray[i] == '31') ||
			   (myArray[i] == '32') ||
			   (myArray[i] == '35') ||
			   (myArray[i] == '37') ||
			   (myArray[i] == '1') ||
			   (myArray[i] == '22')) {
			   // do nothing
			 }else{
				changeImages('FakeCheckBox_' + myArray[i]);
				//alert('FakeCheckBox_' + myArray[i]);
			}
		}
		setCookie(cookie,"18,16,10,11,12");
		reloadMap();
	}
function clearRadarMenu (cookie) {
	var existingLayers = getCookie(cookie);
	var myArray = new Array();
		myArray = existingLayers.split(",");
		//alert(myArray.length + '/' + existingLayers);
		for (i=1;i < myArray.length; i++) {
			if((myArray[i] == '18') ||
			   (myArray[i] == '16') ||
			   (myArray[i] == '10') ||
			   (myArray[i] == '11') ||
			   (myArray[i] == '12') ||
			   (myArray[i] == '108') ||
			   (myArray[i] == '23') || 
			   (myArray[i] == '28') ||
			   (myArray[i] == '38') ||
			   (myArray[i] == '39')) {
			   // do nothing
			 }else{
				changeImages('FakeCheckBox_' + myArray[i]);
				//alert('FakeCheckBox_' + myArray[i]);
			}
		}
		setCookie(cookie,"18,16,10,11,12");
		reloadMap();
	}
	
	function newPopupWindow(winName,filename,height,width) {
		window.open(filename,winName,"toolbar=no,status=no,width=" + width + ",height=" + height + ",scrollbars=no");
	}
//-->
</script>

<script language="JavaScript" type="text/JavaScript">
<!--
function getCookie(name) 
{ // use: getCookie("name");
    var index = document.cookie.indexOf(name + "=");
    if (index == -1) return null;
    index = document.cookie.indexOf("=", index) + 1;
    var endstr = document.cookie.indexOf(";", index);
    if (endstr == -1) endstr = document.cookie.length;
    return unescape(document.cookie.substring(index, endstr));
  }

function setCookie(name, value, hours)
{
  var expire = "";
  if(hours != null)
  {
    expire = new Date((new Date()).getTime() + hours * 3600000);
    expire = "; expires=" + expire.toGMTString();
  }
  document.cookie = name + "=" + escape(value) + expire;
}


function getFlashMovieObject(MovieName)
{
   if (navigator.appName.indexOf("Microsoft Internet")!=-1)	return window[MovieName];
   else	return window.document[MovieName]; 
}

function refreshMovie(MovieName, FrameToLoad)
{
	//alert("Function: refreshMovie \nMovie:" + MovieName + "\nFrame: " + FrameToLoad);
	var flashMovie=getFlashMovieObject(MovieName);
	flashMovie.TCallFrame("/", FrameToLoad); 
	setDelay(100);
	getNewText();
	//alert("end of refresh call");
}

function reloadMap() {
	var srcLocation = document.getElementById('mapCall').src;
	document.getElementById('mapCall').src= srcLocation;
	if(document.getElementById('timeText') != null) {
		getNewText();
	}
	document.getElementById('execute').disabled = true;
}

function enableFastPageLoadButton() {
	document.getElementById('execute').disabled = false;
	return true;
}

function newMapLayer(MovieName,cookieName,newLayer)
{
//cookieMapLayersName
       var LayerExists = false;
       //alert ("CookieName is:" + cookieName + " and Layer to add/remove is: " + newLayer);
	   var existingLayers = getCookie (cookieName);
       //alert ("Existing Layers are:" + existingLayers );
       if (existingLayers == null) {
	   		var newMapLayer = "18,16,10,11,12" + newLayer;
	   }
	   else	{
	       var i = 0;
		   var newMapLayer = existingLayers;
	       var myArray = new Array();
		   myArray = existingLayers.split(",");
		   for (i = 0; i < myArray.length; i++) {
		   		if ( myArray[i] == newLayer ) {
				LayerExists = true;
				myArray.splice(i,1);
				i = myArray.length + 1;
				}
		   } 
		   if (LayerExists == false) {
		   		newMapLayer = newMapLayer + "," + newLayer;
		   }
		   else {
		   		newMapLayer = myArray.toString();
		   }
	   }
	   if ((newMapLayer.indexOf('38') != -1) && (newMapLayer.indexOf('108') == -1)) {
	   		newMapLayer = newMapLayer + ',108';
			//alert('composite radar is there, but tops isn''t');
		}
		if ((newMapLayer.indexOf('108') != -1) && (newMapLayer.indexOf('38') == -1)) {
			newMapLayer = newMapLayer.replace(',108','');
			//alert('tops is there, but radar summary isn''t');
		}
       //alert ("Now Layers are:" + newMapLayer);
       setCookie (cookieName, newMapLayer);
       //alert ("Now Cookie is:" + getCookie (cookieName));
	  // if(MovieName != "MapLayers2") {
   	   	//	refreshMovie(MovieName,3);
		//}
}

function removeMapLayer(MovieName,cookieName,newLayer)
{
//cookieMapLayersName
       var LayerExists = true;
       //alert ("CookieName is:" + cookieName + "\nLayer to remove is: " + newLayer);
	   var existingLayers = getCookie (cookieName);
       //alert ("Existing Layers are:" + existingLayers );
       if (existingLayers == null) {
	   		var newMapLayer = "18,16,10,11,12";
	   }
	   else	{
	       var i = 0;
		   var newMapLayer = existingLayers;
	       var myArray = new Array();
		   myArray = existingLayers.split(",");
		   for (i = 0; i < myArray.length; i++) {
		   		if ( myArray[i] == newLayer ) {
					LayerExists = true;
					myArray.splice(i,1);
				}
		   } 
		   if (LayerExists == true) newMapLayer = myArray.toString();
	   }
	   
      //alert ("Now Layers are:" + newMapLayer);
       setCookie (cookieName, newMapLayer);
       //alert ("Now Cookie is:" + getCookie (cookieName));

	   //refreshMovie(MovieName,3);

}

//-->
</script>

<script type="text/javascript">
/***********************************************
* Switch Content script- © Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use. Last updated April 2nd, 2005.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

var enablepersist="on" //Enable saving state of content structure using session cookies? (on/off)
var collapseprevious="no" //Collapse previously open content when opening present? (yes/no)

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
if (ccollect[inc].id!=omit)
ccollect[inc].style.display="none"
inc++
}
}

function expandcontent(curobj, cid){
var spantags=curobj.getElementsByTagName("SPAN")
var showstateobj=getElementbyClass(spantags, "showstate")
if (ccollect.length>0){
if (collapseprevious=="yes")
contractcontent(cid)
document.getElementById(cid).style.display=(document.getElementById(cid).style.display!="block")? "block" : "none"
if (showstateobj.length>0){ //if "showstate" span exists in header
if (collapseprevious=="no")
showstateobj[0].innerHTML=(document.getElementById(cid).style.display=="block")? contractsymbol : expandsymbol
else
revivestatus()
}
}
}

function revivecontent(){
contractcontent("omitnothing")
selectedItem=getselectedItem()
selectedComponents=selectedItem.split(",")
for (i=0; i<selectedComponents.length-1; i++) {

	if ( document.getElementById(selectedComponents[i]) ) {
		//alert("defined selectedItem is:" + selectedComponents[i] );
		document.getElementById(selectedComponents[i]).style.display="block";
		}
	else {
		//	alert("undefine selectedItem is:" + selectedComponents[i] );
		}
}		
		
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
	if (get_cookie("ceBEACON") != ""){
		selectedItem=get_cookie("ceBEACON")
		return selectedItem
	}
	else return ""
}

/*
function saveswitchstate(){
	var inc=0, selectedItem=""
	while (ccollect[inc]){
		if (ccollect[inc].style.display=="block") selectedItem+=ccollect[inc].id+"|"
		inc++
	}
	//document.cookie=window.location.pathname+"="+selectedItem
	document.cookie="ceBEACON="+selectedItem
	alert("saved state with cookie ceBEACON:" + get_cookie("ceBEACON"));
}
*/

function saveswitchstate(){
	var inc=0, selectedItemToAdd="", selectedItemToRemove=""
	while (ccollect[inc]){
		if (ccollect[inc].style.display=="block") selectedItemToAdd+=ccollect[inc].id+"|"
		else selectedItemToRemove+=ccollect[inc].id+"|"
		inc++
	}
	//alert("toadd:" + selectedItemToAdd);
	//alert("toremove:" + selectedItemToRemove);

	selectedItem=getselectedItem();
	selectedComponents=selectedItem.split(",");
	
	//alert("selectedComponents before: " + selectedComponents);
	
	selectedComponentsToAdd=selectedItemToAdd.split("|");
	selectedComponentsToRemove=selectedItemToRemove.split("|");
	
	for (i=0; i<selectedComponentsToAdd.length-1; i++) { //loop over additions
		var alreadyExists = false;
		for (j=0; j<selectedComponents.length-1; j++) { //loop over existing cookie
			if (selectedComponentsToAdd[i] == selectedComponents[j])
				alreadyExists = true;
		}
		if (alreadyExists == false)
			selectedComponents+=selectedComponentsToAdd[i]+","
	}
	for (i=0; i<selectedComponentsToRemove.length-1; i++) { //loop over deletions
		for (j=0; j<selectedComponents.length-1; j++) { //loop over existing cookie
			if (selectedComponentsToRemove[i] == selectedComponents[j])
				selectedComponents.splice(j,1);
		}
	}
		
	document.cookie="ceBEACON="+selectedComponents;
	//alert("saved state with cookie ceBEACON:" + get_cookie("ceBEACON"));
}

function do_onload(){
//uniqueidn=window.location.pathname+"firsttimeload"
	uniqueidn="firsttimeload"
	var alltags=document.all? document.all : document.getElementsByTagName("*")
	ccollect=getElementbyClass(alltags, "switchcontent")
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
</head>

<body bgcolor="#333333" leftmargin="6" topmargin="6" marginwidth="12" marginheight="0" id="instrument" onLoad="MM_preloadImages('<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/contact_button_ovr.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/terms_of_use_button_ovr.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/privacy_button_ovr.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/disclaimer_button_ovr.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_on.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_on.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_on.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_on.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_on.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_on.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_7_on.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_1_off.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_2_off.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_3_off.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_4_off.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_5_off.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/buttons_6_off.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_1.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_2.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_4.gif','<cfoutput>#Request.imagesPrefix#</cfoutput>animation_control_images/speed_slider_5.gif')">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td rowspan="2"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>title_graphic.gif" alt="Weathernews BEACON" width="400" height="36"></td>
	<td class="whiteText" align="right" style="padding-bottom: 5px; font-size:9px" valign="bottom">&nbsp;&nbsp;</td>
  </tr>	
  <tr>
    <td class="whiteText" align="right" style="padding-bottom: 5px" valign="bottom"><cfif isdefined("cookie.initialized")><cfoutput>#ListGetAt(cookie.BeaconStats,2,"|")#</cfoutput></cfif>&nbsp;&nbsp;|&nbsp;<a href="<cfoutput>#Request.urlPrefix#</cfoutput><cfoutput>#Request.default_htm#</cfoutput>?mID=20" class="reversed">Preferences</a>&nbsp;|&nbsp;
				  <cfif not isdefined("cookie.initialized")>
				  <cfif TopSection EQ "LOGIN">
						  Login
				  <cfelse>
						  <a class="reversed" href="<cfoutput>#Request.urlPrefix##Request.login_htm#</cfoutput>">Login</a>
				  </cfif>
			  <cfelse>
					<cfif cookie.initialized EQ 1>
						  <a class="reversed" href="<cfoutput>#Request.urlPrefix##Request.login_htm#</cfoutput>?logout&reason=2">Logout</a>
					<cfelse>
						  Login
				   </cfif>
			  </cfif>
	  &nbsp;</td>
  </tr>
</table>

<!--- For Debug
<div class="whiteText" style="color:#FFFF00">
<cfloop index="LoopIndex" from="1" to="20">
	
	<cfset cookieBBoxName = "BBOX_" & LoopIndex>
	<cfset cookieMapLayersName = "MAPLAYERS_" & LoopIndex>
	<cfset cookieStageHName = "STAGEH_" & LoopIndex>
	<cfset cookieStageWName = "STAGEW_" & LoopIndex>
		
		
	<cfif isDefined("cookie." & cookieBBoxName)>
		<cfoutput>BBox#LoopIndex# Is Defined: #Evaluate("cookie." & cookieBBoxName)#<br></cfoutput>
	</cfif>

	<cfif isDefined("cookie." & cookieStageHName)>
		<cfoutput>StageH#LoopIndex# Is Defined: #Evaluate("cookie." & cookieStageHName)#<br></cfoutput>
	</cfif>

	<cfif isDefined("cookie." & cookieStageWName)>
		<cfoutput>StageW#LoopIndex# Is Defined: #Evaluate("cookie." & cookieStageWName)#<br></cfoutput>
	</cfif>
	<cfif isDefined("cookie." & cookieMapLayersName)>
		<cfoutput>Maplayers#LoopIndex# Is Defined: #Evaluate("cookie." & cookieMapLayersName)#<br></cfoutput>
	</cfif>


</cfloop>
</div>
 --->