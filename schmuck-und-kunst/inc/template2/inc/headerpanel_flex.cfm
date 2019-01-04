<!--- Headerpanel with flexslyder and some title--->



<div class="flexslider">
	<ul class="slides">
	<cfoutput query="getHeaderpanels">	

	<cfif image NEQ "">
		<li >
			<img src="/#session.serverpath#/upload/img/headerpanel/#image#" alt=""  class="slide_img"/>
			 <div class="slide_desc">
			  	<h4>#titel#</h4>
				<aside>#fliesstext#</aside>
				<a  href="#href#">#hreflabel#</a>
			  </div>
		</li>
		</cfif>
	</cfoutput>	
	</ul>
</div>		

	<!--- if no flexslider pictures are defined - show content- headerpannel pic (static) --->

<!--- <cfoutput query="getHeaderpanels">
	<cfif image EQ "">
	<div class="slide_desc" style="background:##0C6;"><h4>kein flexyslider bild</h4></div>
	</cfif>
</cfoutput> --->
<!--- 		
	<cfoutput query="getHeaderpanels">
	<cfif getHeaderpanels.recordcount EQ "">
		<h2>hi!</h2>
			<img  src="/#session.serverpath#/upload/img/#pageProperties.headerbild#"  alt="" style="display:block;" />
	</cfif>
	</cfoutput>

	
	
 --->