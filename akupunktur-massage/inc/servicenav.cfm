<cfprocessingdirective pageencoding="utf-8" />
<nav>
<ul>
	<cfoutput query="getServiceNav">
	<li <cfif id EQ listFirst(session.navtree)>class="active"</cfif>>
		<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
			#navtitel#
		</a>
	</li>
	</cfoutput>
</ul>
</nav>