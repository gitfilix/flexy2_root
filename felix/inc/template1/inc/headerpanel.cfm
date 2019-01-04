<!--- flexslyder Headerpannel Bilder --->

<!--- Headerpannel zeige Slider mit Bilder vom ordner : Template X/ sliderpix --->

<div class="flexslider">
	  <ul class="slides">
	  <cfoutput query="getHeaderpanels">
	 	<cfif getHeaderpanels.recordcount NEQ "">
		<li>
		  <img src="/#session.serverpath#/upload/img/headerpanel/#image#" class="slide_img" />
			  <div class="slide_desc">
				<h4>#titel#</h4>
				<div class="slidertext">#fliesstext#</div><br>
				<a href="#href#">#hreflabel#</a>
			  </div>
			  <cfelse>
			   <img  src="/#session.serverpath#/upload/img/#pageProperties.headerbild#"  alt="" style="display:block;" />
		  </cfif>
		</li>
		</cfoutput>
	</ul>
</div>
<!--- 
<cfoutput query="getHeaderpanels">
	<cfif getHeaderpanels.recordcount EQ "">
		<h2>hi!</h2>
			<img  src="/#session.serverpath#/upload/img/#pageProperties.headerbild#"  alt="" style="display:block;" />
	</cfif>
</cfoutput> --->

	 
	