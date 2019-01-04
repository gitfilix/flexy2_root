<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor,label FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_8
WHERE slideid = #url.slideID#
</cfquery>

<cfquery name="getAllArticles" datasource="#application.dsn#">
SELECT 	M.*,S.parent
FROM 	articles2Slides A LEFT JOIN 
		magazinslides S ON S.id = A.otherSlideID LEFT JOIN
		magazinslidetpl_7 M ON M.slideid = S.id
WHERE 	A.slideid = #url.slideID#
GROUP	BY S.id
ORDER	BY M.bild DESC
</cfquery>

<!--- 
id,
titel_1,
titel_2,
anriss,
textabschnitt_1,
textabschnitt_2,
textabschnitt_3,
bild,
galerie,
youtube,
bild_legenede,
bild_quelle,
setting_layout,
setting_bildanim,
setting_slidetransition,
setting_allowcomment,
setting_titlecolor,
setting_leadcolor,
setting_textcolor,
setting_skin,
setting_titleanimation,
setting_leadanimation,
setting_textanimation,
setting_mediaanimation, 
textabschnitt_2_bild,
textabschnitt_3_bild,
slideID,
setting_titleanimation_delay,
setting_titleanimation_duration,
setting_leadanimation_delay,
setting_leadanimation_duration, 
setting_textanimation_delay,
setting_textanimation_duration
--->


