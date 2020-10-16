<cfcomponent displayname="layerDataGateway" output="no">
	<cfset variables.debug_file_path = "d:\Data\console\include\debug\">
	<!--- <cfset variables.list_qualified_stations = ''> --->
	<cfset variables.set_debug = '0'>
	
<!---
	HELLO!
 	<cfsavecontent variable="variables.list_qualified_stations">
	KATL,KFTY,KMGE,KPDK,KVPC,KCCO,KFFC,KLZV,KWDR,KAHN,KGVL,K47A,KRMG,KDMN,K4A9,KCHA,KSLC,KHIF,KOGD,KLGU,KMLD,KEVW,
	KFIR,KENV,KDPG,KPVU,KU24,KPUC,KVEL,KTWF,KBYI,KPIH,KJER,KCVG,KLUK,KHAO,KMGY,KILN,KFFO,KDAY,KFFT,KLEX,KSDF,KLOU,
	KBAK,KGEZ,KAID,KMIE,KIND,KEYE,KOKK,KGUS,KFWA,KAOH,KALB,KBDL,KBOS,KBUF,KBWI,KDCA,KEWR,KGSO,KHPN,KIAD,KISP,KJFK,
	KLGA,KMDT,KORF,KPHL,KPVD,KRDU,KRIC,KROC,KSWF,KSYR,KAZO,KBMI,KBNA,KCID,KCLE,KCLT,KCMH,KCMI,KCVG,KCWA,KDAY,KDBQ,
	KDSM,KDTW,KEVV,KFWA,KGRB,KGRR,KIND,KLAN,KLSE,KMCI,KMDW,KMEM,KMKE,KMLI,KMSN,KMSP,KMWA,KOMA,KORD,KPIA,KPIT,KRST,
	KSAW,KSBN,KSDF,KSGF,KSPI,KSTL,KTOL,KTVC,KABI,KABQ,KACT,KAEX,KAFW,KAMA,KAUS,KBFL,KBPT,KBTR,KBUR,KCLL,KCOS,KCRP,
	KCRQ,KDAL,KDEN,KDFW,KDRO,KEGE,KELP,KFAT,KGGG,KGUC,KHDN,KHOU,KHRL,KIAH,KICT,KILE,KJAC,KLAS,KLAW,KLAX,KLBB,KLCH,
	KLFT,KLGB,KLIT,KLRD,KMAF,KMFE,KMRY,KMSY,KOAK,KOKC,KONT,KPDX,KPHX,KPSP,KRNO,KSAN,KSAT,KSBA,KSBP,KSEA,KSFO,KSHV,
	KSJC,KSJT,KSLC,KSMF,KSNA,KSPS,KTUL,KTUS,KTXK,KTYR,KAPF,KATL,KBHM,KEYW,KFLL,KFSM,KFYV,KHSV,KJAN,KJAX,KMCO,KMEM,
	KMIA,KMTH,MYNN,KPBI,KRSW,KSFB,KSRQ,KTPA,CYEG,CYOW,CYUL,CYVR,CYWG,CYYC,CYYZ,TAPA,TNCA,TXKF,TBPB,TNCC,TFFF,TGPY,
	MUHA,MUHG,MKJP,MKJS,TJNR,SVMG,MDPP,TTPP,TFFR,MDSD,TJSJ,MDST,TIST,TISX,TNCM,TTCP,MMAA,MMLO,MZBZ,MMUN,MMGL,MGGT,
	MMBT,MMLP,MMMX,MNMG,MMMD,MMMY,MMMZ,MPTO,MMPR,MSLP,MHLM,MROC,MHTG,SCFA,SCAR,SGAS,SKBQ,SBBE,SKBO,SBBR,SBBV,SCIE,
	SVMI,SKCL,SBCF,SKCG,SPZO,SAEZ,SBGL,SBGR,SEGU,SPQT,SPIM,SLLP,SBEG,SVMC,KMDZ,SUMU,SPSO,SBPA,SBPV,SBRB,SARE,SACO,
	SCEL,SBSN,SEQU,SLVR,LEMG,EHAM,ESSA,ENBR,EBBR,LFPG,EDDK,EKCH,EDDL,EGPF,LSGG,EFHK,EGKK,EGLL,LEMD,EGCC,EDDM,LIMC,
	LFPO,EGSS,EFTU,EDDT,LEVC,LSZH,EIDW,EGPH,BIKF,EGPK,LPAZ,EINN,LPLA,CYFB,CYHT,CYQM,CYQX,CYYR,CYYT,PANC,RJCC,RJTT,
	PHNL,PHTO,RJBB,RJAA,PHOG
	</cfsavecontent>
 --->	
	<cfif variables.set_debug EQ 1>
		<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="-----------------------------------------#chr(10)##chr(13)#invoked layerDateGateway on #dateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now(), 'HH:MM:SS:')# FROM #CGI.REMOTE_ADDR#" />
	</cfif>
	
	
	<!--- 
		********************************************************
		*************** Database  Queries **********************
		********************************************************
	--->
	
	<cffunction access="remote" name="getMETAR" returntype="struct" output="false">
	
		<cfscript>
		//break out the arguments
		//var bounding_box = Arguments[1].bBox; 
		//var flash_id = Arguments[1].flashID;
		var shape = '';
		var select_metars = '';
		var bounding_box = ''; 
		var flash_id = '';	
		var stArgs = structNew();
		
		try{
			bounding_box = Arguments[1].bBox; 
			flash_id = Arguments[1].flashID;
		} catch (Any excpt){
			bounding_box = Arguments.bBox; 
			flash_id = Arguments.flashID;
		}		
		struct_coordinates = deriveCoordinates(bounding_box);				
		</cfscript>
		
		<cftry>

			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="-----------------------------------------#chr(10)##chr(13)#entered layerDateGateway.getMETAR() on #dateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now(), 'HH:MM:SS:')# FROM #CGI.REMOTE_ADDR#" />
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="Set Arguments::bBox = #bounding_box#, flashID =#flash_id#, shape=#struct_coordinates.shape#, size=#struct_coordinates.size#" />
  			</cfif>
			<cfquery name="select_metars" datasource="#request.AVNOPS_DS#">
				exec obsdb..sp_GetMETAR_bkr
					#struct_coordinates.x3#,
					#struct_coordinates.x2#,
					#struct_coordinates.y3#,
					#struct_coordinates.y1#,
					#struct_coordinates.size#
			</cfquery> 
			
	<!---
		<cfquery name="select_metars" datasource="#request.AVNOPS_DS#">
				exec obsdb..sp_GetMETAR_bkr
					-170,
					-100,
					-20,
					40,
					3
			</cfquery>
	 --->
			<cfscript>
			   //stArgs = structNew();
			   stArgs.ERROR = "ERROR";
			   stArgs.METAR = select_metars;
   			   stArgs.NUMRECORDS = select_metars.recordcount;			  
			</cfscript>
		
			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="leaving component, record count = #select_metars.recordcount#"/>
			</cfif>
				
		<cfcatch>
				
			<cfsavecontent variable="debuginfo">
			<cfoutput>
			<div align="left">
			<table border="0" cellspacing="1" cellpadding="2" bgcolor="##999999" width="600" style="text-align:left; vertical-align:top; " border="1">
			<tr>
				<td ><strong>type</strong></td>
				<td bgcolor="##CCCCCC">Caught an exception, type = #CFCATCH.TYPE# </td>
			</tr>
			<tr>
				<td><strong>message</strong></td>
				<td bgcolor="##CCCCCC">#cfcatch.message#</td>
			</tr>
			<tr>
				<td><strong>detail</strong></td>
				<td bgcolor="##CCCCCC"> #cfcatch.detail#</td>
			</tr>
			<cfif cfcatch.Type EQ "Database">
			<tr>
				<td><strong>SQL</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.Sql#"></td>
			</tr>
			</cfif>
			<tr>
				<td><strong>tag stack</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.tagcontext#"></td>
			</tr>
			
			</table>
			</div> 
			</cfoutput>
			</cfsavecontent>				
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#debuginfo.html" output="#debuginfo#">
		</cfcatch>		
		
		</cftry>
		
		<cfreturn stArgs />	
		
	</cffunction>


	<cffunction access="remote" name="getStationData" returntype="struct" output="false">
		<cfscript>
		//break out the arguments
		//var bounding_box = Arguments[1].bBox; 
		//var flash_id = Arguments[1].flashID;
		var shape = '';
		var select_stations = '';
		var bounding_box = ''; 
		var flash_id = '';	
		var stArgs = structNew();
		
		try{
			bounding_box = Arguments[1].bBox; 
			flash_id = Arguments[1].flashID;
		} catch (Any excpt){
			bounding_box = Arguments.bBox; 
			flash_id = Arguments.flashID;
		}		
		struct_coordinates = deriveCoordinates(bounding_box);				
		</cfscript>
		
		
		<cftry>

			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="-----------------------------------------#chr(10)##chr(13)#entered layerDateGateway.getStationData() on #dateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now(), 'HH:MM:SS:')# FROM #CGI.REMOTE_ADDR#" />
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="Set Arguments::bBox = #bounding_box#, flashID =#flash_id#, shape=#struct_coordinates.shape#, size=#struct_coordinates.size#" />
  			</cfif>
		
			<cfquery name="select_stations" datasource="#request.AVNOPS_DS#">
			    SELECT icaoID, name, state, country, stnLat, stnLon, stnElev
				FROM obsdb..LOCATION 
                WHERE stnLon > #struct_coordinates.x3# AND stnLon < #struct_coordinates.x2#
            		AND stnLat > #struct_coordinates.y3# AND stnLat < #struct_coordinates.y1#
					<cfif #struct_coordinates.size#	EQ 1>
						AND displayPriority = 1
					<cfelseif #struct_coordinates.size#	EQ 2>
						AND displayPriority IN (1,2)
					<cfelseif #struct_coordinates.size#	EQ 3>
						AND displayPriority IN (1,2,3)
					</cfif>
			</cfquery>
			
		<cfscript>
			   //stArgs = structNew();
			   stArgs.ERROR = "ERROR";
			   stArgs.METAR = select_stations;
   			   stArgs.NUMRECORDS = select_stations.recordcount;
		</cfscript>

		<cfif variables.set_debug EQ 1>
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="leaving component, record count = #select_stations.recordcount#"/>
		</cfif>
		
		<cfcatch>
				
			<cfsavecontent variable="debuginfo">
			<cfoutput>
			<div align="left">
			<table border="0" cellspacing="1" cellpadding="2" bgcolor="##999999" width="600" style="text-align:left; vertical-align:top; " border="1">
			<tr>
				<td ><strong>type</strong></td>
				<td bgcolor="##CCCCCC">Caught an exception, type = #CFCATCH.TYPE# </td>
			</tr>
			<tr>
				<td><strong>message</strong></td>
				<td bgcolor="##CCCCCC">#cfcatch.message#</td>
			</tr>
			<tr>
				<td><strong>detail</strong></td>
				<td bgcolor="##CCCCCC"> #cfcatch.detail#</td>
			</tr>
			<cfif cfcatch.Type EQ "Database">
			<tr>
				<td><strong>SQL</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.Sql#"></td>
			</tr>
			</cfif>
			<tr>
				<td><strong>tag stack</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.tagcontext#"></td>
			</tr>
			
			</table>
			</div> 
			</cfoutput>
			</cfsavecontent>				
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#debuginfo.html" output="#debuginfo#">
		</cfcatch>		
		
		</cftry>
		
		<cfreturn stArgs />	
		
	</cffunction>

	<cffunction access="remote" name="getTAF" returntype="struct" output="false">
		<cfscript>
		//break out the arguments
		//var bounding_box = Arguments[1].bBox; 
		//var flash_id = Arguments[1].flashID;
		var stArgs = structNew();
		var shape = '';
		var select_tafs = '';
		var bounding_box = ''; 
		var flash_id = '';	
		
		try{
			bounding_box = Arguments[1].bBox; 
			flash_id = Arguments[1].flashID;
		} catch (Any excpt){
			bounding_box = Arguments.bBox; 
			flash_id = Arguments.flashID;
		}		
		struct_coordinates = deriveCoordinates(bounding_box);				
		</cfscript>
		
		
		<cftry>
			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="-----------------------------------------#chr(10)##chr(13)#entered layerDateGateway.getTAF() on #dateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now(), 'HH:MM:SS:')# FROM #CGI.REMOTE_ADDR#" />
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="Set Arguments::bBox = #bounding_box#, flashID =#flash_id#, shape=#struct_coordinates.shape#, size=#struct_coordinates.size#" />
  			</cfif>
			
			<cfquery name="select_tafs" datasource="#request.AVNOPS_DS#">
				exec avnfcstdb..sp_GetTAF
					#struct_coordinates.x3#,
					#struct_coordinates.x2#,
					#struct_coordinates.y3#,
					#struct_coordinates.y1#,
					#struct_coordinates.size#,
					-540  <!--- This is the time to go back from getdate() in minutes --->
			</cfquery>
			
			<cfscript>
				   //stArgs = structNew();
				   stArgs.ERROR = "ERROR";
				   stArgs.TAF = select_tafs;
				   stArgs.NUMRECORDS = select_tafs.recordcount;
			</cfscript>

			<cfif variables.set_debug EQ 1>
				<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="leaving component, record count = #select_tafs.recordcount#"/>
			</cfif>
		
		<cfcatch>
				
			<cfsavecontent variable="debuginfo">
			<cfoutput>
			<div align="left">
			<table border="0" cellspacing="1" cellpadding="2" bgcolor="##999999" width="600" style="text-align:left; vertical-align:top; " border="1">
			<tr>
				<td ><strong>type</strong></td>
				<td bgcolor="##CCCCCC">Caught an exception, type = #CFCATCH.TYPE# </td>
			</tr>
			<tr>
				<td><strong>message</strong></td>
				<td bgcolor="##CCCCCC">#cfcatch.message#</td>
			</tr>
			<tr>
				<td><strong>detail</strong></td>
				<td bgcolor="##CCCCCC"> #cfcatch.detail#</td>
			</tr>
			<cfif cfcatch.Type EQ "Database">
			<tr>
				<td><strong>SQL</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.Sql#"></td>
			</tr>
			</cfif>
			<tr>
				<td><strong>tag stack</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.tagcontext#"></td>
			</tr>
			
			</table>
			</div> 
			</cfoutput>
			</cfsavecontent>				
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#debuginfo.html" output="#debuginfo#">
		</cfcatch>		
		
		</cftry>
		
		<cfreturn stArgs />	
		
	</cffunction>
	
	<cffunction name="getPIREP" access="remote" returntype="struct" output="false">		
		
		<!--- This fuction has a filter for the flight level the user is wanting to view. --->
		<!--- <cfargument name="bounding_box" required="yes" type="string" />  --->
		 <cfscript>
		 	flightLevelTop = 45000;  //Get this from the client
			flightLevelBottom = 0;	//Get this from the client
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}		
			struct_coordinates = deriveCoordinates(bounding_box);	
		</cfscript>

		<cfif variables.set_debug EQ 1>
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="-----------------------------------------#chr(10)##chr(13)#entered layerDateGateway.getPIREP() on #dateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now(), 'HH:MM:SS:')# FROM #CGI.REMOTE_ADDR#" />
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="Set Arguments::bBox = #bounding_box#, flashID =#flash_id#, shape=#struct_coordinates.shape#, size=#struct_coordinates.size#" />
		</cfif>

		 <cfquery name="select_pireps" datasource="#request.AVNOPS_DS#">
			exec obsdb..sp_GetPIREP
					#struct_coordinates.x3#,
					#struct_coordinates.x2#,
					#struct_coordinates.y3#,
					#struct_coordinates.y1#,
					-120  <!--- This is the time to go back from getdate() in minutes --->		 
 		</cfquery>		 
		<cfscript>
			pirepStruct = structNew();
			pirepStruct.PIREP = select_pireps;
		    pirepStruct.NUMRECORDS = select_pireps.recordcount;
		</cfscript>	

		<cfif variables.set_debug EQ 1>
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#layerDataGateway.txt" output="leaving component, record count = #select_pireps.recordcount# FROM #CGI.REMOTE_ADDR#"/>
		</cfif>

		<cfreturn pirepStruct />	
	</cffunction>
	


	<!--- 
		********************************************************
		*************** XML Parsing **********************
		********************************************************
	--->
	
	<cffunction name="parseCellTopsMotion" access="remote" returntype="array" output="false">		
		<cfscript>
		var currentZoom = 0;
		var bounding_box = ''; 
		var flash_id = '';	
		
		try{
			bounding_box = Arguments[1].bBox; 
			flash_id = Arguments[1].flashID;
		} catch (Any excpt){
			bounding_box = Arguments.bBox; 
			flash_id = Arguments.flashID;
		}		
		struct_coordinates = deriveCoordinates(bounding_box);			
		currentZoom = (abs(struct_coordinates.x3 - struct_coordinates.x2));	
		//currentZoom = 40;
		</cfscript>
		 <cffile action="read" file="D:\Data\console\flash\xml\conus_topsmotion.xml" variable="ctmFile"> 
		<!---<cffile action="read" file="D:\Data\console\flash\xml\newtops.xml" variable="ctmFile">--->
		 <CFSET ctMotion=XMLParse(ctmFile)> 	
		 
 		<cftry>

		<cfscript>	
			stArray = arrayNew(1);	
			selectedElements = XmlSearch(ctMotion, "/spotset/spot");	
			for(i=1;i LT ArrayLen(selectedElements); i=i+1) {						
				stTops = structNew();				
				stTops.CTOP = ctMotion.XmlRoot.XmlChildren[i].XmlChildren[4].XmlText;
				stTops.CSPEED = ctMotion.XmlRoot.XmlChildren[i].XmlChildren[3].XmlText;
				stTops.CDIR = ctMotion.XmlRoot.XmlChildren[i].XmlChildren[2].XmlText;
				stTops.PROX = ctMotion.XmlRoot.XmlChildren[i].XmlChildren[5].XmlText;				
				tmpList = ListToArray(ctMotion.XmlRoot.XmlChildren[i].XmlChildren[1].XmlChildren[1].XmlText, ",");
				stTops.CLAT = tmpList[2];
				stTops.CLON = tmpList[1];				
				if((ctMotion.XmlRoot.XmlChildren[i].XmlChildren[5].XmlText) gt currentZoom) {
					stArray[i] = stTops;			
				}
			}	
		</cfscript>	
		
		<cfcatch>
				
			<cfsavecontent variable="debuginfo">
			<cfoutput>
			<div align="left">
			<table border="0" cellspacing="1" cellpadding="2" bgcolor="##999999" width="600" style="text-align:left; vertical-align:top; " border="1">
			<tr>
				<td ><strong>type</strong></td>
				<td bgcolor="##CCCCCC">Caught an exception, type = #CFCATCH.TYPE# </td>
			</tr>
			<tr>
				<td><strong>message</strong></td>
				<td bgcolor="##CCCCCC">#cfcatch.message#</td>
			</tr>
			<tr>
				<td><strong>detail</strong></td>
				<td bgcolor="##CCCCCC"> #cfcatch.detail#</td>
			</tr>
			<cfif cfcatch.Type EQ "Database">
			<tr>
				<td><strong>SQL</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.Sql#"></td>
			</tr>
			</cfif>
			<tr>
				<td><strong>tag stack</strong></td>
				<td bgcolor="##CCCCCC"><cfdump var="#cfcatch.tagcontext#"></td>
			</tr>
			
			</table>
			</div> 
			</cfoutput>
			</cfsavecontent>				
			<cffile action="append" addnewline="yes" file="#variables.debug_file_path#debuginfo.html" output="#debuginfo#">		
		
				</cfcatch>		
		
		</cftry>

		<cfreturn stArray />	
	</cffunction>


 
	<cffunction name="parse00ZFntHiLo" access="remote" returntype="struct" output="false">
		<!--- Need to do the bump orientation here instead of in Flash.  
			  I'll passback the bump type...rotation....and centerposition --->
		<cfscript>
			var selectedElementsFront = arrayNew(1);
			var selectedElementsHiLo = arrayNew(1);
			var	someTmpArray = arrayNew(1);
			
			var tmpArrayBump = arrayNew(1);
			var tempArrayFront = arrayNew(1);	
			var tempArrayHiLo = arrayNew(1);	
			var	frontStruct = structNew();	
			var bounding_box = '';
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			struct_coordinates = deriveCoordinates(bounding_box);		
		</cfscript>			
		<cffile action="read" file="D:\Data\console\flash\xml\fronts_00.xml" variable="front00File">		
		<CFSET tempFront=XMLParse(front00File)> 	 
		<cfscript>	
			selectedElementsFront = XmlSearch(tempFront, "/chart/curveset/curve");	
			errorCnt = 0;		
			for(i=2;i LTE ArrayLen(selectedElementsFront); i=i+1) {		
				succCnt = 0;						
				tempLevel = structNew();				
				tempLevel.TYPE = tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[1].XmlText;
				tempLevel.HAND = tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlText;
				tmpLineList = ListToArray(tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[3].XmlChildren[1].XmlText, ",");	
				tempLevel.STRINGOFPOINTS = tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[3].XmlChildren[1].XmlText;	
				for(p=1;p LT ArrayLen(tmpLineList);p=p+2) {
					if((tmpLineList[p] GT struct_coordinates.x3 AND tmpLineList[p] LT struct_coordinates.x2) AND (tmpLineList[p+1] GT struct_coordinates.y3 AND tmpLineList[p+1] LT struct_coordinates.y1)) {
						succCnt = 1;		
					}					
				}
				if(succCnt EQ 1) {			
					tempArrayFront[i+errorCnt] = tempLevel;						
				}
				else {
					errorCnt = errorCnt + 1;
				}			
			}		
			frontStruct.FRONTARRAY = tempArrayFront;						
		</cfscript>
		<cfscript>
			selectedElementsFront = XmlSearch(tempFront, "/chart/curveset/curve");	
			errorCnt = 0;		
			for(i=2;i LTE ArrayLen(selectedElementsFront); i=i+1) {		
				succCnt = 0;						
				tempLevel = structNew();		
				tmpSpanArray = arrayNew(1);		
				tempLevel.TYPE = tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[1].XmlText;
				tempLevel.HAND = tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlText;
				tempLevel.COUNT = 0;
				tmpLineList = ListToArray(tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[3].XmlChildren[1].XmlText, ",");	
				bufferedArray = arrayNew(1);	
				bArrayCount = 1;
				loopRoundCount = ArrayLen(tmpLineList) MOD 4;
				if(loopRoundCount NEQ 0) {
					loopRoundCount = ArrayLen(tmpLineList) - 2;
				}
				else {
					loopRoundCount = ArrayLen(tmpLineList);
				}
				//for(p=1;p LTE ArrayLen(tmpLineList);p=p+4) {
				for(p=1;p LTE loopRoundCount;p=p+4) {
					if((tmpLineList[p] GT struct_coordinates.x3 AND tmpLineList[p] LT struct_coordinates.x2) AND (tmpLineList[p+1] GT struct_coordinates.y3 AND tmpLineList[p+1] LT struct_coordinates.y1)) {
						succCnt = 1;						
						/*bufferedArray[bArrayCount]=tmpLineList[p];
						bufferedArray[bArrayCount+1]=tmpLineList[p+1];
						bufferedArray[bArrayCount+8]=tmpLineList[p+2];
						bufferedArray[bArrayCount+9]=tmpLineList[p+3];
						bufferedArray[bArrayCount+4]=(tmpLineList[p]+tmpLineList[p+2])/2;
						bufferedArray[bArrayCount+5]=(tmpLineList[p+1]+tmpLineList[p+3])/2;
						bufferedArray[bArrayCount+2]=(bufferedArray[bArrayCount+4]+bufferedArray[bArrayCount])/2;
						bufferedArray[bArrayCount+3]=(bufferedArray[bArrayCount+5]+bufferedArray[bArrayCount+1])/2;
						bufferedArray[bArrayCount+6]=(bufferedArray[bArrayCount+8]+bufferedArray[bArrayCount+4])/2;
						bufferedArray[bArrayCount+7]=(bufferedArray[bArrayCount+9]+bufferedArray[bArrayCount+5])/2;
						bArrayCount = bArrayCount+10;*/
						}										
					bufferedArray[bArrayCount]=tmpLineList[p];
					bufferedArray[bArrayCount+1]=tmpLineList[p+1];
					bufferedArray[bArrayCount+8]=tmpLineList[p+2];
					bufferedArray[bArrayCount+9]=tmpLineList[p+3];
					bufferedArray[bArrayCount+4]=(tmpLineList[p]+tmpLineList[p+2])/2;
					bufferedArray[bArrayCount+5]=(tmpLineList[p+1]+tmpLineList[p+3])/2;
					bufferedArray[bArrayCount+2]=(bufferedArray[bArrayCount+4]+bufferedArray[bArrayCount])/2;
					bufferedArray[bArrayCount+3]=(bufferedArray[bArrayCount+5]+bufferedArray[bArrayCount+1])/2;
					bufferedArray[bArrayCount+6]=(bufferedArray[bArrayCount+8]+bufferedArray[bArrayCount+4])/2;
					bufferedArray[bArrayCount+7]=(bufferedArray[bArrayCount+9]+bufferedArray[bArrayCount+5])/2;
					bArrayCount = bArrayCount+10;			
				}
				if(succCnt EQ 1) {		

					tempLevel.COUNT = ArrayLen(bufferedArray);
					spanCounter = ((ArrayLen(bufferedArray))/2)-4;					
					tmpIndex = 1;
					for(q=1;q LTE (spanCounter*2);q=q+2) {				
						tmpPointArray = arrayNew(1);
						tmpPointArray[1] = (bufferedArray[q]+bufferedArray[q+2]+bufferedArray[q+4])/3;
						tmpPointArray[2] = (bufferedArray[q+1]+bufferedArray[q+3]+bufferedArray[q+5])/3;
						if((bufferedArray[q+1]-bufferedArray[q+5]) eq 0) {
							tmpSlope = 1;
						}
						else if((bufferedArray[q]-bufferedArray[q+4]) eq 0) {
							tmpSlope = 1;
						}
						else {
						 	tmpSlope =(bufferedArray[q+1]-bufferedArray[q+5]) / (bufferedArray[q]-bufferedArray[q+4]);
						}
						if(tempFront.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlText EQ "R") {
							if(tmpSlope eq 1) {
								//tmpPointArray[3] = 90;			
								//This is not correct....needs to be a case where this resolves to 90					
								tmpPointArray[3] = 180;
								if((bufferedArray[q+1]-bufferedArray[q+5]) neq 0) { tmpPointArray[3] = 90; }
							}
							else {
								tmpPointArray[3] = 180-((atn(tmpSlope) * 180/Pi()));
							}
						}
						else {
							if(tmpSlope eq 1) {
								tmpPointArray[3] = -90;								
							}
							else {
								tmpPointArray[3] = (180-((atn(tmpSlope) * 180/Pi()))+180);
							}
						}
						tmpSpanArray[tmpIndex] = tmpPointArray;	
						tmpIndex=tmpIndex+1;				
					}
					tempLevel.SPANARRAY = tmpSpanArray;
					tempArrayFront[i+errorCnt] = tempLevel;					
				}
				else {
					errorCnt = errorCnt + 1;
				}			
			}		
			frontStruct.BUMPARRAY = tempArrayFront;		
		</cfscript>
		<cffile action="read" file="D:\Data\console\flash\xml\hilo_00.xml" variable="hilo00File">		
		<CFSET tempHiLo=XMLParse(hilo00File)> 		
		<cfscript>
		
			errorCount = 0;
			selectedElementsHiLo = XmlSearch(tempHiLo, "/chart/spotset/spot");	
			for(i=2;i LTE ArrayLen(selectedElementsHiLo); i=i+1) {						
				tmpHiLO = structNew();
				tmpHiLO.STRINGOFPOINTS = tempHiLo.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[1].XmlChildren[1].XmlText;	
				tmpList = ListToArray(tempHiLo.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[1].XmlChildren[1].XmlText, ",");				
				tmpHiLO.TYPE = tempHiLo.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlText;	
				tmpHiLO.PVAL = tempHiLo.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[3].XmlText;			
				if((tmpList[1] GT struct_coordinates.x3 AND tmpList[1] LT struct_coordinates.x2) AND (tmpList[2] GT struct_coordinates.y3 AND tmpList[2] LT struct_coordinates.y1)) {
					tempArrayHiLo[i+errorCount] = tmpHiLO;			
				}
				else {
					errorCount = errorCount+1;
				}
			}
			frontStruct.HILOARRAY = tempArrayHiLo; 				
		</cfscript>	
		<cfreturn frontStruct />	
	</cffunction>


	<cffunction name="parse_48Z_Pres" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "pressure_48.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_24Z_Pres" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "pressure_24.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_12Z_Pres" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "pressure_12.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_00Z_Pres" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "pressure_00.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_300_06Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_300_06.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_300_24Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_300_24.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>
	
	<cffunction name="parse_300_18Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_300_18.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_300_12Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_300_12.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	

	<cffunction name="parse_300_00Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_300_00.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>
	<cffunction name="parse_250_18Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_250_18.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_250_06Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_250_06.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_250_24Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_250_24.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_250_12Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_250_12.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_250_00Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_250_00.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>
	<cffunction name="parse_200_18Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_200_18.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_200_06Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_200_06.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_200_24Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_200_24.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>

	<cffunction name="parse_200_12Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_200_12.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	

	<cffunction name="parse_200_00Z_Temp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_200_00.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	

	<cffunction name="parseTropoHeight" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "gztropo.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	
	

	<cffunction name="parsePressure" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "pressure.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	

	<cffunction name="parseFreezingLevel" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "frzlvl.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	
	
	
	<cffunction name="parse00SurfaceTemp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_sfc_00.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>
	<cffunction name="parse12SurfaceTemp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_sfc_12.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>
	<cffunction name="parse24SurfaceTemp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_sfc_24.xml";
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;				
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	
	<cffunction name="parse36SurfaceTemp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_sfc_36.xml";		
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;		
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>	
	<cffunction name="parse48SurfaceTemp" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "temp_sfc_48.xml";
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;	
			tmpArray = buildSimpleContours(xmlFileName, boundingB);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>
	<!--- 
	Function: parseTurb 
	Description: Turbulence areas
	--->
	<!--- <cffunction name="parseTurb" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "turb.xml";
			pType = Arguments[1].polyType;
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;	
			tmpArray = buildPolygonsXML(xmlFileName, boundingB, pType);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction>
	<cffunction name="parseCnvc" access="remote" returntype="array" output="false">
		<cfscript>	
			tmpArray = arrayNew(1);	
			xmlFileName = "cnvc.xml";
			pType = Arguments[1].polyType;
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;	
			tmpArray = buildPolygonsXML(xmlFileName, boundingB, pType);
		</cfscript>	
		<cfreturn tmpArray />		
	</cffunction> --->	
	<cffunction name="parseSigmet" access="remote" returntype="struct" output="false">
		<cfscript>	
			tmpStruct = structNew();
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;	
			pType = "SIGMET";
			tmpStruct = buildPolygonsDB(boundingB, pType);
		</cfscript>	
		<cfreturn tmpStruct />		
	</cffunction>
	<cffunction name="parseAirmet" access="remote" returntype="struct" output="false">
		<cfscript>	
			tmpStruct = structNew();
			try{
				bounding_box = Arguments[1].bBox; 
				flash_id = Arguments[1].flashID;
			} catch (Any excpt){
				bounding_box = Arguments.bBox; 
				flash_id = Arguments.flashID;
			}
			boundingB = bounding_box;	
			pType = "AIRMET";
			tmpStruct = buildPolygonsDB(boundingB, pType);
		</cfscript>	
		<cfreturn tmpStruct />		
	</cffunction>

	
	<cffunction name="buildSimpleContours" access="public" returntype="array" output="false">	
		<cfargument name="xmlFileName" required="yes" type="string" />
		<cfargument name="boundingB" required="yes" type="string" />
		<cfscript>
		var bounding_box = '';
		bounding_box = arguments.boundingB;
		struct_coordinates = deriveCoordinates(bounding_box);					
		tmpFName = arguments.xmlFileName;
		</cfscript>			
		<cffile action="read" file="D:\Data\console\flash\xml\#tmpFName#" variable="tmpFilePoint">
		 <CFSET tFileLvl=XMLParse(tmpFilePoint)> 	
		<cfscript>		
			selectedElements = XmlSearch(tFileLvl, "/chart/curveset/curve");	
			errorCnt = 0;	
			eleArray = arrayNew(1);	
			descStruct = structNew();
			descStruct.ITIME = tFileLvl.XmlRoot.XmlChildren[1].XmlChildren[3].XmlText;
			descStruct.VTIME = tFileLvl.XmlRoot.XmlChildren[1].XmlChildren[4].XmlText;
			eleArray[1] = descStruct;
			for(i=1;i LTE ArrayLen(selectedElements); i=i+1) {  //Changed the i to equal 1 instead of two.
				succCnt = 0;						
				dataStruct = structNew();				
				dataStruct.CVAL = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[1].XmlText;				
				tmpLineList = ListToArray(tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlChildren[1].XmlText, ",");	
				dataStruct.STRINGOFPOINTS = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlChildren[1].XmlText;	
				for(p=1;p LT ArrayLen(tmpLineList);p=p+2) {
					if((tmpLineList[p] GT struct_coordinates.x3 AND tmpLineList[p] LT struct_coordinates.x2) AND (tmpLineList[p+1] GT struct_coordinates.y3 AND tmpLineList[p+1] LT struct_coordinates.y1)) {
						succCnt = 1;		
					}					
				}
				if(succCnt EQ 1) {			
					eleArray[i+errorCnt] = dataStruct;		
				}
				else {
					errorCnt = errorCnt + 1;
				}			
			}	
		</cfscript>	
		<cfreturn eleArray />		
	</cffunction>
	<!--- <cffunction name="buildPolygonsXML" access="public" returntype="array" output="false">	
		<cfargument name="xmlFileName" required="yes" type="string" />
		<cfargument name="boundingB" required="yes" type="string" />
		<cfargument name="pType" required="yes" type="string" />
		<cfscript>
		var bounding_box = '';
		var polyType = '';
		polyType = arguments.pType;
		bounding_box = arguments.boundingB;
		struct_coordinates = deriveCoordinates(bounding_box);					
		tmpFName = arguments.xmlFileName;
		</cfscript>			
		<cffile action="read" file="D:\Data\console\flash\xml\#tmpFName#" variable="tmpFilePoint">
		 <CFSET tFileLvl=XMLParse(tmpFilePoint)> 	
		<cfscript>		
			selectedElements = XmlSearch(tFileLvl, "/chart/areaset/area");
			errorCnt = 0;	
			eleArray = arrayNew(1);	
			descStruct = structNew();

			descStruct.ITIME = tFileLvl.XmlRoot.XmlChildren[1].XmlChildren[3].XmlText;
			descStruct.VTIME = tFileLvl.XmlRoot.XmlChildren[1].XmlChildren[4].XmlText;
			eleArray[1] = descStruct;

			for(i=2;i LTE ArrayLen(selectedElements); i=i+1) {
				succCnt = 0;						
				dataStruct = structNew();				
				if(polyType EQ "turb") {
					dataStruct.SIGTYPE = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[1].XmlText;				
					dataStruct.SIGLEVEL = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlText;	
					dataStruct.SEVERITY = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[3].XmlText;	
					dataStruct.BASE = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[4].XmlText;	
					dataStruct.TOP = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[5].XmlText;					
					tmpLineList = ListToArray(tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[6].XmlChildren[1].XmlText, ",");	
					dataStruct.STRINGOFPOINTS = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[6].XmlChildren[1].XmlText;	
				}
				if(polyType EQ "cnvc") {
					dataStruct.SIGTYPE = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[1].XmlText;				
					dataStruct.SIGLEVEL = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[2].XmlText;	
					dataStruct.COVERAGE = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[3].XmlText;	
					dataStruct.AVGTOP = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[4].XmlText;	
					dataStruct.MAXTOP = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[5].XmlText;					
					tmpLineList = ListToArray(tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[6].XmlChildren[1].XmlText, ",");	
					dataStruct.STRINGOFPOINTS = tFileLvl.XmlRoot.XmlChildren[2].XmlChildren[i].XmlChildren[6].XmlChildren[1].XmlText;	
				}		
				dataStruct.ERRORCOLLECT = 0;
				for(p=1;p LT ArrayLen(tmpLineList);p=p+2) {
					if((tmpLineList[p] GT struct_coordinates.x3 AND tmpLineList[p] LT struct_coordinates.x2) AND (tmpLineList[p+1] GT struct_coordinates.y3 AND tmpLineList[p+1] LT struct_coordinates.y1)) {
						succCnt = 1;		
					}					
				}
				if(succCnt EQ 1) {			
					eleArray[i+errorCnt] = dataStruct;						
				}
				else {
					errorCnt = errorCnt + 1;
					dataStruct.ERRORCOLLECT = 1;	
				}			
			}	
		</cfscript>	
		<cfreturn eleArray />		
	</cffunction> --->


	<cffunction name="buildPolygonsDB" access="public" returntype="struct" output="false">	
		<cfargument name="boundingB" required="yes" type="string" />		
		<cfargument name="pType" required="yes" type="string" />
		<cfscript>
		var bounding_box = '';
		var polyType = '';
		bounding_box = arguments.boundingB;		
		polyType = arguments.pType;
		struct_coordinates = deriveCoordinates(bounding_box);					
		</cfscript>			
		<cfif polyType is "SIGMET">
			<cfinvoke component="qryGetValidSIGMETS" method="init" returnvariable="SIGS" />
			<cfscript>		
				sigmetStruct = structNew();
				sigmetStruct.SIGMET = SIGS;
				sigmetStruct.NUMRECORDS = SIGS.recordcount;	
			</cfscript>	
			<cfreturn sigmetStruct />
		</cfif>		
		<cfif polyType is "AIRMET">
			<cfinvoke component="qryGetValidAIRMETS" method="init" returnvariable="AIRS" />
			<cfscript>		
				airmetStruct = structNew();
				airmetStruct.AIRMET = AIRS;
				airmetStruct.NUMRECORDS = AIRS.recordcount;	
			</cfscript>	
			<cfreturn airmetStruct />
		</cfif>
		
	</cffunction>
