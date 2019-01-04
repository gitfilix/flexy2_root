<!---alle Sidebars contents aus der db lesen und pasten--->


<cfoutput query="getTeaserElems">

<div class="third">
	<cfif currentrow EQ 1 >
		<div class="bg gray_one SidebarElems" style="position:relative;">
	<cfelse>
	<cfif currentrow EQ 2 >
		<div class="bg gray_two SidebarElems" style="position:relative;">
	<cfelse>
	<cfif currentrow EQ 3 >
		<div class="bg gray_three SidebarElems" style="position:relative;">
	 </cfif>
	<!--- 	<div class="bg gray"> --->
	</cfif> 
</cfif>
		<cfif titel NEQ "">
			<h3>
			#titel#
			</h3>
			<br>
		</cfif>
		<cfif image NEQ "">
			<img class="bg_pix" src="/#session.serverpath#/upload/img/#image#" alt="" />
		</cfif>
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
			#fliesstext#
		</cfif>
		<cfif href NEQ "" AND hreflabel NEQ "">
			<br>
			<div class="hreflabel" style="position:absolute;bottom:10px;">
				<a href="#href#" title="#hreflabel#" target="_blank">
				#hreflabel#
				</a>
			</div>
			
		</cfif>
		</div>
</div>		
</cfoutput>
