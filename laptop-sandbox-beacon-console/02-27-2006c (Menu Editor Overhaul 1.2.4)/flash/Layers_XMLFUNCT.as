//Variable declarations relevent for this as file
var layerArray = new Array;
//***********************
//
//***********************
function ObjResultGetLayerArray() {
	//receives data returned from the method
	this.onResult = function(ObjResult)
	{
		layerArray = ObjResult;		
		displayLayerArray(layerObj);
		_level0.Status.text =  "";
		//ADDED 1-30-2006
		//_level0.ShowHideLayersXML(resultArrFromCF, 1);				
		return 0;
	}
	this.onStatus = function(error)
	{
		//Status.text = "ERROR: "+error.description;
		Status.text = "ERROR E9000:"+error.description;
		_level0.WMSMap.loading.removeMovieClip();
		toggleTools(true);
		return 0;
	}
}

function createLayerXML() {	

	_level0.Status.text =  "Getting Layer Information";
	var layerOBJ = new Object();
	layerOBJ.flashID = _level0.flashID;	
	var layerOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResultGetLayerArray());	
	layerOBJCF.getLayerArray({x:layerOBJ});	
	return 0;
}
//***********************
//
//***********************
function displayLayerArray(tmpLayerArray) {	

	//This does nothing and will be removed....it is called in ObjResultGetLayerArray() above which also must be resolved.
		
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
	tmpID = -1;	
	var arrayCount = layerArray.length;
	for(p=0;p<arrayCount;p++) {			
		if(layerArray[p][1] == tmpName) {			
			tmpID = layerArray[p][0];
			p=arrayCount+1;			
		}
		else { tmpID = -1; }		
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
	
	//Yet another do nothing fuction that must be retired.
	
	//for(q=0;q<layerArray.length;q++) {
		//if(layerArray[q]>100) {
			//var loadString = "SymbolsLayer"+layerArray[q]; --8-24-05
			//_root.WMSMap[loadString].load(); --8-24-05
			//_root.WMSMap[loadString]._visible = true; --8-24-05
			//if(layerArray[q] == 105) { _level0.showFrontArray(); }
		//} //if(resultArrFromCF[q]>100)
	//} //for(q=0;q<resultArrFromCF.length;q++)
} //function checkAndDisplayLayers()
