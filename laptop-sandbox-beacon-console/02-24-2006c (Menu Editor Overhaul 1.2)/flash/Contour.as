//Contour.as

	class Contour {
		
		//Public Variables
		public var pointArray:Array;
		public var contourType:String;
		public var contourThickness:Number;
		public var contourColor:String;
		public var contourFillColor:String;
		public var contourFillAlpha:Number;
		public var contourFillType:Number;
		public var contourCVal:Number;
		public var clipName:String;		
		public var className:String;		
		public var contourHand:Number;
	
		//Default Constructor
		public function Contour() {			
			pointArray = new Array;			
			contourType = "error"; //normal type
			contourColor = "0xA7FF58";
			contourFillColor = "0xFF0000";
			contourFillAlpha = 100;
			contourThickness = 2;
			contourFillType = 0;
			contourCVal = -10;
			contourHand = 0; //Right
			clipName = "contourClip1";
			
		}
		
		//****************************************		
		//Public Functions	
		//****************************************
		public function addPoint (tmplat,tmplon,tmpposition):Void {		
			pointArray[tmpposition] = new Array(2);
			pointArray[tmpposition][0] = tmplat;
			pointArray[tmpposition][1] = tmplon;			
  		}
		public function setColor (tmpColorString):Void {
			contourColor = tmpColorString;
		}
		public function setFillColor (tmpColorString):Void {
			contourFillColor = tmpColorString;
		}
		public function setFillAlpha (tmpAlpha):Void {
			contourFillAlpha = tmpAlpha;
		}
		public function setContourHand (tmpHand):Void {
			contourHand = tmpHand;
		}
		public function setClipName (tmpClipName):Void {
			clipName = tmpClipName;			
		}
		public function getClipName ():String {
			return clipName;			
		}
		public function setClassName (tmpClassName):Void {
			className = tmpClassName;			
		}
		public function getClassName ():String {
			return className;			
		}
		public function setCVal (tmpCVal):Void {
			contourCVal = tmpCVal;
		}
		public function getCVal ():Number {
			return contourCVal;
		}
		public function setThickness (tmpcontourThickness):Void {
			contourThickness = tmpcontourThickness;
		}
		public function setContourType (tmpContourType):Void {
			contourType = tmpContourType;			
		}
		public function getContourType ():String {
			return contourType;			
		}
		public function setFillType (tmpFillType):Void {
			contourFillType = tmpFillType;
		}
		public function getFillType ():Number {
			return contourFillType;			
		}
		public function getPoint (tmpposition):String {
			var pointString = new String;
			pointString = pointArray[tmpposition][0]+","+pointArray[tmpposition][1] ;
			return pointString;
  		}
		public function drawContour(tmpDepth):Void {		
			//_level0.textBoxTest.text = _level0.textBoxTest.text+contourType;
			if(_level0[clipName] != undefined) {
					_level0[clipName].removeMovieClip();
			}
			var testClipName = clipName+"tt";
			var testClipID = clipName+tmpDepth;
			_root.WMSMap.attachMovie("SymbolClip", testClipName, tmpDepth);
			var tmppVal = Math.round(contourCVal);
			if(tmppVal == -10) {
				tmppVal = contourType;				
			}
			
			_level0.WMSMAP[testClipName].onRollOver = function () {
				_level0.WMSMAP.createTextField("tmpBox", 300,_level0.WMSMAP._xmouse, _level0.WMSMAP._ymouse, 60,40);
				_level0.WMSMAP.tmpBox.multiline = true;
				_level0.WMSMAP.tmpBox.wordWrap = true;
				_level0.WMSMAP.tmpBox.border = false;				
				//_level0.WMSMAP.tmpBox.backgroundColor = 0xFFFFFF;
				var myformat = new TextFormat();
				myformat.color = 0xFFFFFF;
				myformat.bullet = false;
				myformat.underline = false;
				myformat.bold = true;
				var tmpCVal1 = this.getCVal();

				_level0.WMSMAP.tmpBox.text =  tmppVal;
				_level0.WMSMAP.tmpBox.setTextFormat(myformat);					
				_level0.WMSMAP.tmpBox._visible = true;				
				
			}
			
			_level0.WMSMAP[testClipName].onRollOut = function () {
											   
			}

			_level0.WMSMAP[testClipName].lineStyle(contourThickness,contourColor,contourFillAlpha);
			var i;
			var dotLine = 0;
			var startStat = 0;
			var lastGoodPoint = new Array(2);
			var firstGoodPoint = new Array(2);
			var pointCount = 0;
			for(i=0;i<pointArray.length;i++) {						
				var tmpScaleArray = new Array(2);		
				var nextScaleArray = new Array(2);
				tmpScaleArray = parseBbox(pointArray[i][1], pointArray[i][0]);
				nextScaleArray = parseBbox(pointArray[i+1][1], pointArray[i+1][0]);
			if((tmpScaleArray[0] > Stage.width) || (tmpScaleArray[0] < 0) || tmpScaleArray[1] > Stage.height || (tmpScaleArray[1] < 0)) {
				if(contourFillType == 1) {
					if(i == pointArray.length -1) {
						if(pointCount < 3) {
							_level0.WMSMAP[testClipName].removeMovieClip();
						}
						else {							
							_level0.WMSMAP[testClipName].lineTo(firstGoodPoint[0],firstGoodPoint[1]);	
							_level0.WMSMAP[testClipName].endFill();							
						}
					}
				}
			}
			else {
				if(i==0 || startStat == 0) {			
					lastGoodPoint = tmpScaleArray;		
					firstGoodPoint = tmpScaleArray;		
					_level0.WMSMAP[testClipName].moveTo(tmpScaleArray[0],tmpScaleArray[1]);		
					pointCount ++;
					if(contourFillType == 1) {
						_level0.WMSMAP[testClipName].beginFill(contourFillColor, contourFillAlpha);						
					}
					startStat = 1;
				}//if(i==0)
				else
				{				
					lastGoodPoint = tmpScaleArray;
					_level0.WMSMAP[testClipName].lineTo(tmpScaleArray[0],tmpScaleArray[1]);	
					startStat = 1;
					pointCount ++;
					if(contourFillType == 1) {
						if(i == pointArray.length-1) {
							if(tmpScaleArray[0] != firstGoodPoint[0] || tmpScaleArray[1] != firstGoodPoint[1]) {
								_level0.WMSMAP[testClipName].lineTo(firstGoodPoint[0],firstGoodPoint[1]);								
							}
							_level0.WMSMAP[testClipName].endFill();
						}
					}
				} //else
				_level0.WMSMAP[testClipName]._visible = true;
			}
		}//for(i=0;i<pointArray.length;i++)
	} //public function drawContour(tmpDepth):Void

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
			var XMin = Number(parsebox[0]);
			var YMin = Number(parsebox[1]);
			var XMax = Number(parsebox[2]);
			var YMax = Number(parsebox[3]);
			delete parsebox;
			
			//then you calculate the map coordinate to pixel ratio:
			var xscale = _level0.WMSMap.width/(XMax-XMin);
			var yscale = _level0.WMSMap.height/(YMax-YMin);
			
			parseBoxArray[0] = (tmpX-XMin)*xscale;
			parseBoxArray[1] = (YMax-tmpY)*yscale;
			
			return parseBoxArray;			
		}
		
}; //END CONTOUR CLASS

