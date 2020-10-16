// XML symbols, name for legend
var LoadStatus = 0;
var SymbolsName = "Symbolen";
var fullLayerList = new Array;
//_level0.debugBox.text =  _level0.debugBox.text+"mapsymbols loaded";
function goGetCookie() {

}
//Process CF result
function Result(functionToRun) {
	//receives data returned from the method
	this.onResult = function(result)
	{
		switch(functionToRun) {
			case 1:
				//_level0.debugBox.text =  _level0.debugBox.text+"error";
				break;
			case 10: 
				//_level0.debugBox.text =  _level0.debugBox.text+"bbox:"+_level0.WMSMap.BBox;				
				//MapClip.Load();
				//_level0.MapClip.Load();
				//_level0.ToolBar.Refresh();
				if(LoadStatus == 0) {
					LoadStatus = 1;
					_level0.PassCookieToCF();
				}
				//do nothing
			break;
			case 11: 			
				//do nothing
			break;
			case 12: 
				//_level0.debugBox.text =  _level0.debugBox.text+"case12";
				if(SLO==1) { break; } 				
				var resultOBJ = new Object;
				resultOBJ = result;
				if(_level0.Toolbar._x == -150) { 
					_level0.Toolbar._x = (resultOBJ.StageW)-150;
					_level0.Toolbar._y = 2;
				} //if(_level0.Toolbar._x == -150) 
				var resultArrFromCF = new Array;				
				resultArrFromCF = resultOBJ.MAPLAYERS.split(",");				
				ShowHideLayersXML(resultArrFromCF, 0);
				_level0.ToolBar.Refresh();
			break;
			case 13:
				//_level0.debugBox.text =  _level0.debugBox.text+"case13";
				if(SLO==1) { break; } 				
				var resultOBJ = new Object;
				resultOBJ = result;
				var resultArrFromCF = new Array;				
				resultArrFromCF = resultOBJ.MAPLAYERS.split(",");				
				ShowHideLayersXML(resultArrFromCF, 1);
				_level0.ToolBar.Refresh();
			break;
			case 14:	
				
			break;			
			case 15:			
			
				
			break;
			default:
				_level0.ToolBar.Refresh();
			break;
			
		}
		return result;
	}
	this.onStatus = function(error)
	{
		Status.text = "ERROR: "+error.description;
		return 0;
	}
} //Result()


//*****************************
//Function: PassOBJtoCF
//Description:
//		Passes the bounding box, FlashID, and mapLayers to CF...no result needed.
//		
//*****************************
function PassOBJtoCF() {

} //PassOBJtoCF

//*****************************
//Function: PassCookieToCF
//Description:
//		Passes the flashID to the CF server and expects the comma separted layer list returned
//		
//*****************************
function PassCookieToCF() {	
	cookieOBJ = new Object();
	cookieOBJ.flashID = _level0.flashID;	
	cookieOBJ.bBox = _level0.WMSMap.BBox;	
	cookieOBJ.mapLayers = _level0.IntStrFromCurrLyrCont();
	cookieOBJ.StageW = Stage.width;
	cookieOBJ.StageH = Stage.height;
	var cookiesCF = gw.getService("include.cfc.FlashComponent", new Result(13));	
	cookiesCF.setMapState({x:cookieOBJ});		
} //PassCookieToCF

//*****************************
//Function: BboxCookieChange
//Description:
//		When the Bbox changes this passes the new values to CF
//		
//*****************************
function BboxCookieChange() {	
	bBoxCookieOBJ = new Object();
	bBoxCookieOBJ.flashID = _level0.flashID;	
	bBoxCookieOBJ.bBox = _level0.WMSMap.BBox;
	bBoxCookieOBJ.StageW = Stage.width;
	bBoxCookieOBJ.StageH = Stage.height;
	bBoxCookieOBJ.mapLayers = _level0.IntStrFromCurrLyrCont();
	var cookiesCF = gw.getService("include.cfc.FlashComponent", new Result(12));	 //was 15
	cookiesCF.setMapState({x:bBoxCookieOBJ});		
}

// the click sound is used by the EventHandler to make the map "click" as well
function ClickSound() {
	_root.speaker.stop();
	var Click = new Sound();
	Click.attachSound("SoundClick");
	Click.onSoundComplete = function() {
		_root.speaker.stop();
	};
	Click.start();
	_root.speaker.play();
}
//*****************************
//Function: HandOverBbox
//Description:
//		This simply pushes a sort of status object back to the server
//		this is redundant because we don't know when the bounding
//		box information is valid...so we send it twice.
//		
//*****************************
function HandOverBbox() {	
	bBoxCookieOBJ = new Object();
	bBoxCookieOBJ.flashID = _level0.flashID;	
	bBoxCookieOBJ.bBox = _level0.WMSMap.BBox;
	bBoxCookieOBJ.StageW = Stage.width;
	bBoxCookieOBJ.StageH = Stage.height;
	bBoxCookieOBJ.mapLayers = _level0.IntStrFromCurrLyrCont();
	var cookiesCF = gw.getService("include.cfc.FlashComponent", new Result(10));	
	cookiesCF.setMapState({x:bBoxCookieOBJ});	
}


