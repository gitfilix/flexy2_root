<!---alle Sidebar contents aus der db lesen und pasten--->



<cfoutput query="getSidebarElems">
	<div>
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



<!--- 
<h4>Sidebar A</h4>
<img class="pixliquid" src="pix/kenna4.jpg">
<div class="sidebartext">
<p>Pellentesque habitant morbi tristique senectus et netus. Quisque sagittis feugiat diam, malesuada tristique leo commodo ut. </p>
<br>
<a href="#">link to this</a> 
--->