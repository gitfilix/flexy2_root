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
	
	
	<cffunction name="getIssueFromChapterID" returntype="numeric" output="yes" access="public">
		<cfargument name="chapterID" type="numeric" required="yes" />
		
		<cfquery name="local.getIssueFromChapterID" datasource="#application.dsn#">
		SELECT 	*
		FROM	magazinKapitel
		WHERE	id = #arguments.chapterID#
		</cfquery>	
		
		<cfreturn local.getIssueFromChapterID.magazinAusgabeID />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getPrevChapter" returntype="numeric" output="yes" access="public">
		<cfargument name="chapterID" type="numeric" required="yes" />
				
		<cfquery name="local.getReihenfolgeOfActChapter" datasource="#application.dsn#">
		SELECT 	reihenfolge
		FROM	magazinkapitel
		WHERE	id = #arguments.chapterid#
		</cfquery>	
		
		
		
		<cfif local.getReihenfolgeOfActChapter.recordcount EQ 0 OR local.getReihenfolgeOfActChapter.reihenfolge EQ 0>
			<cfset local.prevChapterID = 0 />
		<cfelse>
			<cfquery name="local.xgetPrevChapter" datasource="#application.dsn#">
			SELECT 	id
			FROM	magazinkapitel
			WHERE	reihenfolge < <cfqueryparam cfsqltype="cf_sql_numeric" value="#local.getReihenfolgeOfActChapter.reihenfolge#"> AND
					magazinAusgabeID = #getIssueFromChapterID(arguments.chapterID)#
			ORDER	BY reihenfolge DESC
			</cfquery>	
			<cfset local.prevChapterID = local.xgetPrevChapter.id />
			
		</cfif>
		
		<cfreturn local.prevChapterID />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getNextChapter" returntype="numeric" output="yes" access="public">
		<cfargument name="chapterID" type="numeric" required="yes" />
				
		<cfquery name="local.getReihenfolgeOfActChapter" datasource="#application.dsn#">
		SELECT 	reihenfolge
		FROM	magazinkapitel
		WHERE	id = #arguments.chapterid#
		</cfquery>	
		
		<cfif local.getReihenfolgeOfActChapter.recordcount EQ 0>
			<cfset local.nextChapterID = 0 />
		<cfelse>
			<cfquery name="local.getNextChapter" datasource="#application.dsn#">
			SELECT 	id
			FROM	magazinkapitel
			WHERE	reihenfolge > <cfqueryparam cfsqltype="cf_sql_numeric" value="#local.getReihenfolgeOfActChapter.reihenfolge#"> AND
					magazinAusgabeID = #getIssueFromChapterID(arguments.chapterID)#
			ORDER	BY reihenfolge
			</cfquery>	
			
			<cfif local.getNextChapter.recordcount GT 0>
				<cfset local.nextChapterID = local.getNextChapter.id />
			<cfelse>
				<cfset local.nextChapterID = 0 />
			</cfif>
			
			
		</cfif>

		<cfreturn local.nextChapterID />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getTopChapterSlides" returntype="query" output="yes" access="public">
		<cfargument name="chapterID" type="numeric" required="yes" />
		
		<cfquery name="local.getNextChapterSlides" datasource="#application.dsn#">
		SELECT 	*
		FROM	magazinslides
		WHERE	parent = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.chapterID#">
		ORDER	BY reihenfolge
		LIMIT 	3
		</cfquery>	
		
		<cfreturn local.getNextChapterSlides />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getChapterFromSlideID" returntype="numeric" output="yes" access="public">
		<cfargument name="slideID" type="numeric" required="yes" />
		
		<cfquery name="local.getChapterFromSlideID" datasource="#application.dsn#">
		SELECT 	K.id
		FROM	magazinKapitel K left JOIN
				magazinSLides S ON S.parent = K.id
		WHERE	S.id = #arguments.slideID#	
		ORDER	BY K.reihenfolge,S.reihenfolge
		</cfquery>	
		
		<cfif getChapterFromSlideID.recordcount EQ 0>
			<cfset local.returnID = 0 />
		<cfelse>
			<cfset local.returnID = local.getChapterFromSlideID.id />
		</cfif>
		
		<cfreturn local.returnID />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getSlide" returntype="query" output="yes" access="public">
		<cfargument name="slideID" type="numeric" required="yes" />
		
		<cfquery name="local.getSlide" datasource="#application.dsn#">
		SELECT 	*
		FROM	magazinSlides
		WHERE	id = #arguments.slideID#	
		</cfquery>	
		
		<cfreturn local.getSlide />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getFirstSlideID" returntype="numeric" output="yes" access="public">
		<cfargument name="issueID" type="numeric" required="yes" />
		
		<cfquery name="local.getFirstChapterWithFirstSlide" datasource="#application.dsn#">
		SELECT 	S.id
		FROM	magazinKapitel K left JOIN
				magazinSlides S ON S.parent = K.id
		WHERE	S.id != '' AND K.magazinAusgabeID = #arguments.issueID#
		ORDER	BY K.reihenfolge,S.reihenfolge
		</cfquery>	
		
		
		<cfreturn local.getFirstChapterWithFirstSlide.id />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getPrevSlideID" returntype="numeric" output="yes" access="public">
		<cfargument name="slideID" type="numeric" required="yes" />
		
		<cfset local.parent = getChapterFromSlideID(slideID=arguments.slideID) />
		<cfset local.getSlide = getSlide(slideID=arguments.slideID).reihenfolge />
		
		<cfif local.getSlide EQ "">
			<cfset local.getSlide = -1 />
		</cfif>
				
		<cfquery name="local.getPreviousSlideID" datasource="#application.dsn#">
		SELECT 	id
		FROM	magazinSlides
		WHERE	parent = #local.parent# AND reihenfolge < #local.getSlide#
		ORDER	BY reihenfolge DESC
		</cfquery>	
		
		<cfif local.getPreviousSlideID.recordcount EQ 0>
			<cfset returnID = 0 />
		<cfelse>
			<cfset returnID = local.getPreviousSlideID.id />
		</cfif>

		<cfreturn returnID />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getNextSlideID" returntype="numeric" output="yes" access="public">
		<cfargument name="slideID" type="numeric" required="yes" />
		
		<cfset local.parent = getChapterFromSlideID(slideID=arguments.slideID) />
		<cfset local.getSlide = getSlide(slideID=arguments.slideID).reihenfolge />
		
		<cfif local.getSlide EQ "">
			<cfset local.getSlide = -1 />
		</cfif>
		
		<cfquery name="local.getNextSlideID" datasource="#application.dsn#">
		SELECT 	id
		FROM	magazinSlides
		WHERE	parent = #local.parent# AND reihenfolge > #local.getSlide#
		ORDER	BY reihenfolge
		</cfquery>	
		
		<cfif local.getNextSlideID.recordcount EQ 0>
			<cfset returnID = 0 />
		<cfelse>
			<cfset returnID = local.getNextSlideID.id />
		</cfif>
		
		<cfreturn returnID />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getChapter" returntype="any" output="yes" access="public">
		<cfargument name="issueID" type="numeric" required="yes" />
		<cfargument name="chapterID" type="numeric" required="yes" />
		
		<cfset chapterTopSlides = getTopChapterSlides(chapterID=arguments.chapterID) />
		
		<cfset matrixArray = arrayNew(1) />
		<cfset matrixArray[1] = structNew() />
		<cfset matrixArray[1].chapterID = arguments.chapterID />
		<cfset actSlideIDs = arrayNew(1) />
		
		<cfset cnt = 1 />
		<cfloop query="chapterTopSlides">
			<cfset actSlideIDs[cnt] = id />
			<cfset cnt = cnt + 1 />
		</cfloop>
		<cfset structInsert(matrixArray[1],'slides',actSlideIDs) />
		
		<cfreturn matrixArray />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	<cffunction name="getInitialMatrix" returntype="any" output="yes" access="public">
		<cfargument name="issueID" type="numeric" required="yes" />  
		<cfargument name="startSlide" type="numeric" required="no" default="0" />  
		
		<cfif arguments.startSlide EQ 0>
			<cfset startSlidex = getFirstSlideID(issueID=arguments.issueID) />
		<cfelse>	
			<cfset startSlidex = arguments.startSlide />
		</cfif>
		
		<cfset actualChapterID = getChapterFromSlideID(slideID=startSlidex) />
		<cfset nextChapterID = getNextChapter(chapterID=actualChapterID) />
		
		
	
		
		<cfset nextNextChapterID = getNextChapter(chapterID=nextChapterID) />
		<cfset prevChapterID = getPrevChapter(chapterID=actualChapterID) />
		<cfset prevPrevChapterID = getPrevChapter(chapterID=prevChapterID) />
		<cfset nextChapterTopSlides = getTopChapterSlides(chapterID=nextChapterID) />
		<cfset nextNextChapterTopSlides = getTopChapterSlides(chapterID=nextNextChapterID) />
		<cfset prevChapterTopSlides = getTopChapterSlides(chapterID=prevChapterID) />
		<cfset prevPrevChapterTopSlides = getTopChapterSlides(chapterID=prevPrevChapterID) />
		<cfset previousSlideID = getPrevSlideID(slideID=arguments.startSlide) />
		<cfset nextSlideID = getNextSlideID(slideID=arguments.startSlide) />
		<cfset nextNextSlideID = getNextSlideID(slideID=nextSlideID) />
		<cfset prevSlideID = getPrevSlideID(slideID=arguments.startSlide) />
		<cfset prevPrevSlideID = getPrevSlideID(slideID=prevSlideID) />
		
		<cfset matrixArray = arrayNew(1) />
		
		<!--- prevPrevChapter --->
		<cfset matrixArray[1] = structNew() />
		<cfset matrixArray[1].chapterID = prevPrevChapterID />
		<cfset cnt = 1 />
		<cfset prevPrevSlideIDs = arrayNew(1) />
		<cfloop query="prevPrevChapterTopSlides">
			<cfset prevPrevSlideIDs[cnt] = id />
			<cfset cnt = cnt + 1 />
		</cfloop>
		<cfset structInsert(matrixArray[1],'slides',prevPrevSlideIDs) />
		
		<!--- prevChapter --->
		<cfset matrixArray[2] = structNew() />
		<cfset matrixArray[2].chapterID = prevChapterID />
		<cfset cnt = 1 />
		<cfset prevSlideIDs = arrayNew(1) />
		<cfloop query="prevChapterTopSlides">
			<cfset prevSlideIDs[cnt] = id />
			<cfset cnt = cnt + 1 />
		</cfloop>
		<cfset structInsert(matrixArray[2],'slides',prevSlideIDs) />
		
		<!--- actChapter --->
		<cfset matrixArray[3] = structNew() />
		<cfset matrixArray[3].chapterID = actualChapterID />
		<cfset actSlideIDs = arrayNew(1) />
		<cfset actSlideIDs[1] = prevPrevSlideID />
		<cfset actSlideIDs[2] = prevSlideID />
		<cfset actSlideIDs[3] = startSlidex />
		<cfset actSlideIDs[4] = nextSlideID />
		<cfset actSlideIDs[5] = nextNextSlideID />
		<cfset structInsert(matrixArray[3],'slides',actSlideIDs) />
		
		<!--- nextChapter --->
		<cfset matrixArray[4] = structNew() />
		<cfset matrixArray[4].chapterID = nextChapterID />
		<cfset cnt = 1 />
		<cfset nextSlideIDs = arrayNew(1) />
		<cfloop query="nextChapterTopSlides">
			<cfset nextSlideIDs[cnt] = id />
			<cfset cnt = cnt + 1 />
		</cfloop>
		<cfset structInsert(matrixArray[4],'slides',nextSlideIDs) />
		
		<!--- nextNextChapter --->
		<cfset matrixArray[5] = structNew() />
		<cfset matrixArray[5].chapterID = nextNextChapterID />
		<cfset cnt = 1 />
		<cfset nextNextSlideIDs = arrayNew(1) />
		<cfloop query="nextNextChapterTopSlides">
			<cfset nextNextSlideIDs[cnt] = id />
			<cfset cnt = cnt + 1 />
		</cfloop>
		<cfset structInsert(matrixArray[5],'slides',nextNextSlideIDs) />
			
		<cfreturn matrixArray />
	</cffunction>
		
	<!--- --------------------------------------------------------------------------------------------------- --->
	
	
	
	
</cfcomponent>