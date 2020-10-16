//ComplexFront.as

	class ComplexFront extends MovieClip {
		
		//Public Variables
		public var CF_Hand:String;
		public var CF_Type:String;
		public var CF_LineColor:String;
		public var CF_LineAlpha:Number;
		public var CF_LineThickness:Number;
		public var CF_LinePointArray:Array;	
		public var CF_RawPointString:String;
		public var CF_Alpha:Number;		
		public var CF_ClipName:String;
		public var CF_OTime:String;
		public var CF_Depth:Number;		
		
	
		//Default Constructor
		public function ComplexFront() {			
			CF_LinePointArray = new Array;
			CF_LineColor = "0xFFFF00";
			CF_LineThickness = 5;	
			CF_Alpha = 100;
			CF_ClipName = "Default";
			CF_Depth = 3600;
		}		
		
		//****************************************		
		//Public Functions	
		//****************************************
		public function setClipName(tmpClipName):Void {
			CF_ClipName = tmpClipName;
		}
		public function setHand(tmpHand):Void {
			CF_Hand = tmpHand;
		}
		public function setType(tmpType):Void {
			CF_Type = tmpType;
		}
		public function setDepth(tmpDepth):Void {
			CF_Depth = tmpDepth;
		}
		public function setAlpha(tmpAlpha):Void {
			CF_Alpha = tmpAlpha;
		}
		public function setColor(tmpColor):Void {
			CF_LineColor = tmpColor;			
		}
		public function setLineThickness(tmpThick):Void {
			CF_LineThickness = tmpThick;
		}
		public function peelPointsFromString(tmpRawPtString) {
			var ptString = tmpRawPtString;
			var tmpPTArray = new Array;
			tmpPTArray = ptString.split(",");			
			for(var i=0;i<tmpPTArray.length;i++) {			
				var tmpDPHolder = new DataPoint(10);
				tmpDPHolder.addPoint(tmpPTArray[i+1], tmpPTArray[i]);
				tmpDPHolder.addRawMsg("Testing");	
				var tmpClipID = CF_ClipName+"_"+i;
				tmpDPHolder.setIDClip(tmpClipID);
				tmpDPHolder.addOTime("NULLNULLNULL");	
				tmpDPHolder.setAlpha(20);
				tmpDPHolder.setAlphaOnMouseOver(70);
				addDPtoArray(tmpDPHolder);
				i=i+1;
			}
			drawComplexFront();
		}
		
		//**************************
		//Function: addDPtoArray
		//
		//**************************
		public function addDPtoArray(tmpDP):Void {
			CF_LinePointArray[CF_LinePointArray.length] = tmpDP;			
		} // end setPointArray
		
		public function printLatLonPoints() {
			for(var i=0;i<CF_LinePointArray.length;i++) {
				var tmpPtArray = new Array;
				tmpPtArray = CF_LinePointArray[i].getPoint();
				//_level0.debugBox.text = _level0.debugBox.text+tmpPtArray[0]+","+tmpPtArray[1];
			}
			
		}
		public function drawComplexFront() {
			_level0.WMSMap.createEmptyMovieClip(CF_ClipName, CF_Depth);			
			_level0.WMSMap[CF_ClipName].lineStyle(CF_LineThickness, CF_LineColor, CF_Alpha);
			for(var i = 0;i< CF_LinePointArray.length;i++) {
				if(i == 0) {
					var tmpArray = CF_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);					
					_level0.WMSMap[CF_ClipName].moveTo(tmpxyArray[0],  tmpxyArray[1]);						
				} //if(i == 0)
				else {
					var tmpArray = CF_LinePointArray[i].getPoint();
					var tmpX = tmpArray[0];
					var tmpY = tmpArray[1];
					var tmpxyArray = parseBbox(tmpY, tmpX);
					_level0.WMSMap[CF_ClipName].lineTo(tmpxyArray[0],  tmpxyArray[1]);						
				} //else {					
			} //for(var i = 0;i< CF_LinePointArray.length;i++)					
			_level0.WMSMap[CF_ClipName].MCcName = CF_ClipName;
			_level0.WMSMap[CF_ClipName].MCDepth = CF_Depth;
			
			_level0.WMSMap[CF_ClipName].onRollOver = function () {				
				var tmpClipName = this.MCcName+"txt";
				var clipDepth = this.MCDepth+200;
				var myformat = new TextFormat();
				myformat.color = 0xFFFFFF;
				myformat.bullet = false;
				myformat.underline = false;
				myformat.size = 14;
				myformat.bold = true;
				_level0.WMSMap.createTextField(tmpClipName, clipDepth, _level0.WMSMap._xmouse+20, _level0.WMSMap._ymouse, 60, 20);
				_level0.WMSMap[tmpClipName].autosize =  "center"; 
				_level0.WMSMap[tmpClipName].autosize =  "center"; 
				//_level0.WMSMap[tmpClipName].text = Math.round(this.MCcVal);
				_level0.WMSMap[tmpClipName].setTextFormat(myformat);				
			}
			_level0.WMSMap[CF_ClipName].onRollOut = function () {	
				var tmpClipName = this.MCcName+"txt";
				_level0.WMSMap[tmpClipName].removeTextField(); 

			}
			
		} //drawComplexFront()
		
		
		public function killLines() {
			//_level0.debugBox.text = _level0.debugBox.text+"kill lines called";
			//_level0.debugBox.text = _level0.debugBox.text+"kill it";
			_level0.WMSMap[CF_ClipName].removeMovieClip();	
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
		/*
		private function calculateSpan():Array {
			
			
		}
		*/
		
}; //END ComplexFront CLASS

