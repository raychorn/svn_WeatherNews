function disableFastPageLoadButton() {
	
		document.getElementById('execute').disabled = true;
	
}

function enableFastPageLoadButton() {
	if(document.getElementById('execute')) {
		document.getElementById('execute').disabled = false;
		return true;
	} else {
		return false;
	}
}