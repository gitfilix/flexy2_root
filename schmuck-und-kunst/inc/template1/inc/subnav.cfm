<cfprocessingdirective pageencoding="utf-8" />

<cfoutput>
	<cfif session.cugLoggedIn EQ 1>
	#application.com.nav.GenerateNav(usergroup=session.cug.groupID,parentid=listFirst(session.navtree),level=0,type=4,lang=session.lang,mandant=session.mandant,navpos=0)#
	<cfelse>
	#application.com.nav.GenerateNav(usergroup=0,parentid=listFirst(session.navtree),level=0,type=4,lang=session.lang,mandant=session.mandant,navpos=0)#
	</cfif>
</cfoutput> 