<cfoutput query="getcontent">
		<!--- include this just for mobile view portrait only --->
		<div class="mob-view-img">
				<img src="/#session.serverpath#/upload/img/bg_mobile_400.jpg" alt="bg-mobile" />
			</div>
		<header class="uppercontent bg-content bigimg" >		
			<img src="/#session.serverpath#/upload/img/#bildname#" alt="#imagecaption#" />
		<div id="headings" >		
			<!--- Print a Title --->	
			<cfif titel NEQ "">
					<h3 id="imagetitle">#titel#</h3>
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