<div>
 <!--- Headerpannel zeige Slider mit Bilder vom ordner : Template X/ sliderpix --->
	<div class="flexslider">
		<!--- fallback: wenn kein headerpanal definiert - nur logo anzeigen ohne position absolut  --->
		<div id="logobg" style="<cfif getHeaderpanels.recordcount GT 0> position:absolute;</cfif> 	width:50%;   z-index:3;">
			<div class="logostyle">
				<table>
					<tr>
						<td>
						<cfoutput>
							<img src="/#session.serverpath#/upload/img/headerpanel/flx_logo_360.jpg" />
						</cfoutput>	
						</td>
						
						<td valign="top">
							<div class="flx_style">
							 <h1>} .FLX _media{
							 </h1>
							 </div>
						 </td>
						</tr>
				</table>
					
					
				</div>
			</div>
		  <ul class="slides">
		  <cfoutput query="getHeaderpanels">
			<li style="position:relative;">
			  <img src="/#session.serverpath#/upload/img/headerpanel/#image#" />
			  <div class="headerpannel">
			  	<h4>#titel#</h4><br />
				<div class="headertext">#fliesstext#</div><br/>
				<a href="#href#">#hreflabel#</a>
			  </div>
			</li>
			</cfoutput>
		</div>
</div>

	
	
			
			<!--- < bckup
			
				<div class="flexslider">
		<div id="logobg" style="position:absolute; 	width:50%;   z-index:3;">
			<div class="logostyle">
				<table>
					<tr>
						<td>
							<div class="logocircle">{</div>
						</td>
						<td>
						<div class="flx_style">
							 <h1>FLX _media</h1>
						 </div>
						</td>
					</tr>
				</table>
				</div>
			</div>
		  <ul class="slides">
		  <cfoutput query="getHeaderpanel">
			<li style="position:relative;">
			  <img src="/#session.serverpath#/inc/template2/sliderpix/#image#" />
			  <div class="headerpannel">
			  	<h4>#titel#</h4><br />
				<div class="headertext">#fliesstext#</div><br/>
				<a href="#href#">#hreflabel#</a>
			  </div>
			</li>
			</cfoutput>
		</div>
			
			> --->
		  
	
