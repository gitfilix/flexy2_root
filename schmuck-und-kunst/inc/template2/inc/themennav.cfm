<!--- themennavigation mit aktivstatusabfrage  --->
<cfprocessingdirective pageencoding="utf-8" />
<nav>
<ul>
	<cfoutput query="getThemenNav">
	<li <cfif id EQ listfirst(session.navtree)>class="themennav_active"</cfif>>
		<!--- homelink --->
		<cfif id EQ session.startID AND ownDomain NEQ "">
			<a href="http://www.#ownDomain#" >
				#navtitel#
			</a>
		<!--- jeder andere link --->
		<cfelse>
			<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
				#navtitel#
			</a>
		</cfif>
	</li>
	</cfoutput>
</ul>
</nav>