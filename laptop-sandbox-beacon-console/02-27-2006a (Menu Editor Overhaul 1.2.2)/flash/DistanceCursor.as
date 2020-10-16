//ComplexPoly.as

	class DistanceCursor extends MovieClip {
		
		//Public Variables
		public var DC_Symbol:String;
		public var DC_ClipName:String;
		public var DC_ClipName1:String;
		public var DC_ClipName2:String;
		public var DC_ClipName3:String;
		public var DC_ClipName4:String;	
		public var DC_ClipName5:String;
		public var DC_ClipName6:String;
		public var DC_ClipName7:String;
		public var DC_ClipName8:String;		
		public var DC_BaseColor:String;
		public var DC_ExtColor1:String;
		public var DC_ExtColor2:String;
		public var DC_ExtColor3:String;
		public var DC_ExtColor4:String;
		public var DC_LineColor:String;
		public var DC_Labels:Array;
		public var DC_LineThickness:Number;
		public var DC_Alpha:Number;
		public var DC_Depth:Number;
		public var DC_CenterX:Number;
		public var DC_CenterY:Number;
		
		//Private Variables
		public var DC_Width:Number;
		public var DC_Height:Number;
	
		//Default Constructor
		public function DistanceCursor() {		
			DC_Symbol = "Graphic_Rings";
			DC_LineColor = "0x000000";
			DC_ClipName = "someCursor";
			DC_LineThickness = 1;	
			DC_Alpha = 100;
			DC_ClipName = "Default";
			DC_ClipName1 = DC_ClipName+"_1";
			DC_ClipName2 = DC_ClipName+"_2";
			DC_ClipName3 = DC_ClipName+"_3";
			DC_ClipName4 = DC_ClipName+"_4";
			DC_ClipName5 = DC_ClipName+"_5";
			DC_ClipName6 = DC_ClipName+"_6";
			DC_ClipName7 = DC_ClipName+"_7";
			DC_ClipName8 = DC_ClipName+"_8";
			DC_CenterX = 200;
			DC_CenterY = 200;
			
			DC_Depth = 1200;
			//_level0.debugBox.text = _level0.debugBox.text+"ComplexPoly called";
		}		
		
		//****************************************		
		//Public Functions	
		//****************************************
		public function setClipName(tmpClipName):Void {
			DC_ClipName = tmpClipName;
		}
		public function setAlpha(tmpAlph):Void {
			DC_Alpha = tmpAlph;
		}
		public function setDepth(tmpDepth):Void {
			DC_Depth = tmpDepth;
		}
		public function setCenter(tmpX, tmpY):Void {
			DC_CenterX = tmpX;
			DC_CenterY = tmpY;
		}
		public function setColor(tmpColor):Void {
			DC_LineColor = tmpColor;			
		}
		public function setLineThickness(tmpThick):Void {
			DC_LineThickness = tmpThick;
		}
				
		public function drawDistanceCursor():Void {

			var parsebox = _level0.WMSMap.BBox.split(",");			
			var XMin = Number(parsebox[0]);
			var YMin = Number(parsebox[1]);
			var XMax = Number(parsebox[2]);
			var YMax = Number(parsebox[3]);
			var crossDist = (_level0.WMSMap.GeoDistance(XMin, YMin, XMax, YMax))/1609;
			var stageDist = Math.sqrt((Stage.width)*(Stage.width)+(Stage.height)*(Stage.height));
			var ratioCrossMovie = stageDist/crossDist;
			//_level0.debugBox.text = _level0.debugBox.text+"Cross Distance: "+(crossDist)+" Miles";
			//_level0.debugBox.text = _level0.debugBox.text+" Movie Distance: "+(stageDist)+" pixels";
			//_level0.debugBox.text = _level0.debugBox.text+" pixel/mile: "+(ratioCrossMovie);
			
			drawCircle(DC_ClipName, (150*ratioCrossMovie), 0, "0x000000", 1, DC_CenterX, DC_CenterY);
			drawCircle(DC_ClipName1, (125*ratioCrossMovie), 2, "0xFFFF00", 0, DC_CenterX, DC_CenterY);
			drawCircle(DC_ClipName2, (100*ratioCrossMovie), 4, "0xFFFF00", 0, DC_CenterX, DC_CenterY);
		  	drawCircle(DC_ClipName3, (75*ratioCrossMovie), 6, "0xFFFF00", 0, DC_CenterX, DC_CenterY);
			drawCircle(DC_ClipName4, (50*ratioCrossMovie), 8, "0xFFFF00", 0, DC_CenterX, DC_CenterY);
		  	drawCircle(DC_ClipName5, (40*ratioCrossMovie), 10, "0xFFFF00", 0, DC_CenterX, DC_CenterY);
		  	drawCircle(DC_ClipName6, (30*ratioCrossMovie), 12, "0xFFFF00", 0, DC_CenterX, DC_CenterY);
		  	drawCircle(DC_ClipName7, (20*ratioCrossMovie), 14, "0xFFFF00", 0, DC_CenterX, DC_CenterY);
			drawCircle(DC_ClipName8, (10*ratioCrossMovie), 16, "0xFFFF00", 0, DC_CenterX, DC_CenterY);			
			
			
			if(ratioCrossMovie < .7) {
				labelCircle(DC_ClipName, (150*ratioCrossMovie), 1, "0x000000", DC_CenterX, DC_CenterY, 150);
			}
			else if(ratioCrossMovie < 1.1) {
				labelCircle(DC_ClipName, (150*ratioCrossMovie), 1, "0x000000", DC_CenterX, DC_CenterY, 150);
				labelCircle(DC_ClipName2, (100*ratioCrossMovie), 5, "0x000000", DC_CenterX, DC_CenterY, 100);
				labelCircle(DC_ClipName4, (50*ratioCrossMovie), 9, "0x000000", DC_CenterX, DC_CenterY, 50);
				labelCircle(DC_ClipName8, (10*ratioCrossMovie), 17, "0x000000", DC_CenterX, DC_CenterY, 10);
			}			
			else {
				labelCircle(DC_ClipName, (150*ratioCrossMovie), 1, "0x000000", DC_CenterX, DC_CenterY, 150);
				labelCircle(DC_ClipName1, (125*ratioCrossMovie), 3, "0x000000", DC_CenterX, DC_CenterY, 125);	
				labelCircle(DC_ClipName2, (100*ratioCrossMovie), 5, "0x000000", DC_CenterX, DC_CenterY, 100);	
				labelCircle(DC_ClipName3, (75*ratioCrossMovie), 7, "0x000000", DC_CenterX, DC_CenterY, 75);	
				labelCircle(DC_ClipName4, (50*ratioCrossMovie), 9, "0x000000", DC_CenterX, DC_CenterY, 50);
				labelCircle(DC_ClipName5, (40*ratioCrossMovie), 11, "0x000000", DC_CenterX, DC_CenterY, 40);
				labelCircle(DC_ClipName6, (30*ratioCrossMovie), 13, "0x000000", DC_CenterX, DC_CenterY, 30);
				labelCircle(DC_ClipName7, (20*ratioCrossMovie), 15, "0x000000", DC_CenterX, DC_CenterY, 20);
				labelCircle(DC_ClipName8, (10*ratioCrossMovie), 17, "0x000000", DC_CenterX, DC_CenterY, 10);
			}
			
			
		} //drawDistanceCursor()
		
		
		public function killCursor() {
			_level0.debugBox.text = _level0.debugBox.text+"kill called";
			_level0.WMSMap[DC_ClipName].removeMovieClip();	
			_level0.WMSMap[DC_ClipName1].removeMovieClip();	
			_level0.WMSMap[DC_ClipName1+"a"].removeMovieClip();
			_level0.WMSMap[DC_ClipName2].removeMovieClip();
			_level0.WMSMap[DC_ClipName2+"a"].removeMovieClip();
			_level0.WMSMap[DC_ClipName3].removeMovieClip();
			_level0.WMSMap[DC_ClipName3+"a"].removeMovieClip();
			_level0.WMSMap[DC_ClipName4].removeMovieClip();
			_level0.WMSMap[DC_ClipName4+"a"].removeMovieClip()
			_level0.WMSMap[DC_ClipName5].removeMovieClip()
			_level0.WMSMap[DC_ClipName5+"a"].removeMovieClip()
			_level0.WMSMap[DC_ClipName6].removeMovieClip()
			_level0.WMSMap[DC_ClipName6+"a"].removeMovieClip()
			_level0.WMSMap[DC_ClipName7].removeMovieClip()
			_level0.WMSMap[DC_ClipName7+"a"].removeMovieClip()
			_level0.WMSMap[DC_ClipName8].removeMovieClip()
			_level0.WMSMap[DC_ClipName8+"a"].removeMovieClip()
			
		}
		
		//****************************************		
		//Private Functions	
		//****************************************	
		//**************************
		//Name: drawCircle
		//*************************
		private function drawCircle(clipName, tmpRadius, depthMult, lineColor, fillBin, tmpx, tmpy):Void {
			
			_level0.WMSMap.createEmptyMovieClip(clipName, DC_Depth+depthMult);			
			_level0.WMSMap[clipName].lineStyle(DC_LineThickness, lineColor, DC_Alpha);				
			
			var x = tmpx; // set our x for the center point of the circle
          	var y = tmpy; // set our y for the center point of the circle
          	var radius = tmpRadius; // radius is half of width so 100/2 = 50.
          	var theta = (45/180)*Math.PI; // each segment is 45 degrees, so convert to radians.
          	var ctrlRadius = radius/Math.cos(theta/2); // this gets the radius of the control point _root.lineStyle(1); // set our lineStyle
          	_level0.WMSMap[clipName].moveTo(x+radius, y); //we start the circle on the far right side.
			if(fillBin == 1) {
				_level0.WMSMap[clipName].beginFill(0xFF0000, 10);
			}
          	var angle = 0; // start drawing at angle 0;
          	// this loop draws the circle in 8 segments
          	for (var i = 0; i<8; i++) {
             	// increment our angles
                angle += theta;
                var angleMid = angle-(theta/2);
                // calculate our control point
                var cx = x+Math.cos(angleMid)*(ctrlRadius);
                var cy = y+Math.sin(angleMid)*(ctrlRadius);
                // calculate our end point
                var px = x+Math.cos(angle)*radius;
                var py = y+Math.sin(angle)*radius;
                // draw the circle segment
                _level0.WMSMap[clipName].curveTo(cx, cy, px, py);
				_level0.WMSMap[clipName].cName = clipName;
          }
		  if(fillBin == 1) {
			 _level0.WMSMap[clipName].endFill();
		  }
			
		} //drawCircle
		
		private function labelCircle(clipName, tmpRadius, depthMult, labelColor, tmpx, tmpy, tmpMiles):Void {
			//_level0.WMSMap.createTextField(
			var textFName = clipName+"a";
			_level0.WMSMap.createTextField(textFName,(DC_Depth+depthMult),((tmpx+tmpRadius)-10),tmpy,40,20);
			_level0.WMSMap[textFName].multiline = false;
			_level0.WMSMap[textFName].wordWrap =false;
			_level0.WMSMap[textFName].border = false;

			var myformat = new TextFormat();
			myformat.color = 0xffffff;
			myformat.bullet = false;
			myformat.underline = false;

			_level0.WMSMap[textFName].text = tmpMiles;
			_level0.WMSMap[textFName].setTextFormat(myformat);   
										   
			
		}
		
		
		//**************************
		//
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

