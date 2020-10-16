//**************************************************
//File: Object_XMLFUNCT.as
//Created: 07-07-05
//Description:
//	Handles the objects being passed for xml data 
//	display.
//
//**************************************************
var cursorState = "NULL";

var timeStampArray = new Array;
var masObjArray = new Array;
var MetarArr = new Array;
var TempArr = new Array;
var FlightRulesArr = new Array;
var windSpdArr = new Array;
var cTopsMotionArr = new Array;
var cTopsMotionArr2 = new Array;
var freezingArray = new Array;
var pressureArray = new Array;
var pirepsArr = new Array;
var metarLevel1 = new Array;
var tropoArray = new Array;
var tafArray = new Array;
//model surface temps
var temp00Array = new Array;
var temp12Array = new Array;
var temp24Array = new Array;
var temp36Array = new Array;
var temp48Array = new Array;

//model FL200 temps
var temp200_00Array = new Array;
var temp200_12Array = new Array;
var temp200_24Array = new Array;
var temp200_06Array = new Array;
var temp200_18Array = new Array;

//model FL250 temps
var temp250_00Array = new Array;
var temp250_12Array = new Array;
var temp250_24Array = new Array;
var temp250_06Array = new Array;
var temp250_18Array = new Array;

//model FL300 temps
var temp300_00Array = new Array;
var temp300_12Array = new Array;
var temp300_24Array = new Array;
var temp300_06Array = new Array;
var temp300_18Array = new Array;

//model pressure
var pres_00Array = new Array;
var pres_12Array = new Array;
var pres_24Array = new Array;
var pres_48Array = new Array;

//Fronts
var hilo_00Array = new Array;
var bump_00Array = new Array;
var front_00Array = new Array;

//Poly Test
var ptest_00Array = new Array;

//Turbulence
var turb_Array = new Array;

//Convection
var cnvc_Array = new Array;

//SIGMET
var sigmet_Array = new Array;

//AIRMET
var airmet_Array = new Array;

