// JavaScript Document
// Commands to control writing to the database for layers

var xmlhttpincrement = 1;

function getServer() {
	var url = window.location.href;
	url = url.split('/');
	
	var server = url[0] + url[1] + '//' + url[2];
	//alert(server);
	return server;
}

function getFlashID () {
	var url = window.location.href;
	arrQueryParts = url.split("?");
	if(arrQueryParts.length > 1) {
		var arrQuerySections = arrQueryParts[1].split("&");
		//alert(arrQuerySections[0]);
			for(var z=0;z < arrQuerySections.length;z++) {
				//alert(arrQuerySections.length);
				var keyValuePair = arrQuerySections[z].split('=');
				//alert(keyValuePair[0]);
				if(keyValuePair[0] == 'mID') {
					var returnValue = keyValuePair[1];
				}
			}
	} else {
		var returnValue = "";
	}
	//alert(returnValue);
	return returnValue;
}
	
	
	

function loadDoc(url) {
		var server = getServer();
		disableFastPageLoadButton();
		xmlhttpincrement = xmlhttpincrement + 1;
		eval("var " + "_xGo_" + xmlhttpincrement + " = new Request(server + url,'enableFastPageLoadButton','text'); " + "_xGo_" + xmlhttpincrement + ".doXmlhttp();");
		//alert("var " + "_xGo_" + xmlhttpincrement + " = new Request(server + url,'enableFastPageLoadButton','text'); " + "_xGo_" + xmlhttpincrement + ".doXmlhttp();");
		//alert(server + url);
		//document.getElementById('generalPurpose').src = url;
}

function newMapLayer(flashID,newLayer)
{
	//alert(newLayer);
	loadDoc ('/include/ajax/ajaxDriver.cfm?evt=updateLayerData&flashID=' + flashID + '&newLayer=' + newLayer);
}

function removeMapLayer(flashID,newLayer)
{
//cookieMapLayersName
       var LayerExists = true;
       //alert ("CookieName is:" + cookieName + "\nLayer to remove is: " + newLayer);
	   ajaxResponse = loadDoc ('/include/ajax/ajaxDriver.cfm?evt=removeLayer&flashID=' + flashID + '&layer=' + newLayer);
	  
}

function resetMapLayers(flashID,layerList) {
	ajaxResponse = loadDoc ('/include/ajax/ajaxDriver.cfm?evt=resetLayers&flashID=' + flashID + '&layer=' + layerList);
}
	

function reloadMap(flashID) {
	var srcLocation = '/mapCall.cfm?mID=' + flashID + '&flashid=' + flashID;
	document.getElementById('mapCall').src= srcLocation;
	if(document.getElementById('timeText') != null) {
		getNewText();
	}
	document.getElementById('execute').disabled = true;
	if(document.getElementById('animate')) {
		document.getElementById('animate').value = 'Animate';
		document.getElementById('clear').disabled = false;
	}
}

function removeAndAddLayer(flashID,newLayer,defaultLayerList) {
	// code to add tops & motion to the composite radar
	//alert('flashID: ' + flashID + ', newLayer: ' + newLayer + ' ,defaultLayerList: ' + defaultLayerList);
	if (newLayer == 38) {
			checkedLayers = checkedLayers + ',' + "108";
	} else {
			checkedLayers = '';
	}
	//alert(defaultLayerList + checkedLayers + ',' + newLayer);
	resetMapLayers(flashID,defaultLayerList + checkedLayers + ',' + newLayer);
}


function clearMenu (flashID) {
	if(flashID == 3 || flashID == 4) {
		//alert('working');
		var input = new Array();
		input = document.getElementsByTagName("input");
		for(i = 0; i < input.length; i++) {
			//alert(input[i].type);
			if(input[i].type == "radio") {
				//alert(input[i].checked);
				input[i].checked = false;
			}
		}
	}
	disableFastPageLoadButton();
	resetMapLayers(flashID,"18,16,10,11,12");
	resetFakeImages();
	turnOffAnimation();
	var timeout = window.setTimeout('reloadMap(' + flashID + ')',1500);
	while(!timeout) {
		disableFastPageLoadButton();
	} 
	enableFastPageLoadButton();
}