<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor,parent,label FROM magazinSlides
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
<cfquery name="getDirection" datasource="#application.dsn#">
SELECT 	direction
FROM 	magazinkapitel
WHERE 	id = #getSlideBackgroundImage.parent#
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


<cfoutput query="getSlideContent">
	
	<!--- klassiches übersicht, links, rechts, rechts2 --->
	<cfif setting_layout EQ 0 OR setting_layout EQ 1 OR setting_layout EQ 2>
		<div class="tpl8-mainArticles" style="width:68%;height:100%;float:<cfif getSlideContent.setting_layout EQ 1>right;margin-left:2%<cfelseif getSlideContent.setting_layout EQ 0 OR getSlideContent.setting_layout EQ 2>left;margin-right:2%</cfif>;position:relative;"> 
		<cfloop query="getAllArticles" startrow="1" endrow="1">
			<article class="tpl8-mainArticle" style="<cfif getSlideContent.setting_layout EQ 2>width:100%;position:absolute;bottom:1%;margin-top:2%;<cfelse>margin-bottom:1%;</cfif>height:58%;background:transparent <cfif bild NEQ "">url('/mirza-in-progress/upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;-webkit-transform: translate3d(0,0,0);">
				<div style="padding:1.4em;width:60%;"> 
					<span style="color:white;font-weight:bold;font-size:0.8em;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>>
						#titel_1#
					</span>
					<h1 style="margin-top:0.2em;font-size:4em !important;color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> 
						<span style="Background-color:white;color:##333;">
							#titel_2#
						</span> 
					</h1>
				</div>
				<cfif getSlideContent.articleType EQ 1>
					<div id="artikel#id#" class="hidden"> <span style="color:white;font-weight:bold;" class="tpl8-thematitel"> #titel_1# </span><br/>
						<h1 style="font-size:1.5em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> #titel_2# </h1>
						<h2 style="font-size:0.62em !important;line-height:1.2em;width:40%;color:##fff;"> <strong>#anriss#</strong> </h2>
						#textabschnitt_1# 
					</div>
				</cfif>
			</article>
		</cfloop>
		<!--- Sub Article --->
		<cfloop query="getAllArticles" startrow="2" endrow="2">
			<article class="tpl8-mainSubArticle" style="height:38%;<cfif getSlideContent.setting_layout EQ 2>position:relative;top:0;</cfif>">
				<div style="height:100%;width:64%;margin-right:2%;background:transparent <cfif bild NEQ "">url('/mirza-in-progress/upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;float:left;-webkit-transform: translate3d(0,0,0);" class="tpl8-thematitel"> &nbsp; </div>
				<div style="float:left;width:34%;height:100%;position:relative;">
					<div  class="ftScrollerlVertical" id="iiiscroll#id#" style="height:100%;">
						<div id="iiiscroller#id#" style="padding:0.5em;background-color:##fff;">
							<cfif getSlideContent.setting_layout EQ 2>
								<br/>
							</cfif>
							<span style="font-size:0.8em;color:##333;font-weight:bold;background-color:##333;padding:0.2em;color:##e7e7e7;"> #titel_1# </span><br/>
							<h1 style="font-size:3em;color:##333;font-family:'League Gothic',Tahoma;margin-top:0.2em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>> #titel_2# </h1>
							<h2 style="font-size:1em !important;line-height:1.2em;color:##333;"> #anriss# </h2>
						</div>
					</div>
				</div>
			</article>
		</cfloop>
	</div>
	<!--- Sidebar Articles --->
	<div class="tpl8-sidebarArticles" style="height:98%;width:28%;<cfif getSlideContent.setting_layout EQ 1>padding-left:2%;<cfelse>padding-right:2%;</cfif>float:left;position:relative;">
		<div class="ftScrollerlVertical" id="iscroll#replace(createUUID(),'-','','ALL')#" style="height:100%;width:100%;overflow:hidden;">
			<div id="iscroller#replace(createUUID(),'-','','ALL')#">	
				<cfloop query="getAllArticles" startrow="3" endrow="6">
					<div style="margin-bottom:1.5em;"> 
						<span style="margin-bottom:0.6em;color:##333;font-weight:bold;font-size:0.8em;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel"> #titel_1# </span><br/>
						<h1 style="-moz-hyphens:auto;-webkit-hyphens:auto;hyphens:auto;color:##333;margin-top:0.3em;font-size:1em;line-height:1em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>>
							<strong>#titel_2#</strong>
						</h1>
						<h2 style="font-size:1em;line-height:1.2em;color:##333;-moz-hyphens:auto;-webkit-hyphens:auto;hyphens:auto;"> #anriss# </h2>
					</div>
				</cfloop>		
			</div>
		</div>
	</div>
	
	<!--- 1 hauptartikel oder ressort, artikelswiper --->
	<cfelseif setting_layout EQ 3 OR setting_layout EQ 4>
	
		<div class="tpl8-mainArticles" style="width:100%;height:100%;position:relative;"> 
		<cfloop query="getAllArticles" startrow="1" endrow="1">
			<article class="tpl8-mainArticle" style="margin-bottom:1%;height:58%;background:transparent <cfif bild NEQ "">url('/mirza-in-progress/upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;-webkit-transform: translate3d(0,0,0);">
				<div style="padding:1.4em;width:60%;"> 
					<span style="color:white;font-weight:bold;font-size:<cfif getSlideContent.setting_layout EQ 3>0.8em<cfelse>3em</cfif>;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>>
						<cfif getSlideContent.setting_layout EQ 3>
							#titel_1#
						<cfelse>
							#getSlideBackgroundImage.label#
						</cfif>
					</span>	
					<cfif getSlideContent.setting_layout EQ 3>
						<h1 style="margin-top:0.2em;font-size:4em !important;color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> <span style="Background-color:white;color:##333;">#titel_2#</span> </h1>
					</cfif>
				</div>
				<cfif getSlideContent.articleType EQ 1>
					<div id="artikel#id#" class="hidden"> 
						<span style="color:white;font-weight:bold;" class="tpl8-thematitel"> #titel_1# </span><br/>
						<h1 style="font-size:1.5em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> #titel_2# </h1>
						<h2 style="font-size:0.62em !important;line-height:1.2em;width:40%;color:##fff;"> <strong>#anriss#</strong> </h2>
						#textabschnitt_1# 
					</div>
				</cfif>
			</article>
		</cfloop>
		<!--- Bottombar Articles --->
		<div class="tpl8-sidebarArticles2" style="height:38%;width:98%;margin:0 auto;">
			<div style="height:100%;width:100%;text-overflow: ellipsis;">
				<div style="height:100%;width:100%;position:relative;">
					<div class="ftScrollerlHorizontal<cfif getDirection.direction NEQ 1>WithSwipe</cfif>" id="iscroll1#getSlideContent.id#" style="height:100%;width:100%;">
						<div id="iscroller1#getSlideContent.id#" style="height:100% !important;width: #330*(getAllArticles.recordcount-1)#px;">
							<ul style="height:100%;width:100%;">
								<cfloop query="getAllArticles" startrow="2" endrow="7">
									<li style="float:left;margin-right:30px;width:300px;height:100%;display:block;">
										<div style="height:100%;position:relative;">
											<div class="ftScrollerlVertical" id="iiscroll#createUUID()#" style="height:98%;">
												<div id="iiscroller#getSlideContent.id#" style="background-color:white;padding:0.5em;height.100%;"> 
													<span style="font-weight:bold;font-size:0.8em;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel">#titel_1#</span><br/>
													<h1 style="font-family:'League Gothic',Tahoma;font-size:2em;margin-top:0.2em;">#titel_2#</h1>
													<h2 style="font-size:1em;line-height:1.2em;margin-top:0.2em;">#anriss#</h2>
												</div>
											</div>
										</div>
									</li>
								</cfloop>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!--- vollbild artikel übersicht --->
	<cfelse>
		<div class="tpl8-mainArticles" style="width:100%;height:100%;position:relative;"> 
			<cfloop query="getAllArticles" startrow="1" endrow="1">
				<article class="tpl8-mainArticle" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"</cfif> style="<cfif getSlideContent.setting_layout EQ 2>position:absolute;bottom:1%;margin-top:2%;<cfelse>margin-bottom:1%;</cfif>height:<cfif getSlideContent.setting_layout EQ 5>100%<cfelse>58%</cfif>;background:transparent <cfif bild NEQ "">url('/mirza-in-progress/upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;-webkit-transform: translate3d(0,0,0);">
					<div style="padding:1.4em;width:60%;"> 
						<span style="color:white;font-weight:bold;<cfif getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>font-size:0.8em;background-color:##333;<cfelse>font-size:2em;background-color:##333;</cfif>padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel">
							#getSlideBackgroundImage.label#
						</span>
						
						<div style="width:60%;padding-top:5%;">
							<cfset idx = 1 />
							<cfloop query="getAllArticles" startrow="2" endrow="4">
								<span style="font-size:1em;line-height:1.3em;color:white;font-weight:bold;background-color:##333;">#titel_1#</span>
								<h1 style="margin-top:0.2em;<cfif idx GT 1>font-size:2em !important;<cfelse>font-size:3em !important;</cfif>color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> <span style="background-color:white;color:##333;">#titel_2#</span> </h1>
								<br/>
								<br/>
								<cfset idx = idx + 1 />
							</cfloop>
						</div>
						<cfif getAllArticles.recordcount GT 6>
							<div class="ftScrollerlVertical" id="ft#id#" style="height:100%;position:absolute;right:0;top:0;padding-right:2%;text-align:right;width:45%;padding-top:5%;">
								<cfloop query="getAllArticles" startrow="5" endrow="20">
									<span style="line-height:1.3em;color:white;font-weight:bold;font-size:1em;background-color:##333;">#titel_1#</span>
									<h1 style="margin-top:0.2em;font-size:2em !important;color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> <span style="background-color:white;color:##333;">#titel_2#</span> </h1>
									<br/>
									<br/>
								</cfloop>
							</div>
						</cfif>
						
					</div>
					<cfif getSlideContent.articleType EQ 1>
						<div id="artikel#id#" class="hidden"> <span style="color:white;font-weight:bold;" class="tpl8-thematitel"> #titel_1# </span><br/>
							<h1 style="font-size:1.5em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> #titel_2# </h1>
							<h2 style="font-size:0.62em !important;line-height:1.2em;width:40%;color:##fff;"> <strong>#anriss#</strong> </h2>
							#textabschnitt_1# 
						</div>
					</cfif>
				</article>
			</cfloop>
			
	
	
	</cfif>



</cfoutput>








<!--- <div class="tpl8-mainArticles" style="<cfif getAllArticles.recordcount LT 3 OR getSlideContent.setting_layout EQ 3 OR getSlideContent.setting_layout EQ 4 OR getSlideContent.setting_layout EQ 5>width:100%;<cfelse>width:78%;</cfif>height:100%;float:<cfif getSlideContent.setting_layout EQ 1>right;margin-left:2%<cfelseif getSlideContent.setting_layout EQ 0 OR getSlideContent.setting_layout EQ 2>left;margin-right:2%</cfif>;position:relative;"> 
	<cfoutput query="getAllArticles" startrow="1" maxrows="1">
		<article class="tpl8-mainArticle" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"</cfif> style="<cfif getSlideContent.setting_layout EQ 2>position:absolute;bottom:1%;margin-top:2%;<cfelse>margin-bottom:1%;</cfif>height:<cfif getSlideContent.setting_layout EQ 5>100%<cfelse>58%</cfif>;background:transparent <cfif bild NEQ "">url('/mirza-in-progress/upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;-webkit-transform: translate3d(0,0,0);">
			<div style="padding:1.4em;width:60%;"> <span style="color:white;font-weight:bold;<cfif getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>font-size:0.8em;background-color:##333;<cfelse>font-size:2em;background-color:##333;</cfif>padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel">
				<cfif getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>
					#titel_1#
				<cfelse>
					#getSlideBackgroundImage.label#
				</cfif>
				</span>
				<cfif getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>
					<h1 style="margin-top:0.2em;font-size:4em !important;color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> <span style="Background-color:white;color:##333;">#titel_2#</span> </h1>
				<cfelseif getSlideContent.setting_layout EQ 5>
					<div style="width:60%;padding-top:5%;">
						<cfset idx = 1 />
						<cfloop query="getAllArticles" startrow="2" endrow="6">
							<span style="font-size:1em;line-height:1.3em;color:white;font-weight:bold;background-color:##333;">#titel_1#</span>
							<h1 style="margin-top:0.2em;<cfif idx GT 1>font-size:2em !important;<cfelse>font-size:3em !important;</cfif>color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> <span style="background-color:white;color:##333;">#titel_2#</span> </h1>
							<br/>
							<br/>
							<cfset idx = idx + 1 />
						</cfloop>
					</div>
					<cfif getAllArticles.recordcount GT 6>
						<div class="ftScrollerlVertical" id="ft#id#" style="height:100%;position:absolute;right:0;top:0;padding-right:2%;text-align:right;width:45%;padding-top:5%;">
							<cfloop query="getAllArticles" startrow="7" endrow="20">
								<span style="line-height:1.3em;color:white;font-weight:bold;font-size:1em;background-color:##333;">#titel_1#</span>
								<h1 style="margin-top:0.2em;font-size:2em !important;color:white;font-family:'League Gothic',Tahoma;hyphens:auto;" <cfif getSlideContent.articleType EQ 0 AND getSlideContent.setting_layout NEQ 4 AND getSlideContent.setting_layout NEQ 5>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> <span style="background-color:white;color:##333;">#titel_2#</span> </h1>
								<br/>
								<br/>
							</cfloop>
						</div>
					</cfif>
				</cfif>
			</div>
			<cfif getSlideContent.articleType EQ 1>
				<div id="artikel#id#" class="hidden"> <span style="color:white;font-weight:bold;" class="tpl8-thematitel"> #titel_1# </span><br/>
					<h1 style="font-size:1.5em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"<cfelse>data-lightboxdiv="artikel#id#" data-lightboxtype="full-white" class="lighbox"</cfif>> #titel_2# </h1>
					<h2 style="font-size:0.62em !important;line-height:1.2em;width:40%;color:##fff;"> <strong>#anriss#</strong> </h2>
					#textabschnitt_1# 
				</div>
			</cfif>
		</article>
	</cfoutput>
	<!--- Sub Article --->
	<cfif getSlideContent.setting_layout NEQ 3 AND getSlideContent.setting_layout NEQ 4>
		<cfoutput query="getAllArticles" startrow="2" maxrows="1">
			<article class="tpl8-mainSubArticle" style="height:38%;<cfif getSlideContent.setting_layout EQ 2>position:relative;top:0;</cfif>">
				<div style="height:100%;width:64%;margin-right:2%;background:transparent <cfif bild NEQ "">url('/mirza-in-progress/upload/magazine/#bild#')<cfelse>url('img/zplus-schraffur.jpg')</cfif> center center no-repeat;background-size:cover;float:left;-webkit-transform: translate3d(0,0,0);" class="tpl8-thematitel"> &nbsp; </div>
				<div style="float:left;width:34%;height:100%;position:relative;">
					<div  class="ftScrollerlVertical" id="iiiscroll#id#" style="height:100%;">
						<div id="iiiscroller#id#" style="padding:0.5em;background-color:##fff;">
							<cfif getSlideContent.setting_layout EQ 2>
								<br/>
							</cfif>
							<span style="font-size:0.8em;color:##333;font-weight:bold;background-color:##333;padding:0.2em;color:##e7e7e7;"> #titel_1# </span><br/>
							<h1 style="font-size:3em;color:##333;font-family:'League Gothic',Tahoma;margin-top:0.2em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>> #titel_2# </h1>
							<h2 style="font-size:1em !important;line-height:1.2em;color:##333;"> #anriss# </h2>
						</div>
					</div>
				</div>
			</article>
		</cfoutput>
	<!--- Bottombar Articles --->
	<cfelseif getSlideContent.setting_layout NEQ 5>
		<div class="tpl8-sidebarArticles2" style="height:38%;width:98%;margin:0 auto;">
			<div style="height:100%;width:100%;text-overflow: ellipsis;">
				<div style="height:100%;width:100%;position:relative;">
					<div class="ftScrollerlHorizontal<cfif getDirection.direction NEQ 1>WithSwipe</cfif>" id="iscroll1<cfoutput>#getSlideContent.id#</cfoutput>" style="height:100%;width:100%;">
						<div id="iscroller1<cfoutput>#getSlideContent.id#</cfoutput>" style="height:100% !important;width: <cfoutput>#330*(getAllArticles.recordcount-1)#</cfoutput>px;">
							<ul style="height:100%;width:100%;">
								<cfoutput query="getAllArticles" startrow="2" maxrows="10">
									<li style="float:left;margin-right:30px;width:300px;height:100%;display:block;">
										<div style="height:100%;position:relative;">
											<div class="ftScrollerlVertical" id="iiscroll<cfoutput>#getSlideContent.id#</cfoutput>" style="height:98%;">
												<div id="iiscroller<cfoutput>#getSlideContent.id#</cfoutput>" style="background-color:white;padding:0.5em;"> <span style="font-weight:bold;font-size:0.8em;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel">#titel_1#</span><br/>
													<h1 style="font-family:'League Gothic',Tahoma;font-size:2em;margin-top:0.2em;">#titel_2#</h1>
													<h2 style="font-size:1em;line-height:1.2em;margin-top:0.2em;">#anriss#</h2>
												</div>
											</div>
										</div>
									</li>
								</cfoutput>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</cfif>
</div>
<cfif getAllArticles.recordcount LT 4>
	<div class="tpl8-sidebarArticles" style="height:98%;width:18%;<cfif getSlideContent.setting_layout EQ 1>padding-left:2%;<cfelse>padding-right:2%;</cfif>float:left;position:relative;">
		<div class="ftScrollerlVertical" id="iscroll<cfoutput>#replace(createUUID(),'-','','ALL')#</cfoutput>" style="height:100%;width:100%;">
			<div id="iscroller<cfoutput>#replace(createUUID(),'-','','ALL')#</cfoutput>">
				<ul>
					<cfoutput query="getAllArticles" startrow="3" maxrows="100">
						<li style="margin-bottom:1.5em;"> 
							<span style="margin-bottom:0.4em;color:##333;font-weight:bold;font-size:0.8em;background-color:##333;padding:0.2em;color:##e7e7e7;" class="tpl8-thematitel"> #titel_1# </span><br/>
							<h1 style="color:##333;font-family:'League Gothic',Tahoma;font-size:2em;line-height:1em;margin-top:0.2em;" <cfif getSlideContent.articleType EQ 0>onclick="location.href='##/slide#slideid#';"</cfif>>
								<div style="-moz-hyphens:auto;-webkit-hyphens:auto;hyphens:auto;font-family:'League Gothic',Tahoma;"> #titel_2# </div>
							</h1>
							<h2 style="font-size:1em;line-height:1.2em;color:##333;-moz-hyphens:auto;-webkit-hyphens:auto;hyphens:auto;"> #anriss# </h2>
						</li>
					</cfoutput>
				</ul>
			</div>
		</div>
	</div>
</cfif>
 --->