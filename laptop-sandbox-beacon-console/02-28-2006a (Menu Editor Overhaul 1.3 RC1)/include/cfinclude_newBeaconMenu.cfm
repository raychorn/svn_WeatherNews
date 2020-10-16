	<cfscript>
		const_menuDisplayRecord_symbol = 'menuDisplayRecord';

		Request.cf_html_container_symbol = "html_container";
		Request.const_jsapi_loading_image = "/images/loading.gif";
		Request.const_paper_color_light_yellow = '##FFFFBF';
		Request.const_color_light_blue = '##80FFFF';
		
		Request.cf_div_floating_debug_menu = 'div_floating_debug_menu';
	</cfscript>

	<cfoutput>
	<script>
		currentLayerList = '#bboxAndLayers.layerString#';
	</script>
	<script language="JavaScript1.2" type="text/javascript">
		function _dispaySysMessages(s, t, bool_hideShow, taName) {
			if (taName.toUpperCase() == 'ta_menuHelperPanel'.toUpperCase()) {
				var taObj = _getGUIObjectInstanceById(taName);
				if (!!taObj) {
					taObj.value += s;
				}
			} else {
				var cObj = getGUIObjectInstanceById('div_sysMessages');
				var tObj = getGUIObjectInstanceById('span_sysMessages_title');
				var sObj = getGUIObjectInstanceById('span_sysMessages_body');
				var taObj = _getGUIObjectInstanceById(taName);
				var s_ta = '';
				if ( (!!cObj) && (!!sObj) && (!!tObj) ) {
					bool_hideShow = ((bool_hideShow == true) ? bool_hideShow : false);
					s_ta = ((!!taObj) ? taObj.value : '');
					flushGUIObjectChildrenForObj(sObj);
					sObj.innerHTML = '<textarea id="' + taName + '" class="codeSmaller" cols="150" rows="30" readonly>' + ((s.length > 0) ? s_ta + '\n' : '') + s + '</textarea>';
					flushGUIObjectChildrenForObj(tObj);
					tObj.innerHTML = t;
					cObj.style.display = ((bool_hideShow) ? const_inline_style : const_none_style);
					cObj.style.position = 'absolute';
					cObj.style.left = 10 + 'px';
					cObj.style.top = 10 + 'px';
					cObj.style.width = (clientWidth() - 10) + 'px';
					cObj.style.height = (clientHeight() - 10) + 'px';
				}
			}
		}
		
		function dispaySysMessages(s, t) {
			return _dispaySysMessages(s, t, true, 'textarea_sysMessages_body');
		}
		
		function _alert(s) {
			return dispaySysMessages(s, 'DEBUG');
		}

		function jsErrorExplainer(e) {
			var msg = '';
			msg += "e.number is: " + (e.number & 0xFFFF) + '\n'; 
			msg += "e.description is: " + e.description + '\n'; 
			msg += "e.name is: " + e.name + '\n'; 
			msg += "e.message is: " + e.message + '\n';
			if (!!_alert) _alert(msg); else alert(msg);
			return msg;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////
	
		var _last_menuItem_clicked_dict = DictionaryObj.getInstance();
		
		var oMenuDict = DictionaryObj.getInstance();
		var uMenuDict = DictionaryObj.getInstance();
		var global_dict = DictionaryObj.getInstance();
		var global_ClientMenuObj = ClientMenuObj.getInstance();

		var url_sBasePath = 'http' + (('#CGI.SERVER_PORT#' == '443') ? 's' : '') + ':\/\/#CGI.HTTP_HOST#';
		//var url_sBasePath = getServer();

		var global_allow_loading_data_message = false;

		var const_cf_html_container_symbol = '#Request.cf_html_container_symbol#';
		var const_loading_data_message_symbol = '<span class="normalStatusClass">&nbsp;Loading !</span>';
		var const_system_ready_message_symbol = '<span class="normalStatusClass">&nbsp;Ready !</span>';
		var const_jsapi_loading_image = '#Request.const_jsapi_loading_image#';
		
		var const_div_floating_debug_menu = '#Request.cf_div_floating_debug_menu#';
		
		var oAJAXEngine = AJAXEngine.getInstance(url_sBasePath + ((url_sBasePath.charAt(url_sBasePath.length - 1) == '/') ? '' : '/') + 'ajax-cfm/AJAX_functions.cfm', false);

		function init_AJAX() {
			oAJAXEngine.setMethodGet();
			oAJAXEngine.setReleaseMode();
			oAJAXEngine.isXmlHttpPreferred = false;
		//	oAJAXEngine.setDebugMode();
		//  oAJAXEngine.showFrame();
			oAJAXEngine.js_global_varName = 'js_Global';

			// define the function to run when a packet has been sent to the server
			oAJAXEngine.onSend = function (){
				if (global_allow_loading_data_message == true) {
					showServerCommand_Begins();
				}
			};
	
			// define the function to run when a packet has been received from the server
			oAJAXEngine.onReceive = function (){
				var _db = '';
	
				showServerCommand_Ends();

				// BEGIN: This block of code always returns the JavaScript Query Object known as oAJAXEngine.js_global_varName regardless of the technique that was used to perform the AJAX function...
				try {
					if (this.isReceivedFromCFAjax()) {
						eval(this.received);
					} else {
						var _db = '';
						try {
							for( var i = 0; i < this.received.length; i++) {
								eval(this.received[i]);
								_db += '\n' + this.received[i];
								//alert(this.received[i]);
							}
						} catch(ee) {
							if (!!jsErrorExplainer) jsErrorExplainer(ee, '1.0' + 'this.received[' + i + '] = [' + this.received[i] + ']', true);
						} finally {
						}
					}
				} catch(e) {
					if (!!jsErrorExplainer) jsErrorExplainer(ee, '1.0', true);
				} finally {
				}
				if (this.isDebugMode()) _alert('oAJAXEngine.mode = [' + oAJAXEngine.mode + ']' + '\n' + oAJAXEngine.js_global_varName + ' = [' + js_Global + ']' + '\n' + this.received);
				// END! This block of code always returns the JavaScript Query Object known as oAJAXEngine.js_global_varName regardless of the technique that was used to perform the AJAX function...

				handle_next_AJAX_function(); // get the next item from the stack...
			};
	
			oAJAXEngine.onTimeout = function (){
				this.throwError("The current request has timed out.\nPlease try your request again.");
				showServerCommand_Ends();
				handle_next_AJAX_function(); // get the next item from the stack...
			};
		}

		function doAJAX_func(cmd, callBackFuncName, vararg_params) {
			var j = -1;
			var j2 = -1;
			var ar = [];
			var ar2 = [];
			var ampersand_i = -1;
			var equals_i = -1;
			var _argCnt = 0;
			var anArg = '';
			var iArg = 0;
			var s_argSpec = '';
			var isObject = false;
			var sValue = '&cfm=' + cmd + '&callBack=' + callBackFuncName;
			
			var _db = '';

		    // BEGIN: Make the arguments into a series of URL Parms, as-required, don't worry the AJAX Engine will figure out how to handle all this data...
			// a Parm may be a simple value or a Query String using the standard CGI Query String specification of "&name=value"...
			iArg = 0;
		    for (var i = 0; i < arguments.length - 2; i++) {
				anArg = arguments[i + 2];
				isObject = false;
				_db += ', (typeof anArg) = [' + (typeof anArg) + ']';
				if ((typeof anArg).toUpperCase() == const_object_symbol.toUpperCase()) {
					// the arg might be an array or a complex object...
					var k = -1;
					for (k = 0; k < anArg.length; k++) {
						if (anArg[k].trim().length > 0) {
							if ((typeof anArg[k]).toUpperCase() != const_string_symbol.toUpperCase()) {
								try {
									anArg[k] = anArg[k].toString();
								} catch(e) {
									anArg[k] = ''; // default is empty string whenever the thing that is not a string cannot be made into a string...
								} finally {
								}
							}
							s_argSpec += '&arg' + (iArg + 1) + '=' + anArg[k].URLEncode();
							_argCnt++;
							iArg++;
						}
					}
					isObject = true;
				} else if ((typeof anArg).toUpperCase() != const_string_symbol.toUpperCase()) {
					try {
						anArg = anArg.toString();
					} catch(e) {
						anArg = ''; // default is empty string whenever the thing that is not a string cannot be made into a string...
					} finally {
					}
				}
				_db += ', isObject = [' + isObject + ']';
				if (isObject == false) {
					ampersand_i = anArg.indexOf('&');
					equals_i = anArg.indexOf('=');
					if ( (ampersand_i != -1) && (equals_i != -1) && (ampersand_i < equals_i) ) {
						s_argSpec += anArg.toString().URLEncode();
						_argCnt++;
						iArg++;
					} else if (anArg.indexOf(',') != -1) {
						ar = anArg.split(',');
						for (j = 0; j < ar.length; j++) {
							if (ar[j].indexOf('=') != -1) {
								ar2 = ar[j].split('=');
								j2 = (j * 2);
								s_argSpec += '&arg' + (j2 - 1) + '=' + ar2[0].toString().URLEncode();
								_argCnt++;
								iArg++;
								s_argSpec += '&arg' + j2 + '=' + ar2[1].toString().URLEncode();
								_argCnt++;
								iArg++;
							} else {
								s_argSpec += '&arg' + (j + 1) + '=' + ar[j].toString().URLEncode();
								_argCnt++;
								iArg++;
							}
						}
					} else {
						s_argSpec += '&arg' + (iArg + 1) + '=' + anArg.toString().URLEncode();
						_argCnt++;
						iArg++;
					}
				}
		    }
			sValue += '&argCnt=' + _argCnt + s_argSpec;
		    // END! Make the arguments into a series of URL Parms, as-required, don't worry the AJAX Engine will figure out how to handle all this data...

			if (oAJAXEngine.isXmlHttpPreferred == false) {
				oAJAXEngine.setMethodGet();
			}
			oAJAXEngine.sendPacket(sValue);
		}

		function queueUp_AJAX_Session() {
			var jsCode = '';
			var pQueryString = '';

			pQueryString = '';
			oAJAXEngine.addNamedContext('#const_menuDisplayRecord_symbol#', pQueryString);
			doAJAX_func('getMenuEditorContents', 'displayClientMenuData(' + oAJAXEngine.js_global_varName + ')');
		}

		function displayClientMenuData(qObj) {
			var nRecs = -1;
			var oParms = -1;
			var _spanName = '#const_menuDisplayRecord_symbol#';

			function displayRecord(_ri, _dict, _rowCntName, queryObj) {
				var _ID = '';
				var _PROMPT = '';
				var _MENUUUID = -1;
				var _PARENT_ID = -1;
				var _PARENTUUID = -1;
				var _SRCID = -1;
				var _SRCTABLENAME = '';
				var _DISPORDER = '';
				var _rowCnt = -1;

				try {
					_ID = _dict.getValueFor('ID');
					_PROMPT = _dict.getValueFor('PROMPT');
					_MENUUUID = _dict.getValueFor('MENUUUID');
					_PARENT_ID = _dict.getValueFor('PARENT_ID');
					_PARENTUUID = _dict.getValueFor('PARENTUUID');
					_SRCID = _dict.getValueFor('SRCID');
					_SRCTABLENAME = _dict.getValueFor('SRCTABLENAME');
					_DISPORDER = _dict.getValueFor('DISPORDER');
					_rowCnt = _dict.getValueFor(_rowCntName);
				} catch(e) {
				} finally {
				}

				_PARENTUUID = ((_PARENTUUID.trim().length == 0) ? '-1' : _PARENTUUID);
				
				var eDISPORDER = -1;
				var aVal = global_ClientMenuObj.oMenuDict.getValueFor(_PARENTUUID);
				if (aVal == null) {
					eDISPORDER = 0;
				} else if (typeof aVal != const_object_symbol) {
					eDISPORDER = 1;
				} else {
					eDISPORDER = aVal.length;
				}
				_dict.put('DISPORDER', eDISPORDER);
				global_ClientMenuObj.oMenuDict.push(_PARENTUUID, '&_ri=' + _ri + _dict.asQueryString());
				
				global_ClientMenuObj.uMenuDict.push(_MENUUUID, '&_ri=' + _ri + _dict.asQueryString());
			};
			
			global_dict.init(); // clear-out the parms from the previous AJAX call otherwise they just build-up and that's not so helpful...
			var qStats = qObj.named('qDataNum');
			if (!!qStats) {
				nRecs = qStats.dataRec[1];
			}
			if (nRecs > 0) { // at present only the first data record is consumed...
				var qData = qObj.named('qData1');
				if (!!qData) {
					oParms = qObj.named('qParms');
					if (!!oParms) {
						// no parms are expected so doesn't matter if they arrived...
						oAJAXEngine.setContextName(_spanName);

						oMenuDict.init();
						uMenuDict.init();
						
						qData.iterateRecObjs(displayRecord);

						var dObj = getGUIObjectInstanceById('div_clientMenuTest');
						if (!!dObj) {
							var _html = '';
							var mDict = -1;
							var mAR = global_ClientMenuObj.oMenuDict.getValueFor('-1');
							for (var i = 0; i < mAR.length; i++) {
								mDict = DictionaryObj.getInstance(mAR[i]);
								_html += '<span class="menuClass"><a href="" onclick="ClientMenuObj.openClientMenuByUUID(global_ClientMenuObj, \'' + mDict.getValueFor('MENUUUID') + '\'); return false;">' + mDict.getValueFor('PROMPT') + '</a></span>' + ((i < (mAR.length - 1)) ? ' | ' : '');
								DictionaryObj.removeInstance(mDict.id)
							}
							flushGUIObjectChildrenForObj(dObj);
							dObj.innerHTML = _html;
							
							global_ClientMenuObj.bool_adjustMarginLeft = false;

							global_ClientMenuObj.onCheckBoxClicked = function(id, bool, ar) {
								var aSpec = global_ClientMenuObj.uMenuDict.getValueFor(ar[ar.length - 1]);
								_last_menuItem_clicked_dict.fromSpec(aSpec);
							//	var d = DictionaryObj.getInstance(aSpec);
								var _CURRID = parseInt((!!(_CURRID = _last_menuItem_clicked_dict.getValueFor('CURRID'))) ? _CURRID : '-1');
								var _LEGACYID = parseInt((!!(_LEGACYID = _last_menuItem_clicked_dict.getValueFor('LEGACYID'))) ? _LEGACYID : '-1');
							//	DictionaryObj.removeInstance(d.id);
							//	alert('_last_menuItem_clicked_dict = [' + _last_menuItem_clicked_dict + ']');
							//alert(_LEGACYID);
								//if (!!newMapLayer) newMapLayer('#mID#', _LEGACYID);
							};
							
							global_ClientMenuObj.onL2DecideToUseRadioButtonOrCheckBoxes = function(uuid) {
							};
							
							global_ClientMenuObj.onL2DecideToUseLinks = function(uuid) {
							};
							
							ClientMenuObj.openClientMenuByUUID(global_ClientMenuObj, '#Request.menuUUID#');
						}
					}
				}
			}
		}

		oAJAXEngine.create();
		
		init_AJAX();
		
		queueUp_AJAX_Session();
	</script>
	</cfoutput>
	
	<cfoutput>
		<div id="#Request.cf_html_container_symbol#"></div>
		<div id="div_clientMenuTest" style="display: none;"></div>
		<div id="div_menu_container" style="display: none;">
			<b>Menu Goes Here</b>
		</div>
		<div id="div_clientSubMenuTest"></div>
		<div id="div_sysMessages" style="display: none;">
			<table width="*" border="1" cellspacing="-1" cellpadding="-1" bgcolor="##FFFF80">
				<tr>
					<td>
						<table width="*" cellspacing="-1" cellpadding="-1">
							<tr bgcolor="silver">
								<td align="center">
									<span id="span_sysMessages_title" class="boldPromptTextClass"></span>
								</td>
								<td align="right">
									<button class="buttonClass" title="Click this button to dismiss this pop-up." onclick="dismissSysMessages(); return false;">[X]</button>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<span id="span_sysMessages_body" class="textClass"></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		
	</cfoutput>
