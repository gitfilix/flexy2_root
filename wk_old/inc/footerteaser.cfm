<!---alle Sidebar elemente im Footer max 3 aus der db lesen und pasten--->

	<cfoutput query="getTeasers">
	<div class="third teaser-elem">
		<div class="sidebar_bottom" style="position:relative;">
			
			<cfif image NEQ "">
				<img src="/#session.serverpath#/upload/img/#image#" alt=""/>
			</cfif>
			<br>
			<cfif titel NEQ "">
				<h4>#titel#</h4>
			</cfif>
			<article>
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />" >
				#fliesstext#
			</article>
			</cfif>
			<cfif hreflabel NEQ	"">
				<div class="sidebar_bottom_link">
					<a href="#href#" >#hreflabel#</a>
				</div>
			</cfif>	
		</div>
	</div>	
	</cfoutput>
<div class="clear"></div>