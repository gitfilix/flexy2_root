<!--- Headerpannel zeige Slider mit Bilder vom ordner : Template X/ sliderpix --->
<div <cfif getHeaderpanels.recordcount GT 1>class="flexslider"</cfif> >
	<ul class="slides">
		<cfoutput query="getHeaderpanels">
			<cfif getHeaderpanels.recordcount NEQ "">
				<li style="position:relative;" class="slide">
					<img src="/#session.serverpath#/upload/img/headerpanel/#image#" class="slide_img" alt="" />
					<div class="slide_desc">
						<h4>#titel#</h4>
						<div class="slidertext">#fliesstext#</div><br>
						<a href="#href#">#hreflabel#</a>
					</div>
				</li>
			<cfelse>
				<li style="position:relative;">
					<img  src="/#session.serverpath#/upload/img/#pageProperties.headerbild#" alt="" style="display:block;" />
				</li>
			</cfif>
		</cfoutput>
	</ul>
</div>