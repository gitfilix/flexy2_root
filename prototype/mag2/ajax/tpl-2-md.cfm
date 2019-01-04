<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_2
WHERE slideid = #url.slideID#
</cfquery>
<cfoutput query="getSlideContent">
	<div id="tpl2-top-pannel" >
		<div>
			<h1>#titel#</h1>
			<br />
			<h2>#lead#</h2>
		</div>
	</div>
	<div class="tpl2-picture">
		<img src="../upload/magazine/#bild#">
	</div>
	 <div id="tpl2-left-pannel">
		&nbsp;
	</div>
	<div class="tpl2-box">
		#bildlegende#
	</div>
</cfoutput>