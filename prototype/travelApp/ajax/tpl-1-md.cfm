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

<!--- 
setting_layout
setting_skin
titel
titlecolor
lead
bild
imgpos
bildlegende
lightboxtitle
lightboxbutton
lbbild
video
ytvideo
lightboxtext
lightboxtype
 --->


<cfoutput query="getSlideContent">
<!--- layout 0: text left 30 and big picture right 70% --->
<cfif setting_layout EQ 0>
<div style="width:100%; height:100%;" class="tpl1-layout">
	<div style="width:30%; height:100%; float:left;" >
		<div style="width:100%; height:10%;">&nbsp;</div>
		<div style="width:100%; height:25%;" class="tpl1-title">
			<h1 <cfif titlecolor NEQ "">style="color:#titlecolor#;"</cfif>>#titel#</h1>
		</div>
		<div style="width:100%; height:45%;">
			<div class="tpl1-lead ftScrollerlVertical" id="somescrollidlayout1">
				#lead#
			</div>
		</div> 
		<div style="width:100%; height:20%;">
			<!--- <div style=" margin-top:1em; text-align:right; width:100%; height:50%; background:##E1E1E1;" >
				<!--- show no button --->
				<cfif lightboxtype EQ 0>
					<div >-no button-</div>
				<!--- content in light box: show button --->
				<cfelseif lightboxtype EQ 1 OR lightboxtype EQ 2>
					<div>
						<button class="large lightbox tpl1-buttonstyle"  data-lightboxdiv="test#id#" data-lightboxtype="full-white">#lightboxbutton#</button>
					</div>
				</cfif>
			</div> --->
			<div style="width:100%; height:50%; background-color:##535353;">
					<div class="tpl1-figcapture" >#bildlegende#</div>
			</div>
		</div>
	</div>
	<div style="width:70%; height:100%; float:left;">
		<div class="tpl1-overflow tpl1-heigth-100 tpl1-grid-100"
		<cfif imgpos EQ 0>style="background-image:url(../upload/magazine/#bild#); background-position: center center; background-size:cover;"
		<cfelseif imgpos EQ 1>style="background-image:url(../upload/magazine/#bild#); background-position: center top; background-size:cover;"
		<cfelseif imgpos EQ 2>style="background-image:url(../upload/magazine/#bild#); background-position: center bottom; background-size:cover;"
		<cfelseif imgpos EQ 3>style="background-image:url(../upload/magazine/#bild#); background-position: left top; background-size:cover;"
		<cfelseif imgpos EQ 4>style="background-image:url(../upload/magazine/#bild#); background-position: left center; background-size:cover;"
		<cfelseif imgpos EQ 5>style="background-image:url(../upload/magazine/#bild#); background-position: left bottom; background-size:cover;"
		<cfelseif imgpos EQ 6>style="background-image:url(../upload/magazine/#bild#); background-position: right top; background-size:cover;"
		<cfelseif imgpos EQ 7>style="background-image:url(../upload/magazine/#bild#); background-position: right center; background-size:cover;"
		<cfelseif imgpos EQ 8>style="background-image:url(../upload/magazine/#bild#); background-position: right bottom; background-size:cover;"</cfif> >
		&nbsp;
		<div style="position:relative">
			<div style=" position:absolute;  bottom:1em; right:1em; text-align:right; background:##E1E1E1;" >
				<!--- show no button --->
				<cfif lightboxtype EQ 0>
					<div >-no button-</div>
				<!--- content in light box: show button --->
				<cfelseif lightboxtype EQ 1 OR lightboxtype EQ 2>
					<div>
						<button class="large lightbox tpl1-buttonstyle"  data-lightboxdiv="test#id#" data-lightboxtype="full-white">#lightboxbutton#</button>
					</div>
				</cfif>
			</div>
			</div>
		</div>
	</div>
	<div style="clear:both;"></div>
