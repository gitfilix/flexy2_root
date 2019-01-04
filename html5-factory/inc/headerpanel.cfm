<cfif pageProperties.headerbild NEQ "" OR getHeaderPanels.recordcount GT 0>
<div class="content">
	<header class="uppercontent bg-content" >
	<cfif pageProperties.headerbild NEQ "">
		<cfoutput><img src="/#session.serverpath#/upload/img/#pageProperties.headerbild#" alt="" /></cfoutput>
	<cfelse>
	
		 <div class="flexslider">
		     <ul class="slides">
		     
			<cfoutput query="getHeaderPanels">
			  <li class="slide">
			   <img src="/#session.serverpath#/upload/img/headerpanel/#image#" />
					<div id="headings">
						<h2>#titel#</h2>
						<br />
						<div class="slidertext">#fliesstext#</div>
						<a href="#href#">#hreflabel#</a>
					</div>
			</li>
			</cfoutput>
		  </ul>
		</div>
	</cfif>
	</header>
</div>
</cfif>
