<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_4
WHERE slideid = #url.slideID#
</cfquery>

<cfoutput query="getSlideContent">
<div class="tpl4-wrapper-templ">
	<div>
	#titel#
	</div>
	
	<div style="background:rgba(134,134,134,1.00)">
	#lead#
	</div>
	
	<div>
	Layout Type: #layoutType#
	</div>
<div>

</cfoutput>


