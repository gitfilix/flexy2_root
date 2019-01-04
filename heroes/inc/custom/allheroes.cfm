<cfoutput query="getTeammembers">
<cfdump var="#getTeammembers#">
<article class="content">
	<h1>print all hereoes in custom include:</h1>
	<cfif TEAMVORNAME NEQ "">
		<p>Teamvorname: #TEAMVORNAME#</p>
	</cfif>
	<br />
	<cfif TEAMNAME NEQ "">
		<p>Teamname aka: #TEAMNAME#</p>
	</cfif>
	<br />
	<cfif TEAMTESTIMONIAL NEQ "">
		<p>TEAMTESTIMONIAL is: #TEAMTESTIMONIAL#</p>
	</cfif>
	<br />
	
	TEAMAUSBILDUNG
	<cfif TEAMAUSBILDUNG NEQ "">
		<p>TEAMAUSBILDUNG is: #TEAMAUSBILDUNG#</p>
	</cfif>
	<br />
	<!--- Print a Title --->	
	<cfif TEAMADRESSE NEQ "">
			<p>Custom Adresse #TEAMADRESSE#</p>
	</cfif>
	<br/ >
	<cfif TEAMMOBILE NEQ "">
			<p>Custom Adresse #TEAMMOBILE#</p>
	</cfif>
	<br/ >
	<cfif TEAMTEL NEQ "">
			<p>Custom Mobile #TEAMTEL#</p>
	</cfif>
	<br/ >
	<cfif TEAMCV NEQ "">
			<p>Custom CV #TEAMCV#</p>
	</cfif>
	<br/ >

		
</article>

</cfoutput> 
