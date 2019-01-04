<!--- <cfprocessingdirective pageencoding="utf-8" />

<ul>
	<cfoutput query="getsubnav">
	<li <cfif id EQ url.id>class="active"</cfif>>
		<a href="/#session.serverpath#/#urlshortcut#">
			#pagetitel#
		</a>
	</li>
	</cfoutput>
</ul> --->


<cfprocessingdirective pageencoding="utf-8" />
<cfif getsubnav.recordcount GT 0>
<nav style="margin:1em 0 1em 0;padding:1em 0 1em 0;">
<ul>
	<cfoutput query="getsubnav">
	<li <cfif id EQ url.id>class="active"</cfif>>
		<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#" <cfif id EQ listLast(session.navtree)>style="color:red !important;"</cfif>>
			#pagetitel#
		</a>
	</li>
	</cfoutput>
</ul>
<div style="clear:both;"></div>
</nav>
</cfif>