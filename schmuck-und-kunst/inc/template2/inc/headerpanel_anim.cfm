<div class="flexslider headerpanel">
	<ul class="slides">
	<cfif pageProperties.headerbild NEQ "">
		<cfoutput query="getHeaderpanels">	
		<li>
			<img src="/#session.serverpath#/upload/img/headerpanel/#image#" alt="" style="display:block;" />
			<div class="headerpannel">
			  	<h4>#titel#</h4><br />
				<div class="headertext">#fliesstext#</div><br/>
				<a href="#href#">#hreflabel#</a>
			  </div>
		</li>
		</cfoutput>
	<cfelse>
		<h2>no headerpannel bild</h2>
	</cfif>
	
	</ul>		
</div>