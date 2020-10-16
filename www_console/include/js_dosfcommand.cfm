<cfoutput>
<script language="javascript" type="text/javascript">
function MapSymbols#flashID#_DoFSCommand(command, args){
//stops flash errors. 
	if(command == "submitbuttonshow") {
		thisBool = window.parent.enableFastPageLoadButton();
		//alert("The FS Command is working");
	}
}
</script>
<SCRIPT LANGUAGE="VBScript">
<!-- 
// Catch FS Commands in IE, and pass them to the corresponding JavaScript function.

Sub MapSymbols#flashID#_FSCommand(ByVal command, ByVal args)
    call MapSymbols#flashID#_DoFSCommand(command, args)
end sub

// -->
</SCRIPT>
</cfoutput>