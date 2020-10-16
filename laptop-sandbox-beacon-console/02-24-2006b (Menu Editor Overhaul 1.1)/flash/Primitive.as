//Primitive.as

	class Primitive {
		
		//Public Variables
		public var pointArray:Array;
		public var primitiveType:String;
		public var primitiveThickness:Number;
		public var primitiveColor:String;
		public var primitiveFillColor:String;
		public var primitiveFillAlpha:Number;
		public var primitiveFillType:Number;
		public var primitiveCVal:Number;
		public var clipName:String;		
		public var className:String;		
		public var primitiveHand:Number;
	
		//Default Constructor
		public function Primitive() {			
			pointArray = new Array;			
			primitiveType = "error"; //normal type
			primitiveColor = "0xA7FF58";
			primitiveFillColor = "0xFF0000";
			primitiveFillAlpha = 100;
			primitiveThickness = 2;
			primitiveFillType = 0;
			primitiveCVal = -10;
			primitiveHand = 0; //Right
			clipName = "primitiveClip1";
			
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
			primitiveColor = tmpColorString;
		}
		public function setFillColor (tmpColorString):Void {
			primitiveFillColor = tmpColorString;
		}
		public function setFillAlpha (tmpAlpha):Void {
			primitiveFillAlpha = tmpAlpha;
		}
		public function setPrimitiveHand (tmpHand):Void {
			primitiveHand = tmpHand;
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
			primitiveCVal = tmpCVal;
		}
		public function getCVal ():Number {
			return primitiveCVal;
		}
		public function setThickness (tmpprimitiveThickness):Void {
			primitiveThickness = tmpprimitiveThickness;
		}
		public function setPrimitiveType (tmpPrimitiveType):Void {
			primitiveType = tmpPrimitiveType;			
		}
		public function getPrimitiveType ():String {
			return primitiveType;			
		}
		public function setFillType (tmpFillType):Void {
			primitiveFillType = tmpFillType;
		}
		public function getFillType ():Number {
			return primitiveFillType;			
		}
		public function getPoint (tmpposition):String {
			var pointString = new String;
			pointString = pointArray[tmpposition][0]+","+pointArray[tmpposition][1] ;
			return pointString;
  		}
		public function drawPrimitive(tmpDepth):Void {		
			//_level0.textBoxTest.text = _level0.textBoxTest.text+primitiveType;
			if(_level0[clipName] != undefined) {
					_level0[clipName].removeMovieClip();
			}
			var testClipName = clipName+"tt";
			var testClipID = clipName+tmpDepth;
			_root.WMSMap.attachMovie("SymbolClip", testClipName, tmpDepth);
			var tmppVal = Math.round(primitiveCVal);
			if(tmppVal == -10) {
				tmppVal = primitiveType;				
			}
			
			_level0.WMSMAP[testClipName].onRollOver = function () {
				_level0.WMSMAP.createTextField("tmpBox", 300,_level0.WMSMAP._xmouse, _level0.WMSMAP._ymouse, 60,40);
				_level0.WMSMAP.tmpBox.multiline = true;
				_level0.WMSMAP.tmpBox.wordWrap = true;
				_level0.WMSMAP.tmpBox.border = false;				
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

			_level0.WMSMAP[testClipName].lineStyle(primitiveThickness,primitiveColor,primitiveFillAlpha);
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
				if(primitiveFillType == 1) {
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
					if(primitiveFillType == 1) {
						_level0.WMSMAP[testClipName].beginFill(primitiveFillColor, primitiveFillAlpha);						
					}
					startStat = 1;
				}//if(i==0)
				else
				{				
					lastGoodPoint = tmpScaleArray;
					_level0.WMSMAP[testClipName].lineTo(tmpScaleArray[0],tmpScaleArray[1]);	
					startStat = 1;
					pointCount ++;
					if(primitiveFillType == 1) {
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
	} //public function drawPrimitive(tmpDepth):Void

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

