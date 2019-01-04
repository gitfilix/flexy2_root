<cfprocessingdirective pageencoding="utf-8" />

<ul>
	<cfoutput query="getThemenNav">
	<!--- <li <cfif id EQ url.id>class="active"</cfif> >
		
			<a href="/#session.serverpath#/#urlshortcut#">
				#pagetitel#
			</a>
		
		
	</li> --->
	
	<li <cfif id EQ url.id>class="active"</cfif>>
		<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#" <cfif id EQ listFirst(session.navtree)>style="color:red !important;"</cfif>>
			#pagetitel#
		</a>
	</li>
	</cfoutput>
</ul>