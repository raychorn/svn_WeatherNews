// The XMLHttpRequest class object

function Request (url,oFunction,type) {
	this.funct = "";
	// this.req = "";
	this.url = url;
	this.oFunction = oFunction;
	this.type = type;
	this.doXmlhttp = doXmlhttp;
	this.loadXMLDoc = loadXMLDoc;
}

function doXmlhttp() {
	//var funct = "";
	if (this.type == 'text') {
		this.funct = this.oFunction + '(req.responseText)';
	} else {
		this.funct = this.oFunction + '(req.responseXML)';
	}
	this.loadXMLDoc();
	
}

function loadXMLDoc() {
	//alert(this.url);
	var functionA = this.funct;
	var req;
	req = false;
	
	function processReqChange() {
		// alert('reqChange is being called');
	    // only if req shows "loaded"
	    if (req.readyState == 4) {
	        // only if "OK"
	        if (req.status == 200) {
	            // ...processing statements go here...
	            eval(functionA);
	            		
	        } else {
	            alert("Error 7000: There was a problem retrieving the data from the server:\n" +
	                'Response Status: ' + req.statusText + '\nstatus: ' + req.status + '\nAddress: ' +
	                this.url);
	        }
	    	}
	}
	
    // branch for native XMLHttpRequest object
    if(window.XMLHttpRequest) {
    	try {
			req = new XMLHttpRequest();
        } catch(e) {
			req = false;
        }
    // branch for IE/Windows ActiveX version
    } else if(window.ActiveXObject) {
       	try {
	        	req = new ActiveXObject("Msxml2.XMLHTTP");
      	} catch(e) {
	        	try {
	          		req = new ActiveXObject("Microsoft.XMLHTTP");
	        	} catch(e) {
	          		req = false;
	        	}
		}
    }
	if(req) {
		req.onreadystatechange = processReqChange;
		req.open("GET", this.url, true);
		req.send("");
	}
}