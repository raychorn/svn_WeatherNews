// AnimationFrameClass.as
//Programmer: Travis Martin, Weathernews America's Inc.
// class definition
class AnimationFrameClass extends MovieClip {
	//public variables
	public var frameID:String;
	public var frameURL:String;
	public var frameFullURL:String;
	public var frameMovie:MovieClip;
	public var frameDesc:String;
	public var frameSeqNum:Number;
	public var frameMapName:String;
	public var frameBbox:String;
	public var frameLayerArray:Array;
	public var frameWidth:Number;
	public var frameHeight:Number;
	public var frameImageType:String;
	public var frameDay:Number;
	public var frameMonth:Number;
	public var frameYear:Number;
	public var frameTime:Number;
	public var frameSimpleDateTime:String;
	public var frameTargetName:String;
	public var frameVisible:Boolean;
	public var frameX:Number;
	public var frameY:Number;
	public var frameTimeString:String;
	
	//default constructor
	public function AnimationFrameClass(tmpFrameID) {
		frameID = tmpFrameID;
	}
	public function setFrameUrl(tmpFrameURL):Void {
		frameURL = tmpFrameURL;
	}
	public function setFrameHeightWidth(tmpFrameHeightWidthArray):Void {
		//_level0.debugBox.text = _level0.debugBox.text+"[0]:"+tmpFrameHeightWidthArray[0]+"<br>";
		//_level0.debugBox.text = _level0.debugBox.text+"[1]:"+tmpFrameHeightWidthArray[1]+"<br>";
		var frameHeightWidthArray = new Array();
		frameHeightWidthArray = tmpFrameHeightWidthArray;
		frameWidth = frameHeightWidthArray[0];
		frameHeight = frameHeightWidthArray[1];
		//_level0.debugBox.text = _level0.debugBox.text+"Width:"+frameWidth+"<br>";
		//_level0.debugBox.text = _level0.debugBox.text+"Height:"+frameHeight+"<br>";
	}
	//public function setFrameDate(tmpFrameDay, tmpFrameMonth, tmpFrameYear, tmpFrameTime):Void {
	public function setFrameDate(tmpFrameDateArray):Void {
		var FrameDateArray = new Array;
		FrameDateArray = tmpFrameDateArray;
		frameTimeString = "";
		frameTimeString = frameTimeString+"  "+getFrameDateString(FrameDateArray[0], FrameDateArray[1], FrameDateArray[3], FrameDateArray[2], FrameDateArray[4]);
		if(FrameDateArray.length > 5) {
			frameTimeString = frameTimeString+"  "+getFrameDateString(FrameDateArray[5], FrameDateArray[6], FrameDateArray[8], FrameDateArray[7], FrameDateArray[9]);
		}
		if(FrameDateArray.length > 10) {
			frameTimeString = frameTimeString+"  "+getFrameDateString(FrameDateArray[10], FrameDateArray[11], FrameDateArray[13], FrameDateArray[12], FrameDateArray[14]);
		}
		if(FrameDateArray.length > 15) {
			frameTimeString = frameTimeString+"  "+getFrameDateString(FrameDateArray[15], FrameDateArray[16], FrameDateArray[18], FrameDateArray[17], FrameDateArray[19]);
		}
		if(FrameDateArray.length > 20) {
			frameTimeString = frameTimeString+"  "+getFrameDateString(FrameDateArray[20], FrameDateArray[21], FrameDateArray[23], FrameDateArray[22], FrameDateArray[24]);
		}
	}
	public function setFrameSimpleDateTime(tmpFrameSimpleDateTime):Void {
		frameSimpleDateTime = tmpFrameSimpleDateTime;
		frameTimeString = frameSimpleDateTime;
	}
	
