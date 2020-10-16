<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	
	<html>
	<head>
		<title>ajax</title>
<cfif IsDefined("URL.evt")>
	<cfswitch expression="#URL.evt#">
	
		<cfcase value="updateLayerData">
		
			<cfinvoke component="com.weathernews.beacon.DAO.getLayers" method="init" returnvariable="ajaxData">
				<cfinvokeargument name="flashID" value="#URL.flashID#" />
			</cfinvoke>
			
			<cfif ListFind(ajaxData,URL.newLayer,",")>
				<cfif URL.newLayer EQ 38>
					<cfset variables.offendingPosition = ListFind(ajaxData,"108",",") />
					<cfset ajaxdata = ListDeleteAt(ajaxData,variables.offendingPosition,",") />
				</cfif>
				
				<cfset variables.offendingPosition = ListFind(ajaxData,URL.newLayer,",") />
				<cfset list.newLayerList = ListDeleteAt(ajaxData,variables.offendingPosition,",") />
				<cfinvoke component="com.weathernews.beacon.DAO.setLayers" method="init" returnvariable="ajaxData">
					<cfinvokeargument name="flashID" value="#URL.flashID#" />
					<cfinvokeargument name="layers" value="#list.newLayerList#" />
				</cfinvoke>
				
			<cfelse>	
			
				<cfset variables.newLayers = ajaxData & "," & URL.newLayer />
				
				<cfif URL.newLayer EQ 38>
					<cfset variables.newLayers = variables.newLayers & ",108" />
				</cfif>
				
				<cfinvoke component="com.weathernews.beacon.DAO.setLayers" method="init" returnvariable="ajaxData">
					<cfinvokeargument name="flashID" value="#URL.flashID#" />
					<cfinvokeargument name="layers" value="#variables.newLayers#" />
				</cfinvoke>
				
			</cfif>
			
		<cfbreak />
		</cfcase>
		
		<cfcase value="removeLayer">
			
				<cfinvoke component="com.weathernews.beacon.DAO.getLayers" method="init" returnvariable="ajaxData">
					<cfinvokeargument name="flashID" value="#URL.flashID#" />
				</cfinvoke>
				
				<cfset list.newLayerList = ajaxData />
				
				<cfloop list="URL.layer" index="curLayer">
				
					<cfset variables.offendingPosition = ListFind(list.newLayerList,curLayer,",") />
					<cfset list.newLayerList = ListDeleteAt(list.newLayerList,variables.offendingPosition,",") />
				
				</cfloop>
				
				<cfinvoke component="com.weathernews.beacon.DAO.setLayers" method="init" returnvariable="ajaxData">
					<cfinvokeargument name="flashID" value="#URL.flashID#" />
					<cfinvokeargument name="layers" value="#list.newLayerList#" />
				</cfinvoke>
			
			</cfcase>
			
			<cfcase value="resetLayers">
				
				<cfinvoke component="com.weathernews.beacon.DAO.setLayers" method="init" returnvariable="ajaxData">
					<cfinvokeargument name="flashID" value="#URL.flashID#" />
					<cfinvokeargument name="layers" value="#URL.layer#" />
				</cfinvoke>
			<cfbreak />
		</cfcase>
			
		</cfswitch>
	</head>
	<body>
		</body>
			<cfoutput>#ajaxData#</cfoutput>
			<script>
				window.parent.enableFastPageLoadButton();
			</script>
		</body>
<cfelse>
		</body>
			It just ain't happenin' brother!
		</body>
</cfif>
	</html>