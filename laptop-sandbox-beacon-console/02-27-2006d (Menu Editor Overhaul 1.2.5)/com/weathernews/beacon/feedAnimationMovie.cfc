<cfcomponent hint="feedAnimationMovie.cfc - I give the animation movie the layers and times that it needs">

	<cffunction name="init" access="public" returntype="struct">
		<cfargument name="arrLayers" type="array" required="true" />
		<cfargument name="bBox" type="string" required="true" />
		<cfargument name="serverUrl" type="string" required="true" />
		<cfargument name="mapName" type="string" required="true" />
		<cfargument name="StageW" type="numeric" required="true" />
		<cfargument name="StageH" type="numeric" required="true" />
		<cfargument name="timeFileName" type="string" required="true" />
		
		<cfset variables.sctFlashAnimation = doReturnAnimationStruct(arguments.arrLayers,
																	 arguments.bBox,
																	 arguments.serverUrl,
																	 arguments.mapName,
																	 arguments.StageW,
																	 arguments.StageH,
																	 arguments.timeFileName) />
		<cfreturn variables.sctFlashAnimation />
	</cffunction>

	<cffunction name="doReturnAnimationStruct" access="package" returntype="struct">
		<cfargument name="arrLayers" type="array" required="true" />
		<cfargument name="bBox" type="string" required="true" />
		<cfargument name="serverUrl" type="string" required="true" />
		<cfargument name="mapName" type="string" required="true" />
		<cfargument name="StageW" type="numeric" required="true" />
		<cfargument name="StageH" type="numeric" required="true" />
		<cfargument name="timeFileName" type="string" required="true" />
				
		<!--- Create Struct to return to Flash --->
		<cfset var animationStruct = StructNew() />
		
		<cfset newTimeArray = 0 />
		<cfset tempArray = ArrayNew(2) />
		
		<!--- Start adding superfluous items to struct --->
		<cfset animationStruct.bBox = arguments.bBox />
		<cfset animationStruct.serverUrl = arguments.serverUrl />
		<cfset animationStruct.mapName = arguments.mapName />
		<cfset animationStruct.containerSize = arguments.stageW & ',' & arguments.stageH />
		
		
		<!--- set the new layerarray equal to the arrLayers argument --->
		<cfset animationStruct.layerArray = ArrayNew(1) />
		<cfloop from="1" to="#ArrayLen(arguments.arrLayers)#" index="i">
			<cfset animationStruct.layerArray[i] = arguments.arrLayers[i] />
		</cfloop>
	
		<!--- Set up the array of times --->
		<cfset animationStruct.timeArray = ArrayNew(2) />
		
		<cfset variables.newTimeArray = CreateObject("component","com.weathernews.beacon.getTimeFileForAnimation").init(arguments.timeFileName) />
		<!--- <cfdump var="#variables.newTimeArray#">
		<cfabort> --->
		<cfloop from="1" to="#ArrayLen(variables.newTimeArray)#" index="c">
			
			<cfset animationStruct.timeArray[c][1] = variables.newTimeArray[c] />
		
		</cfloop>
		<!--- <cfdump var="#animationStruct.timeArray#">
		<cfabort> --->
		<cfif (ArrayLen(variables.newTimeArray) NEQ ArrayLen(animationStruct.layerArray)) AND
			  (ArrayLen(variables.newTimeArray) MOD ArrayLen(animationStruct.layerArray) EQ 0) AND
			  (ArrayLen(variables.newTimeArray) NEQ 0)>
			 <cfset theDivisor =  ArrayLen(variables.newTimeArray) / ArrayLen(animationStruct.layerArray) />
			 <cfswitch expression="#theDivisor#">
			 	<cfcase value="2">
			 		<cfset filterList = "1,2,3,4,5,6" />
			 	</cfcase>
			</cfswitch>
			<cfloop list="#filterList#" index="noBlanks">
				<cfset ArrayDeleteAt(animationStruct.timeArray,noBlanks) />
			</cfloop>
			
			<!--- <cfset animationStruct.timeArray = tempArray /> --->
			
		</cfif>
		<cfreturn animationStruct />
		
	</cffunction>	

</cfcomponent>