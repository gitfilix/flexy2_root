<aside>
<cfoutput query="getSidebarElems">
	<div class="sidebar_right">
		<h2>#titel#</h2>
		<cfif image NEQ "" AND fileExists(expandPath('/#session.serverpath#/upload/img/') & image)>
			<img src="/#session.serverpath#/upload/img/#image#" alt="#titel#" />
		</cfif>
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
				<div class="teasertext">
				#fliesstext#
				</div>
			</cfif>
		<ul>
			<li><cfif href NEQ "" AND hreflabel NEQ "">
				<a href="#href#" title="#hreflabel#" target="_blank">#hreflabel#</a>
			</cfif></li>
		</ul>
	</div>
</cfoutput>
</aside>