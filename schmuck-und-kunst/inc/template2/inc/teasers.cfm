<!---alle Teasers contents aus der db lesen und pasten--->

<cfoutput query="getSidebarElems">
<div class="third">
<div class="bg gray_two">
	
		<cfif titel NEQ "">
			<h3>
			#titel#
			</h3>
			<br>
		</cfif>
		<cfif image NEQ "">
			<img class="content_pix" src="/#session.serverpath#/upload/img/#image#" alt="" />
		</cfif>
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
			<p>
			#fliesstext#
			</p>
		</cfif>
		<cfif href NEQ "" AND hreflabel NEQ "">
			<br>
			<span><a href="#href#" title="#hreflabel#" target="_blank">#hreflabel#</a></span>
			
		</cfif>
		</div>
</div>		
</cfoutput>
