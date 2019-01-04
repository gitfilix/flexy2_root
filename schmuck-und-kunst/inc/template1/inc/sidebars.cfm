<!---alle Sidebar contents aus der db lesen und pasten--->

<cfoutput query="getSidebarElems">
	<div class="sidebar-elem">
		<cfif titel NEQ "">
			<div class="bold" style="padding:20px;">#titel#</div>
		</cfif>
		<cfif image NEQ "">
			<img src="/#session.serverpath#/upload/img/#image#" style="width:100%;" alt="" hspace="3" />
		</cfif>
		<div style="padding:1em;">
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
				#fliesstext#
			</cfif>
			<cfif href NEQ "" AND hreflabel NEQ "">
				<a href="#href#" title="#hreflabel#" target="_blank">#hreflabel#</a>
			</cfif>
		</div>
	</div>
</cfoutput>