	public function setFrameStatus(tmpFrameVisible):Void {
		frameVisible = tmpFrameVisible;
		_level0[frameTargetName]._visible = frameVisible;
		
	}
	public function getFrameStatus():Boolean {
		return frameVisible;
	}
	public function getFrameDateString(tmpFrameMonth, tmpFrameDay, tmpFrameTime, tmpFrameYear, tmpFrameTitle):String {		
		var frameDateString = tmpFrameTitle+" ";
		if(tmpFrameMonth < 10) {
			frameDateString=frameDateString+"0"+tmpFrameMonth;
		}
		else {
			frameDateString=frameDateString+"."+tmpFrameMonth;
		}
		if(tmpFrameDay < 10) {
			frameDateString=frameDateString+".0"+tmpFrameDay;
		}
		else {
			frameDateString=frameDateString+"."+tmpFrameDay;
		}
		frameDateString=frameDateString+"."+tmpFrameYear;
		if(tmpFrameTime < 1000) {
			if(tmpFrameTime < 100) {
				if(tmpFrameTime < 10) {
					frameDateString=frameDateString+":000"+tmpFrameTime;
				}
				else {
					frameDateString=frameDateString+":00"+tmpFrameTime;
				}
			}
			else {
				frameDateString=frameDateString+":0"+tmpFrameTime;
			}
		}
		else {
			frameDateString=frameDateString+":"+tmpFrameTime+"GMT";
		}
		if(frameDateString == "undefined" || frameDateString == undefined) {
			frameDateString = "ERROR:"+frameURL;
		}
		return frameDateString;
	}
	public function getFrameDate():String {
		return frameTimeString;
	}
	public function setFrameMapName(tmpFrameMapName):Void {
		frameMapName = tmpFrameMapName;
	}
	public function setFrameBbox(tmpFrameBbox):Void {
		frameBbox = tmpFrameBbox;
	}
	public function setFrameLayerArray(tmpFrameLayerArray):Void {
		frameLayerArray = tmpFrameLayerArray.split(",");
	}
	public function setFrameWidthHeight(tmpFrameWidth, tmpFrameHeight):Void {
		frameWidth = tmpFrameWidth;
		frameHeight = tmpFrameHeight;
	}
	public function setFrameImageType(tmpFrameImageType):Void {
		frameImageType = tmpFrameImageType;
	}
		
	//public functions
	public function setFrameID(tmpFrameID, tmpFrameSeqNum):Void {
		frameID = tmpFrameID;
		frameSeqNum = tmpFrameSeqNum;
	}
	public function getFrameTargetName():String {
		return frameTargetName;
	}
	public function showFrameTest():Void {
		frameLayerArray.join(",");
		var testURL = frameURL+"wms/wms.asp?WMS="+frameMapName+"&VERSION=1.1.0&REQUEST=GetMap&SRS=EPSG:4326&BBOX="+frameBbox+"&WIDTH="+frameWidth+"&HEIGHT="+frameHeight+"&FORMAT="+frameImageType+"&BGCOLOR=0xFFFFFF&EXCEPTIONS=INIMAGE&WRAPDATELINE=TRUE&LAYERS=";
		testURL = testURL+frameLayerArray.join(",");
		testURL = testURL+"&TRANSPARENT=TRUE";	
		frameTargetName = "frame"+frameSeqNum;
		_level0.createEmptyMovieClip(frameTargetName, (frameSeqNum+10));	
		_level0[frameTargetName]._xscale = _level0.scaleValueWidth;
		_level0[frameTargetName]._yscale = _level0.scaleValueHeight;
		
		frameFullURL = testURL;
		
		_level0.debugBox.text = _level0.debugBox.text+frameFullURL+"<br>";
		
		_level0[frameTargetName].loadMovie(testURL);
		_level0[frameTargetName]._x = 0;
		_level0[frameTargetName]._y = 0;
		//_level0[frameTargetName]._xscale = 800;
		//_level0[frameTargetName]._yscale = 600;
		setFrameStatus(false);
	}
	//private functions
	private function initialize():Void {
		
	}	
	
} //end AnimationFrameClass