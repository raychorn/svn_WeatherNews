<!--- <link rel="stylesheet" href="<cfoutput>#Request.urlPrefix#</cfoutput>include/css/style.css" type="text/css">
<link href="<cfoutput>#Request.urlPrefix#</cfoutput>include/css/text_attributes.css" rel="stylesheet" type="text/css">

 --->
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
var contractsymbol='<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>Next.gif">'
var expandsymbol='<img src="<cfoutput>#Request.imagesPrefix#</cfoutput>Down.gif">'

if (document.getElementById){
document.write('<style type="text/css">')
document.write('.switchcontent{display:none;}')
document.write('</style>')
}

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
	if (get_cookie("ceSAT") != ""){
		selectedItem=get_cookie("ceSAT")
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
	document.cookie="ceSAT="+selectedItem
	//alert("saved state with cookie ce:" + get_cookie("contractexpand"));
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

<SCRIPT Language="Javascript">
<!--

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

function changeImages (imgId) {
//	alert("inside change Image2: " + document.images[imgId].src + "index is: " + document.images[imgId].src.indexOf("down.gif") );
		if (document.images[imgId].src.indexOf("obs_on.jpg") > 0 )
			document.images[imgId].src = "..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_off.jpg";
		else	
			document.images[imgId].src = "..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_on.jpg";
}

// -->
</script>

<cfset cookieBBoxName = "BBOX_" & flashID>
<cfset cookieMapLayersName = "MAPLAYERS_" & flashID>

<form action="#" method="post">
<DIV class=menuWrap>
<DIV class=sideMenuBG><SPAN class=sideMenuFontLev1>Satellite</SPAN></DIV>

	<cffile action="read" file="#Request.webRoot#flash\xml\layers.xml" variable="XMLFileText">
	<cfset myXMLDocument=XmlParse(XMLFileText)>
	<cfloop index="LoopIndex" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#">
	<cfoutput>
	<cfset currID = myXMLDocument.layers.layer[LoopIndex].ID.XmlText>
	<cfset currName = myXMLDocument.layers.layer[LoopIndex].Name.XmlText>
	<cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
	<DIV class=sideMenuBG2><SPAN class=sideMenuFontLev2>
		  <cfif ListFind(CookieList,currID)>
				<img src="..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_on.jpg" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
		  <cfelse>
				<img src="..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_off.jpg" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
		  </cfif>
		#currName#</SPAN></DIV>
	</cfoutput>
	</cfloop>


<!--- 			<table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="3" valign="top" bgcolor="#FFFFFF">OBS MENU</td>
              </tr>
               <!--- observation menu goes here --->
				<cffile action="read" file="#Request.webRoot#flash\xml\layers.xml" variable="XMLFileText">
				<cfset myXMLDocument=XmlParse(XMLFileText)>
				<cfloop index="LoopIndex" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#">
				<cfoutput>
			  	<cfset currID = myXMLDocument.layers.layer[LoopIndex].ID.XmlText>
				<cfset currName = myXMLDocument.layers.layer[LoopIndex].Name.XmlText>
                <tr>
					<td>
					  <cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
					  <cfif ListFind(CookieList,currID)>
							<img src="..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_on.jpg" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
					  <cfelse>
							<img src="..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_off.jpg" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
					  </cfif>
					 </td>
					 <td colspan="2" valign="top" nowrap>#currName#</td>
				</tr>
				</cfoutput>
				</cfloop>
				</table>
 --->
</DIV>

</form>
<!--- 







			<table width="160" border="0" cellspacing="0">
                <tr bgcolor="#666666">
                  <td height="26" colspan="6" class="White11Norm" >&nbsp;Observation Menu</td>
                </tr>
                <tr>
                  <td bgcolor="#FFFFFF"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="#FFFFFF"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr bgcolor="cecfce" class="r">
                  <td height="15" colspan="5">OPERATIONAL</td>
                </tr>

<!---                 <tr bgcolor="cecfce">
                  <td width="14%" height="15" class="r">Satellite</td>
                  <td height="15" colspan="4" class="r"><cfoutput>
				  <cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
				  <input type="radio" <cfif ListFind(CookieList,1)>checked</cfif> value="1" name="LegendOnOff" onClick="parent.addMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',1)" value="1">On&nbsp;
				  <input type="radio" <cfif NOT ListFind(CookieList,1)>checked</cfif> name="LegendOnOff" onClick="parent.removeMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',1)" value="0">Off
				  </cfoutput>
				  </td>
                </tr>

                <tr>
                  <td bgcolor="#FFFFFF"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="#FFFFFF"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr bgcolor="cecfce">
                  <td width="14%" height="15" class="r"><cfoutput>
				  <cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
				  <input type="checkbox" <cfif ListFind(CookieList,1)>checked</cfif> value="1" name="Legend2OnOff" onClick="parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',1)">
				  </cfoutput></td>
                  <td height="15" colspan="4" class="r">Satellite</td>
                </tr>
 --->


  <cffile action="read" file="#Request.webRoot#flash\xml\layers.xml" variable="XMLFileText">
  <cfset myXMLDocument=XmlParse(XMLFileText)>

	<cfloop index="LoopIndex" from="1" to="#ArrayLen(myXMLDocument.layers.layer)#">

	<cfoutput>
		<cfset currID = myXMLDocument.layers.layer[LoopIndex].ID.XmlText>
		<cfset currName = myXMLDocument.layers.layer[LoopIndex].Name.XmlText>
                <tr>
                  <td bgcolor="##FFFFFF"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="##FFFFFF"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr bgcolor="cecfce">
                  <td width="14%" height="15" class="r"><cfoutput>
				  <cfset CookieList = #Evaluate("cookie." & cookieMapLayersName)#>
<!--- 				  <input type="checkbox" <cfif ListFind(CookieList,currID)>checked</cfif> value="1" name="Legend2OnOff" onClick="parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)"> --->
				  <cfif ListFind(CookieList,currID)>
					  	<img src="..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_on.jpg" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
				  <cfelse>
					  	<img src="..<cfoutput>#Request.imagesPrefix#</cfoutput>obs_off.jpg" name="FakeCheckBox_#currID#" id="FakeCheckBox_#currID#" onClick="changeImages('FakeCheckBox_#currID#');parent.newMapLayer('MapSymbols#mID#','#UCASE(cookieMapLayersName)#',#currID#)">
				  </cfif>						
				  </cfoutput></td>
                  <td height="15" colspan="4" class="r">#currName#</td>
                </tr>

	</cfoutput>


</cfloop>










                <tr>
                  <td bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr>
                  <td bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr>
                  <td bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr bgcolor="cecfce" class="r">
                  <td height="15" colspan="5">DEMO</td>
                </tr>


                <tr>
                  <td bgcolor="ffffff"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="ffffff"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr bgcolor="cecfce" class="r"><!---  style="cursor:hand; cursor:pointer"  --->
                  <td height="15" colspan="5"><div onClick="expandcontent(this, 'sc1')" style="cursor:hand; cursor:pointer"><span class="showstate"></span>&nbsp;Flight Level Winds</div></td>
                </tr>

                <tr bgcolor="cecfce" class="r">
					<td colspan="5">
						<table border="0" id="sc1" class="switchcontent">
						<tr bgcolor="cecfce" class="r">
						  <td height="15">&nbsp;</td>
						  <td height="15"><input name="FLWradiobutton" type="radio" value="radiobutton"></td>
						  <td width="30%" height="15">FL390</td>
						  <td width="14%"><input name="FLWradiobutton" type="radio" onClick="MM_goToURL('parent','ip_ulw.htm');return document.MM_returnValue" value="radiobutton"></td>
						  <td width="28%">FL340</td>
						</tr>
						<tr bgcolor="cecfce" class="r">
						  <td height="15">&nbsp;</td>
						  <td height="15"><input name="FLWradiobutton" type="radio" value="radiobutton"></td>
						  <td height="15">FL300</td>
						  <td height="15"><input name="FLWradiobutton" type="radio" value="radiobutton"></td>
						  <td height="15">FL240</td>
						</tr>
						<tr bgcolor="cecfce" class="r">
						  <td height="15">&nbsp;</td>
						  <td height="15"><input name="FLWradiobutton" type="radio" value="radiobutton"></td>
						  <td height="15" colspan="3">FL180</td>
						</tr>
						</table>
					</td>
				</tr>
				

                <tr>
                  <td bgcolor="ffffff"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                  <td colspan="4" bgcolor="ffffff"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
                </tr>
                <tr bgcolor="cecfce" class="r">
                  <td height="15" colspan="5"><div onClick="expandcontent(this, 'sc2')" style="cursor:hand; cursor:pointer"><span class="showstate"></span>&nbsp;Routes</div></td>
                </tr>

                <tr bgcolor="cecfce" class="r">
					<td colspan="5" id="sc2" class="switchcontent" style="display:block">
						<table border="0">
						<tr bgcolor="cecfce" class="r">
						  <td height="15">&nbsp;</td>
						  <td height="15"><input name="FLradiobutton" type="checkbox">Jet Routes</td>
						</tr>
						<tr bgcolor="cecfce" class="r">
						  <td height="15">&nbsp;</td>
						  <td height="15"><input name="FLradiobutton" type="checkbox">VORs</td>
						</tr>
						<tr bgcolor="cecfce" class="r">
						  <td height="15">&nbsp;</td>
						  <td height="15"><input name="FLradiobutton" type="checkbox">Victor Routes</td>
						</tr>
						</table>
					</td>
				</tr>

                <tr bgcolor="cecfce" class="r">
                  <td height="5">&nbsp;</td>
                  <td height="5" colspan="4">&nbsp;</td>
                </tr>
             </table>
			 
</form>			


 ---> 