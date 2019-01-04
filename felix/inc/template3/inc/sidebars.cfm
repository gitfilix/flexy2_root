<!---alle Sidebar contents aus der db lesen und pasten--->

<cfoutput query="getSidebarElems">
<div class="sidebar_right">
	
	<cfif titel NEQ "">
		<h4>#titel#</h4>
	</cfif>
	<cfif image NEQ "">
		<img src="/#session.serverpath#/upload/img/#image#" width="100%" alt=""/>
	</cfif>
	<br><br>
	<article>
	<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />" >
		<p>#fliesstext#</p>
	</article>
	</cfif>
	<cfif hreflabel NEQ	"">
		<a href="#href#" >#hreflabel#</a>
	</cfif>
	
</div>
</cfoutput>
