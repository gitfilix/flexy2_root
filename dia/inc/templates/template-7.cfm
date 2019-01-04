<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_7
WHERE slideid = #url.slideID#
</cfquery>

<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = #getSlideContent.galerie#
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
<div style="width:100%;height:100%;background:url('/mirza-in-progress/upload/magazine/#getSlideBackgroundImage.bgimage#') center center no-repeat;background-size:cover;">
<div class="fadeInBGImage tpl7-bigImage<cfif setting_layout EQ 1>-large</cfif> <cfif setting_bildanim GT 0>anim</cfif> <cfif setting_bildanim EQ 1>animatedBackgroundLeftRight<cfelseif setting_bildanim EQ 2>animatedBackgroundRightLeft<cfelseif setting_bildanim EQ 3>animatedBackgroundTopDown<cfelseif setting_bildanim EQ 4>animatedBackgroundBottomUp</cfif>" data-inanimation="1.2-fadeIn-0.8" style="font-size:1.5em;background:url('<cfif bild NEQ "" AND setting_layout NEQ 6>/mirza-in-progress/upload/magazine/#bild#<cfelseif setting_layout NEQ 6>img/zplus-fallback.jpg</cfif>') center center no-repeat;background-size:cover;<cfif setting_layout EQ 3 OR setting_layout EQ 4>float:right !important;<cfelseif setting_layout EQ 2>float:none;width:100%;height:60%;<cfelseif setting_layout EQ 5>float:none;width:100%;height:60%;position:absolute;bottom:0;</cfif>">
	&nbsp;<cfif bild_legenede NEQ "" AND bild NEQ "">
	<div  class="tpl7-imageHolder">
		<div style="font-size:0.6em;line-height:1.15em;position:absolute;bottom:0;left:0;width:100%;background:rgba(0,0,0,0.7);color:##e7e7e7;">
			<div style="Padding:2em;">
				#bild_legenede#
			</div>
		</div>
	</div></cfif>
