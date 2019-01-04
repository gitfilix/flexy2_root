<cfprocessingdirective pageencoding="utf-8">
<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor,parent,label FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>
<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_100
WHERE slideid = #url.slideID#
</cfquery>



	<cfoutput>
	<!--- layout type 1 VERY Big title --->
	<cfif getSlideContent.layout EQ 1 >
	<div style="height:100%; <cfif getSlideBackgroundImage.bgimage EQ "">background:#getSlideBackgroundImage.bgcolor#;<cfelse>backgroundurl(/dia/upload/magazine/#getSlideBackgroundImage.bgimage#) center center no-repeat; background-size:cover;	</cfif>" class="tpl100" >
		<div style="height:100%; padding:3em;box-seizing:border-box;position:relative;">
			<div class="redbutton-top lightbox" data-lightboxdiv="lb#url.slideid#" data-lightboxtype="1">
				&nbsp;
			</div>	
			<div  class="very-bigtitel anim" style="height:30%" data-inanimation="0.2-fadeIn-0.4">
				<h1>#getSlideContent.titel#</h1>
			</div>
			<div  style="height:12%" class="untertitel-sans anim" data-inanimation="0.6-fadeIn-0.3">
				<h2>#getSlideContent.lead#</h2>
			</div>
			<div style="height:58%;overflow:hidden;"  class="fliesstext ftScrollerVertical anim" id="ghjhg#url.slideid#" data-inanimation="1-fadeIn-0.3">
				#getSlideContent.text#<br/><!--- <p>+layouttyp-1+</p> --->
			</div>
		</div>
		<!--- lightbox  --->
		<div id="lb#url.slideid#" class="hidden">
			<div style="padding:2em; height:100%; background:##111; "  class=" tpl100-lb">
				<div class="bigtitel" style="height:15%; border-top:1px solid ##777;">
					<h1>#getSlideContent.lb_titel#</h1>
				</div>
				<div class="units-row" style="height:85%;">
					<div class="unit-70" >
						<div class="lb-img" style="height:100%">
						<cfif getSlideContent.galerie NEQ 0>
							<cfquery name="getAlbums" datasource="#application.dsn#">
							SELECT	*
							FROM	albums A LEFT JOIN
									albumimages I ON I.albumID = A.id
							WHERE	A.id = #getSlideContent.galerie#
							</cfquery>
							<cfif getAlbums.recordcount GT 0>
								<div class="swiper-container" style="height:100%;">
								  <div class="swiper-wrapper" style="height:100%;">
									  <cfloop query="getAlbums">
										  <div class="swiper-slide" style="height:100%;">
										  		<div style="height:100%;background:url('/dia/upload/galleries/#imagePath#') left top no-repeat;background-size:cover;">&nbsp;</div>
												<!--- <img src="/dia/upload/galleries/#imagePath#" /> --->
										  </div>
									  </cfloop>
									</div>
								</div>
							</cfif>
						<cfelseif getSlideContent.lb_bild NEQ "">
							<img src="/dia/upload/magazine/#getSlideContent.lb_bild#">
						</cfif>
						</div>	
					</div>
					<div class="unit-30 ftScrollerVertical" id="uu#url.slideid#">
						<div  class="fliesstext">
							#getSlideContent.lb_text#<br /><br />
						</div>
						<div class="untertitel-sans">
							<p>#getSlideContent.lb_bildcaption#</p>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
	<!--- layout type 2 longtitle with more text --->
	<cfelseif getSlideContent.layout EQ 2 >
	<div style="height:100%; <cfif getSlideBackgroundImage.bgimage EQ "">background:#getSlideBackgroundImage.bgcolor#;<cfelse>backgroundurl(/dia/upload/magazine/#getSlideBackgroundImage.bgimage#) center center no-repeat; background-size:cover;	</cfif>" class="tpl100" >
		<div style="height:100%; padding:3em;box-seizing:border-box;position:relative;">
			<div class="redbutton-top lightbox" data-lightboxdiv="lb#url.slideid#" data-lightboxtype="1">
				&nbsp;
			</div>	
			<div class="very-bigtitel-long anim" style="height:30%" data-inanimation="0.2-fadeIn-0.4">
				<h1>#getSlideContent.titel#</h1>
			</div>
			<div  style="height:20%" class="untertitel-sans anim" data-inanimation="0.6-fadeIn-0.4">
				<h2>#getSlideContent.lead#</h2>
			</div>
			<div style="height:50%;overflow:hidden;"  class="fliesstext-long ftScrollerVertical anim" id="gh44#url.slideid#" data-inanimation="1-fadeIn-0.4">
				#getSlideContent.text#<br/>
			</div>
		</div>
		<!--- lightbox  --->
		<div id="lb#url.slideid#" class="hidden">
			<div style="padding:2em; height:100%; background:##111; "  class=" tpl100-lb">
				<div class="bigtitel" style="height:15%; border-top:1px solid ##777;">
					<h1>#getSlideContent.lb_titel#</h1>
				</div>
				<div class="units-row" style="height:85%;">
					<div class="unit-70" >
						<div class="lb-img" style="height:100%">
						<cfif getSlideContent.galerie NEQ 0>
							<cfquery name="getAlbums" datasource="#application.dsn#">
							SELECT	*
							FROM	albums A LEFT JOIN
									albumimages I ON I.albumID = A.id
							WHERE	A.id = #getSlideContent.galerie#
							</cfquery>
							<cfif getAlbums.recordcount GT 0>
								<div class="swiper-container" style="height:100%;">
								  <div class="swiper-wrapper" style="height:100%;">
									  <cfloop query="getAlbums">
										  <div class="swiper-slide" style="height:100%;">
										  		<div style="height:100%;background:url('/dia/upload/galleries/#imagePath#') left top no-repeat;background-size:cover;">&nbsp;</div>
												<!--- <img src="/dia/upload/galleries/#imagePath#" /> --->
										  </div>
									  </cfloop>
									</div>
								</div>
							</cfif>
						<cfelseif getSlideContent.lb_bild NEQ "">
							<img src="/dia/upload/magazine/#getSlideContent.lb_bild#">
						</cfif>
						</div>	
					</div>
					<div class="unit-30 ftScrollerVertical" id="uu#url.slideid#">
						<div  class="fliesstext">
							#getSlideContent.lb_text#<br /><br />
						</div>
						<div class="untertitel-sans">
							<p>#getSlideContent.lb_bildcaption#</p>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
	</cfif> 
</cfoutput>