</div>
<!--- lightbox in tpl1 layout 0 --->
<div id="test#id#" class="hidden" style="overflow-y:hidden;">
	<div style="height:100%; width:100%; overflow-y:auto;-webkit-overflow-scrolling:touch;" class="<cfif getTemplateSkin.recordcount NEQ 0 AND isDefined("getTemplateSkin.setting_skin")>tpl#url.template#-skin#getTemplateSkin.setting_skin#</cfif> tpl1-lb-background">
		<div style="height:10%; width:100%;">&nbsp;</div>
		<div style="height:20%; width:100%;">
			<div class="tpl1-lb-title">	
				<h1>#lightboxtitle#</h1>
			</div>
		</div>
		<div style="height:70%; width:30%; float:left;">
			<div class="tpl1-lead-lb ftScrollerlVertical" id="someidfornoreasonLB0">#lead#</div>
		 </div>
		<div style="height:100%; width:70%; float:left;">
			<div style="height:100%; width:100%; background:##2B2B2B;">
				<div style="background-image:url(../upload/magazine/#lbbild#);background-position: center top; background-size:cover; height:100%;">&nbsp;</div>
			<!--- <div id="someVideoID-tpl1" class="hasVideo" data-videotype="youtube" data-youtubecode="#ytvideo#" data-displaytype="withinContainer" data-videoautoplay="true"  data-videoclose="true" data-videoposter="" ></div> --->
			<!--- <div id="someVideoID-tpl2" class="hasVideo" data-videotype="html5" data-lightboxtype="full-white"  data-videosource="/#session.serverpath#/upload/magazine/moon.mp4" data-displaytype="withinContainer" data-videoautoplay="false" data-videoinanimation="slideInTop" data-videoclose="true" data-videoposter=""> </div> --->
			</div>
	<!---    --->
		</div>
	<div class="clear"></div>
	</div>
</div>

<!--- layout 1: bild links: 66% - text und lead Rechts 34% --->
<cfelseif setting_layout EQ 1>
<div style="width:100%; height:100%;" class="tpl1-layout">
	<div style="width:66%; height:100%; float:left;" >
		<div class="tpl1-overflow tpl1-heigth-100 tpl1-grid-100"
		<cfif imgpos EQ 0>style="background-image:url(../upload/magazine/#bild#); background-position: center center; background-size:cover;"
		<cfelseif imgpos EQ 1>style="background-image:url(../upload/magazine/#bild#); background-position: center top; background-size:cover;"
		<cfelseif imgpos EQ 2>style="background-image:url(../upload/magazine/#bild#); background-position: center bottom; background-size:cover;"
		<cfelseif imgpos EQ 3>style="background-image:url(../upload/magazine/#bild#); background-position: left top; background-size:cover;"
		<cfelseif imgpos EQ 4>style="background-image:url(../upload/magazine/#bild#); background-position: left center; background-size:cover;"
		<cfelseif imgpos EQ 5>style="background-image:url(../upload/magazine/#bild#); background-position: left bottom; background-size:cover;"
		<cfelseif imgpos EQ 6>style="background-image:url(../upload/magazine/#bild#); background-position: right top; background-size:cover;"
		<cfelseif imgpos EQ 7>style="background-image:url(../upload/magazine/#bild#); background-position: right center; background-size:cover;"
		<cfelseif imgpos EQ 8>style="background-image:url(../upload/magazine/#bild#); background-position: right bottom; background-size:cover;"</cfif>>
		&nbsp;
		</div>
	</div>
	<div style="width:34%; height:100%; float:left;">
		<div style="width:100%; height:10%;">&nbsp;</div>
			<div style="width:100%; height:30%;" class="tpl1-title">
				<div style="padding-left:1em; padding-right:0.5em;">
					<h1 <cfif titlecolor NEQ "">style="color:#titlecolor#;"</cfif>>#titel#</h1>
				</div>
			</div>
		<div style="width:100%; height:15%;">
		<!--- show no button --->
		<cfif lightboxtype EQ 0>
			<div >&nbsp;</div>
		<!--- content in light box: show button --->
		<cfelseif lightboxtype EQ 1 OR lightboxtype EQ 2>
			<div  style="padding-right:1em; text-align:right; margin-bottom:0.5em;">
				<button class="large lightbox tpl1-buttonstyle" data-lightboxdiv="test_layout1#id#" data-lightboxtype="full-white">#lightboxbutton#</button>
			</div>
		</cfif>
		</div>
		<div style="width:100%; height:45%;" class="tpl1-lead ftScrollerlVertical" id="somescrollid">#lead#</div>
	</div>
	<div style="clear:both;"></div>
