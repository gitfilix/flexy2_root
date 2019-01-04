<!--- Content in Non Acordeon style Service Nav only --->
<cfoutput query="getServiceContent">	
		<!---   <cfdump var="#getcontent#">  --->
		<div class="content-service animate fadeInRight">
				<h2>#titel#</h2>
				<h3>#lead#</h3>
				<br/>
				<div class="pix-content-service">
					<figure>
						<img src="/#session.serverpath#/upload/img/#bildname#" alt="alt tag" >
						<figcaption>#IMAGECAPTION#</figcaption>
					</figure>
					</div>	
				<article>
				#fliesstext#
				</article>
			<!--- 	<cfdump var="#getServiceContent#"> --->
				<cfif hreflabel NEQ "">
				<div class="content-service-link">
					<a href="#HREF#" target="_blank">#hreflabel#</a>
				</div>
				</cfif>

				<div class="clear"></div>
			</div>	  
</cfoutput>
