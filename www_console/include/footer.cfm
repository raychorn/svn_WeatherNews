<TABLE WIDTH=99% BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR>
    <td bgcolor="#333333"><img src="<cfoutput>#Request.imagesPrefix#</cfoutput>spacer.gif" width="1" height="9" alt=""></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
  </TR>
  <TR>
    <TD BGCOLOR="#333333"><IMG SRC="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/spacer.gif" WIDTH=1 HEIGHT=27 ALT=""></TD>
	<cfoutput>    
	<TD><a href="#Request.CorporateRootPath#contact/" onMouseOver="MM_swapImage('contactUs','','<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/contact_button_ovr.gif',1)" onMouseOut="MM_swapImgRestore()"><IMG SRC="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/contact_button.gif" ALT="Contact Us" name="contactUs" WIDTH=63 HEIGHT=27 border="0" id="contactUs"></a></TD>
    <TD><a href="#Request.CorporateRootPath#terms/" onMouseOver="MM_swapImage('termsOfUse','','<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/terms_of_use_button_ovr.gif',1)" onMouseOut="MM_swapImgRestore()"><IMG SRC="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/terms_of_use_button.gif" ALT="Terms of Use" name="termsOfUse" WIDTH=65 HEIGHT=27 border="0" id="termsOfUse"></a></TD>
    <TD><a href="#Request.CorporateRootPath#privacy/" onMouseOver="MM_swapImage('privacyPolicy','','<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/privacy_button_ovr.gif',1)" onMouseOut="MM_swapImgRestore()"><IMG SRC="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/privacy_button.gif" ALT="Privacy Policy" name="privacyPolicy" WIDTH=68 HEIGHT=27 border="0" id="privacyPolicy"></a></TD>
	<TD><a href="javascript:void(0);" onClick="newWin=openWin('/Disclaimer.htm','WeathernewsBEACON','status=yes,scrollbars=yes,resizable=yes,width=800,height=550'); newWin.focus();" onMouseOver="MM_swapImage('disclaimer','','<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/disclaimer_button_ovr.gif',1)" onMouseOut="MM_swapImgRestore()"><IMG SRC="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/disclaimer_button.gif" ALT="Disclaimer" name="disclaimer" WIDTH=62 HEIGHT=27 border="0" id="disclaimer"></a></TD>
	</cfoutput>    
	<TD width="100%" background="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/bottom_nav_background.gif"> <IMG SRC="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/spacer.gif" WIDTH=1 HEIGHT=27 ALT=""></TD>
    <TD><IMG SRC="<cfoutput>#Request.imagesPrefix#</cfoutput>bottom_nav_images/copyright.gif" WIDTH=215 HEIGHT=27 ALT="Copyright 1996-2005 Weathernerws Inc., All Rights Reserved"></TD>
  </TR>
</TABLE>
<script language="JavaScript" type="text/javascript" src="/wz_tooltip.js"></script>
</body>
</html>
