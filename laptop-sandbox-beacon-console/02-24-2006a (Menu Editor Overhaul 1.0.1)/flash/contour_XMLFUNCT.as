//Variable declarations relevent for this as file
//var layerArray = new Array;
var contourNameArray = new Array;
var contourShowStatus = 0;
var contourLayerArray = new Array;

//***************************************************
//
//
//
//
//
//***************************************************
function createContourXML(tmpStat, tmpXmlName, tmpNamePrefix, tmpArrIndex, tmpLayerMultiplier) {
	var contour_xml:XML = new XML();
	contour_xml.ignoreWhite = true;	
	var tmpXMLVAR = tmpXmlName;	
	contour_xml.load(tmpXMLVAR);
	
	var namePrefix = tmpNamePrefix;
	//var namePrefix = "Contour";
	
	contour_xml.onLoad = function (success:Boolean) {
		if (success) {			
			var tmpXMLLayerArray = new Array;
			if(tmpStat == 1) {				
				displayContourArray(contour_xml, namePrefix, tmpArrIndex, tmpLayerMultiplier);
				showContourArray(0,tmpArrIndex);

			}
			else {
				displayContourArray(contour_xml, namePrefix, tmpArrIndex, tmpLayerMultiplier);
				hideContourArray(0,tmpArrIndex);				
			}
		} else {

		};
	}
	return contour_xml;
}
//***************************************************
//
//
//
//
//
//***************************************************
function displayContourArray(xmlOBJName, tmpNamePrefix, tmpArrayIndex, tmpLayerMult) {
	//_level0.textBoxTest.text = _level0.textBoxTest.text+"-displaycalled";
	var arrayIndex = tmpArrayIndex;
	var tmpStorageArray = new Array;
	var layerMult = tmpLayerMult;
	var tempLayer_xml:XML = new XML();
	tempLayer_xml = xmlOBJName;	
	var coordCounter = 0;
	for(i=0;i<tempLayer_xml.firstChild.childNodes.length;i++) {
		//Kill the description block
		if(tempLayer_xml.firstChild.childNodes[i].childNodes[0].childNodes[0].nodeValue == "description") {
			i++;
			break;			
		} //if(tempLayer_xml.firstChild.chi.....
			   
		

		var clipName=tmpNamePrefix+coordCounter;
		var className=tmpNamePrefix+"_"+coordCounter;		
		
		if(_level0[className] == undefined) {
			_level0[className] = new Contour();			
		}
		_level0[className].setClipName(clipName);
		var polyType = 0;
		//set polyType to 2 for turbulence
		//set polyType to 3 for convection
		for(z=0;z<tempLayer_xml.firstChild.childNodes[i].childNodes.length;z++) {
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "cval") {				
				var tmpCVall = tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue;				
				_level0[className].setCVal(tmpCVall);
				if(tmpCVall == 0 && tmpArrayIndex != 1 && tmpArrayIndex != 2) {
					_level0[className].setColor("0x4B64FF");	
					_level0[className].setThickness(3);
				}
				else if(tmpArrayIndex == 1) {
					_level0[className].setColor("0xFCFF00");	
				}
				else if(tmpArrayIndex == 0) {
					_level0[className].setColor("0xC2FF8C");	
				}
				else if(tmpArrayIndex == 2) {
					_level0[className].setColor("0xFFFFFF");	
					_level0[className].setThickness(3);
				}
			} //if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "cval") 
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "type") {	
				var tmpCType = tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue;	
				switch(tmpCType) {
					case "cold":
						_level0[className].setContourType(tmpCType);
						_level0[className].setColor("0x0006FF");
						_level0[className].setThickness(3);
						break;
					case "warm":
						_level0[className].setContourType(tmpCType);
						_level0[className].setColor("0xFF0000");
						_level0[className].setThickness(3);
						break;
					case "occluded":
						_level0[className].setContourType(tmpCType);
						_level0[className].setColor("0xB400FF");
						_level0[className].setThickness(3);
						break;
					case "trof":
						_level0[className].setContourType(tmpCType);
						_level0[className].setColor("0xCAAD24");
						_level0[className].setThickness(3);
						break;
					case "stationary":
						_level0[className].setContourType(tmpCType);
						_level0[className].setColor("0x28E27B");
						_level0[className].setThickness(3);
					default:
						_level0[className].setContourType(tmpCType);
						_level0[className].setColor("0x28E27B");
						_level0[className].setThickness(3);
						break;
				} //end switch
			
			}//if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "type") 
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "maxtop") {	
				var tmpCType = tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue;					
				_level0[className].setContourType(tmpCType);
				_level0[className].setFillType(1);
				_level0[className].setFillColor("0x00FF18");
				_level0[className].setFillAlpha(50);
				_level0[className].setColor("0x000000");
				_level0[className].setThickness(1);			
				polyType = 3;
			}//if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "maxtop") 
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "sigType" && tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue == "TURB") {	
				//var tmpCType = tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue;					
				//var tmpCType = "TURB";	
				//_level0[className].setContourType(tmpCType);
				if(polyType != 3) {
					_level0[className].setFillType(1);
					_level0[className].setFillColor("0xFF0000");
					//_level0[className].setFillAlpha(50);
					_level0[className].setColor("0x000000");
					_level0[className].setThickness(1);		
					polyType = 2;
				}
			}//if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "sigType") 
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "base") {	
				if(polyType != 3) {
					var tmpCType = tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue;					
					_level0[className].setContourType(tmpCType);
					polyType = 2
				};
			}//if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "base") 
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "top") {	
				if(polyType != 3) {
					var tmpCType = tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue;					
					_level0[className].setContourType(tmpCType);
					polyType = 2;
				}
			}//if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "top")
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "severity") {	
				if(polyType != 3) {
					var tmpCType = tempLayer_xml.firstChild.childNodes[i].childNodes[z].childNodes[0].nodeValue;		
					_level0[className].setFillAlpha(tmpCType*20);
					polyType = 2;
				}
			}//if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].nodeName == "severity")
			if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].firstChild.nodeName == "coordinates") {
				var pointArray = new Array;
				var pointString = tempLayer_xml.firstChild.childNodes[i].childNodes[z].firstChild.childNodes[0].nodeValue;
				pointArray = pointString.split(",");		
				var ArrCount = 0;
				for(p=0;p<pointArray.length;p++) {
					_level0[className].addPoint(pointArray[p+1],pointArray[p],ArrCount);
					ArrCount++;	
					p=p+1;		
				} //for(p=0;p<pointArray.length;p++)	
				_level0[className].setClassName(className);
				_level0[className].drawContour(coordCounter+layerMult);
				tmpStorageArray[coordCounter] = _level0[className].getClipName();
			} //if(tempLayer_xml.firstChild.childNodes[i].childNodes[z].firstChild.nodeName == "coordinates")

		}
		coordCounter++;
	} //END FOR
	//_level0.textBoxTest.text = _level0.textBoxTest.text+"added to "+arrayIndex;
	contourLayerArray[arrayIndex] = tmpStorageArray;
	hideContourArray(2 , tmpArrayIndex);
} //displayContourArray