<!--- 
Function: getLayerArray
Description:  This function calls the getLayerArr object which returns an array of layer ids and their corresponding layer names
 --->
	<cffunction name="getLayerArray" access="remote" returntype="array" output="false">
		<cfscript>		
			var layerArray = arrayNew(2);
		</cfscript>
		<cfinvoke component="com.weathernews.beacon.DAO.getLayerArr" method="init" returnvariable="arrLayers" />		
		<cfscript>				
		layerArray = arrLayers;
		</cfscript>
		<cfreturn layerArray />
	</cffunction>


<!--- 
Function: objToFlashAnimation
Description:  This function returns the users request details for animimations....more later
 --->
	<cffunction name="objToFlashAnimation" access="remote" returntype="struct" output="false">
		<cfset var myLayer =  ""/>
		<cfinclude template="/include/GlobalParams.cfm" />
		<!--- Define the layer array --->
		<cfset arguments.arrLayers = ArrayNew(1) />
		<cfset myLayer = "" />
		<!--- Get user's mid --->
		<cfset flashID = SESSION.flashID />
		
		
		<!--- Get the database information for user --->
		<cfset variables.getLayerAndBbox = CreateObject("component","com.weathernews.beacon.DAO.getBboxAndLayers").init(flashID) />
		
		<!--- Check to see if the list is numbers or words --->
		<cfif REFindNoCase("[0-9]",variables.getLayerAndBbox.layerString) >
			<cf_Layers2Text LayersIN="#variables.getLayerAndBbox.layerString#" Display="0">
			<cfset mapLayers = LayersOut>
		<cfelse>
			<cfset mapLayers = variables.getLayerAndBbox.layerString />
		</cfif>
		<cfset backgroundLayers = "," />
		
		<cfloop list="#mapLayers#" index="bakLayer">
		
			<cfquery name="query.getLegacyID" datasource="#INTRANET_DS#" cachedwithin="#createTimeSpan(0,0,45,0)#">
				SELECT legacyID, layerName, id
				FROM AvnLayer
				WHERE layerName = '#bakLayer#' AND legacyID < 100
			</cfquery>
			
			<cfset backgroundLayers = backgroundLayers & query.getLegacyID.layerName & "," />
		</cfloop>
		<cfset normalLyr = "Borders,Coastlines,US State Borders,Counties,Countries" />
		<!--- <cfset backgroundLayers = Left(backgroundLayers,ListLen(backgroundLayers) - 1) /> --->
		<cfloop list="#normalLyr#" index="nmlyr">
			<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,nmlyr)) />
		</cfloop>
		<!--- remove the trailing comma --->
		<cfset backgroundLayers = Left(backgroundLayers,Len(backgroundLayers) - 1) />
		<!--- Loop over list to find out if any of the layers meet the criteria--->
		<cfloop list="#mapLayers#" index="curLayer">
			
			<!--- Switch Statement on Database return for user's layers 
				  The case statement should contain the layer's name in the database or XML file,
				  not the display name --->
			<cfswitch expression="#curLayer#">
				
				<cfcase value="CONUSIR">
					
					<cfset myLayer = "CONUSIR" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "CONUSIR_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "CONUSIR_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "CONUSIR_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "CONUSIR_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "CONUSIR_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "CONUSIR_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="CONUSVS">
					
					<cfset myLayer = "CONUSVS" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "CONUSVS_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "CONUSVS_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "CONUSVS_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "CONUSVS_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "CONUSVS_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "CONUSVS_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="CONUSWV">
					
					<cfset myLayer = "CONUSWV" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "CONUSWV_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "CONUSWV_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "CONUSWV_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "CONUSWV_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "CONUSWV_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "CONUSWV_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="EUROPE_IR_NH">
					
					<cfset myLayer = "EUROPE_IR_NH" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "EUROPE_IR_NH_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "EUROPE_IR_NH_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "EUROPE_IR_NH_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "EUROPE_IR_NH_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "EUROPE_IR_NH_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "EUROPE_IR_NH_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
				
				
				</cfcase>
				
				<cfcase value="EUROPE_VS_NH">
					
					<cfset myLayer = "EUROPE_VS_NH" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "EUROPE_VS_NH_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "EUROPE_VS_NH_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "EUROPE_VS_NH_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "EUROPE_VS_NH_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "EUROPE_VS_NH_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "EUROPE_VS_NH_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="EUROPE_WV_NH">
				
					<cfset myLayer = "EUROPE_WV_NH" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "EUROPE_WV_NH_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "EUROPE_WV_NH_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "EUROPE_WV_NH_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "EUROPE_WV_NH_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "EUROPE_WV_NH_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "EUROPE_WV_NH_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="ASIA_IR_NH">
					
					<cfset myLayer = "ASIA_IR_NH" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "ASIA_IR_NH_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "ASIA_IR_NH_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "ASIA_IR_NH_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "ASIA_IR_NH_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "ASIA_IR_NH_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "ASIA_IR_NH_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="ASIA_WV_NH">
				
					<cfset myLayer = "ASIA_WV_NH" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "ASIA_WV_NH_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "ASIA_WV_NH_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "ASIA_WV_NH_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "ASIA_WV_NH_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "ASIA_WV_NH_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "ASIA_WV_NH_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="CONUS Radar Mosaic">
				
					<cfset myLayer = "CONUS Radar Mosaic" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "conus_mosaic_12,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "conus_mosaic_10,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "conus_mosaic_8,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "conus_mosaic_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "conus_mosaic_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "conus_mosaic_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />

				</cfcase>
				
				<cfcase value="EUROPE Radar Mosaic">
				
					<cfset myLayer = "EUROPE Radar Mosaic" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "europe_mosaic_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "europe_mosaic_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "europe_mosaic_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "europe_mosaic_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "europe_mosaic_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "europe_mosaic_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="CONUS_RDR_WIN">
					
					<cfset myLayer = "CONUS_RDR_WIN" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "CONUS_RDR_WIN_12,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "CONUS_RDR_WIN_10,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "CONUS_RDR_WIN_8,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "CONUS_RDR_WIN_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "CONUS_RDR_WIN_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "CONUS_RDR_WIN_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="US Composite">
					
					<cfset myLayer = "US Composite" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "CONUS_RDR_COMP,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "CONUS_RDR_COMP,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "CONUS_RDR_COMP,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "CONUS_RDR_COMP,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "CONUS_RDR_COMP,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "CONUS_RDR_COMP,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="SatelliteWV">
					
					<cfset myLayer = "SatelliteWV" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "SatelliteWV_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "SatelliteWV_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "SatelliteWV_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "SatelliteWV_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "SatelliteWV_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "SatelliteWV_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
				<cfcase value="SatelliteIR">
					
					<cfset myLayer = "SatelliteIR" />
					<cfset backgroundLayers = ListDeleteAt(backgroundLayers,listFindNoCase(backgroundLayers,myLayer)) />
					<cfset arguments.arrLayers[1] = "SatelliteIR_6,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[2] = "SatelliteIR_5,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[3] = "SatelliteIR_4,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[4] = "SatelliteIR_3,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[5] = "SatelliteIR_2,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					<cfset arguments.arrLayers[6] = "SatelliteIR_1,Borders,Coastlines,US State Borders,Counties" & backgroundLayers />
					
				</cfcase>
				
			</cfswitch>
		</cfloop>
		
		<!--- <cfscript>			
				animationStruct = structNew();
				animationStruct.BBOX = "-125.117058820898,20.5824146950512,-72.3070212771477,50.3947821573447";
				animationStruct.SERVERURL="https://beacon-dev.wni.com/";
				animationStruct.MAPNAME="WorldMap4";
				animationStruct.CONTAINERSIZE="1314,400";
				//Array of layers
				//Layers go from top down and oldest to newest
				animationStruct.LAYERARRAY = arrayNEW(1);
				
				/*
				animationStruct.LAYERARRAY[1] = "CONUSIR_6,Borders,Coastlines";
				animationStruct.LAYERARRAY[2] = "CONUSIR_5,Borders,Coastlines";
				animationStruct.LAYERARRAY[3] = "CONUSIR_4,Borders,Coastlines";
				animationStruct.LAYERARRAY[4] = "CONUSIR_3,Borders,Coastlines";
				animationStruct.LAYERARRAY[5] = "CONUSIR_2,Borders,Coastlines";
				animationStruct.LAYERARRAY[6] = "CONUSIR_1,Borders,Coastlines";
				*/
				animationStruct.LAYERARRAY[1] = "SatelliteIR_6,Borders,Coastlines";
				animationStruct.LAYERARRAY[2] = "SatelliteIR_5,Borders,Coastlines";
				animationStruct.LAYERARRAY[3] = "SatelliteIR_4,Borders,Coastlines";
				animationStruct.LAYERARRAY[4] = "SatelliteIR_3,Borders,Coastlines";
				animationStruct.LAYERARRAY[5] = "SatelliteIR_2,Borders,Coastlines";
				animationStruct.LAYERARRAY[6] = "SatelliteIR_1,Borders,Coastlines";

				//2D Array of times
				animationStruct.TIMEARRAY = arrayNEW(2);				
				animationStruct.TIMEARRAY[1][1] = "1,13,2006:1605GMT GOES WEST   1,13,2006:1505GMT GOES EAST   1,13,2006:1405GMT MSG";				
				animationStruct.TIMEARRAY[2][1] = "1,13,2006:1610GMT GOES WEST   1,13,2006:1510GMT GOES EAST   1,13,2006:1410GMT MSG";				
				animationStruct.TIMEARRAY[3][1] = "1,13,2006:1615GMT GOES WEST   1,13,2006:1515GMT GOES EAST   1,13,2006:1415GMT MSG";
				animationStruct.TIMEARRAY[4][1] = "1,13,2006:1620GMT GOES WEST   1,13,2006:1520GMT GOES EAST   1,13,2006:1420GMT MSG";				
				animationStruct.TIMEARRAY[5][1] = "1,13,2006:1625GMT GOES WEST   1,13,2006:1525GMT GOES EAST   1,13,2006:1425GMT MSG";				
				animationStruct.TIMEARRAY[6][1] = "1,13,2006:1630GMT GOES WEST   1,13,2006:1530GMT GOES EAST   1,13,2006:1430GMT MSG";				
		</cfscript>	 --->
		<!--- Set the values that will be passed into the CFC --->
		<cfset arguments.bbox = variables.getLayerAndBbox.bbox />
		<cfset arguments.serverURL = "http://demis-qa.wni.com/" />
		<cfset arguments.mapName = "WorldMap4" />
		<cfset arguments.StageW = variables.getLayerAndBbox.StageW />
		<cfset arguments.StageH = variables.getLayerAndBbox.StageH />
		
		<cfquery name="query.getTimeFileName" datasource="#INTRANET_DS#">
			SELECT timeFileList
			FROM AvnLayer
			WHERE layerName = '#myLayer#'
		</cfquery>
		
		<cfset arguments.timeFileName = query.getTimeFileName.timeFileList />
		
		
		<cfset animationStruct = CreateObject("component","com.weathernews.beacon.feedAnimationMovie").init(arguments.arrLayers,
																										    arguments.bBox,
																										    arguments.serverUrl,
																										    arguments.mapName,
																										    arguments.StageW,
																										    arguments.StageH,
																										    arguments.timeFileName) />
		
		<cfreturn animationStruct />		
	</cffunction>

	
	<cffunction name="deriveCoordinates" access="public" returntype="struct" output="false">
	
		<cfargument name="bounding_box" required="yes" type="string" />
	
		<cfscript>
		/*		
		derive missing coordinate points for the bounding box.
		
		x = longitude, y = latitude
		
		bounding box delivers coordinates for areas 3 and 4
		
		3x, 3y, 4x, 4y
		 
		ex:-133.138258633871,33.8651235754053,-41.4183387844118,54.4313800099924
		
							y		
		+-------------------+-------------------+
		|					|		 			|
		|		 1			|		 4			|
		|					|					|
		+-------------------+-------------------+ x
		|					|					|
		|		 3			|		 2			|
		|					|					|
		+-------------------+-------------------+
		
		*/
		//default values
		
		var x1 ='';
		var y1 ='';
		
		var x2 ='';
		var y2 ='';
		
		var x3 ='';
		var y3 ='';
		
		var x4 ='';
		var y4 ='';
		
		var size = 3;
		var distance = 360;
		
		//var list_map_layers = evaluate("cookie.MAPLAYERS_" & flashID);
		//117.833050824742,42.5225174856738,238.257614841893,65.4267090383558
		// set coordinates
		
		x3 = trim(listGetAt(arguments.bounding_box, 1));
		y3 = trim(listGetAt(arguments.bounding_box, 2));	
		
		x4 = trim(listGetAt(arguments.bounding_box, 3));
		y4 = trim(listGetAt(arguments.bounding_box, 4));	
		/*
		x3 = trim(listGetAt(arguments.bounding_box, 3));
		y3 = trim(listGetAt(arguments.bounding_box, 4));	
		
		x4 = trim(listGetAt(arguments.bounding_box, 1));
		y4 = trim(listGetAt(arguments.bounding_box, 2));*/		
		//new code here 12-13-2005
		
		if(x3 GT 180) { x3 = -1*(180-(x3-180)); }
		if(x4 GT 180) { x4 = -1*(180-(x4-180)); }
		if(x3 LT -180) { x3 = (180-(abs(x3)-180)); }
		if(x4 LT -180) { x4 = (180-(abs(x4)-180)); }

		
		x1 = x3;
		y1 = y4;
		
		x2 = x4;
		y2 = y3;
		
		
		//determine the shape
		if ((x2-x3) EQ (y1-y3))
		{
			shape = 'square';	
		} 
		
		if ((x2-x3) GT (y1-y3)){
			//use y1 to  y3 first in where clause
			shape = 'horizontal_rectangle';
		} 
		
		if ((x2-x3) LT (y1-y3)){
			//use x2 to x3 first in where clause
			shape = 'vertical_rectangle';
		}
		
		//determine the size
		// 1 is big; 2 is medium; 3 is small
		
		
		if (x1 LT 0) {
			if (x4 LT 0)
				distance = abs(-x1+x4);
			else 
				distance = abs(x4-x1);
		}
		else		
			distance = abs(x4-x1);
		
		if (distance GT 40)
		{
			size = 1;
		}
		else if (distance GT 20)
		{
			size = 2;
		}
		
		///TESTING 2-13-2006
		if (x3 lt 0) {
			if(x2 LT 0) {
			  if(x3 GT x2) {
			  	x3 = -179;
			  	x2 = 179;
			  } //if(x3 GT x2)
			} //if(x2 LT 0)
		} //if (x3 lt 0)

		struct_coordinates = structNew();
		struct_coordinates.x1 = x1;
		struct_coordinates.y1 = y1;
		struct_coordinates.x2 = x2;
		struct_coordinates.y2 = y2;
		struct_coordinates.x3 = x3;
		struct_coordinates.y3 = y3;
		struct_coordinates.x4 = x4;
		struct_coordinates.y4 = y4;
		struct_coordinates.shape = shape;		
		struct_coordinates.size = size;		
		</cfscript>
		
		<cfreturn struct_coordinates/>		
	</cffunction>
</cfcomponent>