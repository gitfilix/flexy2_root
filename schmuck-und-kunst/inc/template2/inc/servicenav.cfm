<cfprocessingdirective pageencoding="utf-8" />

<ul>
	<cfoutput query="getServiceNav">
	<li <cfif id EQ url.id>class="active"</cfif>>
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