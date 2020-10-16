// Animation Functions
var hideAnimationDiv = "";
	function disableAnimation() {
		var input = new Array();
		input = document.forms['radioForm'].elements;
		for(i = 0; i < input.length; i++) {
			if((input[i].id.indexOf('SatelliteType') != -1) || (input[i].id.indexOf('RadarType') != -1)) {
				//alert(input[i].checked);
				if(input[i].checked == true) {
					document.getElementById('animationControl').style.display = 'block';
				} 
			}
		}
	}
	
	function enableAnimation() {
		document.getElementById('animationControl').style.display = 'block';
	}
	
	function turnOffAnimation() {
		var bool = false;
		try {
			bool = document.getElementById('RadarType3').checked;
		} 
		catch(e) {
			bool = (_last_menuItem_clicked_dict.getValueFor('LEGACYID') == 38);
		} 
		finally {}
		if (bool == true) {
			document.getElementById('animationControl').style.display = 'none';
		} else {
			document.getElementById('animationControl').style.display = 'block';
		}
	}
	
	function swapMovie(flashID) {
		//alert(flashID);
		if (document.getElementById('animate').value == "Return") {
			document.getElementById('mapCall').src = '/mapCall.cfm?mID=' + flashID + '&flashid=' + flashID;
			document.getElementById('animate').value = "Animate";
			document.getElementById('clear').disabled = false;
		} else {
			document.getElementById('mapCall').src = 'aniMapViewer.cfm';
			document.getElementById('animate').value = "Return";
			document.getElementById('clear').disabled = true;
		}
		
	}