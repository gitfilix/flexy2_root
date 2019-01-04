<cfprocessingdirective pageencoding="utf-8" />
<div class="subnav-pos">
	<div class="subnav">
		<ul>
			<cfoutput query="getfooternav">
			<li>
				<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
					#navtitel#
				</a>
			</li>
			</cfoutput>
		</ul>
	</div>
</div>