</div>
<div class="tpl7-contentContainer<cfif setting_layout EQ 1>-small</cfif>" id="tpl7#id#" style="font-size:1.5em;<cfif setting_layout EQ 2>width:100%;height:40%;<cfelseif setting_layout EQ 5>width:100%;height:40%;position:absolute;top:0;</cfif>">
	<div class="tpl7-textContainer<cfif youtube NEQ "" OR galerie NEQ 0>-yt</cfif>">
		<cfif setting_layout EQ 2 OR setting_layout EQ 5><div class="tpl7-textContainerInner" style="position:relative;padding:1% 0 0 1%;height:99%;overflow:hidden;">
				<div style="width:33%;float:left;height:95%;">
					<div style="padding:0.1em;">
						<span style="color:#setting_titlecolor#;font-size:0.6em;">
							#titel_1#
						</span><br/>
						<h1 data-inanimation="#setting_titleanimation_delay#-<cfif setting_titleanimation EQ 1>fadeIn<cfelseif setting_titleanimation EQ 2>slideInLeft<cfelseif setting_titleanimation EQ 3>slideInRight<cfelseif setting_titleanimation EQ 4>slideInTop<cfelseif setting_titleanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_titleanimation_duration#" class="<cfif setting_titleanimation GT 0>anim</cfif>" data-style="color:#setting_titlecolor#;" style="<cfif setting_titleanimation GT 0>opacity:0;</cfif>color:#setting_titlecolor#;">#titel_2#</h1>
					</div>
				</div>
				<div style="width:33%;float:left;height:95%;">
					<div style="padding:0.3em;">
						<h2 data-inanimation="#setting_leadanimation_delay#-<cfif setting_leadanimation EQ 1>fadeIn<cfelseif setting_leadanimation EQ 2>slideInLeft<cfelseif setting_leadanimation EQ 3>slideInRight<cfelseif setting_leadanimation EQ 4>slideInTop<cfelseif setting_leadanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_leadanimation_duration#" class="<cfif setting_leadanimation GT 0>anim</cfif>" style="<cfif setting_leadanimation GT 0>opacity:0;</cfif>color:#setting_leadcolor#;font-size:0.8em !important;">#anriss#</h2>
					</div>	
				</div>
				<div style="width:34%;float:left;height:95%;overflow-y:auto;-webkit-overflow-scrolling:touch;" class="overflow">
					<div class="tpl7-text <cfif setting_textanimation GT 0>anim</cfif>" data-inanimation="#setting_textanimation_delay#-<cfif setting_textanimation EQ 1>fadeIn<cfelseif setting_textanimation EQ 2>slideInLeft<cfelseif setting_textanimation EQ 3>slideInRight<cfelseif setting_textanimation EQ 4>slideInTop<cfelseif setting_textanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_textanimation_duration#" style="<cfif setting_textanimation GT 0>opacity:0;</cfif>color:#setting_textcolor#;padding:0.5em;-moz-column-count:1;-webkit-column-count:1;">#textabschnitt_1#</div>
				</div>
				<div style="clear:both;"></div>
			</div>
			<cfelse><div class="tpl7-textContainerInner overflow" style="position:relative;">
				<span style="color:#setting_titlecolor#;font-size:0.6em;">#titel_1#</span><br/>
				 <cfif setting_bigtext EQ 1><div class="test222" style="width:100%;color:#setting_titlecolor#;font-family:'League Gothic',Tahoma;font-weight:bold;"><cfset words = listLen(titel_2,' ') /><cfif words gt 11><cfset factor = 3 /><cfelseif words ltE 3><cfset factor = 1 /><cfelse><cfset factor = 2 /></cfif><cfset wordsPerLine = int(words/factor) />
					<cfif factor EQ 1><div>#titel_2#</div> 
					<cfelseif factor EQ 2><div><cfloop from="1" to="#wordsperline#" index="i">#listGetAt(titel_2,i,' ')# </cfloop></div> 
						<div><cfloop from="#wordsperline+1#" to="#listLen(titel_2,' ')#" index="i">#listGetAt(titel_2,i,' ')# </cfloop></div>
					<cfelse><div><cfloop from="1" to="#wordsperline#" index="i">#listGetAt(titel_2,i,' ')# </cfloop></div> 
						<div><cfloop from="#wordsperline+1#" to="#wordsperline+wordsperline#" index="i">#listGetAt(titel_2,i,' ')# </cfloop></div> 
						<div><cfloop from="#(wordsperline*2)+1#" to="#listLen(titel_2,' ')#" index="i">#listGetAt(titel_2,i,' ')# </cfloop></div></cfif></div>
				<cfelse><h1 data-inanimation="#setting_titleanimation_delay#-<cfif setting_titleanimation EQ 1>fadeIn<cfelseif setting_titleanimation EQ 2>slideInLeft<cfelseif setting_titleanimation EQ 3>slideInRight<cfelseif setting_titleanimation EQ 4>slideInTop<cfelseif setting_titleanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_titleanimation_duration#" class="<cfif setting_titleanimation GT 0>anim</cfif>" data-style="color:#setting_titlecolor#;" style="<cfif setting_titleanimation GT 0>opacity:0;</cfif>color:#setting_titlecolor#;">#titel_2#</h1></cfif><h2 data-inanimation="#setting_leadanimation_delay#-<cfif setting_leadanimation EQ 1>fadeIn<cfelseif setting_leadanimation EQ 2>slideInLeft<cfelseif setting_leadanimation EQ 3>slideInRight<cfelseif setting_leadanimation EQ 4>slideInTop<cfelseif setting_leadanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_leadanimation_duration#" class="<cfif setting_leadanimation GT 0>anim</cfif>" style="<cfif setting_leadanimation GT 0>opacity:0;</cfif>color:#setting_leadcolor#;">#anriss#</h2>
				<div class="tpl7-text <cfif setting_textanimation GT 0>anim</cfif>" data-inanimation="#setting_textanimation_delay#-<cfif setting_textanimation EQ 1>fadeIn<cfelseif setting_textanimation EQ 2>slideInLeft<cfelseif setting_textanimation EQ 3>slideInRight<cfelseif setting_textanimation EQ 4>slideInTop<cfelseif setting_textanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_textanimation_duration#" style="<cfif setting_textanimation GT 0>opacity:0;</cfif>color:#setting_textcolor#;">#textabschnitt_1#</div>
				<div class="tpl7-mobileButton">
					<button class="large lightbox" data-lightboxdiv="test#id#" data-lightboxtype="full-white">ganzer Artikel</button>
				</div>
			</div></cfif><div class="textFadeOut" style="-moz-linear-gradient(center top , rgba(231, 231, 231, 0), #getSlideBackgroundImage.bgcolor#)">
			&nbsp;

		</div>
	</div><cfif youtube NEQ ""><div class="tpl7-ytHolder <cfif setting_mediaanimation EQ 1>anim</cfif>" data-inanimation="1.3-slideInBottom-0.5">  
		<div class="tpl7-ytHolderInner">
			<iframe class="ytvideo-iframe" data-src="http://www.youtube.com/embed/#youtube#?controls=1&amp;showinfo=0&amp;modestbranding=1&amp;wmode=transparent&amp;enablejsapi=1&html5=1" width="100%" height="100%" frameborder="0" style="margin:0;padding:0;width: 100%; height: 100%;" allowfullscreen="1" title="YouTube video player" src="/mirza-in-progress/travelapp/offline.htm"></iframe>
		</div>
	</div><cfelseif galerie NEQ 0><div class="tpl7-ytHolder <cfif setting_mediaanimation EQ 1>anim</cfif>" id="tpl7-ytHolder#id#" data-inanimation="1.3-slideInBottom-0.5" onclick="toggleGallery()">
		<div class="tpl7-ytHolderInner">
			<div class="swiper-container">
				<div class="swiper-wrapper"><cfloop query="getAlbumWithImages"><div class="swiper-slide">
					<div class="inner">
						<img src="<cfif imagePath NEQ "">/mirza-in-progress/upload/galleries/#imagePath#<cfelse>img/zplus-fallback.jpg</cfif>" alt="">
					</div>
				</div></cfloop></div>
			</div>
		</div>
	</div></cfif>
</div>	
<div style="clear:both;"></div>
<div id="test#id#" class="hidden">
	<div class="tpl7-lightboxContainer">	
		<h1>#titel_1#</h1>	
		<h2>
			#anriss#
		</h2>
		<div class="tpl7-lightbox-author">
			by M. Grossniklaus, Biel-Bienne
		</div>
		<div class="tpl7-lightbox-contentContainer">
			#anriss#
		</div>
	</div>
</div>
</div> 
</cfoutput>



<!--- <script>
	$(document).ready(function(){
		slidey.obj.on("slidechanged", function() {	
		// do something			
			if(!navigator.onLine){
				$('.tpl7-ytHolder').hide();
				$('.tpl7-textContainer-yt').css({
					height:'100%'
				})
			}
			$('section[data-template=7]').each(function(){
				_this = $(this)
				// only init gallery if availible
				if($('.swipeGallery',_this).length>0){
					// loop through each gallery
					$('.swipeGallery',_this).each(function(idx){
						// init photoswipe
						$("a",'.swipeGallery').photoSwipe({
							captionAndToolbarHideOnSwipe: false,
							captionAndToolbarFlipPosition: true,
							captionAndToolbarShowEmptyCaptions: true
						})
						
					})
				}
			})	
		});	
	})
	
</script> --->