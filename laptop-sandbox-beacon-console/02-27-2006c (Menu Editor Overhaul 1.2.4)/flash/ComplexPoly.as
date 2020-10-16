//ComplexPoly.as

	class ComplexPoly extends MovieClip {
		
		//Public Variables
		public var CP_FlightLevel:Number;
		public var CP_Cval:String;
		public var CP_DataValue:Number;
		public var CP_LineColor:String;
		public var CP_FillColor:String;
		public var CP_LineAlpha:Number;
		public var CP_FillAlpha:Number;
		public var CP_LineThickness:Number;
		public var CP_LinePointArray:Array;	
		public var CP_RawPointString:String;
		public var CP_Alpha:Number;		
		public var CP_ClipName:String;
		public var CP_OTime:String;
		public var CP_Depth:Number;		
		public var CP_Tstring:String;
		public var CP_Ptype:String;
		public var CP_RawMsg:String;
		public var CP_Flevel1:String;
		public var CP_Flevel2:String;
		public var CP_MetType:String;
		
	
		//Default Constructor
		public function ComplexPoly() {		
			//_level0.debugBox.text = _level0.debugBox.text+"Poly constructor";
			CP_Ptype = "DEFAULT";
			CP_RawMsg = "DEFAULT";
			CP_LinePointArray = new Array;
			CP_LineColor = "0xFFFF00";
			CP_FillColor = "0xFF0000";
			CP_LineThickness = 3;	
			CP_Alpha = 100;
			CP_FillAlpha = 100;
			CP_ClipName = "Default";
			CP_Depth = 1200;
			//_level0.debugBox.text = _level0.debugBox.text+"ComplexPoly called";
		}		
		
		//****************************************		
		//Public Functions	
		//****************************************
		public function setClipName(tmpClipName):Void {
			CP_ClipName = tmpClipName;
		}
		public function setCval(tmpCval):Void {
			CP_Cval = tmpCval;
		}
		public function setAlpha(tmpAlph):Void {
			CP_Alpha = tmpAlph;
		}
		public function setPtype(tmpPtype):Void {
			CP_Ptype = tmpPtype;
		}
		public function setRawMsg(tmpRawMsg):Void {
			CP_RawMsg = tmpRawMsg;
		}
		public function setMetType(tmpMetType):Void {
			CP_MetType = tmpMetType;
		}
		public function setflightLevels(tmpLvl1, tmpLvl2) {
			 CP_Flevel1 = tmpLvl1;
			 CP_Flevel2 = tmpLvl2;
		}
		public function setFillAlpha(tmpAlph):Void {
			CP_FillAlpha = tmpAlph;
		}
		public function setTimeString(tmpTString):Void {
			CP_Tstring = tmpTString;
		}
		public function setDepth(tmpDepth):Void {
			CP_Depth = tmpDepth;
		}
		public function setColor(tmpColor):Void {
			CP_LineColor = tmpColor;			
		}
		public function setFillColor(tmpColor):Void {
			CP_FillColor = tmpColor;			
		}
		public function setLineThickness(tmpThick):Void {
			CP_LineThickness = tmpThick;
		}
		public function peelPointsFromString(tmpRawPtString, tmpOrder) {
			//_level0.debugBox.text = _level0.debugBox.text+"Peeling the points off"+tmpRawPtString;
			var ptString = tmpRawPtString;
			var tmpPTArray = new Array;
			tmpPTArray = ptString.split(",");			
			for(var i=0;i<tmpPTArray.length;i++) {			
				var tmpDPHolder = new DataPoint(10);
				if(tmpOrder == 1) {					
					tmpDPHolder.addPoint(tmpPTArray[i], tmpPTArray[i+1]);
				}
				else {
					tmpDPHolder.addPoint(tmpPTArray[i+1], tmpPTArray[i]);
				}
				tmpDPHolder.addRawMsg("Testing");	
				var tmpClipID = CP_ClipName+"_"+i;
				tmpDPHolder.setIDClip(tmpClipID);
				tmpDPHolder.addOTime("NULLNULLNULL");	
				tmpDPHolder.setAlpha(20);
				tmpDPHolder.setAlphaOnMouseOver(70);
				addDPtoArray(tmpDPHolder);
				i=i+1;
			}
			drawComplexPoly();
		}
		
		//**************************
		//Function: addDPtoArray
		//
		//**************************
		public function addDPtoArray(tmpDP):Void {
			CP_LinePointArray[CP_LinePointArray.length] = tmpDP;
		} // end setPointArray
		
		public function printLatLonPoints() {
			for(var i=0;i<CP_LinePointArray.length;i++) {
				var tmpPtArray = new Array;
				tmpPtArray = CP_LinePointArray[i].getPoint();
			}			
		}
		public function drawComplexPoly() {
			//_level0.debugBox.text = _level0.debugBox.text+"Draw:"+CP_ClipName;
			_level0.WMSMap.createEmptyMovieClip(CP_ClipName, CP_Depth);			
			_level0.WMSMap[CP_ClipName].lineStyle(CP_LineThickness, CP_LineColor, CP_Alpha);
			var startPointx;
			var startPointy;
			var midPointx;
			var midPointy;
			for(var i = 0;i< CP_LinePointArray.length;i++) {
				if(i == 0) {
					var tmpArray = CP_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);							
					_level0.WMSMap[CP_ClipName].moveTo(tmpxyArray[0],  tmpxyArray[1]);	
					_level0.WMSMap[CP_ClipName].beginFill(CP_FillColor,80);
					startPointx = tmpxyArray[0]
					startPointy = tmpxyArray[1];

				} //if(i == 0)
				else {
					var tmpArray = CP_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);					
					_level0.WMSMap[CP_ClipName].lineTo(tmpxyArray[0],  tmpxyArray[1]);
					if(i == Math.round(CP_LinePointArray.length/2)) {
						midPointx = tmpxyArray[0]
						midPointy = tmpxyArray[1];
					}
					if(i == (CP_LinePointArray.length - 1)) { 
						//this is for non-closed polys
						var tmpArray2 = CP_LinePointArray[0].getPoint();
						var tmpX2 = tmpArray2[0];
						var tmpY2 = tmpArray2[1];
						var tmpxyArray2 = parseBbox(tmpY2, tmpX2);		
						_level0.WMSMap[CP_ClipName].lineTo(tmpxyArray2[0],  tmpxyArray2[1]);
						_level0.WMSMap[CP_ClipName].endFill(); 
					}
				} //else {					
			} //for(var i = 0;i< CP_LinePointArray.length;i++)		
			
			//Floating label
			var tmpClipName = CP_ClipName+"height";
			var clipDepth = CP_Depth+300;
			var timeStringName = CP_ClipName+"tname";
			var myformat1 = new TextFormat();
			myformat1.color = 0xFFFFFF;
			myformat1.bullet = false;
			myformat1.underline = false;
			//Zoom level needs to mod this...
			
			var parsebox = _level0.WMSMap.BBox.split(",");			
			var XMin = Number(parsebox[0]);
			var YMin = Number(parsebox[1]);
			var XMax = Number(parsebox[2]);
			var YMax = Number(parsebox[3]);
			var crossDist = (_level0.WMSMap.GeoDistance(XMin, YMin, XMax, YMax))/1609;
			var stageDist = Math.sqrt((Stage.width)*(Stage.width)+(Stage.height)*(Stage.height));
			var ratioCrossMovie = stageDist/crossDist;
			if(ratioCrossMovie < .7) {
				myformat1.size = 10;
			}
			else if(ratioCrossMovie < 1.1) {
				myformat1.size = 14;
			}
			else {
				myformat1.size = 18;
			}
			myformat1.bold = true;
			_level0.WMSMap.createTextField(tmpClipName, clipDepth, (startPointx+midPointx)/2, (startPointy+midPointy)/2, 80, 20);
			_level0.WMSMap[tmpClipName].autoSize =  "left"; 
			_level0.WMSMap[tmpClipName].html = true;
			_level0.WMSMap[tmpClipName].type =  " dynamic " ;
			_level0.WMSMap[tmpClipName].textColor = "0xFFFFFF";
			_level0.WMSMap[tmpClipName].textColor = 0xFFFFFF;
			_level0.WMSMap[tmpClipName].multiline = true;			
			
			if(CP_Flevel2 > CP_Flevel1) {
				if(CP_Flevel1 == 0) {
					if(CP_MetType == "CNVC") {
						_level0.WMSMap[tmpClipName].height = 80;
						_level0.WMSMap[tmpClipName].width = 20;
						_level0.WMSMap[tmpClipName].htmlText = "<b>MAXTOP</b><br>";
						_level0.WMSMap[tmpClipName].htmlText = _level0.WMSMap[tmpClipName].htmlText+"<b>FL"+CP_Flevel2+"</b>";
					}
					else {
						_level0.WMSMap[tmpClipName].text = CP_Flevel2+" / SFC";
					}					
				}
				else {
					_level0.WMSMap[tmpClipName].text = CP_Flevel2+" / "+CP_Flevel1;
				}					
			}
			else {
				if(CP_Flevel2 == 0) {
					if(CP_MetType == "CNVC") {
						_level0.WMSMap[tmpClipName].height = 80;
						_level0.WMSMap[tmpClipName].width = 20;
						_level0.WMSMap[tmpClipName].htmlText = "<b>MAXTOP</b><br>";
						_level0.WMSMap[tmpClipName].htmlText = _level0.WMSMap[tmpClipName].htmlText+"<b>FL"+CP_Flevel1+"</b>";
					}
					else {
						_level0.WMSMap[tmpClipName].text = CP_Flevel1+" / SFC";
					}
				}
				else {
					_level0.WMSMap[tmpClipName].text = CP_Flevel1+" / "+CP_Flevel2;
				}				
			}
			_level0.WMSMap[tmpClipName].setTextFormat(myformat1);			
			
			_level0.WMSMap[CP_ClipName].MCcVal = CP_Cval;
			_level0.WMSMap[CP_ClipName].MCcName = CP_ClipName;
			_level0.WMSMap[CP_ClipName].MCDepth = CP_Depth;
			_level0.WMSMap[CP_ClipName].MCTString = CP_Tstring;
			_level0.WMSMap[CP_ClipName].MCrawMsg = CP_RawMsg;
			_level0.WMSMap[CP_ClipName].MCpType = CP_Ptype;
			_level0.WMSMap[CP_ClipName].MCFlvl1 = CP_Flevel1;
			_level0.WMSMap[CP_ClipName].MCFlvl2 = CP_Flevel2;

			
			_level0.WMSMap[CP_ClipName].onRollOver = function () {	
			
				if(this.MCpType == "SIGMET" || this.MCpType == "AIRMET") {
					var tmpRawMsg = this.MCrawMsg;
					var myformat = new TextFormat();
					myformat.color = 0x000000;
					myformat.bullet = false;
					myformat.underline = false;
					myformat.bold = true;	
					_root.attachMovie("SymbolPopup", "PopupSymbol", 999);	
					_root.PopupSymbol._x = _level0.WMSMap._xmouse+20;
					_root.PopupSymbol._y = _level0.WMSMap._ymouse+20;
					//Moving the popup symbol if it runs off the map -- Y direction
					if((Stage.width - 260) < _root.PopupSymbol._x) {
						//_root.PopupSymbol._x = this._x-260;					
						_root.PopupSymbol._x = _root.PopupSymbol._x-260;	
					}
					else {
						//_root.PopupSymbol._x = this._x+20;
						_root.PopupSymbol._x = _root.PopupSymbol._x+20;
					}
					//Moving the popup symbol if it runs off the map -- Y direction
					if((Stage.height - 150) < _root.PopupSymbol._y && this.MCrawMsg.length < 100) {
						//_root.PopupSymbol._y = this._y-150;
						_root.PopupSymbol._y = _root.PopupSymbol._y-220;
						
					}
					else if((Stage.height - 190) < _root.PopupSymbol._y && this.MCrawMsg.length >= 100) {	
						//_root.PopupSymbol._y = this._y-190;
						_root.PopupSymbol._y = _root.PopupSymbol._y-230
					}				
					else {
						//_root.PopupSymbol._y = this._y+20;
						_root.PopupSymbol._y = _root.PopupSymbol._y+20;
					}
					
					_root.PopupSymbol.txtValues._y = 20;
					_root.PopupSymbol.txtFields._y = 20;
					_root.PopupSymbol.txtValues2._y = 20;
					_root.PopupSymbol.txtFields2._y = 20;
					_root.PopupSymbol.symbolBG._x = 0;
					_root.PopupSymbol.symbolBG._y = 0;
					_root.PopupSymbol.symbolbgtitle._x = 0;
					_root.PopupSymbol.symbolbgtitle._y = 0;
					_root.PopupSymbol.symbolbgtitle._height = 20;
					_root.PopupSymbol.symbolbgtitle._width = 250;
					_root.PopupSymbol.txtValues3._x = 10;
					_root.PopupSymbol.txtValues3._width = 230;
					_root.PopupSymbol.txtValues3._height = 60;
					_root.PopupSymbol.txtFields._x = 10;
					_root.PopupSymbol.txtValues._x = 65;		
					_root.PopupSymbol.txtFields2._x = 130;
					_root.PopupSymbol.txtValues2._x = 10;
					_root.PopupSymbol.symbolBG._width = 250; 
					
					//clear out the current values...
					_root.PopupSymbol.Values2 = " ";
					_root.PopupSymbol.Values3 = " ";
					_root.PopupSymbol.Values = " ";
					var featureCount = 6;
					if (this.MCrawMsg.length > 100) {				
						_root.PopupSymbol.symbolBG._height = (featureCount * 20)+80;
						_root.PopupSymbol.txtValues3._y = (featureCount * 10)-20;	
					}
					else {
						_root.PopupSymbol.symbolBG._height = (featureCount * 20)+20;
						_root.PopupSymbol.txtValues3._y = (featureCount * 10)-20;
					}
					_root.PopupSymbol.Values3 = this.MCrawMsg;
					_root.PopupSymbol.titlet = this.MCpType;

				}
				else {
					var tmpClipName = this.MCcName+"txt";
					var clipDepth = this.MCDepth+200;
					var timeStringName = this.MCTString;
					var myformat = new TextFormat();
					myformat.color = 0xFFFFFF;
					myformat.bullet = false;
					myformat.underline = false;
					myformat.size = 14;
					myformat.bold = true;
					_level0.WMSMap.createTextField(tmpClipName, clipDepth, _level0.WMSMap._xmouse+20, _level0.WMSMap._ymouse, 60, 20);
					_level0.WMSMap[tmpClipName].autosize =  "center"; 
					_level0.WMSMap[tmpClipName].autosize =  "center"; 
					_level0.WMSMap[tmpClipName].text = Math.round(this.MCcVal);
					_level0.WMSMap[tmpClipName].setTextFormat(myformat);			
				}
				
			}
			_level0.WMSMap[CP_ClipName].onRollOut = function () {	

				if(this.MCpType == "SIGMET" || this.MCpType == "AIRMET") {
					_root.PopupSymbol.unloadMovie();					
					_level0.tmpBox._visible = false;
					_level0.WMSMap.dataBdisp._visible = false;
				}
				else {
					var tmpClipName = this.MCcName+"txt";
					_level0.WMSMap[tmpClipName].removeTextField(); 
					var timeStringName = this.MCTString;
					var tmpString = _level0.WMSMap[timeStringName].text;					
				}				
			}
			
		} //drawComplexPoly()
		
		
		public function killPoly() {
			_level0.WMSMap[CP_ClipName].removeMovieClip();	
			var tmpMovieName = CP_ClipName+"height";
			_level0.WMSMap[tmpMovieName].removeTextField();	
		}
		
		//****************************************		
		//Private Functions	
		//****************************************	
		//**************************
		//
		//Lon,Lat
		//*************************
		private function parseBbox(tmpX, tmpY):Array {
			var tmpXval = tmpX;
			var tmpYval = tmpY;
			var parseBoxArray = new Array;
			var parsebox = _level0.WMSMap.BBox.split(",");
			var XMin = Number(parsebox[0]);
			var YMin = Number(parsebox[1]);
			var XMax = Number(parsebox[2]);
			var YMax = Number(parsebox[3]);
			delete parsebox;
			
			//then you calculate the map coordinate to pixel ratio:
			var xscale = _level0.WMSMap.Width/(XMax-XMin);
			var yscale = _level0.WMSMap.Height/(YMax-YMin);		
			parseBoxArray[0] = (tmpXval -XMin)*xscale;
			parseBoxArray[1] = (YMax-tmpYval)*yscale;
			return parseBoxArray;			
		}
		


		
}; //END ComplexPoly CLASS

