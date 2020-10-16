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
	

function loadDoc(url) {
		var server = getServer();
		disableFastPageLoadButton();
		xmlhttpincrement = xmlhttpincrement + 1;
		eval("var " + "_xGo_" + xmlhttpincrement + " = new Request(server + url,'enableFastPageLoadButton','text'); " + "_xGo_" + xmlhttpincrement + ".doXmlhttp();");
		//alert("var " + "_xGo_" + xmlhttpincrement + " = new Request(server + url,'enableFastPageLoadButton','text'); " + "_xGo_" + xmlhttpincrement + ".doXmlhttp();");
		//document.getElementById('generalPurpose').src = url;
}

function newMapLayer(flashID,newLayer)
{
//cookieMapLayersName
       var LayerExists = false;
       //alert ("CookieName is:" + cookieName + " and Layer to add/remove is: " + newLayer);
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
}

function removeAndAddLayer(flashID,newLayer,defaultLayerList) {
	var arrImageHandles = document.images;
	var checkedLayers = "";
	for(i = 1;i < arrImageHandles.length; i++) {
		if(arrImageHandles[i].src.indexOf('checkBox_on.gif') > 0) {
			checkedLayers = checkedLayers + ',' + arrImageHandles[i].id.substr(13);
		}
	}
	// code to add tops & motion to the composite radar
	if (newLayer == 38) {
			checkedLayers = checkedLayers + ',' + "108";
	}
	//alert(defaultLayerList + checkedLayers + ',' + newLayer);
	resetMapLayers(flashID,defaultLayerList + checkedLayers + ',' + newLayer);
}


function clearMenu (flashID) {
	if(flashID == 3 || flashID == 4) {
		var input = new Array();
		input = document.forms['radioForm'].elements;
		for(i = 0; i < input.length; i++) {
			if((input[i].id.indexOf('SatelliteType') != -1) || (input[i].id.indexOf('RadarType') != -1)) {
				//alert(input[i].checked);
				input[i].checked = false;
			}
		}
	}
	disableFastPageLoadButton();
	resetMapLayers(flashID,"18,16,10,11,12");
	resetFakeImages();
	var timeout = window.setTimeout('reloadMap(' + flashID + ')',1500);
	while(!timeout) {
		disableFastPageLoadButton();
	} 
	enableFastPageLoadButton();
}