<!---alle Sidebar contents aus der db lesen und pasten--->

<!--- Sidebar here in Blue  --->
<cfoutput query="getSidebarElems">
	<div class="sidebar_blue">
		<cfif titel NEQ "">
			<div><h3>#titel#</h3></div>
		</cfif>
		<cfif image NEQ "">
			<img src="/#session.serverpath#/upload/img/#image#" width="100%" alt="" hspace="3" />
		</cfif>
		<div class="boxtext">
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
				#fliesstext#
			</cfif>
			<cfif href NEQ "" AND hreflabel NEQ "">
			<div class="sidebar_link">
				<a href="#href#" title="#hreflabel#" target="_blank">
				#hreflabel#
				</a>
			</div>
			</cfif>
		</div>
	</div>
</cfoutput>