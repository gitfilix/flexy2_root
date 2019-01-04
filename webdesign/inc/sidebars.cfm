<cfoutput query="getSidebarElems">
	<aside class="sidebar" >
		<div class="spacer30">
			&nbsp;
		</div>
		<cfif image NEQ "" AND fileExists(expandPath('/#session.serverpath#/upload/img/#image#'))>
			<img src="/#session.serverpath#/upload/img/#image#" alt="#titel#" />
		</cfif>
		<br />
			<h4>#titel#</h4>
		<div class="sidebartext">
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
				#fliesstext#
			</cfif>
		</div>
		<ul>
			<li>
				<cfif href NEQ "" AND hreflabel NEQ "">
					<a href="#href#" title="#hreflabel#"  target="_self">#hreflabel#</a>
				</cfif>
			</li>
		</ul>
		  <div class="spacer20">
			&nbsp;
		</div> 
	</aside>
</cfoutput>
