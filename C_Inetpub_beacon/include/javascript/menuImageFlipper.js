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
	var arrImageHandles = document.images;
	for (i = 1;i < arrImageHandles.length;i++) {
		if(arrImageHandles[i].src.indexOf('checkBox_on.gif') > 0) {
			arrImageHandles[i].src = '../images/checkBox_off.gif';
			//alert(arrImageHandles[i].src);
		}
	}
}