//*****************
//Function:  ObjResult(functionToRun)
//Description:
//		Handles the result object
//		recieved from the CF call by
//		building new objects containing
//		the passed form CF object and
//		then sending them off to be added
//		to the display
//*****************
function ObjResult(functionToRun) {
	//receives data returned from the method
	this.onResult = function(ObjResult)
	{
		//_level0.WMSMap.loading.removeMovieClip();		
		switch(functionToRun) {
			case 1: 
				//_level0.debugBox.text = _level0.debugBox.text+"BBOX:"+_level0.WMSMap.BBox+"<br>";
				//Metars/Winds/Flight Rules/Temps				
				for(k=0;k<MetarArr.length;k++) {
					MetarArr[k] = NULL;				
					FlightRulesArr[k] = NULL;				
					windSpdArr[k] = NULL;
					TempArr[k] = NULL;
					
				}
				
				//creating a new object to be used to store the passed in object from CF
				var resultOBJ = new Object;
				var queryOBJ = new Object;
				var mapLayerArray = new Array;
				var resultString;
				var someTestInt;

				//Assigning the new object to that which was passed from CF
				resultOBJ = ObjResult;
				queryOBJ = resultOBJ.METAR;
				resultString = resultOBJ.MAPLAYERS;
				//_level0.debugBox.text = _level0.debugBox.text+"Length:"+resultOBJ.METAR.length+"<br>";
				if(resultOBJ.METAR.length == 0 || resultOBJ.METAR.length == undefined) { 
					_level0.WMSMap.loading.removeMovieClip();	
					toggleTools(true);
					break; 
				}
				//someTestInt = queryObj.NUMRECORDS;
				//if(someTestInt <= 0) {
					//Debugging
					var MAXobj = 10000;
					var loopCount;				
					if(resultOBJ.METAR.length > MAXobj) {
						loopCount = MAXobj;
					}
					else if(resultOBJ.METAR.length < MAXobj && resultOBJ.METAR.length > 0) {
						loopCount = resultOBJ.METAR.length;
					}
					else {
	
						break;
					}
	
					var metarStatus = 0;
					var frStatus = 0;
					var windStatus = 0;
					var tempStatus = 0;
					for(k = 0; k < fullLayerList.length; k++) {
						if(fullLayerList[k] == 102) {
							metarStatus = 1;
							//_level0.debugBox.text = _level0.debugBox.text+"metarStatus"+metarStatus+"<br>";
						}
						if(fullLayerList[k] == 106) {
							frStatus = 1;
						} 
						if(fullLayerList[k] == 107) {
							windStatus = 1;
						}
						if(fullLayerList[k] == 114) {
							tempStatus = 1;
						}
						
					} //for(k=0;k<tmpLayerArray.length;k++) {
					if(metarStatus == 0) { removeLayerDisplayed(102); }
					if(frStatus == 0) { removeLayerDisplayed(106); }
					if(windStatus == 0) { removeLayerDisplayed(107); }
					if(tempStatus == 0) { removeLayerDisplayed(114); }
						
					for(i=0;i<loopCount;i++) {							
						//should check to see if it is a metar or/and flight rules
						if(metarStatus == 1) {
							//_level0.debugBox.text = _level0.debugBox.text+resultOBJ.METAR.items[i].lat+","+resultOBJ.METAR.items[i].lon+"<br>";
							MetarArr[i] = new DataPoint(1);	
							MetarArr[i].addPoint(resultOBJ.METAR.items[i].lat, resultOBJ.METAR.items[i].lon);
							MetarArr[i].setIDClip(resultOBJ.METAR.items[i].icaoID);
							MetarArr[i].addRawMsg(resultOBJ.METAR.items[i].rawMsg);
							MetarArr[i].addOTime(resultOBJ.METAR.items[i].oTime);
							MetarArr[i].addWspd(-1);
							MetarArr[i].addWdir(-1);
							MetarArr[i].setAlpha(80);
							MetarArr[i].setAlphaOnMouseOver(100);
							MetarArr[i].setSymbol("GraphicYellowCircle");
							MetarArr[i].setDepth(100+i);
							MetarArr[i].setSize(10);
							MetarArr[i].drawPoint();
						}
						if(tempStatus == 1) {
							TempArr[i] = new DataPoint(3);	
							TempArr[i].addPoint(resultOBJ.METAR.items[i].lat, resultOBJ.METAR.items[i].lon);
							var tmpID = resultOBJ.METAR.items[i].icaoID+"temp";
							TempArr[i].setIDClip(tmpID);
							TempArr[i].addRawMsg(resultOBJ.METAR.items[i].rawMsg);
							TempArr[i].addOTime(resultOBJ.METAR.items[i].oTime);
							TempArr[i].addCtemp(resultOBJ.METAR.items[i].airTemp);
							TempArr[i].addWspd(-1);
							TempArr[i].addWdir(-1);						
							TempArr[i].setAlpha(100);
							TempArr[i].setAlphaOnMouseOver(100);
							TempArr[i].setSymbol("GraphicYellowCircle");
							TempArr[i].setDepth((loopCount*3)+i+100);
							TempArr[i].setSize(20);
							TempArr[i].drawPoint();
						}
						//should check to see if it is a metar or/and flight rules
						if(windStatus == 1) {
							windSpdArr[i] = new DataPoint(4);	
							windSpdArr[i].addPoint(resultOBJ.METAR.items[i].lat, resultOBJ.METAR.items[i].lon);
							var tmpID = resultOBJ.METAR.items[i].icaoID+"wind";
							windSpdArr[i].setIDClip(tmpID);
							windSpdArr[i].addRawMsg(resultOBJ.METAR.items[i].rawMsg);
							windSpdArr[i].addOTime(resultOBJ.METAR.items[i].oTime);
							windSpdArr[i].addWspd(resultOBJ.METAR.items[i].windSpd);
							windSpdArr[i].addWdir(resultOBJ.METAR.items[i].windDir);
							windSpdArr[i].addGustSpd(resultOBJ.METAR.items[i].gustSpd);
							windSpdArr[i].setAlpha(100);
							windSpdArr[i].setAlphaOnMouseOver(100);
							windSpdArr[i].setSymbol("GraphicWindBarbBlack");	
							windSpdArr[i].setDepth(100+loopCount+i);	
							var tmpBboxArray = new Array;
							tmpBboxArray = _level0.WMSMap.BBox.split(",");		
							if((Math.abs(tmpBboxArray[0]) - Math.abs(tmpBboxArray[3])) > 100) {
								windSpdArr[i].setSize(6);						
							}
							else { windSpdArr[i].setSize(12); }
							windSpdArr[i].drawPoint();
							windSpdArr[i].goRotate();
						}
						//This section derives the flight rules from the METARs
						if(frStatus == 1) {						
							FlightRulesArr[i] = new DataPoint(2);
							FlightRulesArr[i].addPoint(resultOBJ.METAR.items[i].lat, resultOBJ.METAR.items[i].lon);
							var tmpID = resultOBJ.METAR.items[i].icaoID+"fr";
							FlightRulesArr[i].setIDClip(tmpID);
							FlightRulesArr[i].addRawMsg(resultOBJ.METAR.items[i].rawMsg);
							FlightRulesArr[i].addOTime(resultOBJ.METAR.items[i].oTime);
							FlightRulesArr[i].addCldHgt(resultOBJ.METAR.items[i].cldHgt);
							FlightRulesArr[i].setSymbol("GraphicBlueCircle");
							FlightRulesArr[i].setAlpha(100);
							FlightRulesArr[i].setAlphaOnMouseOver(100);
							FlightRulesArr[i].setSize(8);	
							FlightRulesArr[i].addWspd(-1);
							FlightRulesArr[i].addWdir(-1)
							FlightRulesArr[i].addVsby(resultOBJ.METAR.items[i].vsby);					
							FlightRulesArr[i].addVertVsby(resultOBJ.METAR.items[i].vertVsby);	
							var calcVsby = (resultOBJ.METAR.items[i].vsby)/(1609.2);
							var visLevel;
							var cldLevel;
							var calcCldHgt = resultOBJ.METAR.items[i].cldHgt;							
							if(toUpperCase(resultOBJ.METAR.items[i].cldHgt) == "M") {
								 cldLevel = 5;
							}
							else if(toUpperCase(resultOBJ.METAR.items[i].cldHgt) == "UNL" || resultOBJ.METAR.items[i].cldHgt == -9999) {
								 cldLevel = 4;
							}						
							else {
								calcCldHgt = resultOBJ.METAR.items[i].cldHgt;
								//calcCldHgt = 5;
							}		
										
							if(calcVsby < 1 && calcVsby > 0) { //code magenta
								visLevel = 1;
							}
							else if (calcVsby > 1 &&  calcVsby < 3) { //code red
								visLevel = 2;
							}
							else if (calcVsby > 3 &&  calcVsby < 5) { //code blue
								visLevel = 3;
							}
							else if(calcVsby > 5) { //code green
								visLevel = 4;
							}					
							else {
								visLevel = 5; //code white
							}		
							if(cldLevel != 5 && cldLevel != 4) {
								if((calcCldHgt * 100) <= 500) {
									cldLevel = 1;
								}
								else if((calcCldHgt * 100) > 500 && (calcCldHgt * 100) <= 1000) {
									cldLevel = 2;
								}
								else if((calcCldHgt * 100) > 1000 && (calcCldHgt * 100) <= 3000) {
									cldLevel = 3;
								}
								else if((calcCldHgt * 100) > 3000 && calcCldHgt != 9999) {
									cldLevel = 4;
								}
								else  {
									
									cldLevel = 5;
								}
								
							} //if(cldLevel != 5)
							var alertLevel;
							if(visLevel < cldLevel) {
								alertLevel = visLevel;
							}
							else {
								alertLevel = cldLevel;
							}
							switch(alertLevel) {
								case 1:
									FlightRulesArr[i].setSymbol("GraphicPinkCircle");
								break;
								case 2:
									FlightRulesArr[i].setSymbol("GraphicRedCircle");
								break;
								case 3:
									FlightRulesArr[i].setSymbol("GraphicBlueCircle");
								break;
								case 4:
									FlightRulesArr[i].setSymbol("GraphicGreenCircle");
									FlightRulesArr[i].setAlpha(30);
								break;
								case 5:
									FlightRulesArr[i].setSymbol("GraphicWhiteDot");
									FlightRulesArr[i].setAlpha(30);
								break;
								default:
									FlightRulesArr[i].setSymbol("GraphicWhiteDot");
									FlightRulesArr[i].setAlpha(30);
								break;
							}
							
							FlightRulesArr[i].setDepth((loopCount*2)+i+100);
							FlightRulesArr[i].drawPoint();
						}					
					}		
				//} //end record check...
				_level0.WMSMap.loading.removeMovieClip();	
				toggleTools(true);
			break;
			case 2: 
				//Cell Tops/Motion
				cTopArr = new Array;
				cTopArr = ObjResult;
				for(i=0;i<cTopArr.length;i++) {
					cTopStruct = new Object;
					cTopStruct = cTopArr[i];
					var idString = "CTID"+i;			
					cTopsMotionArr[i] = new DataPoint(5);	
					cTopsMotionArr[i].addPoint(cTopStruct.CLAT, cTopStruct.CLON);					
					cTopsMotionArr[i].setIDClip(idString);
					cTopsMotionArr[i].addRawMsg("LAT/LON:"+cTopStruct.CLAT+","+cTopStruct.CLON+"TOP:"+cTopStruct.CTOP+"DIR:"+cTopStruct.CDIR+"SPD:"+cTopStruct.CSPEED);
					cTopsMotionArr[i].addOTime("CURRENT");
					cTopsMotionArr[i].addWspd(-1);
					cTopsMotionArr[i].addWdir(-1);
					cTopsMotionArr[i].addCTSpeed(cTopStruct.CSPEED);
					cTopsMotionArr[i].addCTDir(cTopStruct.CDIR);
					cTopsMotionArr[i].addCTTop(cTopStruct.CTOP);					
					cTopsMotionArr[i].setAlpha(100);
					cTopsMotionArr[i].setAlphaOnMouseOver(100);
					cTopsMotionArr[i].setSymbol("GraphicCellTopMotion");
					cTopsMotionArr[i].setDepth(1000+i);
					cTopsMotionArr[i].setSize(12);
					cTopsMotionArr[i].drawPoint();
					cTopsMotionArr[i].goRotate();
				}
				
				_level0.WMSMap.loading.removeMovieClip();	
				toggleTools(true);
			break;
			case 3:
				//PIREP layer
				pirepArr = new Object;
				queryObj = new Object;
				statusOBJ = new Object;
				var someTestInt;
				queryObj = ObjResult;				
				pirepArr = queryObj.PIREP;	
				
				//someTestInt = queryObj.NUMRECORDS;
				//if(someTestInt <= 0) {
					for(i=0;i<pirepArr.length;i++) {
						pirepsArr[i] = new DataPoint(6);	
						pirepsArr[i].addPoint(queryObj.PIREP.items[i].lat, queryObj.PIREP.items[i].lon);
						pirepsArr[i].addRawMsg(queryObj.PIREP.items[i].rawMsg);
						pirepsArr[i].setIDClip(queryObj.PIREP.items[i].flight+i);
						pirepsArr[i].addOTime(queryObj.PIREP.items[i].oTime);
						pirepsArr[i].addPFNum(queryObj.PIREP.items[i].flightLevel);
						pirepsArr[i].addWspd(-1);
						pirepsArr[i].addWdir(-1);					
						pirepsArr[i].setAlpha(100);
						pirepsArr[i].setAlphaOnMouseOver(100);
						var tmpTurbix = queryObj.PIREP.items[i].turbix;
						var tmpIcing = queryObj.PIREP.items[i].icing;
						var tmpRawString = queryObj.PIREP.items[i].rawMsg;
						pirepsArr[i].setSize(18);
						if(tmpRawString.indexOf("VASH", 0) != -1 || tmpRawString.indexOf(" VA ", 0) != -1 || tmpRawString.indexOf("ASH", 0) != -1 || tmpRawString.indexOf("Volcanic Ash", 0) != -1 || tmpRawString.indexOf("Volcano", 0) != -1 || tmpRawString.indexOf("Volc Ash", 0) != -1) {
							pirepsArr[i].setSymbol("GraphicAsh");						
						}
						else if(tmpTurbix == 7 || tmpTurbix == 8 || tmpTurbix == 9 ) {
							pirepsArr[i].setSymbol("GraphicTurbSvr");
						}					
						else if(tmpTurbix == "M" || tmpTurbix == 5 || tmpTurbix == 6 || (tmpIcing >= 40 && tmpIcing < 90)) {
							if(tmpTurbix == "M" || tmpTurbix == 5 || tmpTurbix == 6) {
								pirepsArr[i].setSymbol("GraphicTurbMdt");
							}
							else {
								pirepsArr[i].setSymbol("GraphicIceSvr");
							}
						}
						else  if(tmpTurbix == 1 || tmpTurbix == 2 || tmpTurbix == 3 || tmpTurbix == 4 ||(tmpIcing >= 30 && tmpIcing < 90)) {
							if(tmpIcing >= 30) {
								pirepsArr[i].setSymbol("GraphicIceMdt");
							}
							else {
								pirepsArr[i].setSymbol("GraphicTurbLgt");
							}
						}
						else if(tmpTurbix == 0 || (tmpIcing >= 20 && tmpIcing < 90)) {
							if(tmpIcing >= 20) {
								pirepsArr[i].setSymbol("GraphicIceLgt");
							}
							else {
								pirepsArr[i].setSymbol("GraphicTurbSmooth");
							}
						}
						else if(tmpTurbix == "NULL" || tmpTurbix == "" && tmpIcing < 10){
							pirepsArr[i].setSymbol("GraphicIceNone");
						}
						else {
							pirepsArr[i].setAlpha(30);
							pirepsArr[i].setSize(10);
							pirepsArr[i].setSymbol("GraphicBlackCircle");
						}
	
						
						pirepsArr[i].setDepth(900+i);
						
						pirepsArr[i].drawPoint();
						
						//pirepsArr[i].setIDClip(idString);
					}
				//} //end if
				_level0.WMSMap.loading.removeMovieClip();	
				toggleTools(true);
			break;
			case 4: 
				//Freezing Level
				freezeArr = new Array;
				freezeArr = ObjResult;	
				for(i=0;i<freezeArr.length;i++) {
					freezeStruct = new Object;
					freezeStruct = freezeArr[i];
					var tmpClipName = "line_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(freezeStruct.CVAL);
					if(freezeStruct.CVAL == 0) {
						testLineString.setColor("0x00CCFF");
						testLineString.setLineThickness(5);
					}
					testLineString.setDepth(1200+i);
					testLineString.peelPointsFromString(freezeStruct.STRINGOFPOINTS);			
					freezingArray[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();				
				toggleTools(true);
			break;
			case 5:
				//development only metar station grid
				metarLVL1Arr = new Object;
				queryObj = new Object;
				queryObj = ObjResult;
				metarLVL1Arr = queryObj.METAR;	
				for(i=0;i<metarLVL1Arr.length;i++) {
					metarLevel1[i] = new DataPoint(6);	
					var tmpCID = queryObj.METAR.items[i].icaoID+"_DEV";
					metarLevel1[i].addPoint(queryObj.METAR.items[i].stnLat, queryObj.METAR.items[i].stnLon);
					metarLevel1[i].setIDClip(tmpCID);
					metarLevel1[i].addWspd(-1);
					metarLevel1[i].addWdir(-1);					
					metarLevel1[i].setAlpha(100);
					metarLevel1[i].setAlphaOnMouseOver(100);					
					metarLevel1[i].setSymbol("GraphicRedCircle");					
					metarLevel1[i].setDepth(500+i);
					metarLevel1[i].setSize(4);
					metarLevel1[i].drawPoint();					 
				}
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
			break;
			case 6:
				pressureArr = new Array;
				pressureArr = ObjResult;				
				for(i=0;i<pressureArr.length;i++) {
					pressureStruct = new Object;
					pressureStruct = pressureArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+pressureStruct.ITIME+ " Valid:"+pressureStruct.VTIME+" -- SFC PRES";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfcpres_time";		
						popUpTime("sfcpres_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "press_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(pressureStruct.CVAL);
					testLineString.setColor("0x000000");
					testLineString.setLineThickness(1);
					testLineString.setAlpha(100);
					testLineString.setDepth(1500+i);
					testLineString.peelPointsFromString(pressureStruct.STRINGOFPOINTS);			
					pressureArray[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
			break;
			case 7:
				//Tropopause Height
				TropoArr = new Array;
				TropoArr = ObjResult;				
				for(i=0;i<TropoArr.length;i++) {
					TropoStruct = new Object;
					TropoStruct = TropoArr[i];			
					var tmpClipName = "tropo_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(TropoStruct.CVAL);
					testLineString.setColor("0xFFFFFF");
					testLineString.setDepth(1500+i);
					testLineString.peelPointsFromString(TropoStruct.STRINGOFPOINTS);			
					tropoArray[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();		
				toggleTools(true);
			break;
			case 8:
				//TAF Display
				tafLVL1Arr = new Object;
				queryObj = new Object;
				queryObj = ObjResult;
				tafLVL1Arr = queryObj.TAF;	
				//var someTestInt;
				//someTestInt = queryObj.NUMRECORDS;				
				//if(someTestInt <= 0) {				
					for(i=0;i<tafLVL1Arr.length;i++) {						
						tafArray[i] = new DataPoint(1);	
						var tmpCID = "TAF"+queryObj.TAF.items[i].icaoID;
						var tmpOrigin = queryObj.TAF.items[i].origin;
						tafArray[i].setOrigin(tmpOrigin);
						tafArray[i].addPoint(queryObj.TAF.items[i].lat, queryObj.TAF.items[i].lon);
						tafArray[i].addRawMsg(queryObj.TAF.items[i].rawMsg);
						tafArray[i].setIDClip(tmpCID);
						tafArray[i].addOTime(queryObj.TAF.items[i].iTime);
						tafArray[i].addWspd(-1);
						tafArray[i].addWdir(-1);					
						//tafArray[i].setAlpha(80);
						tafArray[i].setAlphaOnMouseOver(100);	
						if(tmpOrigin == "KWNI" || tmpOrigin == "kwni") {
							tafArray[i].setAlpha(90);
							tafArray[i].setSymbol("GraphicBlueSquare");	
							
						}
						else {
							tafArray[i].setAlpha(50);
							tafArray[i].setSymbol("GraphicBlueSquare");	
						}
						
						//tafArray[i].setSymbol("GraphicGreenCircle");					
						tafArray[i].setDepth(1600+i);
						tafArray[i].setSize(10);
						tafArray[i].drawPoint();					 
					} //for(i=0;i<tafLVL1Arr.length;i++)
				//} //end if
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
			break;
			case 9:
				//Load00SurfaceTemp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC TEMP 00Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfctemp0z_time";		
						popUpTime("sfctemp0z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "temp00_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("sfctemp0z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					
					
					//testLineString.setColor("0x3693B5");
					testLineString.setDepth(1500+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp00Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 10:
				//Load12SurfaceTemp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC TEMP 12Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfctemp12z_time";		
						popUpTime("sfctemp12z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "temp12_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("sfctemp12z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(1900+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp12Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 11:
				//Load24SurfaceTemp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC TEMP 24Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfctemp24z_time";		
						popUpTime("sfctemp24z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "temp24_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("sfctemp24z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2000+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp24Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 12:
				//Load36SurfaceTemp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC TEMP 36Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfctemp36z_time";		
						popUpTime("sfctemp36z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "temp36_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("sfctemp36z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2100+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp36Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 13:
				//Load48SurfaceTemp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC TEMP 48Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfctemp48z_time";		
						popUpTime("sfctemp48z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "temp48_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("sfctemp48z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2200+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp48Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 14:
				//FL200 00Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp200_00_"+i;	
					/*if(i == 0) {		
						//TESTAREA						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- FL200 TEMP 00Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "fl200_temp00z_time";		
						popUpTime("fl200_temp00z_time", tmpITime, "0x000000");										
					}			*/
					
					var testLineString = new LineString();
					//testLineString.setTimeString("fl200_temp00z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2300+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp200_00Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 15:
				//FL200 12Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					/*if(i == 0) {		
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- FL200 TEMP 12Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "fl200_temp12z_time";		
						popUpTime("fl200_temp12z_time", tmpITime, "0x000000");				
					}			*/		
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp200_12_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("fl200_temp12z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2400+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp200_12Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 16:
				//FL200 24Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					/* if(i == 0) {		
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- FL200 TEMP 24Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "fl200_temp24z_time";		
						popUpTime("fl200_temp24z_time", tmpITime, "0x000000");				
					}	*/	
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp200_24_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("fl200_temp24z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2500+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp200_24Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 17:
				//FL200 06Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					/*if(i == 0) {		
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- FL200 TEMP 06Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "fl200_temp06z_time";		
						popUpTime("fl200_temp06z_time", tmpITime, "0x000000");				
					}	*/
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp200_06_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("fl200_temp06z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2600+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp200_06Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 18:
				//FL200 18Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					/*if(i == 0) {		
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- FL200 TEMP 18Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "fl200_temp18z_time";		
						popUpTime("fl200_temp18z_time", tmpITime, "0x000000");				
					}*/
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp200_18_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("fl200_temp18z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2700+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp200_18Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 19:
				//FL250 00Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					/*
					if(i == 0) {		
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- FL250 TEMP 00Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "fl250_temp00z_time";		
						popUpTime("fl250_temp00z_time", tmpITime, "0x000000");				
					}
					*/
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp250_00_"+i;	
					var testLineString = new LineString();
					//testLineString.setTimeString("fl250_temp00z_time");
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2800+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp250_00Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 20:
				//FL250 12Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp250_12_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(2900+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp250_12Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 21:
				//FL250 24Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp250_24_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3000+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp250_24Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 22:
				//FL250 06Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp250_06_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3100+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp250_06Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 23:
				//FL250 18Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp250_18_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3200+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp250_18Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 24:
				//FL300 00Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp300_00_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3300+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp300_00Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 25:
				//FL300 12Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp300_12_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3400+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp300_12Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 26:
				//FL300 24Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp300_24_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3500+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp300_24Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 27:
				//FL300 06Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp300_06_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3600+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp300_06Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 28:
				//FL300 18Z Temp
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "temp300_18_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);
					if(LineStruct.CVAL <= -20) {
						testLineString.setColor("0x95D2FC");
					}
					else if(LineStruct.CVAL > -20 && LineStruct.CVAL <= -10) {						
						testLineString.setColor("0x9EC0E7");
					}
					else if(LineStruct.CVAL > -10 && LineStruct.CVAL <= 0) {						
						testLineString.setColor("0xABA7C8");
					}
					else if(LineStruct.CVAL > 0 && LineStruct.CVAL <= 10) {						
						testLineString.setColor("0xC07D97");
					}
					else if(LineStruct.CVAL > 10 && LineStruct.CVAL <= 12) {						
						testLineString.setColor("0xCF5E71");
					}
					else if(LineStruct.CVAL > 12 && LineStruct.CVAL <= 24) {						
						testLineString.setColor("0xDE404C");
					}
					else if(LineStruct.CVAL > 24 && LineStruct.CVAL <= 34) {						
						testLineString.setColor("0xEF2127");
					}
					else if(LineStruct.CVAL > 34 && LineStruct.CVAL <= 44) {						
						testLineString.setColor("0xFB080A");
					}
					else if(LineStruct.CVAL > 44 && LineStruct.CVAL <= 50) {						
						testLineString.setColor("0xFF0000");
					}
					else {						
						testLineString.setColor("0x000000");
					}
					testLineString.setDepth(3700+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					temp300_18Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 29:
				//00Z Pressure
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC PRES 00Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfcpres00z_time";		
						popUpTime("sfcpres00z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "pres_00_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);					
					testLineString.setColor("0x000000");					
					testLineString.setAlpha(100);
					testLineString.setLineThickness(1);
					testLineString.setDepth(3800+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					pres_00Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 30:
				//12Z Pressure
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC PRES 12Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfcpres12z_time";		
						popUpTime("sfcpres12z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "pres_12_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);					
					testLineString.setColor("0x000000");		
					testLineString.setLineThickness(1);
					testLineString.setAlpha(100);				
					testLineString.setDepth(3900+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					pres_12Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			case 31:
				//24Z Pressure
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					/*if(i == 0) {						
						tmpITime = "Issue: "+LineStruct.ITIME+ " Valid:"+LineStruct.VTIME+" -- SFC PRES 24Z";
						tsArrayCount = timeStampArray.length;
						timeStampArray[tsArrayCount] = "sfcpres24z_time";		
						popUpTime("sfcpres24z_time", tmpITime, "0x000000");
										
					}*/
					var tmpClipName = "pres_24_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);					
					testLineString.setColor("0x000000");		
					testLineString.setLineThickness(1);
					testLineString.setAlpha(100);				
					testLineString.setDepth(4000+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					pres_24Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			default:
				Status.text = "WARNING W9000:"+"No object specified";
				//_level0.debugBox.text = _level0.debugBox.text+error.description+"<br>";
				//Status.text = "ERROR 9000:"+error.description;
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				
			break;
			
		}//end switch
		
	}
	this.onStatus = function(error)
	{
		//Status.text = "ERROR: "+error.description;
		Status.text = "ERROR E9000:"+error.description;		
		//_level0.debugBox.text = _level0.debugBox.text+"ERROR E9000:"+error.description+"<br>";
		_level0.WMSMap.loading.removeMovieClip();
		toggleTools(true);
		toggleTools(true);
		return 0;
	}
	
} //end function ObjResult(functionToRun)

function FcstResult(functionToRun) {
	this.onResult = function(ObjResult)
	{
		switch(functionToRun) {
			case 1:
				//48Z Pressure				
				LineArr = new Array;
				LineArr = ObjResult;				
				for(i=0;i<LineArr.length;i++) {
					LineStruct = new Object;
					LineStruct = LineArr[i];
					var tmpClipName = "pres_48_"+i;	
					var testLineString = new LineString();
					testLineString.setClipName(tmpClipName);
					testLineString.setCval(LineStruct.CVAL);					
					testLineString.setColor("0x000000");		
					testLineString.setLineThickness(1);
					testLineString.setAlpha(100);					
					testLineString.setDepth(4100+i);
					testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
					pres_48Array[i] = testLineString;
				}				
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
			
				break;
			default:
				Status.text = "WARNING W9000:"+"No object specified";
				_level0.WMSMap.loading.removeMovieClip();
				toggleTools(true);
				break;
		} //end switch
	} //end onResult
	this.onStatus = function(error)
	{
		//Status.text = "ERROR: "+error.description;
		Status.text = "ERROR E9000:"+error.description;
		_level0.WMSMap.loading.removeMovieClip();
		toggleTools(true);
		return 0;
	} //end this.onStatus
} //end FcstResultfunctionToRun)

function ObjResult_v2(functionToRun) {
	//receives data returned from the method
	this.onResult = function(ObjResult)
	{
		switch(functionToRun) {
				case 1:
					for(i=0;i<bump_00Array.length;i++) {
						bump_00Array[i].hidePoint();
						bump_00Array[i].killPoint();			
					}
					
					//Fronts and Hi/Lo
					var FrontArr = new Array;
					var HiLoArr = new Array;
					var BumpArr = new Array;
					var queryObj = new Object;
					queryObj = ObjResult;				
					var tmpArrayCounter;
					FrontArr = queryObj.FRONTARRAY;
					HiLoArr = queryObj.HILOARRAY;	
					tmpArrayCounter = queryObj.ARRAYCOUNT;
					BumpArr = queryObj.BUMPARRAY;
					//_level0.debugBox.text = _level0.debugBox.text+"BumpArr.length:"+BumpArr.length+"<br>";
					for(i=0;i < BumpArr.length;i++) {
						var tmpBumpObj = new Object;
						tmpBumpObj = BumpArr[i];	
						var ptArray = new Array;
						ptArray = tmpBumpObj.SPANARRAY;
						tmpBumpCountNum = tmpBumpObj.COUNT;
						var pArrayCount = 0;
						var parsebox = _level0.WMSMap.BBox.split(",");			
						var XMin = Number(parsebox[0]);
						var YMin = Number(parsebox[1]);
						var XMax = Number(parsebox[2]);
						var YMax = Number(parsebox[3]);
						var crossDist = (_level0.WMSMap.GeoDistance(XMin, YMin, XMax, YMax))/1609;
						var spreadMult = 6;
						if(tmpBumpObj.TYPE == "trof" && crossDist < 1000) {
							spreadMult = 4;
						}
						else if(tmpBumpObj.TYPE == "trof" && crossDist > 1000) {
							spreadMult = 8;
						}
						else if(crossDist < 200) {
							spreadMult = 4;
						}
						else if (crossDist > 200 && crossDist < 500) {
							spreadMult = 10;
						}
						else if (crossDist >500 && crossDist < 1000) {
							spreadMult = 16;
						}
						else if (crossDist > 1000 && crossDist < 5000) {
							spreadMult = 42;
						}
						else if(crossDist > 5000) {
							spreadMult = 60;
						}
						var oddTracker = 0;						
						for(p=0;p < ptArray.length;p=p+spreadMult) {
						//for(p=0;p < ptArray.length;p++) {
							
							var tmpPtArray = new Array;
							tmpPtArray = ptArray[p];							
							bump_00Array[pArrayCount] = new DataPoint(8);	
							//var tmpCID = "BUMP00"+i+p+tmpPtArray[1]+tmpPtArray[0];
							var tmpCID = "BUMP00"+i+p;
							bump_00Array[pArrayCount].setIDClip(tmpCID);
							bump_00Array[pArrayCount].addWspd(-1);
							bump_00Array[pArrayCount].addWdir(-1);	
							bump_00Array[pArrayCount].addPoint(tmpPtArray[1], tmpPtArray[0]);
							bump_00Array[pArrayCount].setRotation(tmpPtArray[2]);
							bump_00Array[pArrayCount].setAlpha(80);
							bump_00Array[pArrayCount].setAlphaOnMouseOver(80);	
							bump_00Array[pArrayCount].setSize(30);
							if(tmpBumpObj.TYPE == "cold") {
								bump_00Array[pArrayCount].setSymbol("GraphicColdBump");
								bump_00Array[pArrayCount].setSize(35);
							}
							else if(tmpBumpObj.TYPE == "warm") {
								bump_00Array[pArrayCount].setSymbol("GraphicWarmBump");
								bump_00Array[pArrayCount].setSize(35);
							} 
							else if(tmpBumpObj.TYPE == "occluded") {
								if(oddTracker == 0) {
									bump_00Array[pArrayCount].setSymbol("GraphicOcc1Bump");
									oddTracker = 1;
								}
								else {
									bump_00Array[pArrayCount].setSymbol("GraphicOcc2Bump");
									oddTracker = 0;
								}
								bump_00Array[pArrayCount].setSize(50);
							}
							else if(tmpBumpObj.TYPE == "stationary") {
								if(oddTracker == 0) {
									bump_00Array[pArrayCount].setSymbol("GraphicStn1Bump");
									bump_00Array[pArrayCount].setSize(50);
									oddTracker = 1;
								}
								else {
									bump_00Array[pArrayCount].setSymbol("GraphicStn2Bump");
									bump_00Array[pArrayCount].setSize(50);
									oddTracker = 0;
								}
							}
							else if(tmpBumpObj.TYPE == "trof") {
								bump_00Array[pArrayCount].setSymbol("GraphicTrofBump");
								bump_00Array[pArrayCount].setSize(50);								
							}
							else {
								bump_00Array[pArrayCount].setSymbol("GraphicBlackCircle");
							}
							//bump_00Array[p].setSize(10);
							bump_00Array[pArrayCount].addRawMsg("BUMP:"+4600+i+p);						
							bump_00Array[pArrayCount].setDepth(4600+i+p);						
							bump_00Array[pArrayCount].drawPoint();
							pArrayCount++; 
						} //for(p=0;p < ptArray.length;p=p+6)	
						//pArrayCount++;		//added 2-3-2006			
					} //for(i=0;i < BumpArr.length;i++)
					for(i=1;i < FrontArr.length;i++) {
						var tmpFrontObj = new Object;
						tmpFrontObj = FrontArr[i];
						FrontArr[i] = new ComplexFront();
						var tmpCID = "FRONT00"+i;
						FrontArr[i].setHand(tmpFrontObj.HAND);
						FrontArr[i].setType(tmpFrontObj.TYPE);
						FrontArr[i].setClipName(tmpClipName);
						if(tmpFrontObj.TYPE == "occluded") {
							FrontArr[i].setColor("0x660066");		
						}
						else if(tmpFrontObj.TYPE == "warm") {
							FrontArr[i].setColor("0xFF0000");		
						}
						else if(tmpFrontObj.TYPE == "cold") {
							FrontArr[i].setColor("0x0000FF");		
						}
						else if(tmpFrontObj.TYPE == "trof") {
							FrontArr[i].setColor("0x0000FF");		
							FrontArr[i].setAlpha(0);
						} 
						else if(tmpFrontObj.TYPE == "stationary") {
							FrontArr[i].setColor("0x0000FF");		
						}
						else {
							FrontArr[i].setColor("0x000000");	
						}
						
						FrontArr[i].setDepth(4900+i);
						FrontArr[i].peelPointsFromString(tmpFrontObj.STRINGOFPOINTS);		
						
					}
					front_00Array = FrontArr;
					for(i=1;i < HiLoArr.length;i++) {
						var tmpHiLoObj = new Object;
						tmpHiLoObj = HiLoArr[i];
						hilo_00Array[i] = new DataPoint(7);	
						var tmpCID = "HILO00"+i;
						var ptArray = new Array;
						ptArray = tmpHiLoObj.STRINGOFPOINTS.split(",");
						hilo_00Array[i].addPoint(ptArray[1], ptArray[0]);
						hilo_00Array[i].setIDClip(tmpCID);
						hilo_00Array[i].addWspd(-1);
						hilo_00Array[i].addWdir(-1);					
						hilo_00Array[i].setAlpha(100);
						hilo_00Array[i].setAlphaOnMouseOver(100);	
						hilo_00Array[i].setSize(30);
						if(tmpHiLoObj.TYPE == "high") {
							hilo_00Array[i].setSymbol("GraphicFrontHigh");
							hilo_00Array[i].addRawMsg("High:"+tmpHiLoObj.PVAL);
						}
						else if(tmpHiLoObj.TYPE == "low") {
							hilo_00Array[i].setSymbol("GraphicFrontLow");
							hilo_00Array[i].addRawMsg("Low:"+tmpHiLoObj.PVAL);
						}
						else if(tmpHiLoObj.TYPE == "tropical_storm"){
							//hilo_00Array[i].setSymbol("GraphicTropicalStorm");
							hilo_00Array[i].setSymbol("GraphicTStormAni");
							hilo_00Array[i].setSize(-1);
							hilo_00Array[i].addRawMsg("Tropical Storm:"+tmpHiLoObj.PVAL);
						}
						else if(tmpHiLoObj.TYPE == "tropical_depression"){
							hilo_00Array[i].setSymbol("GraphicTropicalDep");							
							hilo_00Array[i].setSize(-1);
							hilo_00Array[i].addRawMsg("Tropical Depression:"+tmpHiLoObj.PVAL);
						}
						else if(tmpHiLoObj.TYPE == "typhoon"){							
							hilo_00Array[i].setSymbol("GraphicTyphoon");
							hilo_00Array[i].setSize(-1);
							hilo_00Array[i].addRawMsg("Typhoon:"+tmpHiLoObj.PVAL);
						}
						else {
							hilo_00Array[i].setSymbol("GraphicBlackCircle");
							hilo_00Array[i].setSize(10);
							hilo_00Array[i].addRawMsg(tmpHiLoObj.PVAL);
						}
						
						hilo_00Array[i].setDepth(4500+i);
						
						hilo_00Array[i].drawPoint();					 
					}

					_level0.WMSMap.loading.removeMovieClip();		
					toggleTools(true);
					//_level0.debugBox.text = _level0.debugBox.text+"Length1:"+bump_00Array.length+"<br>";
				break;
				default:
					Status.text = "WARNING W9000:"+"No object specified";
					
					_level0.WMSMap.loading.removeMovieClip();
					toggleTools(true);
				break;
		}
	}
	this.onStatus = function(error)
	{
		//Status.text = "ERROR: "+error.description;
		//_level0.debugBox.text = _level0.debugBox.text+error.description+"<br>";
		Status.text = "ERROR E9000:"+error.description;
		_level0.WMSMap.loading.removeMovieClip();
		toggleTools(true);
		return 0;
	}
}


function ObjResult_polygons(functionToRun) {
	//receives data returned from the method
	this.onResult = function(ObjResult)
	{
		switch(functionToRun) {
				case 1:
					LineArr = new Array;
					LineArr = ObjResult;				
					for(i=0;i<LineArr.length;i++) {
						LineStruct = new Object;
						LineStruct = LineArr[i];
						var tmpClipName = "turb_"+i;	
						var testLineString = new ComplexPoly();
						testLineString.setClipName(tmpClipName);
						testLineString.setCval(LineStruct.TOP);					
						testLineString.setColor("0x000000");		
						testLineString.setLineThickness(2);
						testLineString.setAlpha(100);		
						testLineString.setPtype("TURB");
						if(LineStruct.SEVERITY == "MDT") {
							testLineString.setFillAlpha(60);
							testLineString.setFillColor("0xFF0000");
						}
						else if(LineStruct.SEVERITY == "SVR") {
							testLineString.setFillAlpha(80);
							testLineString.setFillColor("0xFF0000");
						}
						else {
							testLineString.setFillAlpha(40);
							testLineString.setFillColor("0xFF0000");
						}
						testLineString.setDepth(3900+i);
						testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);			
						turb_Array[i] = testLineString;
					}				
					_level0.WMSMap.loading.removeMovieClip();
					toggleTools(true);
					break;
				case 2:
					LineArr = new Array;
					LineArr = ObjResult;				
					for(i=0;i<LineArr.length;i++) {
						LineStruct = new Object;
						LineStruct = LineArr[i];
						var tmpClipName = "cnvc_"+i;	
						var testLineString = new ComplexPoly();
						testLineString.setClipName(tmpClipName);
						testLineString.setCval(LineStruct.MAXTOP);					
						testLineString.setColor("0xFFFFFF");		
						testLineString.setLineThickness(2);
						testLineString.setAlpha(100);
						testLineString.setFillAlpha(80);
						testLineString.setFillColor("0xE4FF00");						
						testLineString.setDepth(3950+i);
						testLineString.setPtype("CNVC");
						testLineString.peelPointsFromString(LineStruct.STRINGOFPOINTS);	

						cnvc_Array[i] = testLineString;
						if(cnvc_Array.length == 0) {
							cnvc_Array[1] = testLineString;
						}
						
					}	
					_level0.WMSMap.loading.removeMovieClip();
					toggleTools(true);
					break;
				case 3:
				
					SigStruct = new Object;
					SigStruct = ObjResult;						
					for(i=0;i<SigStruct.NUMRECORDS;i++) {
						var tmpsigarray = new Array;
						tmpsigarray= SigStruct.SIGMET.items[i].Col_24.split(",");
						if(tmpsigarray.length > 5) {
						//if(SigStruct.SIGMET.items[i].Col_24
						LineStruct = new Object;
						LineStruct = LineArr[i];
						var tmpClipName = "sigmet_"+i;	
						var testLineString = new ComplexPoly();
						testLineString.setClipName(tmpClipName);
						testLineString.setCval(SigStruct.SIGMET.items[i].Col_15);
						testLineString.setMetType(SigStruct.SIGMET.items[i].Col_19);
						testLineString.setColor("0x000000");		
						testLineString.setLineThickness(1);
						testLineString.setAlpha(70);
						testLineString.setPtype("SIGMET");
						testLineString.setflightLevels(SigStruct.SIGMET.items[i].Col_6, SigStruct.SIGMET.items[i].Col_7);
						testLineString.setDepth(4800+i);
						testLineString.setRawMsg(SigStruct.SIGMET.items[i].Col_16);
						
						if(SigStruct.SIGMET.items[i].Col_19 == "TURB") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x00FF00");	
						}
						else if(SigStruct.SIGMET.items[i].Col_19 == "CNVC") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0xFF0000");	
						}
						else if(SigStruct.SIGMET.items[i].Col_19 == "ICNG" || SigStruct.SIGMET.items[i].Col_19 == "ICE") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x0000FF");	
						}
						else if(SigStruct.SIGMET.items[i].Col_19 == "VASH") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x997301");	
						}
						else {
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x000000");							
						}
						testLineString.setDepth(3950+i);
						testLineString.peelPointsFromString(SigStruct.SIGMET.items[i].Col_24, 1);				
						//Added 1-30-2006
						//_level0.debugBox.text = _level0.debugBox.text+"points:"+SigStruct.SIGMET.items[i].Col_24;
						//
						sigmet_Array[i] = testLineString;
						}
					}					
					_level0.WMSMap.loading.removeMovieClip();
					toggleTools(true);
				break;
				case 4:
					AirStruct = new Object;
					AirStruct = ObjResult;						
					for(i=0;i<AirStruct.NUMRECORDS;i++) {
						LineStruct = new Object;
						LineStruct = LineArr[i];
						var tmpClipName = "airmet_"+i;	
						var testLineString = new ComplexPoly();
						testLineString.setClipName(tmpClipName);
						testLineString.setCval(SigStruct.AIRMET.items[i].Col_13);	
						testLineString.setMetType(AirStruct.AIRMET.items[i].Col_13);
						testLineString.setColor("0xFFFFFF");		
						testLineString.setLineThickness(2);
						testLineString.setAlpha(70);
						testLineString.setPtype("AIRMET");
						//Flight Levels
						testLineString.setflightLevels(AirStruct.AIRMET.items[i].Col_4, AirStruct.AIRMET.items[i].Col_5);						
						
						testLineString.setRawMsg(AirStruct.AIRMET.items[i].Col_12);
						if(AirStruct.AIRMET.items[i].Col_13 == "TURB") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x00FF00");	
						}
						else if(AirStruct.AIRMET.items[i].Col_19 == "CNVC") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0xFF0000");	
						}
						else if(AirStruct.AIRMET.items[i].Col_19 == "ICNG" || AirStruct.AIRMET.items[i].Col_19 == "ICE") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x0000FF");	
						}
						else if(AirStruct.AIRMET.items[i].Col_19 == "VASH") {							
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x997301");	
						}
						else {
							testLineString.setFillAlpha(5);
							testLineString.setFillColor("0x0000FF");							
						}
						testLineString.setDepth(4950+i);
						testLineString.peelPointsFromString(AirStruct.AIRMET.items[i].Col_24, 1);				
						airmet_Array[i] = testLineString;				
					}					
					_level0.WMSMap.loading.removeMovieClip();
					toggleTools(true);
				break;
				default:
					Status.text = "WARNING W9000:"+"No object specified";
					toggleTools(true);
					_level0.WMSMap.loading.removeMovieClip();
				break;
				
		}
	}
	this.onStatus = function(error)
	{
		//Status.text = "ERROR: "+error.description;
		Status.text = "ERROR E9000:"+error.description;
		_level0.WMSMap.loading.removeMovieClip();
		return 0;
	}
}


//*****************
//Function:  PassOBJtoFromCF()
//Description:
//		sends a sort of status
//		object to the CF and gets
//		a new object back containing
//		an entire layer.
//
//*****************
function PassOBJtoFromCF() {	
	//passes an objct to CF 
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	xmlOBJ.mapLayers = _level0.IntStrFromCurrLyrCont();
	xmlOBJ.StageW = Stage.width;
	xmlOBJ.StageH = Stage.height;
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;	
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(1));	
	xmlOBJCF.getMETAR({x:xmlOBJ});		

} //PassOBJtoFromCF

//Parse some xml
function GrabXMLDataFromCF() {	
	toggleTools(false);
	//passes an objct to CF 
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;

	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(2));	
	xmlOBJCF.parseCellTopsMotion({x:xmlOBJ});		

} //PassOBJtoFromCF
function GrabXMLPireps() {	
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(3));	
	xmlOBJCF.getPIREP({x:xmlOBJ});
}

function LoadLineLayers() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(4));	
	xmlOBJCF.parseFreezingLevel({x:xmlOBJ});			
}

function LoadPressureFromDB() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(6));	
	xmlOBJCF.parsePressure({x:xmlOBJ});			
}

function LoadTropoHeightFromDB() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(7));	
	xmlOBJCF.parseTropoHeight({x:xmlOBJ});			
}

function GrabMeterLevel1() {	
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(5));	
	xmlOBJCF.getStationData({x:xmlOBJ});
}

function GrabTAFs() {	
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(8));	
	xmlOBJCF.getTAF({x:xmlOBJ});
}
function Load00SurfaceTemp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(9));	
	xmlOBJCF.parse00SurfaceTemp({x:xmlOBJ});			
}
function Load12SurfaceTemp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(10));	
	xmlOBJCF.parse12SurfaceTemp({x:xmlOBJ});			
}
function Load24SurfaceTemp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(11));	
	xmlOBJCF.parse24SurfaceTemp({x:xmlOBJ});			
}
function Load36SurfaceTemp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(12));	
	xmlOBJCF.parse36SurfaceTemp({x:xmlOBJ});			
}
function Load48SurfaceTemp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(13));	
	xmlOBJCF.parse48SurfaceTemp({x:xmlOBJ});			
}
function Load00_200Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(14));	
	xmlOBJCF.parse_200_00Z_Temp({x:xmlOBJ});			
}
function Load12_200Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(15));	
	xmlOBJCF.parse_200_12Z_Temp({x:xmlOBJ});			
}
function Load24_200Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(16));	
	xmlOBJCF.parse_200_24Z_Temp({x:xmlOBJ});			
}
function Load06_200Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(17));	
	xmlOBJCF.parse_200_06Z_Temp({x:xmlOBJ});			
}
function Load18_200Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(18));	
	xmlOBJCF.parse_200_18Z_Temp({x:xmlOBJ});			
}
function Load00_250Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(19));	
	xmlOBJCF.parse_250_00Z_Temp({x:xmlOBJ});			
}
function Load12_250Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(20));	
	xmlOBJCF.parse_250_12Z_Temp({x:xmlOBJ});			
}
function Load24_250Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(21));	
	xmlOBJCF.parse_250_24Z_Temp({x:xmlOBJ});			
}
function Load06_250Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(22));	
	xmlOBJCF.parse_250_06Z_Temp({x:xmlOBJ});			
}
function Load18_250Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(23));	
	xmlOBJCF.parse_250_18Z_Temp({x:xmlOBJ});			
}
function Load00_300Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(24));	
	xmlOBJCF.parse_300_00Z_Temp({x:xmlOBJ});			
}
function Load12_300Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(25));	
	xmlOBJCF.parse_300_12Z_Temp({x:xmlOBJ});			
}
function Load24_300Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(26));	
	xmlOBJCF.parse_300_24Z_Temp({x:xmlOBJ});			
}
function Load06_300Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(27));	
	xmlOBJCF.parse_300_06Z_Temp({x:xmlOBJ});			
}
function Load18_300Temp() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(28));	
	xmlOBJCF.parse_300_18Z_Temp({x:xmlOBJ});			
}
function Load00_Pres() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(29));	
	xmlOBJCF.parse_00Z_Pres({x:xmlOBJ});			
}
function Load12_Pres() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(30));	
	xmlOBJCF.parse_12Z_Pres({x:xmlOBJ});			
}
function Load24_Pres() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult(31));	
	xmlOBJCF.parse_24Z_Pres({x:xmlOBJ});			
}
function Load48_Pres() {
	toggleTools(false);
	xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;	
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new FcstResult(1));	
	xmlOBJCF.parse_48Z_Pres({x:xmlOBJ});			
}

