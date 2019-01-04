<cfoutput query="getcontent">
		<header class="uppercontent bg-content bigimg" >		
			<img src="/#session.serverpath#/upload/img/#bildname#" />
		<div id="headings" >		
			<!--- Print a Title --->	
			<cfif titel NEQ "">
					<h2 id="imagetitle">#titel#</h2>
			</cfif>
			<br />
			<!---  PRint the lead --->
			<cfif lead NEQ "">
				<div>
				 	<p id="imagedesc">#imagecaption#</p>
				</div>	
			<cfelse>
			<!--- 	 Print some hardcoded Lorem Ipsum ---> 
				&nbsp;
			</cfif>
			</div>
		</header>	
</cfoutput>