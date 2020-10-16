//Variable declarations relevent for this as file
var layerArray = new Array;
//createLayerXML();
//***********************
//
//***********************
function createLayerXML() {	
	var external_xml:XML = new XML();
	external_xml.ignoreWhite = true;	
	external_xml.load("flash/xml/layers.xml");
	external_xml.onLoad = function (success:Boolean) {
		if (success) {			
			displayLayerArray(external_xml);			
			//TEST
			var tmpXMLLayerArray = new Array;
			tmpXMLLayerArray = Layers.split(",");			
			
		} else {

		};
	}
	return external_xml;
}
//***********************
//
//***********************
function displayLayerArray(xmlOBJName) {
	var tempLayer_xml:XML = new XML();
	tempLayer_xml = xmlOBJName;
	Status.text = Status.text+" + "+tempLayer_xml.firstChild.nodeName;
	for(i=0;i<tempLayer_xml.firstChild.childNodes.length;i++) {
		layerArray[i] = new Array(2);
		if(tempLayer_xml.firstChild.childNodes[i].nodeName=="Layer") {
   			layerArray[i][0] = tempLayer_xml.firstChild.childNodes[i].childNodes[0].firstChild.nodeValue;
			layerArray[i][1] = tempLayer_xml.firstChild.childNodes[i].childNodes[1].firstChild.nodeValue;
		}
	} //END FOR
}
//***********************
//
//***********************
function getLayerNameFromID(tmpID) {
	var tmpLayerName;
	for(i=0;i< layerArray.length;i++) {
		if(layerArray[i][0] == tmpID) {
			tmpLayerName = layerArray[i][1];
			}
	}
	return tmpLayerName;
}
//***********************
//
//***********************
function getLayerIDFromName(tmpName) {
	var tmpID;
	tmpID = 10;
	for(x=0;x<layerArray.length;x++) {
		if(layerArray[x][1] == tmpName) {
			 return tmpID = layerArray[x][0];
		}
	}
	return tmpID;
}
//***********************
//
//***********************
function dumpFullArrToString() {
	var tmpContentString;
	for(i=0;i<layerArray.length;i++) {
		tmpContentString = tmpContentString+layerArray[i][0]+","+tmpContentString+layerArray[i][1]+" + ";
	}	
	return tmpContentString;	
}
//***********************
//
//***********************
function commaArrayofLayersIDs() {
	var tmpContentString;
	for(i=0;i<layerArray.length;i++) {
		if(i==0) {
			tmpContentString = tmpContentString+layerArray[i][0];
		} 
		else {
			tmpContentString = tmpContentString+","+layerArray[i][0]; 
		}
	}
	return tmpContentString;		
}
//***********************
//
//***********************
function IntStrFromCurrLyrCont() {
	var tmpContentString = "";
	tmpLayerArr = new Array;
	var tmpLayerID;
	tmpLayerArr = _level0.WMSmap.Layers.split(",");
	for(i=0;i<tmpLayerArr.length;i++) {			
		tmpLayerID = getLayerIDFromName(tmpLayerArr[i]);
		if(tmpLayerID != "-1" && tmpLayerID != " ") {			
			if(tmpContentString.length < 1) {
				tmpContentString = tmpContentString+tmpLayerID;
			}  //end the else
			else {
				tmpContentString = tmpContentString+","+tmpLayerID;
			} //end the else					
		} //end the if
	} //end the for	
	return tmpContentString;
}

function checkAndDisplayLayers() {
	for(q=0;q<layerArray.length;q++) {
		if(layerArray[q]>100) {
			//var loadString = "SymbolsLayer"+layerArray[q]; --8-24-05
			//_root.WMSMap[loadString].load(); --8-24-05
			//_root.WMSMap[loadString]._visible = true; --8-24-05
			//if(layerArray[q] == 105) { _level0.showFrontArray(); }
		} //if(resultArrFromCF[q]>100)
	} //for(q=0;q<resultArrFromCF.length;q++)
} //function checkAndDisplayLayers()