<div class="tpl8-mainArticles" style="<cfif getAllArticles.recordcount LT 3 OR getSlideContent.setting_layout EQ 3 OR getSlideContent.setting_layout EQ 4 OR getSlideContent.setting_layout EQ 5>width:100%;<cfelse>width:78%;</cfif>height:100%;float:<cfif getSlideContent.setting_layout EQ 1>right;margin-left:2%<cfelseif getSlideContent.setting_layout EQ 0 OR getSlideContent.setting_layout EQ 2>left;margin-right:2%</cfif>;position:relative;">
	<cfoutput query="getAllArticles" startrow="1" maxrows="1"><article class="tpl8-mainArticle" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"</cfif> style="<cfif getSlideContent.setting_layout EQ 2>position:absolute;bottom:1%;margin-top:2%;<cfelse>margin-bottom:2%;</cfif>height:<cfif getSlideContent.setting_layout EQ 5>100%<cfelse>58%</cfif>;background:transparent <cfif bild NEQ "">url('../upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;">
		<div style="padding:1.4em;width:60%;">
			<span style="color:white;font-weight:bold;<cfif getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>font-size:0.8em;background-color:##333;<cfelse>font-size:2em;background-color:##333;</cfif>padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel">
				<cfif getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>#titel_1#<cfelse>#getSlideBackgroundImage.label#</cfif>
			</span><cfif getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>
			<h1 style="margin-top:0.2em;font-size:4em !important;color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>>
				<span style="Background-color:white;color:##333;">#titel_2#</span>
			</h1>
			<!--- <h2 style="font-size:1.2em;line-height:1.1em;hyphens:auto;">
				<span style="color:##333;background-color:##fff;font-weight:bold;"><cfset textstr = REReplace(anriss,'<[^>]*>','','all')>#textstr#</span>
			</h2> ---><cfelseif getSlideContent.setting_layout EQ 5><div style="width:60%;padding-top:5%;"><cfset idx = 1 /><cfloop query="getAllArticles" startrow="2" endrow="6">
					<span style="font-size:1em;line-height:1.3em;color:white;font-weight:bold;background-color:##333;">#titel_1#</span>
					<h1 style="margin-top:0.2em;<cfif idx GT 1>font-size:2em !important;<cfelse>font-size:3em !important;</cfif>color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>>
						<span style="background-color:white;color:##333;">#titel_2#</span>
					</h1><br/><br/>
				<cfset idx = idx + 1 /></cfloop></div><cfif getAllArticles.recordcount GT 6><div class="overflow" style="height:100%;;position:absolute;right:0;top:0;padding-right:2%;text-align:right;width:45%;padding-top:5%;"><cfloop query="getAllArticles" startrow="7" endrow="20">
					<span style="line-height:1.3em;color:white;font-weight:bold;font-size:1em;background-color:##333;">#titel_1#</span>
					<h1 style="margin-top:0.2em;font-size:2em !important;color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>>
						<span style="background-color:white;color:##333;">#titel_2#</span>
					</h1><br/><br/>
				</cfloop></div></cfif></cfif>
		</div>
		<cfif getSlideContent.articleType EQ 1><div id="artikel#id#" class="hidden">
				<span style="color:white;font-weight:bold;" class="tpl8-thematitel">
					#titel_1#
				</span><br/>
				<h1 style="font-size:1.5em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>>
					#titel_2#
				</h1>
				<h2 style="font-size:0.62em !important;line-height:1.2em;width:40%;color:##fff;">
					<strong>#anriss#</strong>
				</h2>
				#textabschnitt_1#
			</div></cfif></article></cfoutput>
	<cfif getSlideContent.setting_layout NEQ 3 AND getSlideContent.setting_layout NEQ 4><cfoutput query="getAllArticles" startrow="2" maxrows="1"><article class="tpl8-mainSubArticle" style="height:38%;<cfif getSlideContent.setting_layout EQ 2>position:relative;top:0;</cfif>">
			<div style="height:100%;width:64%;margin-right:2%;background:transparent <cfif bild NEQ "">url('../upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;float:left;" class="tpl8-thematitel">
				&nbsp;
			</div>
			<div style="float:left;width:34%;height:100%;" class="overflow">
				<cfif getSlideContent.setting_layout EQ 2><br/></cfif>
				<span style="font-size:0.8em;color:##333;font-weight:bold;background-color:##333;padding:0.2em;color:##e7e7e7;">
					#titel_1#
				</span><br/>
				<h1 style="font-size:3em;color:##333;font-family:'League Gothic',Tahoma;margin-top:0.2em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>>
					#titel_2#
				</h1>
				<h2 style="font-size:1em !important;line-height:1.2em;color:##333;">
					#anriss#
				</h2>
			</div>
	</article></cfoutput><cfelseif getSlideContent.setting_layout NEQ 5>
		<div class="tpl8-sidebarArticles2" style="height:38%;width:98%;margin:0 auto;">
			<div style="height:100%;width:100%;text-overflow: ellipsis;">
				<div style="height:100%;width:100%;">
					<div class="swiper-container" style="height:100%;">
						<div class="swiper-wrapper" style="height:100%;"><cfoutput query="getAllArticles" startrow="2" maxrows="10"><div class="swiper-slide overflow" style="width:25%;height:100%;">
							<div class="inner" style="padding:0.2em 0.5em;">
								<span style="font-weight:bold;font-size:0.8em;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel">#titel_1#</span><br/>
								<h1 style="font-family:'League Gothic',Tahoma;font-size:2em;margin-top:0.2em;">#titel_2#</h1>
								<h2 style="font-size:1em;line-height:1.2em;margin-top:0.2em;">#anriss#</h2>
							</div>
						</div></cfoutput></div>
					</div>
				</div>
			</div>
		</div></cfif>
</div><cfif getAllArticles.recordcount LT 3 OR getSlideContent.setting_layout NEQ 3>
<div class="tpl8-sidebarArticles" style="height:98%;width:18%;<cfif getSlideContent.setting_layout EQ 1>padding-left:2%;<cfelse>padding-right:2%;</cfif>float:left;">
	<div class="ovscroll overflow" style="height:100%;width:100%;">
		<div style="height:100%;width:100%;"><br/>
			<cfoutput query="getAllArticles" startrow="3" maxrows="100"><div style="float:none;margin-bottom:1em;width:95%;"> 
				<span style="margin-bottom:0.4em;color:##333;font-weight:bold;font-size:0.8em;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel">
					#titel_1#
				</span><br/>
				<h1 style="color:##333;font-family:'League Gothic',Tahoma;font-size:2em;line-height:1em;margin-top:0.2em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>>
					<div style="-moz-hyphens:auto;-webkit-hyphens:auto;hyphens:auto;font-family:'League Gothic',Tahoma;">
						#titel_2#
					</div>
				</h1>
				<h2 style="font-size:1em;line-height:1.2em;color:##333;-moz-hyphens:auto;-webkit-hyphens:auto;hyphens:auto;">
					#anriss#
				</h2>
			</div></cfoutput>
		</div>
	</div>
</div></cfif>



