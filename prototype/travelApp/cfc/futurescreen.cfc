<cfcomponent displayname="futureScreenTravelApp">

	<cffunction name="getNumberOfPublications" returntype="numeric" output="yes" access="public">
		<cfargument name="mandantID" type="numeric" required="no" default="#session.mandant#" />
		
		<cfset getNumberOfPublications = "" />
		
		<cfquery name="getNumberOfPublications" datasource="#application.dsn#">
		SELECT 	id
		FROM	magazine
		WHERE	mandant = #arguments.mandantID#
		</cfquery>	
		
		<cfreturn getNumberOfPublications.recordcount />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	<cffunction name="getPublications" returntype="query" output="yes" access="public">
		<cfargument name="mandantID" type="numeric" required="no" default="#session.mandant#" />
		
		<cfset getPublications = "" />
		
		<cfquery name="getPublications" datasource="#application.dsn#">
		SELECT 	*
		FROM	magazine
		WHERE	mandant = #arguments.mandantID#
		</cfquery>	
		
		<cfreturn getPublications />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	<cffunction name="getPublication" returntype="query" output="yes" access="public">
		<cfargument name="mandantID" type="numeric" required="no" default="#session.mandant#" />
		<cfargument name="pubID" type="numeric" required="yes" />
		
		<cfset getPublications = "" />
		
		<cfquery name="getPublication" datasource="#application.dsn#">
		SELECT 	*
		FROM	magazine
		WHERE	mandant = #arguments.mandantID# AND
				id = #arguments.pubID#
		</cfquery>	
		
		<cfreturn getPublication />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	<cffunction name="getMatrix" returntype="query" output="yes" access="public">
		<cfargument name="issueID" type="numeric" required="yes" />
		
		<cfset getMatrix = "" />
		
		<cfquery name="getMatrix" datasource="#application.dsn#">
		SELECT 	K.id AS kid,
				K.kapitel,
				K.magazinAusgabeID,
				K.reihenfolge,
				K.direction,
				S.transitiontype,
				S.id,
				S.parent,
				S.label,
				S.template,
				S.bgimage,
				S.bgcolor,
				S.reihenfolge as sreihenfolge
		FROM	magazinKapitel K LEFT JOIN
				magazinSlides S ON S.parent = K.id
		WHERE	K.magazinAusgabeID = #arguments.issueID#
		ORDER	BY K.id,K.reihenfolge,S.reihenfolge
	
		
		</cfquery>	
		
		<cfreturn getMatrix />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	<cffunction name="getIssues" returntype="query" output="yes" access="public">
		<cfargument name="pubID" type="numeric" required="yes" />
		
		<cfset getIssues = "" />
		
		<cfquery name="getIssues" datasource="#application.dsn#">
		SELECT 	*
		FROM	magazinausgaben
		WHERE	magazinID = #arguments.pubID#
		</cfquery>	
		
		<cfreturn getIssues />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getIssue" returntype="query" output="yes" access="public">
		<cfargument name="issueID" type="numeric" required="yes" />
		
		<cfset getIssue = "" />
		
		<cfquery name="getIssue" datasource="#application.dsn#">
		SELECT 	*
		FROM	magazinausgaben
		WHERE	id = #arguments.issueID#
		</cfquery>	
		
		<cfreturn getIssue />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
</cfcomponent>