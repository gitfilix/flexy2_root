<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor,parent,label FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>
<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_104
WHERE slideid = #url.slideID#
</cfquery>


<cfoutput query="getSlideContent">
<!--- Layouttype 1: big lead- little text --->
<cfif getSlideContent.layout EQ 1>
	<div style="width:100%;height:100%;background:#getSlideBackgroundImage.bgcolor# url('/newyork/upload/magazine/#getSlideBackgroundImage.bgimage#') center center no-repeat;background-size:cover;position:relative;">
		#lead#
	</div>
</cfif>
</cfoutput>