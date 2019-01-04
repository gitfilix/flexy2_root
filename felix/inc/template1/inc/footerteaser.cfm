<!---alle Sidebar elemente im Footer max 3 aus der db lesen und pasten--->

<cfoutput query="getTeaserElems">
<div class="third">
	<div class="sidebar_bottom">
		
		<cfif image NEQ "">
			<img src="/#session.serverpath#/upload/img/#image#" width="100%" alt=""/>
		</cfif>
		<br>
		<cfif titel NEQ "">
			<h4>#titel#</h4>
		</cfif>
		<article>
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />" >
			<p>#fliesstext#</p>
		</article>
		</cfif>
		<cfif hreflabel NEQ	"">
			<a href="#href#" >#hreflabel#</a>
		</cfif>	
	</div>
</div>	
</cfoutput>
<div class="clear"></div>