// position text, check that it doesn't go offstage
function PositionToolTip(TextObj, x, y) {
	var w = TextObj._width+this._x;
	var h = TextObj._height+this._y;
	if ((x+w)>(Stage.width-4)) {
		x = Stage.width-w-4;
	}
	if (x<4) {
		x = 4;
	}
	if ((y+h)>(Stage.height-4)) {
		y = Stage.height-h-4;
	}
	if (y<4) {
		y = 4;
	}
	TextObj._x = x;
	TextObj._y = y;
}
//*****************************
//Function: ShowHideLayersXML
//		
//*****************************
function ShowHideLayersXML(tmpLayerList, tmpAction) {
				
				fullLayerList = tmpLayerList;
				if(_level0.Toolbar._x == -150) { 
					_level0.Toolbar._x = (resultOBJ.StageW)-150;
					_level0.Toolbar._y = 2;
				} //if(_level0.Toolbar._x == -150) 

				var layerList = new Array;
				layerList = tmpLayerList;
				
				var resultStringToWMS = "";
				
				//initially hide all layers
				_level0.hideLayerDisplayed(0);  //zero means hide all			 

				 var isMetar = 0;
				 var isCellTops = 0;
				 var isPirep = 0;
				 var isFreeze = 0;
				 var isStnDisp = 0;
				 var isPressure = 0;
				 var isTropo = 0;
				 var isTaf = 0;
				 var submitStat = 0;
				 var isFcstSfcTEMP0z = 0;
				 var isFcstSfcTEMP12z = 0;
				 var isFcstSfcTEMP24z = 0;
				 var isFcstSfcTEMP36z = 0;
				 var isFcstSfcTEMP48z = 0;

				 var isFcst200TEMP0z = 0;
				 var isFcst200TEMP12z = 0;
				 var isFcst200TEMP24z = 0;
				 var isFcst200TEMP06z = 0;
				 var isFcst200TEMP18z = 0; 
				 
				 var isFcst250TEMP0z = 0;
				 var isFcst250TEMP12z = 0;
				 var isFcst250TEMP24z = 0;
				 var isFcst250TEMP06z = 0;
				 var isFcst250TEMP18z = 0; 
				 
				 var isFcst300TEMP0z = 0;
				 var isFcst300TEMP12z = 0;
				 var isFcst300TEMP24z = 0;
				 var isFcst300TEMP06z = 0;
				 var isFcst300TEMP18z = 0; 
				 
				 var isFcstPRES0z = 0;
				 var isFcstPRES12z = 0;
				 var isFcstPRES24z = 0;
				 var isFcstPRES48z = 0;
				 
				 var isFcstFRNT00z = 0; //Load00_Front
				 
				for(j=0;j<layerList.length;j++) {
					if(resultStringToWMS.length < 1 && (layerList[j] < 100)) {
						resultStringToWMS=resultStringToWMS+getLayerNameFromID(layerList[j]);	
					}  //end the else
					else if((layerList[j] < 100)) {
						submitStat = 3;
						resultStringToWMS=resultStringToWMS+","+getLayerNameFromID(layerList[j]);
					} //end the else	
					else if((layerList[j] == 102 || layerList[j] == 106 || layerList[j] == 114 || layerList[j] == 107)) {
						isMetar = 1;
					}
					else if((layerList[j] == 141)) {
						isFcstFRNT00z = 1;
					}
					else if((layerList[j] == 108)) {
						isCellTops = 1;
					}
					else if((layerList[j] == 103)) {
						isPirep = 1;
					}
					else if((layerList[j] == 110)) {
						isFreeze = 1;
					}
					else if((layerList[j] == 115)) {
						isStnDisp = 1;
					}
					else if((layerList[j] == 116)) {
						isTaf = 1;
					}
					else if((layerList[j] == 117)) {
						isFcstSfcTEMP0z = 1;
					}
					else if((layerList[j] == 118)) {
						isFcstSfcTEMP12z = 1;
					}
					else if((layerList[j] == 119)) {
						isFcstSfcTEMP24z = 1;
					}
					else if((layerList[j] == 120)) {
						isFcstSfcTEMP36z = 1;
					}
					else if((layerList[j] == 121)) {
						isFcstSfcTEMP48z = 1;
					}
					else if((layerList[j] == 122)) {
						isFcst200TEMP0z = 1;
					}
					else if((layerList[j] == 123)) {
						isFcst200TEMP12z = 1;
					}
					else if((layerList[j] == 124)) {
						isFcst200TEMP24z = 1;
					}
					else if((layerList[j] == 125)) {
						isFcst200TEMP06z = 1;
					}
					else if((layerList[j] == 126)) {
						isFcst200TEMP18z = 1;
					}
					else if((layerList[j] == 127)) {
						isFcst250TEMP0z = 1;
					}
					else if((layerList[j] == 128)) {
						isFcst250TEMP12z = 1;
					}
					else if((layerList[j] == 129)) {
						isFcst250TEMP24z = 1;
					}
					else if((layerList[j] == 130)) {
						isFcst250TEMP06z = 1;
					}
					else if((layerList[j] == 131)) {
						isFcst250TEMP18z = 1;
					}
					else if((layerList[j] == 132)) {
						isFcst300TEMP0z = 1;
					}
					else if((layerList[j] == 133)) {
						isFcst300TEMP12z = 1;
					}
					else if((layerList[j] == 134)) {
						isFcst300TEMP24z = 1;
					}
					else if((layerList[j] == 135)) {
						isFcst300TEMP06z = 1;
					}
					else if((layerList[j] == 136)) {
						isFcst300TEMP18z = 1;
					}
					else if((layerList[j] == 137)) {
						isFcstPRES0z = 1;
					}
					else if((layerList[j] == 138)) {
						isFcstPRES12z = 1;
					}
					else if((layerList[j] == 139)) {
						isFcstPRES24z = 1;
					}
					else if((layerList[j] == 140)) {
						isFcstPRES48z = 1;
					}					
					else if((layerList[j] == 111)) {
						isTropo = 1;
					}
					else if((layerList[j] == 109)) {
						isPressure = 1;
					}
				}
				if(isMetar == 1) {
					_level0.PassOBJtoFromCF();
				}
				if(isCellTops == 1) {
					_level0.GrabXMLDataFromCF();
				}
				if(isPirep == 1) {
					_level0.GrabXMLPireps();
				}
				if(isFreeze == 1) {
					_level0.LoadLineLayers();
				}
				if(isStnDisp == 1) {
					_level0.GrabMeterLevel1();
				}
				if(isTropo == 1) {
					_level0.LoadTropoHeightFromDB();
				}
				if(isTaf == 1) {
					_level0.GrabTAFs();
				}
				if(isPressure == 1) {
					_level0.LoadPressureFromDB();
				}
				if(isFcstSfcTEMP0z == 1) {
					_level0.Load00SurfaceTemp();
				}
				if(isFcstSfcTEMP12z == 1) {
					_level0.Load12SurfaceTemp();
				}
				if(isFcstSfcTEMP24z == 1) {
					_level0.Load24SurfaceTemp();
				}
				if(isFcstSfcTEMP36z == 1) {
					_level0.Load36SurfaceTemp();
				}
				if(isFcstSfcTEMP48z == 1) {
					_level0.Load48SurfaceTemp();
				}
				if(isFcst200TEMP0z == 1) {
					_level0.Load00_200Temp();
				}
				if(isFcst200TEMP12z == 1) {
					_level0.Load12_200Temp();
				}
				if(isFcst200TEMP24z == 1) {
					_level0.Load24_200Temp();
				}
				if(isFcst200TEMP06z == 1) {
					_level0.Load06_200Temp();
				}
				if(isFcst200TEMP18z == 1) {
					_level0.Load18_200Temp();
				}
				if(isFcst250TEMP0z == 1) {
					_level0.Load00_250Temp();
				}
				if(isFcst250TEMP12z == 1) {
					_level0.Load12_250Temp();
				}
				if(isFcst250TEMP24z == 1) {
					_level0.Load24_250Temp();
				}
				if(isFcst250TEMP06z == 1) {
					_level0.Load06_250Temp();
				}
				if(isFcst250TEMP18z == 1) {
					_level0.Load18_250Temp();
				}
				if(isFcst300TEMP0z == 1) {
					_level0.Load00_300Temp();
				}
				if(isFcst300TEMP12z == 1) {
					_level0.Load12_300Temp();
				}
				if(isFcst300TEMP24z == 1) {
					_level0.Load24_300Temp();
				}
				if(isFcst300TEMP06z == 1) {
					_level0.Load06_300Temp();
				}
				if(isFcst300TEMP18z == 1) {
					_level0.Load18_300Temp();
				}
				if(isFcstPRES0z == 1) {
					_level0.Load00_Pres();
				}
				if(isFcstPRES12z == 1) {
					_level0.Load12_Pres();
				}
				if(isFcstPRES24z == 1) {
					_level0.Load24_Pres();
				}
				if(isFcstPRES48z == 1) {
					_level0.Load48_Pres();
				}
				if(isFcstFRNT00z == 1) {
					_level0.Load00_Front();
				}
				
				_level0.WMSMap.Layers = resultStringToWMS;
				var beenHere = 0;
				
				if(tmpAction == 1) {
					_level0.ToolBar.SubmitLayers(0);  //what to do with this?					
				}				
				/*
				if(submitStat == 3 || tmpAction == 1) {
					_level0.ToolBar.SubmitLayers(0);
				}
				*/
}
function HideAllLayersXML() {
	//_level0.hideLayerDisplayed();
}



