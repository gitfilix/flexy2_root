<cfif pageProperties.headerbild NEQ "" OR getHeaderPanels.recordcount GT 0>
<div class="flex-pix">
	<cfif pageProperties.headerbild NEQ "">
		<cfoutput><img src="/#session.serverpath#/upload/img/#pageProperties.headerbild#" alt="" /></cfoutput>
	<cfelse>
		 <div class="flexslider">
		   <div class="slides">	     
			<cfoutput query="getHeaderPanels">
			  <div class="slide">
			   <img src="/#session.serverpath#/upload/img/headerpanel/#image#"  alt="#TITEL#" />
				 <div class="sliderbox" >
					<h3>#TITEL#</h3>
					<br /><article class="slidertext">#FLIESSTEXT#</article>
					<br/>
					<a href="#HREF#">#HREFLABEL#</a>
				</div> 
			</div>
			</cfoutput>
		  </div>
		</div>
	</cfif>
</div>
</cfif>
