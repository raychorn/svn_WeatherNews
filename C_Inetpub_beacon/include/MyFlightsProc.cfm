<cfif IsDefined("fID")>
	<cfquery NAME="getMyFlights" DATASOURCE="#INTRANET_DS#">
		select F.FlightID, F.FlightName, F.BBox, F.MapLayers, F.StageW, F.StageH
		from AvnUsers U, AvnFlights F
		where U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' 
				AND U.UserID = F.UserID
				AND F.FlightID = #fID#	
				AND F.SectionID = #mID#
		and U.Deleted = 0 and F.Deleted = 0
		order by F.FlightName
	</cfquery>

	<cfif getMyFlights.RecordCount EQ 1>
		<cfcookie name="#cookieBBoxName#" value="#getMyFlights.BBox#">
		<cfset BBox = #getMyFlights.BBox#>

		<cfcookie name="#cookieMapLayersName#" value="#getMyFlights.MapLayers#">
		<cf_Layers2Text LayersIN=#getMyFlights.MapLayers# Display=0>
		<cfset mapLayers = LayersOut>
	</cfif>
</cfif>

<cfif IsDefined("Form.UNIQUECLICK")>

	<cfif LEN(Form.FlightToBeSaved)>
		<cfquery NAME="getMyFlights" DATASOURCE="#INTRANET_DS#">
			IF EXISTS (select F.FlightID from AvnUsers U, AvnFlights F	where U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' AND U.UserID = F.UserID
						AND F.FlightName = '#Form.FlightToBeSaved#' AND F.SectionID = #mID#)	
				UPDATE AvnFlights
				SET FlightName = '#Form.FlightToBeSaved#',
					BBox = '#BBox#',
					MapLayers = '#Evaluate("cookie." & cookieMapLayersName)#',
					Deleted = 0
				FROM AvnUsers U, AvnFlights F	
				WHERE U.LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#' AND U.UserID = F.UserID
						AND F.FlightName = '#Form.FlightToBeSaved#'
						AND F.SectionID = #mID#
			ELSE
				BEGIN
					DECLARE @UserID int
					SELECT @UserID = UserID from AvnUsers where LoginID = '#ListGetAt(cookie.BeaconStats,1,"|")#'
					INSERT INTO AvnFlights (UserID,FlightName, BBox, MapLayers, SectionID)
					VALUES (@UserID, '#Form.FlightToBeSaved#','#BBox#','#Evaluate("cookie." & cookieMapLayersName)#', #mID# )
				END	
		</cfquery>
	</cfif>
</cfif>

