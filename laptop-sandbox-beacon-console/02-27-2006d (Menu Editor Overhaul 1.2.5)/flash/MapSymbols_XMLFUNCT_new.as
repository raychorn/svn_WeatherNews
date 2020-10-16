
// Parameters from html
var URL, Symbol, SymbolSize, FocusSymbol, Labels;
//var symbolNameArray = new array;
//Symbol = "YellowDot"
//FocusSymbol = "YellowDot"
//SymbolSize = 6
//

if (URL == undefined) {
	URL = "flash/xml/shities.xml";
}
// preload external symbols ?
SymbolPreload._visible = false;
if ((Symbol != undefined) and (Symbol.indexOf(".", 0)>=0)) {
	SymbolPreload.createEmptyMovieClip("Symbol", -1);
	SymbolPreload.Symbol.loadMovie(Symbol);
}
if ((FocusSymbol != undefined) and (FocusSymbol.indexOf(".", 0)>=0)) {
	SymbolPreload.createEmptyMovieClip("FocusSymbol", -2);
	SymbolPreload.FocusSymbol.loadMovie(FocusSymbol);
}
//
// load symbols layer, just one for this demo
function LoadSymbols(auto, tmpLname, tmpURL, clipName, clipNum) {
	tmpLayerName = tmpLname;
	tmpClipName = clipName;
	tmpClipNum = clipNum;
	URL = tmpURL;
	if (URL == undefined) {
		return false;
	}
	WMSMap.attachMovie("SymbolClip", tmpLayerName, tmpClipNum);

	// pass on parameters and load XML	
	WMSMap[tmpLayerName].Symbol = Symbol;
	WMSMap[tmpLayerName].FocusSymbol = FocusSymbol;
	WMSMap[tmpLayerName].LabelField = Labels;
	WMSMap[tmpLayerName].EventHandler = SymbolEvent;
	WMSMap[tmpLayerName].LoadXML(URL, auto, clipName);
}
//
function UpdateSymbols(tmpLayerName) {
	//TEST
	//_level0.PassCookieToCF();

	if (ShowSymbols != false) {
		WMSMap[tmpLayerName].Load();
	} else {
		WMSMap[tmpLayerName].Clear();		
	}
	
}
// event handler for XMLSymbols layer(s)
function SymbolEvent(event, args) {
	// pass on the event to javascript running in the browser
	trace("Symbol "+Event+" "+args);
	switch (Event) {
	case "loadxml" :
		Status.text = "";
		Status._visible = false;
		fscommand("messagebox", "xml loading");
		fscommand("Symbol loadxml", args);
		_root.ToolBar.SymbolsName = this.Name;
		break;
	case "load" :
		Status.text = "";
		Status._visible = false;
		break;
	case "rollover" :
		// popup the info returned by the featureinfo query
		var item, fields, values, fields2, values2, values3, tmpTitle;
		tmpTitle = " ";
		PopupSymbol.titlet = " ";
		
		_root.attachMovie("SymbolPopup", "PopupSymbol", 99);
		PopupSymbol.txtFields.autoSize = "left";
		PopupSymbol.txtValues.autoSize = "left";
		PopupSymbol.txtFields2.autoSize = "left";
		PopupSymbol.txtValues2.autoSize = "left";
		PopupSymbol.txtValues3.autoSize = "left";
		var countData = 0;
		var featureCount = 0;
		
		for (item in args.Data) {
			if (item.indexOf("_")<0) { featureCount++; }
		}
		for (item in args.Data) {			
			// only fields that do not begin with an underscore are displayed
			if(this.TName == "metarClip%%") { tmpTitle = "METAR"; }
			if(this.TName == "pirepClip%%") { tmpTitle = "PIREP"; }
			if(this.TName == "hiloClip%%") { tmpTitle = "Front"; }
			if(this.TName == "vsbycbaseClip%%") { tmpTitle = "Flight Rules"; }
			if(this.TName == "windsClip%%") { tmpTitle = "Winds"; }
			if(this.TName == "Pressure%%") { tmpTitle = "Pressure"; }
			if(this.TName == "cellTopsMotionClip%%") { tmpTitle = "Tops/Motion"; }
			if(this.TName == "Contour%%") { tmpTitle = "Freezing Level"; }
			if(this.TName == "Tropo%%") { tmpTitle = "Tropopause Height"; }
			if(this.TName == "POLYsigwx%%") { tmpTitle = "Turbulence"; }
			if(this.TName == "POLYcvnc%%") { tmpTitle = "Convection"; }
		
			
			if (item.indexOf("_")<0) {
				if(item == "otime") {
					 //tmpTitle = " Observation Time:  "+args.Data[item]+"Z ";					
				}
				else if(item == "name") {
					// tmpTitle = " "+args.Data[item]+" ";					
				}
				else if(item == "parameter") {
					if( tmpTitle != undefined) {
						// tmpTitle = " "+(args.Data[item]).toUpperCase()+" ";						
					}
					else {						
						 //tmpTitle = " "+(args.Data[item]).toUpperCase()+" "+PopupSymbol.titlet; 
					}
				}
				if(countData <= (featureCount/2) || featureCount < 10) {
					if(fields != undefined) {
						fields = "\n"+fields;					
						values = "\n"+values;
					}
					if(args.Data[item].length < 20) {
						fields = item+" "+fields;
						values = args.Data[item]+" "+values;
						
					}
					else if(values3.length < 20 && item != "rawms2") {
						//TEST
						values = " ";
						fields = " ";
						values2 = " ";
						fields2 = " ";
						countData = 1;
						//
						values3 = " ";
						fields3 = " ";
						values3 = args.Data[item];
						featureCount = 4;
						break;
						//featureCount--;
					}

				} //if(countData < 10 && fields != undefined) 
				else {
					if(fields2 != undefined) {
						fields2 = "\n"+fields2;					
						values2 = "\n"+values2;
					}
					if(args.Data[item].length < 20) {
						fields2 = item+" "+fields2;						
						values2 = args.Data[item]+" "+values2;						
					}
					else if(values3.length < 20 && item != "rawms2"){
						//TEST
						values = " ";
						fields = " ";
						values2 = " ";
						fields2 = " ";
						countData = 1;
						//
						values3 = " ";
						fields = " ";
						values3 = args.Data[item];
						featureCount = 4;
						break;
						//featureCount--;
					}

				} //else if(fields2 != undefined)
				countData = countData + 1;
			} //if (item.indexOf("_")<0)
		//countData = countData + 1;
		} //for (item in args.Data)
		
		PopupSymbol.Fields = fields;
		PopupSymbol.Fields2 = fields2;
		
		PopupSymbol.txtValues._y = 20;
		PopupSymbol.txtFields._y = 20;
		PopupSymbol.txtValues2._y = 20;
		PopupSymbol.txtFields2._y = 20;
		PopupSymbol.symbolBG._x = 0;
		PopupSymbol.symbolBG._y = 0;
		PopupSymbol.symbolbgtitle._x = 0;
		PopupSymbol.symbolbgtitle._y = 0;
		PopupSymbol.symbolbgtitle._height = 20;
		PopupSymbol.symbolbgtitle._width = 250;
		PopupSymbol.txtValues3._x = 10;
		PopupSymbol.txtValues3._width = 230;
		PopupSymbol.txtValues3._height = 60;
		PopupSymbol.txtFields._x = 10;
		PopupSymbol.txtValues._x = 65;		
		PopupSymbol.txtFields2._x = 130;
		PopupSymbol.txtValues2._x = 180;
		PopupSymbol.symbolBG._width = 250; 
		if(featureCount < 10) {
			if(featureCount < 1) { featureCount = 1; }
			PopupSymbol.symbolBG._height = (featureCount * 20)+20;
			//PopupSymbol.txtValues3._y = (featureCount * 20)-40;
			PopupSymbol.txtValues3._y = (featureCount * 10)-20;
		}
		else {
			PopupSymbol.symbolBG._height = (featureCount * 10)+10;
			//PopupSymbol.txtValues3._y = (featureCount * 10)-40;
			PopupSymbol.txtValues3._y = (featureCount * 10)-20;
		}
		PopupSymbol.Values = values;
		PopupSymbol.Values2 = values2;
		PopupSymbol.Values3 = values3;
		PopupSymbol.titlet = tmpTitle;
		
		//PopupSymbol.titleText = tmpTitle+"*";
		PopupSymbol.width = 250;
		if(featureCount <= 4) {
			PopupSymbol.height = (featureCount * 10)+50;
			PopupSymbol.txtValues3._height = 40;
			//PopupSymbol.txtValues3._width = 250;
		}
		else {
			PopupSymbol.height = (featureCount * 10)+30;
		}
		PositionObject(PopupSymbol, args._x+14, args._y+10);
		
		break;
	case "rollout" :
		Status.text = "";
		Status._visible = false;
		if (PopupSymbol.hitTest(args._x, args._y) == false) {
			PopupSymbol.removeMovieClip();
		}
		break;
	case "press" :
		if (args.Data._URL != undefined) {
			// an URL can be defined in the XML data
			if (args.Data._URL.indexOf("://")>0) {
				getURL(args.Data._URL, "_blank");
			} else {
				getURL(args.Data._URL, "_top");
			}
		} else if (args.Data._FSCommand != undefined) {
			// or a specific command to pass on to javascript
			fscommand("Symbol command", args.Data._FSCommand);
		} else if (args.Data._BBox != undefined) {
			// or a bbox to zoom in to
			WMSMap.ZoomTo(args.Data._BBox);
		} else {
			// default is a Symbol press(x,y) event passed on to javascript
			if (args.Data.Name != undefined) {
				fscommand("Symbol press", args.Data.Name);
			} else {
				fscommand("Symbol press", args.Data._X+","+args.Data._Y);
			}
		}
		break;
	}
}

//***********************************
//
//
//***********************************
function symbolChooser() {
	
	
	
}