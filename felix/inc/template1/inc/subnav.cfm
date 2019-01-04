<!--- <cfprocessingdirective pageencoding="utf-8" />
		<ul>
		<cfoutput query="getsubnav">
			<li>
				<a href="/#session.serverpath#/#urlshortcut#" class="arrow">
				#pagetitel#
				</a>
			</li>
		</cfoutput>
		</ul> --->

<cfprocessingdirective pageencoding="utf-8" />
<cfif getsubnav.recordcount GT 0>
<nav>
<ul>
	<cfoutput query="getsubnav">
	<li <cfif session.navtree EQ id>class="subnav_active"</cfif>>
		<a  class="arrow" href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#" <cfif id EQ listLast(session.navtree)>style="color:red !important;"</cfif>>
			#pagetitel#
		</a>
	</li>
	</cfoutput>
</ul>
</nav>
</cfif>