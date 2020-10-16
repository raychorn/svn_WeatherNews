//LineString.as

	class LineString extends MovieClip {
		
		//Public Variables
		public var LS_FlightLevel:Number;
		public var LS_Cval:Number;
		public var LS_DataValue:Number;
		public var LS_LineColor:String;
		public var LS_LineAlpha:Number;
		public var LS_LineThickness:Number;
		public var LS_LinePointArray:Array;	
		public var LS_RawPointString:String;
		public var LS_Alpha:Number;		
		public var LS_ClipName:String;
		public var LS_OTime:String;
		public var LS_Depth:Number;		
		public var LS_Tstring:String;
		
	
		//Default Constructor
		public function LineString() {		
			LS_LinePointArray = new Array;
			LS_LineColor = "0xFFFF00";
			LS_LineThickness = 3;	
			LS_Alpha = 100;
			LS_ClipName = "Default";
			LS_Depth = 1200;
			//_level0.debugBox.text = _level0.debugBox.text+"linestring called";
		}		
		
		//****************************************		
		//Public Functions	
		//****************************************
		public function setClipName(tmpClipName):Void {
			LS_ClipName = tmpClipName;
		}
		public function setCval(tmpCval):Void {
			LS_Cval = tmpCval;
		}
		public function setAlpha(tmpAlph):Void {
			LS_Alpha = tmpAlph;
		}
		public function setTimeString(tmpTString):Void {
			LS_Tstring = tmpTString;
		}
		public function setDepth(tmpDepth):Void {
			LS_Depth = tmpDepth;
		}
		public function setColor(tmpColor):Void {
			LS_LineColor = tmpColor;			
		}
		public function setLineThickness(tmpThick):Void {
			LS_LineThickness = tmpThick;
		}
		public function peelPointsFromString(tmpRawPtString) {
			var ptString = tmpRawPtString;
			var tmpPTArray = new Array;
			tmpPTArray = ptString.split(",");			
			for(var i=0;i<tmpPTArray.length;i++) {			
				var tmpDPHolder = new DataPoint(10);
				tmpDPHolder.addPoint(tmpPTArray[i+1], tmpPTArray[i]);
				tmpDPHolder.addRawMsg("Testing");	
				var tmpClipID = LS_ClipName+"_"+i;
				tmpDPHolder.setIDClip(tmpClipID);
				tmpDPHolder.addOTime("NULLNULLNULL");	
				tmpDPHolder.setAlpha(20);
				tmpDPHolder.setAlphaOnMouseOver(70);
				addDPtoArray(tmpDPHolder);
				i=i+1;
			}
			drawLineString();
		}
		
		//**************************
		//Function: addDPtoArray
		//
		//**************************
		public function addDPtoArray(tmpDP):Void {
			LS_LinePointArray[LS_LinePointArray.length] = tmpDP;
			//_level0.debugBox.text = _level0.debugBox.text+"filling the array";
		} // end setPointArray
		
		public function printLatLonPoints() {
			for(var i=0;i<LS_LinePointArray.length;i++) {
				var tmpPtArray = new Array;
				tmpPtArray = LS_LinePointArray[i].getPoint();
				//_level0.debugBox.text = _level0.debugBox.text+tmpPtArray[0]+","+tmpPtArray[1];
			}
			
		}
		public function drawLineString() {
			_level0.WMSMap.createEmptyMovieClip(LS_ClipName, LS_Depth);			
			_level0.WMSMap[LS_ClipName].lineStyle(LS_LineThickness, LS_LineColor, LS_Alpha);
			for(var i = 0;i< LS_LinePointArray.length;i++) {
				if(i == 0) {
					var tmpArray = LS_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);					
					_level0.WMSMap[LS_ClipName].moveTo(tmpxyArray[0],  tmpxyArray[1]);						
				} //if(i == 0)
				else {
					var tmpArray = LS_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);
					_level0.WMSMap[LS_ClipName].lineTo(tmpxyArray[0],  tmpxyArray[1]);						
				} //else {					
			} //for(var i = 0;i< LS_LinePointArray.length;i++)		
			_level0.WMSMap[LS_ClipName].MCcVal = LS_Cval;
			_level0.WMSMap[LS_ClipName].MCcName = LS_ClipName;
			_level0.WMSMap[LS_ClipName].MCDepth = LS_Depth;
			_level0.WMSMap[LS_ClipName].MCTString = LS_Tstring;
			
			_level0.WMSMap[LS_ClipName].onRollOver = function () {				
				var tmpClipName = this.MCcName+"txt";
				var clipDepth = this.MCDepth+200;
				var timeStringName = this.MCTString;
				//_level0.WMSMap[timeStringName].text = ">"+_level0.WMSMap[timeStringName].text;				
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
				//_level0.WMSMap.attachMovie("GraphicTimeBG", "timeBG", 3199);
				//_level0.WMSMap.timeBG._x = _level0.WMSMap[timeStringName]._x;
				//_level0.WMSMap.timeBG._y = _level0.WMSMap[timeStringName]._y;
				//_level0.WMSMap.timeBG._alpha = 100;
				
			}
			_level0.WMSMap[LS_ClipName].onRollOut = function () {	
				var tmpClipName = this.MCcName+"txt";
				_level0.WMSMap[tmpClipName].removeTextField(); 
				var timeStringName = this.MCTString;
				var tmpString = _level0.WMSMap[timeStringName].text;
				//_level0.WMSMap.timeBG.removeMovieClip();
			}
			
		} //drawLineString()
		
		
		public function killLines() {
			//_level0.debugBox.text = _level0.debugBox.text+"kill it";
			_level0.WMSMap[LS_ClipName].removeMovieClip();	
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
		


		
}; //END LineString CLASS

