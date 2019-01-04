<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_3
WHERE slideid = #url.slideID#
</cfquery>

<cfoutput query="getSlideContent">
 <!--- <cfdump var="#getSlideContent#">
 ---><div class="tpl3-wrapper-templ">
	
		<div class="tpl3-title-box">
			<h1 class="tpl3-grossertitel">#titel#</h1>
		</div>
			

	
	<div <cfif #LAYOUTTYPE# EQ 1>class="tpl3-desc-center" 
		<cfelseif #LAYOUTTYPE# EQ 2 >class="tpl3-desc-topleft" 
		<cfelseif #LAYOUTTYPE# EQ 3>class="tpl3-desc-bottomright" 
		</cfif> >
		<p>#lead#</p>
	</div>

	<br />

	
</div>	
	
</cfoutput>
