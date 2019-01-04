<cfprocessingdirective pageencoding="utf-8" />

<ul>
	<cfoutput query="getThemenNav">
	<li <cfif id EQ url.id>class="active"</cfif> >
		<!--- <cfif urlshortcut NEQ "">
			<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
				#pagetitel#
			</a>
		<!--- <cfelse>
			<a href="#cgi.SCRIPT_NAME#?id=#id#">
				#pagetitel#
			</a> --->
		</cfif> --->
		
		
		
		
			<!--- homelink --->
			<cfif id EQ session.startID AND ownDomain NEQ "">
				<a href="http://www.#ownDomain#">
					#pagetitel#
				</a>
			<!--- jeder andere link --->
			<cfelse>
				<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
					#pagetitel#
				</a>
			</cfif>
		
		
		
		
	</li>
	</cfoutput>
</ul>