//parse_00Z_Front_HiLo
//Load00_Front
function Load00_Front() {
	toggleTools(false);
	var xmlOBJ = new Object();
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult_v2(1));	
	xmlOBJCF.parse00ZFntHiLo({x:xmlOBJ});			
}

function Load_Poly(tmpType) {	
	toggleTools(false);
	var tmpCase = 0;
	var xmlOBJ = new Object();
	xmlOBJ.polyType = tmpType;
	if(tmpType == "turb") {		
		tmpCase = 1;
	}
	else if(tmpType == "cnvc") {		
		tmpCase = 2;
	}
	else if(tmpType == "sigmet") {		
		tmpCase = 3;
	}
	else if(tmpType == "airmet") {		
		tmpCase = 4;
	}
	else {		
		tmpCase = 0;
	}		
	xmlOBJ.flashID = _level0.flashID;
	xmlOBJ.bBox = _level0.WMSMap.BBox;	
	_level0.WMSMap.attachMovie("loading_v2", "loading", 300);
	_level0.WMSMap.loading._width = 50;
	_level0.WMSMap.loading._height = 10;
	_level0.WMSMap.loading._x = Stage.width - 80;
	_level0.WMSMap.loading._y = Stage.height - 25;
	var xmlOBJCF = gw.getService("include.cfc.layerDataGateway", new ObjResult_polygons(tmpCase));	
	if(tmpType == "turb") {
		//xmlOBJCF.parseTurb({x:xmlOBJ});		
	}
	if(tmpType == "cnvc") {
		//xmlOBJCF.parseCnvc({x:xmlOBJ});		
	}
	if(tmpType == "sigmet") {
		xmlOBJCF.parseSigmet({x:xmlOBJ});		
	}
	if(tmpType == "airmet") {
		xmlOBJCF.parseAirmet({x:xmlOBJ});		
	}
	else {
		//xmlOBJCF.parseSigmet({x:xmlOBJ});		
	}
}

