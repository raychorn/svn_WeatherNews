//ComplexPoly.as

	class ComplexPoly extends MovieClip {
		
		//Public Variables
		public var CP_FlightLevel:Number;
		public var CP_Cval:Number;
		public var CP_DataValue:Number;
		public var CP_LineColor:String;
		public var CP_LineAlpha:Number;
		public var CP_LineThickness:Number;
		public var CP_LinePointArray:Array;	
		public var CP_RawPointString:String;
		public var CP_Alpha:Number;		
		public var CP_ClipName:String;
		public var CP_OTime:String;
		public var CP_Depth:Number;		
		public var CP_Tstring:String;
		
	
		//Default Constructor
		public function ComplexPoly() {		
			CP_LinePointArray = new Array;
			CP_LineColor = "0xFFFF00";
			CP_LineThickness = 3;	
			CP_Alpha = 100;
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
		public function setTimeString(tmpTString):Void {
			CP_Tstring = tmpTString;
		}
		public function setDepth(tmpDepth):Void {
			CP_Depth = tmpDepth;
		}
		public function setColor(tmpColor):Void {
			CP_LineColor = tmpColor;			
		}
		public function setLineThickness(tmpThick):Void {
			CP_LineThickness = tmpThick;
		}
		public function peelPointsFromString(tmpRawPtString) {
			var ptString = tmpRawPtString;
			var tmpPTArray = new Array;
			tmpPTArray = ptString.split(",");			
			for(var i=0;i<tmpPTArray.length;i++) {			
				var tmpDPHolder = new DataPoint(10);
				tmpDPHolder.addPoint(tmpPTArray[i+1], tmpPTArray[i]);
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
			//_level0.debugBox.text = _level0.debugBox.text+"filling the array";
		} // end setPointArray
		
		public function printLatLonPoints() {
			for(var i=0;i<CP_LinePointArray.length;i++) {
				var tmpPtArray = new Array;
				tmpPtArray = CP_LinePointArray[i].getPoint();
				//_level0.debugBox.text = _level0.debugBox.text+tmpPtArray[0]+","+tmpPtArray[1];
			}
			
		}
		public function drawComplexPoly() {
			_level0.WMSMap.createEmptyMovieClip(CP_ClipName, CP_Depth);			
			_level0.WMSMap[CP_ClipName].lineStyle(CP_LineThickness, CP_LineColor, CP_Alpha);
			for(var i = 0;i< CP_LinePointArray.length;i++) {
				if(i == 0) {
					var tmpArray = CP_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);					
					_level0.WMSMap[CP_ClipName].moveTo(tmpxyArray[0],  tmpxyArray[1]);	
					_level0.WMSMap[CP_ClipName].beginFill(0xFFFF00,80);
				} //if(i == 0)
				else {
					var tmpArray = CP_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);
					_level0.WMSMap[CP_ClipName].lineTo(tmpxyArray[0],  tmpxyArray[1]);		
					if(i < (CP_LinePointArray.length - 1)) { _level0.WMSMap[CP_ClipName].endFill(); }
				} //else {					
			} //for(var i = 0;i< CP_LinePointArray.length;i++)		
			_level0.WMSMap[CP_ClipName].MCcVal = CP_Cval;
			_level0.WMSMap[CP_ClipName].MCcName = CP_ClipName;
			_level0.WMSMap[CP_ClipName].MCDepth = CP_Depth;
			_level0.WMSMap[CP_ClipName].MCTString = CP_Tstring;
			
			_level0.WMSMap[CP_ClipName].onRollOver = function () {				
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
			_level0.WMSMap[CP_ClipName].onRollOut = function () {	
				var tmpClipName = this.MCcName+"txt";
				_level0.WMSMap[tmpClipName].removeTextField(); 
				var timeStringName = this.MCTString;
				var tmpString = _level0.WMSMap[timeStringName].text;
				//_level0.WMSMap.timeBG.removeMovieClip();
			}
			
		} //drawComplexPoly()
		
		
		public function killLines() {
			//_level0.debugBox.text = _level0.debugBox.text+"kill it";
			_level0.WMSMap[CP_ClipName].removeMovieClip();	
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

