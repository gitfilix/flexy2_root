<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_5
WHERE slideid = #url.slideID#
</cfquery>

<cfoutput query="getSlideContent">
#getSlideBackgroundImage.bgimage#, #titel#, #lead#, #layoutType#
</cfoutput>


