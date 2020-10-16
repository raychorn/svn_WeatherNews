// AnimationClass.as
//Programmer: Travis Martin, Weathernews America's Inc.
// class definition
class AnimationClass extends MovieClip {
	//public variables
	public var clipID:String;
	public var frameList:Array;	
	public var animationSpeed:Number;
	public var layerString:String;
	public var layerArray:Array;
	public var baseURL:String;
	public var mapName:String;
	public var bBox:String;
	public var aniSpeed:Number;
	public var cSize:Array;
	
	//private variables
	
	//default constructor
	public function AnimationClass(tmpClipID) {
		clipID = tmpClipID;
		initialize();
	}

	//public functions
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function testFrame():Void {
		
		//layerArray[i].showFrameTest
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function setBaseURL(tmpBaseURL):Void {
		baseURL = tmpBaseURL;
	}
	
	public function setContainerSize(tmpCSize):Void {		
		cSize = tmpCSize.split(",");		
	}	
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function setAniSpeed(tmpAniSpeed):Void {
		aniSpeed = tmpAniSpeed;
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function setMapName(tmpMapName):Void {
		mapName = tmpMapName;
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function setbBox(tmpBbox):Void {
		bBox = tmpBbox;
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function playMovie(timerValue):Void {
		
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function loadFrames(tmpLayerArray, tmpTimeArray):Number {
		
		layerArray = tmpLayerArray; 
		var i;
		i = 1;
		var errorCheck = -1;
		var x = 0;
		frameList = new Array;

		//This for loop builds the individual frames and loads them into an array of frames
		for(x=0;x<layerArray.length;x++) {		
			var layerSubArray = layerArray[x];
			var frameOBJ = new AnimationFrameClass();
			frameOBJ.setFrameID("testFrame", x);		
			frameOBJ.setFrameUrl(baseURL);
			//Expand the below to pass the array instead of the individual time
			frameOBJ.setFrameSimpleDateTime(tmpTimeArray[x]);
			frameOBJ.setFrameBbox(bBox);

			frameOBJ.setFrameHeightWidth(cSize);
			frameOBJ.setFrameImageType("JPEG");
			frameOBJ.setFrameLayerArray(layerSubArray);
			frameOBJ.setFrameMapName(mapName);			
			frameList[x] = frameOBJ;
			frameOBJ.showFrameTest();
			_level0.createTextField("timeBox",505,0,(Stage.height-20),(Stage.width-_level0.controller3._width),20);		
			//_level0.timeBox._xscale = _level0.scaleValueWidth;
			_level0.timeBox._yscale = _level0.scaleValueHeight;
			_level0.timeBox._y = Stage.height - _level0.timeBox._height;
			_level0.blackRect._x = 0;
			_level0.blackRect._y = _level0.timeBox._y;
			_level0.blackRect._height = _level0.timeBox._height;
			_level0.blackRect._width = Stage.width;
			_level0.blackRect.swapDepths(504);
			_level0.blackRect._alpha = 100;
			_level0.timeBox.textColor = 0xffffff;
			_level0.timeBox.font = "Arial";
			_level0.timeBox.size = 8;
			
			if(x == layerArray.length-1) {
				frameOBJ.setFrameStatus(true);
				_level0.timeBox.text = frameOBJ.getFrameDate();		
			} 
			else {
				frameOBJ.setFrameStatus(false);
			}
			//_level0.loading1.unloadMovie();
			errorCheck = 1;
		}
		return errorCheck;
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function playAnimation():Void {		
		try {	
			//Below switch manages the time in between image frames.			
			switch(aniSpeed) {
				case 1:
					//animationViewer/
					_level0.createEmptyMovieClip("timerClip4", 2);
					_level0.timerClip4._x = -20;
					_level0.timerClip4._visible = false;
					_level0.timerClip4.loadMovie("flash/animationViewer/timer4.swf"); 
					break;				
				case 2:
					_level0.createEmptyMovieClip("timerClip3", 2);
					_level0.timerClip3._x = -20;
					_level0.timerClip3._visible = false;
					_level0.timerClip3.loadMovie("flash/animationViewer/timer3.swf"); 					
					break;				
				case 3:
					_level0.createEmptyMovieClip("timerClip1", 2);
					_level0.timerClip1._x = -20;
					_level0.timerClip1._visible = false;
					_level0.timerClip1.loadMovie("flash/animationViewer/timer1.swf");					
					break;				
				case 4:
					_level0.createEmptyMovieClip("timerClip1", 2);
					_level0.timerClip1._x = -20;
					_level0.timerClip1._visible = false;
					_level0.timerClip1.loadMovie("flash/animationViewer/timer1.swf");					
					break;			
				case 5:
					_level0.createEmptyMovieClip("timerClip05", 2);
					_level0.timerClip05._x = -20;
					_level0.timerClip05._visible = false;
					_level0.timerClip05.loadMovie("flash/animationViewer/timer05.swf");						
					break;	
				case 6:
					_level0.createEmptyMovieClip("timerClip25", 2);
					_level0.timerClip25._x = -20;
					_level0.timerClip25._visible = false;
					_level0.timerClip25.loadMovie("flash/animationViewer/timer25.swf");		
					break;
				default:
					_level0.createEmptyMovieClip("timerClip1", 2);
					_level0.timerClip1._x = -20;
					_level0.timerClip1._visible = false;
					_level0.timerClip1.loadMovie("flash/animationViewer/timer1.swf");		
					break;	
			}
			
  		}
  		catch (errObject:Error) {   
    		//_level0.debugBox.text = _level0.debugBox.text+"An error occurred: " + errObject.message + "<BR>";
  		}		
		for(var i=0;i<frameList.length;i++) {					
			if(frameList[i].getFrameStatus() == true) { 			
				if(i > frameList.length-2) {					
					frameList[0].setFrameStatus(true);	
					_level0.timeBox.text = frameList[0].getFrameDate();		
				}
				else {
					frameList[i+1].setFrameStatus(true);
					_level0.timeBox.text = frameList[i+1].getFrameDate();		
				}				
				frameList[i].setFrameStatus(false);		
				break;
			}
			else {
				if(i == (frameList.length -1) && frameList[i].getFrameStatus() == false) {
					frameList[0].setFrameStatus(true);
					_level0.timeBox.text = frameList[0].getFrameDate();		
				}
			}
		}
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function stopAnimation():Void {
			var activeFrame = -1;
			for(var i=0;i<frameList.length;i++) {				
				frameList[i].setFrameStatus(false);
			}	
			frameList[0].setFrameStatus(true);
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function pauseAnimation():Void {
		
		
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function stepForward():Void {
			var activeFrame = -1;
			for(var i=0;i<frameList.length;i++) {				
				if(frameList[i].getFrameStatus() == true) {
					activeFrame = i;
				}
				frameList[i].setFrameStatus(false);
			}			
			if(activeFrame == frameList.length -1) {
			 	frameList[0].setFrameStatus(true);
				_level0.timeBox.text = frameList[0].getFrameDate();		
			}
			else {
				frameList[activeFrame+1].setFrameStatus(true);		
				_level0.timeBox.text = frameList[activeFrame+1].getFrameDate();		
			}			
			frameList[activeFrame].setFrameStatus(false);
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	public function stepBackward():Void {
			var activeFrame = -1;
			for(var i=0;i<frameList.length;i++) {				
				if(frameList[i].getFrameStatus() == true) {
					activeFrame = i;
				}
				frameList[i].setFrameStatus(false);
			}			
			if(activeFrame < 1) {
			 	frameList[frameList.length - 1].setFrameStatus(true);
				_level0.timeBox.text = frameList[frameList.length - 1].getFrameDate();		
			}
			else {
				frameList[activeFrame-1].setFrameStatus(true);		
				_level0.timeBox.text = frameList[activeFrame-1].getFrameDate();		
			}			
			frameList[activeFrame].setFrameStatus(false);
	}
	//private functions
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	private function initialize():Void {
		
	}
	//*********************************************
	//Function:
	//Description:
	//
	//
	//*********************************************
	//Why is the below private?  What was my logic?
	private function setSpeed(tmpSpeed):Number {
		var errorCheck = "OK";
		animationSpeed = tmpSpeed;
		return errorCheck;		
	}
	
	
	
	
} //end AnimationClass