</div>
<!--- layout 2: bild oben:75% - Titel und text in lightbox unten 30% --->
<cfelseif setting_layout EQ 2>
<div style="width:100%; height:100%;" class="tpl1-layout">
	<div style="width:100%; height:75%; float:left;">
		<div  class="tpl1-overflow tpl1-heigth-100 tpl1-grid-100"
	 <cfif imgpos EQ 0>style="background-image:url(../upload/magazine/#bild#); background-position: center center; background-size:cover;"
		<cfelseif imgpos EQ 1>style="background-image:url(../upload/magazine/#bild#); background-position: center top; background-size:cover;"
		<cfelseif imgpos EQ 2>style="background-image:url(../upload/magazine/#bild#); background-position: center bottom; background-size:cover;"
		<cfelseif imgpos EQ 3>style="background-image:url(../upload/magazine/#bild#); background-position: left top; background-size:cover;"
		<cfelseif imgpos EQ 4>style="background-image:url(../upload/magazine/#bild#); background-position: left center; background-size:cover;"
		<cfelseif imgpos EQ 5>style="background-image:url(../upload/magazine/#bild#); background-position: left bottom; background-size:cover;"
		<cfelseif imgpos EQ 6>style="background-image:url(../upload/magazine/#bild#); background-position: right top; background-size:cover;"
		<cfelseif imgpos EQ 7>style="background-image:url(../upload/magazine/#bild#); background-position: right center; background-size:cover;"
		<cfelseif imgpos EQ 8>style="background-image:url(../upload/magazine/#bild#); background-position: right bottom; background-size:cover;"</cfif> >
		<!---  <img src="../upload/magazine/#bild#" style="text-indent:9999; -webkit-transform:translate3d(0,0,0);" >  --->
		</div>
	</div>
	<div style="width:100%; height:25%; float:left;">
		<div style="width:50%; height:100%; float:left;" class="tpl1-title">
			<div style="height:100%; text-align:center; padding-top:1em;" >
				<h1 <cfif titlecolor NEQ "">style="color:#titlecolor#;"</cfif>>#titel#</h1>
			</div>
		</div>
		<div style="width:50%; height:100%; float:left;">
		<!--- show no button --->
			<cfif lightboxtype EQ 0>
				<div >&nbsp;</div>
			<!--- content in light box: show button --->
			<cfelseif lightboxtype EQ 1 OR lightboxtype EQ 2>
				<div style="width:100%; height:100%; padding-top:1em; padding-left:5em;">
					<button class="large lightbox tpl1-buttonstyle" data-lightboxdiv="test_layout2#id#" data-lightboxtype="full-white">#lightboxbutton#</button>
				</div>
			</cfif>		
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<!--- lightbox in layout 2  --->
<div id="test_layout2#id#" class="hidden"  style="overflow-y:hidden;">
	<div style="height:100%; width:100%; overflow-y:auto;-webkit-overflow-scrolling:touch; text-align:center;" class="<cfif getTemplateSkin.recordcount NEQ 0 AND isDefined("getTemplateSkin.setting_skin")>tpl#url.template#-skin#getTemplateSkin.setting_skin#</cfif>">
		<div style="height:30%; width:100%;">
			<div class="tpl1-lightbox-title">	
				<h1 <cfif titlecolor NEQ "">style="color:#titlecolor#;"</cfif>>#titel#</h1>
			</div>
		</div>
		<div style="height:70%; width:100%;">
			<div style="width:60%; height:100%; float:left;">
				<div class="tpl1-lightbox-lead">#lead#</div>
				<div class="tpl1-lightbox-caption" <!--- style="padding-top:2em; margin-top:4em; text-align:right; border-top:1px solid ##D30003;" --->>#bildlegende#</div>
			 </div>
			<div style="width:40%; line-height:100%; float:left;">
				<div style="padding:1em;  margin-left:2em; border:1px inset ##555;">
				<img src="../upload/magazine/#bild#" alt="alttag" style="max-width:100%; height:auto;">
				</div> 
				<!---  <div style="background-image:url(../upload/magazine/#bild#);background-position: center top; background-size:cover; height:100%;">&nbsp;</div> ---> 
			</div>
			<div style="clear:both;"></div>	
		</div>
	</div> 
