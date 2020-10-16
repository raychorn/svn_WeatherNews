// functions that manipulate images

function menuArrowFlipper(menuArrowID) {
	if(document.getElementById(menuArrowID).src.indexOf('On') != -1) {
		document.getElementById(menuArrowID).src = '/images/MenuArrowOff.gif';
	} else {
		document.getElementById(menuArrowID).src = '/images/MenuArrowOn.gif';
	}
}