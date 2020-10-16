<style>
	#timeStamps {
		color:#FFFFFF;
		padding:0px;
		margin:0px;
	}
</style>
<cfoutput>
	<script type="text/javascript">
		function showHideRegion(rID){
			if (document.getElementById(rID).style.display=="block") {
				document.getElementById(rID).style.display="none";
				document.getElementById('navLinkSection').style.display = "none";
			}else{
				document.getElementById(rID).style.display="block";
				document.getElementById('navLinkSection').style.display = "block";
			}
		}
		stringData = "";
		doneLoading = false;
		function refreshTimes () {
			timeInfo = stringData;
			document.getElementById('timeText').innerHTML = timeInfo;
			//alert('Refresh Times is Running: ' + timeInfo);
		}
		function getNewText() {
			// here is where the remoting call should be made
			document.getElementById('times').src = "#Request.urlPrefix#jsRemotingPage.cfm";
			refreshTimes();
		}
	</script>
</cfoutput>

<div id="navLinkSection" class="navlink" style="display:none;background-color:#000000; font-family: Tahoma, Verdana, Arial, sans-serif; font-weight: bold; font-size: 9px; padding: 3px 2px 3px 6px" align="left">		<div id="legend" style="display:none">
	    	<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>satellite_ir_legend.gif" border="0" alt="Satellite IR Legend"></span><br />
			<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>radar_legend.gif" border="0" alt="Radar Legend"></span><br />		
	    	<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>flight_rules_legend.gif" border="0" alt="Flight Rules Legend"></span><br />
	    	<!--- <span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>windv_legend.gif" border="0" alt="Winds Legend"></span> --->
			<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>sig_air_legend_1.gif" border="0" alt="Sigmet Airmet Legend"></span><br />
			<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>legends/radar_legend_comp.gif" border="0" alt="Composite Legend"></span><br />
			<span style="color: #E3E6E8;"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>legends/radar_legend_win.gif" border="0" alt="Winter Mosaic Legend"></span>
		</div>
</div>
<div id="timeStamps" style="height:47px;width:100%;overflow:hidden;">

	<cfoutput>
	<iframe name="times" 
			id="times"
			frameborder="0"
			src="#Request.urlPrefix#jsRemotingPage.cfm"
			width="0"
			height="0"
			scrolling="none" style="display:none;">
		Your Browser does not support frames.  Please upgrade to the latest version of internet explorer
	</iframe>
	</cfoutput>
	<div id="timeText" style="background-color:#000000;color:#FFFFFF;width:100%;height:47px;overflow-x:auto;overflow:auto;text-align:left;">
	</div>
</div>
<script>
	getNewText();
</script>