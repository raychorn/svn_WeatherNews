function disableFastPageLoadButton() {
	document.getElementById('execute').disabled = true;
}

function enableFastPageLoadButton() {
	document.getElementById('execute').disabled = false;
	return true;
}