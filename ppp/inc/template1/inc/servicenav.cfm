<cfprocessingdirective pageencoding="utf-8" />

<ul>
	<cfoutput query="getServiceNav">
	<li <cfif id EQ listfirst(session.navtree)>class="service_active"</cfif>>
		<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
			#navtitel#
		</a>
	</li>
	</cfoutput>
</ul>




<!--- <cfprocessingdirective pageencoding="utf-8" />

<cfhtmlhead text='<style type="text/css">##SERVICENAV > UL UL{DISPLAY:NONE;}</style>'>

<DIV ID="SERVICENAV">
	<cfoutput>
		<cfif session.cugLoggedIn EQ 1>
		#application.com.nav.GenerateNav(usergroup=session.cug.groupID,parentid=0,level=0,type=4,lang=session.lang,mandant=session.mandant,navpos=0)#
		<cfelse>
		#application.com.nav.GenerateNav(usergroup=0,parentid=0,level=0,type=4,lang=session.lang,mandant=session.mandant,navpos=0)#
		</cfif>
	</cfoutput>
</DIV> --->