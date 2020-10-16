function changeImages (imgId) {
	//alert("inside change Image2: " + document.images[imgId].src + "index is: " + document.images[imgId].src.indexOf("checkBox_on.gif") );
		if (document.images[imgId].src.indexOf("checkBox_on.gif") > 0 )
			document.images[imgId].src = "../images/checkBox_off.gif";
		else	
			document.images[imgId].src = "../images/checkBox_on.gif";
}

function changeImages2 (imgId) {
	//alert("inside change Image2: " + document.images[imgId].src + "index is: " + document.images[imgId].src.indexOf("checkBox_on.gif") );
		if (document.images[imgId].src.indexOf("checkBox_on.gif") > 0 ) {
			document.images[imgId].src = "../images/checkBox_off.gif";
			document.searchForm[imgId].checked = false;
		}
		else	{
			document.images[imgId].src = "../images/checkBox_on.gif";
			document.searchForm[imgId].checked = true;
		}	
}

function resetFakeImages() {
	var inputBoxes = document.getElementsByTagName("input");
	for(fb=0;fb < inputBoxes.length;fb++){
		if(inputBoxes[fb].type == 'checkbox') {
			inputBoxes[fb].checked = false;
		}
	}
}