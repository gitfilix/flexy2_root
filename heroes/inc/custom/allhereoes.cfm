<cfoutput query="getTeammembers">
<cfdump var="#getTeammembers#">
<article class="content">
			<!--- Print a Title --->	
			<cfif TEAMADRESSE NEQ "">
					<p>Custom Adresse #TEAMADRESSE#</p>
					<br/ >
			</cfif>
		
</article>

</cfoutput> 
