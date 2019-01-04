<cfprocessingdirective pageencoding="utf-8" />
<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_1
WHERE slideid = #url.slideID#
</cfquery>

<cfquery name="getTeasers" datasource="#application.dsn#">
SELECT S.* FROM teaser2slides T LEFT JOIN sidebar S ON S.id = T.teaserid
WHERE T.slideid = #url.slideID#
</cfquery>



<cfoutput query="getSlideContent">
<!--- #getSlideBackgroundImage.bgimage#, 
#titel#,
#lead#,
#bild#,
#bildlegende#,
#ytvideo#,
#slideID#  
#link#,
#linktitel#,
#video#  

TEASERS
#isactive#
#createDate#
#modifyDate#
#titel#
#fliesstext#
#href#
#hrefLabel#
#parentUser#
#image#
#teaserposition#
#mandant# 

 --->

<div class="wrapper-templ-1">
	<div class="tpl1-title-box">
		<div class="tpl1-grossertitel">
			<h1>#titel#</h1>
		</div>
	</div>
	<div class="flip-box">
		<div class="flip-container flip" ontouchstart="this.classList.toggle('hover');">
				<div class="flipper">
					<div class="front">
						<img src="../upload/magazine/#bild#">
						<br />
						<h3>#linktitel#</h3>
						<h4>Details auf der Rückseite</h4>
					</div>
					<div class="back" style="width:100%;min-height:150px;background-color:white;">
						<p>#lead#</p>
						
							
						<!--- <a href="../upload/magazine/#bild#" style="font-size:2em;line-height:1em;">Open</a> --->		
					</div>
				</div>
			</div>
	</div>
	<div class="bildlegende">
	<!--- 	<img src="/#session.serverpath#/upload/magazine/#bild#" style="height:50%;"> --->
		<p>#bildlegende#</p>
	</div>
</div>

</cfoutput>