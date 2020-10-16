function openWin( windowURL, windowName, windowFeatures ) { 
		return window.open( windowURL, windowName, windowFeatures ) ; 
} 


function newPopupWindow(winName,filename,height,width) {
	window.open(filename,winName,"toolbar=no,status=no,width=" + width + ",height=" + height + ",scrollbars=no");
}