</div>
<!--- layout 3: Big picture fullscreen lightbox 1/3 as overlay --->
<cfelseif setting_layout EQ 3>
<div style="width:100%; height:100%;" class="tpl1-layout">
	<div style="width:100%; height:100%;">
		<div style="width:100%; height:100%;">
		<div  class="tpl1-overflow tpl1-heigth-100 tpl1-grid-100"
			<cfif imgpos EQ 0>style="background-image:url(../upload/magazine/#bild#); background-position: center center; background-size:cover;"
			<cfelseif imgpos EQ 1>style="background-image:url(../upload/magazine/#bild#); background-position: center top; background-size:cover;"
			<cfelseif imgpos EQ 2>style="background-image:url(../upload/magazine/#bild#); background-position: center bottom; background-size:cover;"
			<cfelseif imgpos EQ 3>style="background-image:url(../upload/magazine/#bild#); background-position: left top; background-size:cover;"
			<cfelseif imgpos EQ 4>style="background-image:url(../upload/magazine/#bild#); background-position: left center; background-size:cover;"
			<cfelseif imgpos EQ 5>style="background-image:url(../upload/magazine/#bild#); background-position: left bottom; background-size:cover;"
			<cfelseif imgpos EQ 6>style="background-image:url(../upload/magazine/#bild#); background-position: right top; background-size:cover;"
			<cfelseif imgpos EQ 7>style="background-image:url(../upload/magazine/#bild#); background-position: right center; background-size:cover;"
			<cfelseif imgpos EQ 8>style="background-image:url(../upload/magazine/#bild#); background-position: right bottom; background-size:cover;"</cfif> >&nbsp;
		</div>
	</div>
	</div>
	<div style="position:relative;">
		<div style="position:absolute; bottom:2em; right:4em;">
			<div class="readmore"><button class="large lightbox tpl1-buttonstyle" data-lightboxdiv="test_layout3#id#" data-lightboxtype="full-trans">#lightboxbutton#</button></div>
		</div>
	</div>
</div>
<!--- lightbox for fullscreen overlay layout 3 --->
<div id="test_layout3#id#" class="hidden"  style="overflow-y:hidden;">
	<div style="height:100%; width:30%; overflow-y:auto;-webkit-overflow-scrolling:touch; text-align:center;" class="<cfif getTemplateSkin.recordcount NEQ 0 AND isDefined("getTemplateSkin.setting_skin")>tpl#url.template#-skin#getTemplateSkin.setting_skin#</cfif>" >
		<div style="width:100%; height:40%;">
			<h1>#lightboxtitle#</h1>

		</div>
		<div style="width:100%; height:60%;">
			<p>
			#lightboxtext#
			</p>
		</div>
	</div>
</div>
</cfif>
</cfoutput>