//***************************************************
//Function: hideContourArray
//
//Description:
//
//
//***************************************************
function hideContourArray(statVar, tmpIndex) {
	
	var tmpArrIndex = tmpIndex;
	var tmpCheckArray = new Array;	
	tmpCheckArray = contourLayerArray[tmpArrIndex];	
	for(i=0;i<tmpCheckArray.length;i++) {		
		var movieClipName = tmpCheckArray[i];
		//_level0.textBoxTest.text = _level0.textBoxTest.text+"hide:"+movieClipName;
		_level0.WMSMAP[movieClipName+"tt"]._visible = false;
		_level0.WMSMAP[movieClipName]._visible = false;
	}
} //hideContourArray
//***************************************************
//Function: showContourArray 
//
//Description:  
//
//
//***************************************************
function showContourArray(statVar, tmpIndex) {	
	//_level0.textBoxTest.text = _level0.textBoxTest.text+"show";
	var tmpArrIndex = tmpIndex;
	var tmpCheckArray = new Array;	
	tmpCheckArray = contourLayerArray[tmpArrIndex];	
	for(i=0;i<tmpCheckArray.length;i++) {
		var movieClipName = tmpCheckArray[i];
		_level0.WMSMAP[movieClipName+"tt"]._visible = true;
	}
} //showContourArray