//*****************
//Function:  ListPoints(tmpOBJ)
//Description:  
//		prints the lat/lon values
//		from all elements in the 
//		object returned by the cf
//		function
//*****************
function ListPoints(tmpOBJ) {
	var OBJstore = new Object;
	OBJstore = tmpOBJ;
	for(i=0;i< tmpOBJ.objArray.length;i++) {
		var OBJArrVal = new Object;
		OBJArrVal = tmpOBJ.objArray[i];
	} //for(i=0;i< tmpOBJ.objArray.length;i++)
} //function ListPoints(tmpOBJ)

//*****************
//Function:  createTestObject()
//Description:  
//		Creates a mock object to be
//		passed to the function for
//		testing ouside of CF
//*****************
function createTestObject() {

} // function createTestObject()
//*****************
//Function:  removeLayerDisplayed()
//Description:  
//		
//*****************
function removeLayerDisplayed(tmpLayerNum) {
	if(tmpLayerNum == 108) {
		for(i=0;cTopsMotionArr.length;i++) {
			cTopsMotionArr[i].killPoint();
			cTopsMotionArr[i] == NULL;
		}
	}
	if(tmpLayerNum == 103) {
		for(i=0;pirepsArr.length;i++) {
			pirepsArr[i].killPoint();
			pirepsArr[i] == NULL;
		}
	}
	if(tmpLayerNum == 110) {	
		for(i=0;freezingArray.length;i++) {
			freezingArray[i].killLines();
			freezingArray[i] == NULL;
		}
	}
	if(tmpLayerNum == 115) {
		for(i=0;i<metarLevel1.length;i++) {
			metarLevel1[i].killPoint();
			metarLevel1[i] == NULL;
		}
	}
	if(tmpLayerNum == 109) {
		for(i=0;i<pressureArray.length;i++) {
			pressureArray[i].killLines();
			pressureArray[i] == NULL;
		}
	}
	if(tmpLayerNum == 111) {
		for(i=0;i<tropoArray.length;i++) {
			tropoArray[i].killLines();
			tropoArray[i] == NULL;
		}
	}
	if(tmpLayerNum == 112) {
		for(i=0;i<turb_Array.length;i++) {
			turb_Array[i].killLines();
			turb_Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 113) {
		for(i=0;i<cnvc_Array.length;i++) {
			cnvc_Array[i].killLines();
			cnvc_Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 116) {
		for(i=0;i<tafArr.length;i++) {
			tafArray[i].killPoint();
			tafArray[i] == NULL;
		}
	}
	//temp00Array
	if(tmpLayerNum == 117) {
		for(i=0;i<temp00Array.length;i++) {
			temp00Array[i].killLines();
			temp00Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 118) {
		for(i=0;i<temp12Array.length;i++) {
			temp12Array[i].killLines();
			temp12Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 119) {
		for(i=0;i<temp24Array.length;i++) {
			temp24Array[i].killLines();
			temp24Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 120) {
		for(i=0;i<temp36Array.length;i++) {
			temp36Array[i].killLines();
			temp36Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 121) {
		for(i=0;i<temp48Array.length;i++) {
			temp48Array[i].killLines();
			temp48Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 122) {
		for(i=0;itemp200_00Array.length;i++) {
			temp200_00Array[i].killLines();
			temp200_00Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 123) {
		for(i=0;i<temp200_12Array.length;i++) {
			temp200_12Array[i].killLines();
			temp200_12Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 124) {
		for(i=0;i<temp200_24Array.length;i++) {
			temp200_24Array[i].killLines();
			temp200_24Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 125) {
		for(i=0;i<temp200_06Array.length;i++) {
			temp200_06Array[i].killLines();
			temp200_06Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 126) {
		for(i=0;i<temp200_18Array.length;i++) {
			temp200_18Array[i].killLines();
			temp200_18Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 127) {
		for(i=0;itemp250_00Array.length;i++) {
			temp250_00Array[i].killLines();
			temp250_00Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 128) {
		for(i=0;i<temp250_12Array.length;i++) {
			temp250_12Array[i].killLines();
			temp250_12Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 129) {
		for(i=0;i<temp250_24Array.length;i++) {
			temp250_24Array[i].killLines();
			temp250_24Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 130) {
		for(i=0;i<temp250_06Array.length;i++) {
			temp250_06Array[i].killLines();
			temp250_06Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 131) {
		for(i=0;i<temp250_18Array.length;i++) {
			temp250_18Array[i].killLines();
			temp250_18Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 132) {
		for(i=0;itemp300_00Array.length;i++) {
			temp300_00Array[i].killLines();
			temp300_00Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 133) {
		for(i=0;i<temp300_12Array.length;i++) {
			temp300_12Array[i].killLines();
			temp300_12Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 134) {
		for(i=0;i<temp300_24Array.length;i++) {
			temp300_24Array[i].killLines();
			temp300_24Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 135) {
		for(i=0;i<temp300_06Array.length;i++) {
			temp300_06Array[i].killLines();
			temp300_06Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 136) {
		for(i=0;i<temp300_18Array.length;i++) {
			temp300_18Array[i].killLines();
			temp300_18Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 137) {
		for(i=0;i<pres_00Array.length;i++) {
			pres_00Array[i].killLines();
			pres_00Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 138) {
		for(i=0;i<pres_12Array.length;i++) {
			pres_12Array[i].killLines();
			pres_12Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 139) {
		for(i=0;i<pres_24Array.length;i++) {
			pres_24Array[i].killLines();
			pres_24Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 140) {
		for(i=0;i<pres_48Array.length;i++) {
			pres_48Array[i].killLines();
			pres_48Array[i] == NULL;
		}
	}
	if(tmpLayerNum == 141) {
		//_level0.debugBox.text = _level0.debugBox.text+"bump_00Array.length:"+bump_00Array.length+"<br>";
		for(i=0;i<bump_00Array.length;i++) {
			bump_00Array[i].killPoint();			
			bump_00Array[i] == NULL;
		}
		for(i=0;i<hilo_00Array.length;i++) {
			hilo_00Array[i].killPoint();					
			hilo_00Array[i] == NULL;			
		}		
		for(i=0;i<front_00Array.length;i++) {
			front_00Array[i].killLines();
			front_00Array[i] == NULL;
		}
	} //if(tmpLayerNum == 141) 
	if(tmpLayerNum == 143) {
		sigmet_Array[i].killPoly();
	}
	if(tmpLayerNum == 144) {
		airmet_Array[i].killPoly();
	}
	if(tmpLayerNum == 0) {
		for(i=0;i<tafArr.length;i++) {	
			tafArray[i].killPoint();		
		}	
		for(i=0;i<metarLevel1.length;i++) {	
			metarLevel1[i].killPoint();
		}	
		for(i=0;i<tropoArray.length;i++) {	
			tropoArray[i].killLines();		
		}	
		for(i=0;i<pressureArry.length;i++) {	
			pressureArry[i].killLines();		
		}	
		for(i=0;i<freezingArray.length;i++) {	
			freezingArray[i].killLines();		
		}	
		for(i=0;i<cTopsMotionArr.length;i++) {	
			cTopsMotionArr[i].killPoint();
		}
		for(i=0;i<pirepsArr.length;i++) {	
			pirepsArr[i].killPoint();
		}	
		for(i=0;i<temp00Array.length;i++) {	
			temp00Array[i].killLines();		
		}			
		for(i=0;i<temp12Array.length;i++) {	
			temp12Array[i].killLines();		
		}		
		for(i=0;i<temp24Array.length;i++) {	
			temp24Array[i].killLines();		
		}		
		for(i=0;i<temp36Array.length;i++) {	
			temp36Array[i].killLines();		
		}		
		for(i=0;i<temp48Array.length;i++) {	
			temp48Array[i].killLines();		
		}		
		for(i=0;i<temp200_00Array.length;i++) {	
			temp200_00Array[i].killLines();		
		}			
		for(i=0;itemp200_12Array.length;i++) {	
			temp200_12Array[i].killLines();		
		}		
		for(i=0;i<temp200_24Array.length;i++) {	
			temp200_24Array[i].killLines();		
		}		
		for(i=0;i<temp200_06Array.length;i++) {	
			temp200_06Array[i].killLines();		
		}		
		for(i=0;i<temp200_18Array.length;i++) {	
			temp200_18Array[i].killLines();		
		}	
		for(i=0;i<temp250_00Array.length;i++) {	
			temp250_00Array[i].killLines();		
		}			
		for(i=0;itemp250_12Array.length;i++) {	
			temp250_12Array[i].killLines();		
		}		
		for(i=0;i<temp250_24Array.length;i++) {	
			temp250_24Array[i].killLines();		
		}		
		for(i=0;i<temp250_06Array.length;i++) {	
			temp250_06Array[i].killLines();		
		}		
		for(i=0;i<temp250_18Array.length;i++) {	
			temp250_18Array[i].killLines();		
		}	
		for(i=0;i<temp300_00Array.length;i++) {	
			temp300_00Array[i].killLines();		
		}			
		for(i=0;itemp300_12Array.length;i++) {	
			temp300_12Array[i].killLines();		
		}		
		for(i=0;i<temp300_24Array.length;i++) {	
			temp300_24Array[i].killLines();		
		}		
		for(i=0;i<temp300_06Array.length;i++) {	
			temp300_06Array[i].killLines();		
		}		
		for(i=0;i<temp300_18Array.length;i++) {	
			temp300_18Array[i].killLines();		
		}	
		for(i=0;i<pres_00Array.length;i++) {	
			pres_00Array[i].killLines();		
		}	
		for(i=0;i<pres_12Array.length;i++) {	
			pres_12Array[i].killLines();		
		}	
		for(i=0;i<pres_24Array.length;i++) {	
			pres_24Array[i].killLines();		
		}	
		for(i=0;i<pres_48Array.length;i++) {	
			pres_48Array[i].killLines();		
		}		
		for(i=0;i<bump_00Array.length;i++) {			
			bump_00Array[i].killPoint();
		}
		for(i=0;i<hilo_00Array.length;i++) {			
			hilo_00Array[i].killPoint();
		}
		for(i=0;i<front_00Array.length;i++) {
			front_00Array[i].killLines();
		}
		for(i=0;i < cnvc_Array.length;i++) {			
			cnvc_Array[i].killLines();
		}
		for(i=0;i < turb_Array.length;i++) {			
			turb_Array[i].killLines();
		}
		for(i=0;i < sigmet_Array.length;i++) {
			sigmet_Array[i].killPoly();
		}
		for(i=0;i < airmet_Array.length;i++) {
			airmet_Array[i].killPoly();
		}

	}

	for(i=0;i<MetarArr.length;i++) {	
		if(tmpLayerNum == 0) {
			MetarArr[i].killPoint();
			FlightRulesArr[i].killPoint();
			windSpdArr[i].killPoint();
			TempArr[i].killPoint();
		}
		if(tmpLayerNum == 102) {
			MetarArr[i].killPoint();
			MetarArr[i] == NULL;
		}
		if(tmpLayerNum == 106) {
			FlightRulesArr[i].killPoint();
			FlightRulesArr[i] == NULL;
		}	
		if(tmpLayerNum == 107) {
			windSpdArr[i].killPoint();
			windSpdArr[i] == NULL;
		}
		if(tmpLayerNum == 114) {
			TempArr[i].killPoint();
			TempArr[i] == NULL;
		}				
	}
}
//*****************
//Function:  hideLayerDisplayed()
//Description:  
//		
//*****************
function hideLayerDisplayed(tmpLayerNum) {
	//Add logic for determining which objects to show
	for(i=0;i<MetarArr.length;i++) {		
		MetarArr[i].hidePoint();
	}
	for(i=0;i<FlightRulesArr.length;i++) {			
		FlightRulesArr[i].hidePoint();
	}
	for(i=0;i<windSpdArr.length;i++) {			
		windSpdArr[i].hidePoint();
	}
	for(i=0;i<TempArr.length;i++) {			
		TempArr[i].hidePoint();
	}
	for(i=0;i<cTopsMotionArr.length;i++) {			
		cTopsMotionArr[i].hidePoint();
	}
	for(i=0;i<pirepsArr.length;i++) {			
		pirepsArr[i].hidePoint();
	}
	for(i=0;i<freezingArray.length;i++) {
		freezingArray[i].killLines();
	}
	for(i=0;i<metarLevel1.length;i++) {			
		metarLevel1[i].hidePoint();
	}
	for(i=0;i<tafArray.length;i++) {			
		tafArray[i].hidePoint();
	}
	for(i=0;i < tropoArray.length;i++) {			
		tropoArray[i].killLines();
	}
	for(i=0;i < cnvc_Array.length;i++) {			
		cnvc_Array[i].killLines();
	}
	for(i=0;i < turb_Array.length;i++) {			
		turb_Array[i].killLines();
	}	
	for(i=0;i<pressureArray.length;i++) {			
		pressureArray[i].killLines();
	}
	for(i=0;i<temp00Array.length;i++) {			
		temp00Array[i].killLines();
	}	
	for(i=0;i<temp12Array.length;i++) {			
		temp12Array[i].killLines();
	}
	for(i=0;i<temp24Array.length;i++) {			
		temp24Array[i].killLines();
	}
	for(i=0;i<temp36Array.length;i++) {			
		temp36Array[i].killLines();
	}
	for(i=0;i<temp48Array.length;i++) {			
		temp48Array[i].killLines();
	}
	for(i=0;i<temp200_00Array.length;i++) {			
		temp200_00Array[i].killLines();
	}	
	for(i=0;i<temp200_12Array.length;i++) {			
		temp200_12Array[i].killLines();
	}
	for(i=0;i<temp200_24Array.length;i++) {			
		temp200_24Array[i].killLines();
	}
	for(i=0;i<temp200_06Array.length;i++) {			
		temp200_06Array[i].killLines();
	}
	for(i=0;i<temp200_18Array.length;i++) {			
		temp200_18Array[i].killLines();
	}	
	for(i=0;i<temp250_00Array.length;i++) {			
		temp250_00Array[i].killLines();
	}	
	for(i=0;i<temp250_12Array.length;i++) {			
		temp250_12Array[i].killLines();
	}
	for(i=0;i<temp250_24Array.length;i++) {			
		temp250_24Array[i].killLines();
	}
	for(i=0;i<temp250_06Array.length;i++) {			
		temp250_06Array[i].killLines();
	}
	for(i=0;i<temp300_00Array.length;i++) {			
		temp300_00Array[i].killLines();
	}	
	for(i=0;i<temp300_12Array.length;i++) {			
		temp300_12Array[i].killLines();
	}
	for(i=0;i<temp300_24Array.length;i++) {			
		temp300_24Array[i].killLines();
	}
	for(i=0;i<temp300_06Array.length;i++) {			
		temp300_06Array[i].killLines();
	}
	for(i=0;i<temp300_18Array.length;i++) {			
		temp300_18Array[i].killLines();
	}		
	for(i=0;i<pres_00Array.length;i++) {			
		pres_00Array[i].killLines();
	}
	for(i=0;i<pres_12Array.length;i++) {			
		pres_12Array[i].killLines();
	}
	for(i=0;i<pres_24Array.length;i++) {			
		pres_24Array[i].killLines();
	}
	for(i=0;i<pres_48Array.length;i++) {			
		pres_48Array[i].killLines();
	}	
	//_level0.debugBox.text = _level0.debugBox.text+"Length2:"+bump_00Array.length+"<br>";
	for(i=0;i<bump_00Array.length;i++) {
		bump_00Array[i].hidePoint();
		bump_00Array[i].killPoint();	
		
	}
	for(i=0;i<hilo_00Array.length;i++) {
		hilo_00Array[i].hidePoint();		
	}
	for(i=0;i<front_00Array.length;i++) {
		front_00Array[i].killLines();
	}
	for(i=0;i < sigmet_Array.length;i++) {
		sigmet_Array[i].killPoly();
	}
	for(i=0;i < airmet_Array.length;i++) {
		airmet_Array[i].killPoly();
	}
}
//*****************
//Function:  showLayerSelected(tmpLayerNum) {
//Description:  
//		
//*****************
function showLayerSelected(tmpLayerNum) {
	//_level0.debugBox.text = _level0.debugBox.text+"showLayerSelected function";
	if(tmpLayerNum == 102) {
		for(i=0;i<MetarArr.length;i++) {
			MetarArr[i].drawPoint();			
		}
	}
	if(tmpLayerNum == 106) {
		for(i=0;i<FlightRulesArr.length;i++) {
			FlightRulesArr[i].drawPoint();
		}
	}
	if(tmpLayerNum == 107) {
		for(i=0;i<windSpdArr.length;i++) {
			windSpdArr[i].drawPoint();
		}
	}
	if(tmpLayerNum == 108) {
		for(i=0;i<cTopsMotionArr.length;i++) {
			cTopsMotionArr[i].drawPoint();
		}
	}
	if(tmpLayerNum == 114) {
		for(i=0;i<TempArr.length;i++) {
			TempArr[i].drawPoint();
		}
	}
	if(tmpLayerNum == 103) {
		for(i=0;i<pirepsArr.length;i++) {
			pirepsArr[i].drawPoint();
		}
	}
	if(tmpLayerNum == 115) {
		for(i=0;i<metarLevel1.length;i++) {
			metarLevel1[i].drawPoint();
		}
	}
	if(tmpLayerNum == 116) {
		for(i=0;i<tafArray.length;i++) {
			tafArray[i].drawPoint();
		}
	}	
	
}
//*****************
//Function:  showLayerDisplayed()
//Description:  
//		
//*****************
function showLayerDisplayed(tmpLayerNum) {
	
	if(MetarArr.length > 0) {
		for(i=0;i<MetarArr.length;i++) {		
			MetarArr[i].showPoint();			
		}
	}
	if(FlightRulesArr.length > 0) {
		for(i=0;i<FlightRulesArr.length;i++) {		
			FlightRulesArr[i].showPoint();
		}
	}	
	if(windSpdArr.length > 0) {
		for(i=0;i<windSpdArr.length;i++) {		
			windSpdArr[i].showPoint();
		}
	}
	if(TempArr.length > 0) {
		for(i=0;i<TempArr.length;i++) {		
			TempArr[i].showPoint();
		}
	}	
	if(pirepsArr.length > 0) {
		for(i=0;i<pirepsArr.length;i++) {		
			pirepsArr[i].showPoint();
		}
	}
	if(cTopsMotionArr.length > 0) {
		for(i=0;i<cTopsMotionArr.length;i++) {
			cTopsMotionArr[i].showPoint();
		}
	}
	if(metarLevel1.length > 0) {
	   for(i=0;i<metarLevel1.length;i++) {
			metarLevel1[i].showPoint();
		}	   
	}
    if(tafArray.length > 0) {
	   for(i=0;i<tafArray.length;i++) {
			tafArray[i].showPoint();
		}	   
	}
}
//*****************
//Function: 
//Description:  
//		
//		
//		
//*****************
function popUpTime(tmpBoxNameTime, tmpTimeToPrint, clrString) {
		boxNameTime = tmpBoxNameTime;
		timeToPrint = tmpTimeToPrint;
		topX = Stage.width-380;
		if(timeStampArray.length == 0) {
			topY = (Stage.height-40);
		}
		else {
			topY = (Stage.height-40)-(timeStampArray.length * 9);
		}
		tBoxDepth = 3200+timeStampArray.length;
		_level0.WMSMap.createTextField(boxNameTime, tBoxDepth, topX, topY, 380, 18);
		
		//_level0.WMSMap[boxNameTime].autosize =  "center"; 
		var myformat2 = new TextFormat();
		//myformat2.color = 0xFFFFFF;
		myformat2.color = clrString
		myformat2.bullet = false;
		myformat2.underline = false;
		myformat2.border = true;
		myformat2.align = right;
		//myformat2.background = true;	
		//myformat2.backgroundColor = 0x00FF00;				
		//myformat2.bold = true;
		myformat2.size = 12;
		_level0.WMSMap[boxNameTime].text = timeToPrint;
		_level0.WMSMap[boxNameTime].setTextFormat(myformat2);
}
function toggleTools(tmpSwitch) {
	if(flashID != 11 && flashID != 12 && flashID != 13) { 
		if(tmpSwitch == false) {
			_level0.menu = loadingNavigation;
			if(_level0.ToolBar.MouseAction != "query") {
				cursorState = _level0.ToolBar.MouseAction;
			}
			else if(_level0.ToolBar.MouseAction == "NULL") {
				cursorState = _level0.ToolBar.MouseAction;
			}
			_level0.ToolBar.MouseAction = "query";
			_level0.ToolBar._visible = false;		
		}
		else {
				_level0.ToolBar._visible = true;
				rValue1 = fscommand("submitbuttonshow");
				_level0.ToolBar.MouseAction = cursorState;
				_level0.menu = trialNavigation;
				_level0.ToolBar.Refresh();
				//_level0.ToolBar._visible = true;
		}
	}
} //toggleTools
function parseBbox(tmpX, tmpY):Array {
			
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
	parseBoxArray[0] = (tmpX-XMin)*xscale;
	parseBoxArray[1] = (YMax-tmpY)*yscale;
	return parseBoxArray;			
}
