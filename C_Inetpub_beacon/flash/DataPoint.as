//Primitive.as

	class DataPoint extends MovieClip {
		
		//Public Variables
		public var DP_Lat:Number;
		public var DP_Lon:Number;
		public var DP_RawMsg:String;
		public var DP_SID:String;
		public var DP_Symbol:String;
		public var DP_Color:String;
		public var DP_Size:Number;
		public var DP_Alpha:Number;
		public var DP_MOAlpha:Number;
		public var DP_ClipName:String;
		public var DP_StnOrg:String;
		public var DP_OTime:String;
		public var DP_Depth:Number;
		public var DP_SymbolMovie:MovieClip;
		public var DP_VertVsby:Number;
		public var DP_Vsby:Number;
		public var DP_CldHgt:Number;
		public var DP_Wdir:Number;
		public var DP_Wspd:Number;
		public var DP_GustSpd:Number;
		public var DP_Ctemp:Number;
		public var DP_CTTop:Number;
		public var DP_CTDir:Number;
		public var DP_CTSpeed:Number;
		public var DP_PFNum:Number;
		public var DP_PTType:Number;
		public var DP_BRotate:Number;
	
		//Default Constructor
		public function DataPoint(ptType) {					
			DP_Symbol = "GraphicRedCircle"; //normal type
			DP_Color = "0xA7FF58";
			DP_Size = 4;	
			DP_ClipName = "Default";
			DP_RawMsg = "NO MESSAGE YET";
			DP_Alpha = 100;
			DP_MOAlpha = 100;
			//1 = plain METAR; 2 = Flight Rules;3 = Temps;4=wind
			DP_PTType = ptType;
			DP_StnOrg = " ";
			DP_BRotate = 0;
			
			//EventHandler = DataPointEvent;
		}		
		
		//****************************************		
		//Public Functions	
		//****************************************
		public function addPoint (tmplat,tmplon):Void {		
			DP_Lat = tmplat;
			DP_Lon = tmplon;
  		}
		public function addRawMsg (tmpMsg):Void {
			DP_RawMsg = tmpMsg;
		}
		public function addVsby (tmpVsby):Void {
			DP_Vsby = tmpVsby;
		}
		public function addCldHgt (tmpCldHgt):Void {
			DP_CldHgt = tmpCldHgt;
		}
		public function addVertVsby (tmpVertVsby):Void {
			DP_VertVsby = tmpVertVsby;
		}
		public function addWspd (tmpWspd):Void {
			DP_Wspd = Math.round(tmpWspd * 1.944);
		}
		public function addGustSpd (tmpWspd):Void {
			DP_GustSpd = Math.round(tmpWspd * 1.944);
		}
		public function addWdir (tmpWdir):Void {
			DP_Wdir = tmpWdir;
		}
		public function addCtemp (tmpCtemp):Void {
			var tmpFholder = ((9/5)*tmpCtemp) + 32;
			DP_Ctemp = Math.round(tmpFholder);
		}		
		public function addOTime (tmpOtime):Void {
			DP_OTime = tmpOtime;
		}
		public function addCTTop (tmpCTop):Void {
			DP_CTTop = tmpCTop;
		}
		public function addPFNum (tmpFNum):Void {
			DP_PFNum = tmpFNum;
		}
		public function addCTDir (tmpCTop):Void {				
			var tmpCellDirection = Number(tmpCTop)-180;
			if(Number(tmpCellDirection) > 360) { tmpCellDirection = Number(tmpCellDirection) - 360; }			
			DP_CTDir = tmpCellDirection;			
		}
		public function addCTSpeed (tmpCTop):Void {
			DP_CTSpeed = tmpCTop;
		}
		public function setColor (tmpColorString):Void {
			DP_Color = tmpColorString;
		}
		public function setOrigin (tmpORG):Void {
			DP_StnOrg = tmpORG;
		}
		public function setDepth (tmpDepth):Void {
			DP_Depth = tmpDepth;
		}
		public function setAlpha (tmpAlpha):Void {
			DP_Alpha = tmpAlpha;
		}
		public function setRotation(tmpRotate):Void {
			DP_BRotate = tmpRotate;
		}
		public function setSize (tmpSize):Void {
			DP_Size = tmpSize;
		}
		public function setAlphaOnMouseOver (tmpAlpha):Void {
			DP_MOAlpha = tmpAlpha;
		}
		public function setIDClip (tmpIDString):Void {
			DP_SID = tmpIDString;
			DP_ClipName = DP_SID;
		}
		public function setSymbol (tmpSymName):Void {
			DP_Symbol = tmpSymName;			
		}
		public function getClipName ():String {
			return DP_ClipName;			
		}
		public function getPoint ():Array {
			var pointArr = new Array;
			pointArr[0] = DP_Lat;
			pointArr[1] = DP_Lon;
			return pointArr;
  		}
		public function getTest ():Number {
			return 666;
		}
		public function getRawMsg ():String {
			return DP_RawMsg;			
		}
		public function drawPoint():Void {	
			
			var testClipName = DP_ClipName;
			var testClipID = DP_ClipName+DP_Depth;
			if(_level0.WMSMap[testClipName] != undefined) {
					_level0.WMSMap[testClipName].removeMovieClip();
					_level0.WMSMAP[testClipName].removeTextField();
			}
			//Area for showing temps
			if(DP_Ctemp != undefined && DP_PTType == 3) {					
				var TempCname = testClipName;				
				_level0.WMSMap.createTextField(TempCname, DP_Depth, 0, 0, 60, 20);
				_level0.WMSMap[TempCname].autosize =  "center"; 
				var myformat = new TextFormat();
				myformat.color = 0xFFFF00;
				myformat.bullet = false;
				myformat.underline = false;
				myformat.border = true;
				myformat.background = true;	
				myformat.backgroundColor = 0x00FF00;				
				myformat.bold = true;
				myformat.size = 15;
				_level0.WMSMap[TempCname].text = DP_Ctemp;
				_level0.WMSMap[TempCname].setTextFormat(myformat);
				
			}	//end temps		
			else {		
				//_level0.debugBox.text = _level0.debugBox.text+testClipName+" "+DP_Depth;
				_level0.WMSMap.attachMovie(DP_Symbol, testClipName, DP_Depth);
				if(DP_PTType == 8) {					
					_level0.WMSMap[testClipName]._rotation = DP_BRotate;
				}
				_level0.WMSMap[testClipName]._width = DP_Size;
				if(DP_CTTop != undefined) {
					_level0.WMSMap[testClipName]._height = DP_Size * 3;
				}
				else if(DP_Size == -1){
					_level0.WMSMap[testClipName]._width = 40;
					_level0.WMSMap[testClipName]._height = 20;
				}
				else {
					_level0.WMSMap[testClipName]._height = DP_Size;
				}
			}			
			//AREA for drawing wind barbs
			if(DP_Wspd != undefined && DP_Wspd != -1) {
				var tClipNamea = testClipName+"a";
				var tClipNameb = testClipName+"b";
				var tClipNamec = testClipName+"c";
				var tClipNamed = testClipName+"d";
				var tClipNamee = testClipName+"e";
				var tClipNamef = testClipName+"f";
				//place the tree if there is windspeed > 0
				if(DP_Wspd >= 3) {
					_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlackTree", tClipNamea, 0);
				}
				//should it have a flag?
				if(DP_Wspd >= 50) {
					if(DP_Wspd >= 48 && DP_Wspd < 52) {
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlackFlag", tClipNameb, 1);	
					}
					if(DP_Wspd >= 98 && DP_Wspd < 107) {
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlackFlag100", tClipNameb, 1);	
					}
					if(DP_Wspd >= 148 && DP_Wspd < 157) {
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlackFlag150", tClipNameb, 1);	
					}				
				}
				else {
					if(DP_Wspd > 3 && DP_Wspd <= 7) {
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack05", tClipNameb, 1);	
					}
					else if(DP_Wspd > 7 && DP_Wspd <= 12) {					
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack10", tClipNameb, 1);	
					}
					else if(DP_Wspd > 12 && DP_Wspd <= 17) {	
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack15", tClipNameb, 1);
					}
					else if(DP_Wspd > 17 && DP_Wspd <= 22) {								
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack20", tClipNameb, 1);
					}
					else if(DP_Wspd > 22 && DP_Wspd <= 27) {								
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack25", tClipNameb, 1);
					}
					else if(DP_Wspd > 27 && DP_Wspd <= 32) {								
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack30", tClipNameb, 1);
					}
					else if(DP_Wspd > 32 && DP_Wspd <= 37) {								
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack35", tClipNameb, 1);
					}
					else if(DP_Wspd > 37 && DP_Wspd <= 42) {							
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack40", tClipNameb, 1);
					}
					else if(DP_Wspd > 42 && DP_Wspd <= 47) {							
						_level0.WMSMap[testClipName].attachMovie("GraphicWindBarbBlack45", tClipNameb, 1);
					}		
				} //else 
			} //if(DP_Wspd != undefined)
			//end barbs
			

			
			_level0.WMSMap[testClipName]._alpha = DP_Alpha;
			_level0.WMSMap[testClipName].MCrawMsg = DP_RawMsg;	
			if(DP_PFNum != undefined) {
				_level0.WMSMap[testClipName].MCstnID = DP_OTime;
			}
			else {
				_level0.WMSMap[testClipName].MCstnID = DP_ClipName+"  "+DP_OTime;
			}
			_level0.WMSMap[testClipName].MCalpha = DP_Alpha;
			_level0.WMSMap[testClipName].MCMOalpha = DP_MOAlpha;
			_level0.WMSMap[testClipName].MCwSpd = DP_Wspd;	
			_level0.WMSMap[testClipName].MCwDir = DP_Wdir;	
			_level0.WMSMap[testClipName].MCgSpd = DP_GustSpd;
			_level0.WMSMap[testClipName].MCstnOrig = DP_StnOrg;
			_level0.WMSMap[testClipName].MCsID = DP_ClipName;
			_level0.WMSMap[testClipName].MCCldHGT = DP_CldHgt;
			_level0.WMSMap[testClipName].MCPTTYPE = DP_PTType;
			
			var scalePoint = new Array;

			scalePoint = parseBbox(DP_Lon, DP_Lat);
			
			var tmpName = testClipName+DP_Depth;			

			_level0.WMSMap[testClipName]._x = scalePoint[0];
			_level0.WMSMap[testClipName]._y = scalePoint[1];
			setIDClip(testClipName);

			if(DP_CTDir != undefined) {
				var TempCname = testClipName+"a";	
				var TempCnameb = testClipName+"b";	
				var topX = _level0.WMSMap[testClipName]._x;
				var topY = _level0.WMSMap[testClipName]._y;
				if(DP_CTDir > 90 && DP_CTDir < 270) {
					var topX = _level0.WMSMap[testClipName]._x;
					var topY = _level0.WMSMap[testClipName]._y-20;
					_level0.WMSMap.createTextField(TempCname, DP_Depth+50, topX, topY, 60, 20);
					
				}
				else {
					var topX = _level0.WMSMap[testClipName]._x;
					var topY = _level0.WMSMap[testClipName]._y;
					_level0.WMSMap.createTextField(TempCname, DP_Depth+50, topX, topY, 60, 20);
				}
				if(DP_CTDir > 180 && DP_CTDir <= 270) {
					if((DP_CTDir - 180) > 45) {
						topY = (topY+30);
						topX = (topX-30);
					}
					else {
						topY = (topY+30);
						topX = (topX-40);
					}
				}
				if(DP_CTDir > 90 && DP_CTDir <= 180) {
					if((DP_CTDir - 90) > 45) {
						topY = (topY+35);
						topX = (topX+30);
					}
					else {
						topY = (topY+30);
						topX = (topX+35);						
					}
				}
				if(DP_CTDir > 0 && DP_CTDir <= 90) {
					if(DP_CTDir > 45) {
						topY = (topY-30);
						topX = (topX+30);
					}
					else {
						topY = (topY-35);
						topX = (topX+35);
					}
						
				}
				if(DP_CTDir < 0) {
					topY = (topY-35);
					topX = (topX-35);
				}				
				if(DP_CTDir < 360 && DP_CTDir > 270) {
					topY = (topY-30);
					topX = (topX-30);
				}
				//_level0.debugBox.text = _level0.debugBox.text+"xy:"+topX+","+topY+"DIR:"+DP_CTDir+"TOP:"+DP_CTTop;
				_level0.WMSMap.createTextField(TempCnameb, DP_Depth+100, topX, topY, 60, 20);
				_level0.WMSMap[TempCnameb].autosize =  "center"; 
				_level0.WMSMap[TempCname].autosize =  "center"; 
				
				var myformat = new TextFormat();
				myformat.color = 0xFFFFFF;
				myformat.bullet = false;
				myformat.underline = true;
				myformat.border = true;
				myformat.background = true;	
				myformat.backgroundColor = 0x00FF00;				
				myformat.bold = true;
				myformat.size = 15;
				var myformat2 = new TextFormat();
				myformat2.color = 0xFFFFFF;
				myformat2.bullet = false;
				myformat2.underline = false;
				myformat2.border = true;
				myformat2.background = true;	
				myformat2.backgroundColor = 0x00FF00;				
				myformat2.bold = true;
				myformat2.size = 12;
				_level0.WMSMap[TempCname].text = DP_CTTop;
				if(Math.round(DP_CTSpeed) < 10) {
					_level0.WMSMap[TempCnameb].text = "0"+Math.round(DP_CTSpeed);
				}
				else { _level0.WMSMap[TempCnameb].text = Math.round(DP_CTSpeed); } 
				_level0.WMSMap[TempCname].setTextFormat(myformat);			
				_level0.WMSMap[TempCnameb].setTextFormat(myformat2);
			}
			
			_level0.WMSMap[testClipName].onRollOver = function () {				

				var tmpRawMsg = this.getRawMsg();
				var myformat = new TextFormat();
				myformat.color = 0x000000;
				myformat.bullet = false;
				myformat.underline = false;
				myformat.bold = true;
				if(this.MCwSpd == undefined) {
					_level0.WMSMap[testClipName]._width = _level0.WMSMap[testClipName]._width * 2.5;
					_level0.WMSMap[testClipName]._height = _level0.WMSMap[testClipName]._height * 2.5;
				}
				_level0.WMSMap[testClipName]._alpha = this.MCMOalpha;

				_root.attachMovie("SymbolPopup", "PopupSymbol", 999);	
				//Moving the popup symbol if it runs off the map -- Y direction
				if((Stage.width - 260) < this._x) {
					_root.PopupSymbol._x = this._x-260;
				}
				else {
					_root.PopupSymbol._x = this._x+20;
				}
				//Moving the popup symbol if it runs off the map -- Y direction
				//(this.MCrawMsg.length > 100)
				if((Stage.height - 150) < this._y && this.MCrawMsg.length < 100) {
					if(this.MCPTTYPE == 7) {
						_root.PopupSymbol._y = this._y;
					}
					else {
						_root.PopupSymbol._y = this._y-150;
					}
				}
				else if((Stage.height - 190) < this._y && this.MCrawMsg.length >= 100) {
					if(this.MCPTTYPE == 7) {
						_root.PopupSymbol._y = this._y;
					}
					else {
						_root.PopupSymbol._y = this._y-190;
					}
				}
				
				else {
					_root.PopupSymbol._y = this._y+20;
				}
				//_root.PopupSymbol._y = this._y+20;
				
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
				if(this.MCwSpd != -1 && this.MCwDir != -1) {					
					if(this.MCwDir == 999) {
						if(this.MCgSpd < 0) {
							_root.PopupSymbol.Values2 = "WSPD: "+this.MCwSpd+"  WDIR: VRB";
						}
						else {
							_root.PopupSymbol.Values2 = "WSPD: "+this.MCwSpd+" GUST: "+this.MCgSpd+"  WDIR: VRB";
						}
					}
					else {
						if(this.MCgSpd < 0) {
							_root.PopupSymbol.Values2 = "WSPD: "+this.MCwSpd+"  WDIR: "+this.MCwDir;
						}
						else {
							_root.PopupSymbol.Values2 = "WSPD: "+this.MCwSpd+" GUST: "+this.MCgSpd+"  WDIR: "+this.MCwDir;
						}
					}
				}
				if(this.MCstnOrig == "KWNI" || this.MCstnOrig == "kwni") {
					_root.PopupSymbol.titlet = "TAF-Weathernews";

				}
				else if(this.MCstnOrig.length > 1) {
					_root.PopupSymbol.titlet = "TAF";
				}
				else if(this.MCPTTYPE == 7) {
					_root.PopupSymbol.titlet = this.MCrawMsg; 
					_root.PopupSymbol.Values2 = " ";
					_root.PopupSymbol.Values3 = " ";
					_root.PopupSymbol.symbolBG._width = 0; 
					_root.PopupSymbol.symbolBG._height = 0;
					_root.PopupSymbol.symbolBG._visible = false;
					_root.PopupSymbol.BG._width = 0; 
					_root.PopupSymbol.BG._height = 0;
					_root.PopupSymbol.BG._visible = false;
					
					_root.PopupSymbol.txtValues3._x = 0;
					_root.PopupSymbol.txtValues3._y = 0;
					_root.PopupSymbol.txtValues3._width = 0;
					_root.PopupSymbol.txtValues3._height = 0;
					
					_root.PopupSymbol.txtValues2._x = 0;
					_root.PopupSymbol.txtValues2._y = 0;
					_root.PopupSymbol.txtValues2._width = 0;
					_root.PopupSymbol.txtValues2._height = 0;
					
					_root.PopupSymbol.txtFields._x = 0;
					_root.PopupSymbol.txtFields._y = 0;					
					_root.PopupSymbol.txtFields._width = 0;
					_root.PopupSymbol.txtFields._height = 0;
					
					_root.PopupSymbol.txtValues._x = 0;
					_root.PopupSymbol.txtValues._y = 0;
					_root.PopupSymbol.txtValues._width = 0;
					_root.PopupSymbol.txtValues._height = 0;
					
					_root.PopupSymbol.txtFields2._x = 0;
					_root.PopupSymbol.txtFields2._y = 0;
					_root.PopupSymbol.txtFields2._width = 0;
					_root.PopupSymbol.txtFields2._height = 0;
					
					
					_root.PopupSymbol.txtValues2._x = 0;
				}
				else {
					//_root.PopupSymbol.titlet = this.MCstnID;	
					_root.PopupSymbol.titlet = this.MCsID;
					//_level0.debugBox.text = _level0.debugBox.text + this.MCsID+"="+this.MCCldHGT;
				}
			}
			_level0.WMSMap[testClipName].onRollOut = function () {
				_root.PopupSymbol.unloadMovie();
				_level0.WMSMap[testClipName]._alpha = this.MCalpha;
				_level0.tmpBox._visible = false;
				_level0.WMSMap.dataBdisp._visible = false;
				if(this.MCwSpd == undefined) {
					_level0.WMSMap[testClipName]._width = _level0.WMSMap[testClipName]._width / 2.5;
					_level0.WMSMap[testClipName]._height = _level0.WMSMap[testClipName]._height / 2.5;
				}
			}
		
		} //public function drawPrimitive(tmpDepth):Void
		//**************************
		//function: goRotate()
		//
		//*************************
		public function goRotate():Void {
			if(DP_Wdir != undefined && DP_Wdir > -1) {
				_level0.WMSMap[DP_ClipName]._rotation = DP_Wdir;		
			}
			else if(DP_CTDir != undefined) {
				//_level0.debugBox.text = _level0.debugBox.text+"DP_CTDir"+DP_CTDir;
				_level0.WMSMap[DP_ClipName]._rotation = DP_CTDir;					
			}
		}
		//**************************
		//function: killPoint()
		//
		//*************************
		public function killPoint():Void {
			_level0.WMSMap[DP_ClipName].text = " ";
			var tmpClipa = DP_ClipName+"a";
			var tmpClipb = DP_ClipName+"b";
			_level0.WMSMap[DP_ClipName].unloadMovie(DP_ClipName);
			_level0.WMSMap[tmpClipa].removeTextField();
			_level0.WMSMap[tmpClipb].removeTextField();
			_level0.WMSMap[DP_ClipName]._visible = false;
			_level0.WMSMap[DP_ClipName].removeTextField();
		}
		//**************************
		//function: hidePoint()
		//
		//*************************
		public function hidePoint():Void {
			_level0.WMSMap[DP_ClipName].text = " ";
			//_level0.WMSMap[DP_ClipName].unloadMovie(DP_ClipName);
			var tmpClipa = DP_ClipName+"a";
			var tmpClipb = DP_ClipName+"b";			
			_level0.WMSMap[DP_ClipName]._visible = false;
			_level0.WMSMap[DP_ClipName].removeTextField();
			_level0.WMSMap[tmpClipa].removeTextField();
			_level0.WMSMap[tmpClipb].removeTextField();

			
		}
		//**************************
		//function: showPoint()
		//
		//*************************
		public function showPoint():Void {
			_level0.WMSMap[DP_ClipName]._visible = true;
			
		}
		
		//****************************************		
		//Private Functions	
		//****************************************	
		//**************************
		//
		//
		//*************************
		private function parseBbox(tmpX, tmpY):Array {
			
			var parseBoxArray = new Array;
			var parsebox = _level0.WMSMap.BBox.split(",");
			//_level0.debugBox.text = _level0.debugBox.text+parsebox;
			var XMin = Number(parsebox[0]);
			var YMin = Number(parsebox[1]);
			var XMax = Number(parsebox[2]);
			var YMax = Number(parsebox[3]);
			delete parsebox;
			
			//then you calculate the map coordinate to pixel ratio:
			var xscale = _level0.WMSMap.Width/(XMax-XMin);
			var yscale = _level0.WMSMap.Height/(YMax-YMin);			
			parseBoxArray[0] = (tmpX-XMin)*xscale;
			parseBoxArray[1] = (YMax-tmpY)*yscale;
			return parseBoxArray;			
		}
		


		
}; //END DataPoint CLASS

