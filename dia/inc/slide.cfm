<cfset slide = url.slideID />
<cfset nextSlide = fs.getNextSlideID(slideID=slide) />
<cfset prevSlide = fs.getPrevSlideID(slideID=slide) />
<cfoutput>
	<li data-id="#url.slideID#" <cfif nextSlide NEQ 0>data-nextID="#nextSlide#"</cfif> <cfif prevSlide NEQ 0>data-prevID="#prevSlide#"</cfif> class="subslide" style="position:relative;height:100%;background:silver;">						
		
			<cfset templateID = fs.getSlide(url.slideID).template />
			<cfset url.slideID = url.slideID />
			<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />	
		
	</li>
</cfoutput>