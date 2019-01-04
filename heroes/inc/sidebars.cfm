<cfoutput query="getSidebarElems">
<!--- <cfdump var="#getSidebarElems#"> --->
	<aside>	
		<!---<h5>Wir danken dem Sponsor</h5>--->
		<div class="sidebar">
		<!--- <h3 class="animated bounceIn">#titel#</h3> --->
		<cfif image NEQ "" AND fileExists(expandPath('/#session.serverpath#/upload/img/#image#'))>
			<img class="sidebar-img" src="/#session.serverpath#/upload/img/#image#" alt="#titel#" />
		</cfif>
		<br />
		<!--- 	<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
			#fliesstext#
			</cfif> --->
		<br />
		<ul class="animated tata">
			<li>
			<cfif href NEQ "" AND hreflabel NEQ "">
				<a href="#href#" title="#hreflabel#" target="_blank" >#hreflabel#</a>
			</cfif>
			</li>
		</ul>
		</div>
	</aside>
</cfoutput>