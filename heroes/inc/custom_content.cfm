<cfoutput query="getTeammembers">
<!--- <cfdump var="#getTeammembers#"> --->
<article class="content">
			<!--- Print a Title --->	
			<cfif TEAMADRESSE NEQ "">
					<h1>Custom Adresse #TEAMADRESSE#</h1>
			</cfif>

	<!--- 	
		 <!--- Show Content Image --->
		 <cfif bildname NEQ "">
			<figure>
				<img src="/#session.serverpath#/upload/img/#bildname#" alt="alt tag" >
			</figure> 
		</cfif>
		<br />
		<br />
		<!---  PRint the lead is Weapons --->
		<cfif lead NEQ "">
				<div>
				 	<h2>Weapons:</h2> 
					<br />
					<p>#lead#</p>
					<br />
				</div>	
		<cfelse>
			<!--- OR: Print some hardcoded LoremIpsum  --->
			 Praesent venenatis egestas enim, et tincidunt velit porta tempor! Quisque eu placerat leo!
		</cfif> --->
</article>

</cfoutput> 

