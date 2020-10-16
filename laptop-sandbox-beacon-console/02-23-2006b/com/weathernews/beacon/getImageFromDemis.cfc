<cfcomponent hint="getImageFromDemis.cfc">
	<cffunction name="init" access="public" returntype="boolean">
		<cfargument name="imageType" type="string" required="yes" />
		<cfargument name="layerString" type="string" required="yes" />
		<cfargument name="demisLocation" type="string" required="yes" />
		<cfargument name="bbox" type="string" required="yes" />
		<cfargument name="stageW" type="string" required="yes" />
		<cfargument name="stageH" type="string" required="yes" />
		<cfargument name="imageName" type="string" required="yes" />
		<cfset var image = getImage(arguments.imageType,arguments.layerString,arguments.demisLocation,arguments.bbox,arguments.stageW,arguments.stageH,arguments.imageName) />
		<cfreturn image />
	</cffunction>
	<cffunction name="getImage" access="package" returntype="boolean">
		<cfargument name="imageType" type="string" required="yes" />
		<cfargument name="layerString" type="string" required="yes" />
		<cfargument name="demisLocation" type="string" required="yes" />
		<cfargument name="bbox" type="string" required="yes" />
		<cfargument name="stageW" type="string" required="yes" />
		<cfargument name="stageH" type="string" required="yes" />
		<cfargument name="imageName" type="string" required="yes" />
		<cftry>
			<cfhttp timeout="#createTimeSpan(0,0,0,15)#" 
					url="#arguments.demisLocation#?WMS=WorldMap4&request=map&srs=EPSG:4326&BBOX=#arguments.BBox#&width=#arguments.stageW#&height=#arguments.stageH#&layers=#arguments.layerString#&transparent=true&format=#arguments.imageType#" 
					path="#ExpandPath('/UserMaps')#" 
					file="#arguments.imageName#.#arguments.imageType#" 
					resolveurl="yes" 
					getasbinary="yes" />
			<cfcatch type="any">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>
</cfcomponent>