<cfprocessingdirective suppresswhitespace="yes">
<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>
<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_6
WHERE slideid = #url.slideID#
</cfquery>

<!--- 
id
slideID
title
lead
targetSlideID
buttontext
titleColor
leadColor
boxed
box_bgcolor
titlePos
leadPos
titleAnimation
leadAnimation
img
imgpos
setting_layout 
  
---> 
<cfoutput query="getSlideContent"> 
	<!--- layout 0 centered and big picture --->
	<cfif setting_layout EQ 0>
		<div class="tpl6-grid-100 tpl6-heigth-60" >
			<div class="tpl6-overflow tpl6-heigth-100" <cfif imgpos EQ 0>style="background-image:url(../upload/magazine/#img#); background-position: center center; background-size:cover;"
				<cfelseif imgpos EQ 1>style="background-image:url(../upload/magazine/#img#); background-position: center top; background-size:cover;"
				<cfelseif imgpos EQ 2>style="background-image:url(../upload/magazine/#img#); background-position: center bottom; background-size:cover;"
				<cfelseif imgpos EQ 3>style="background-image:url(../upload/magazine/#img#); background-position: left top; background-size:cover;"
				<cfelseif imgpos EQ 4>style="background-image:url(../upload/magazine/#img#); background-position: left center; background-size:cover;"
				<cfelseif imgpos EQ 5>style="background-image:url(../upload/magazine/#img#); background-position: left bottom; background-size:cover;"
				<cfelseif imgpos EQ 6>style="background-image:url(../upload/magazine/#img#); background-position: right top; background-size:cover;"
				<cfelseif imgpos EQ 7>style="background-image:url(../upload/magazine/#img#); background-position: right center; background-size:cover;"
				<cfelseif imgpos EQ 8>style="background-image:url(../upload/magazine/#img#); background-position: right bottom; background-size:cover;"</cfif>>
				<div>&nbsp;</div>
			</div>
		</div>
		<div class="<cfif splashtext NEQ "">tpl6-grid-50 <cfelse>tpl6-grid-100</cfif> tpl6-heigth-20">
			<div class="<cfif titlePos EQ 0>tpl6-titlepos0<cfelseif titlePos EQ 1>tpl6-titlepos1<cfelseif titlePos EQ 2>tpl6-titlepos2<cfelseif titlePos EQ 3>tpl6-titlepos3<cfelseif titlepos EQ 4>tpl6-titlepos4</cfif> tpl6-heigth-100">
				<cfif title NEQ"">
					<div class="tpl6-heigth-100 tpl6-no-titlebox"<cfif boxed EQ 1>style="background-color:#box_bgcolor#; opacity:#box_opacity#;"</cfif> style="padding-top:2%;" >
						<h1 <cfif titleAnimation NEQ "">class="anim tpl6-title" data-inanimation="#setting_titleAnimation_delay#-<cfif titleAnimation EQ 1>fadeIn<cfelseif titleAnimation EQ 2>slideInLeft<cfelseif titleAnimation EQ 3>slideInRight<cfelseif titleAnimation EQ 4>slideInTop<cfelseif titleAnimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_titleanimation_duration#" </cfif> style="color:<cfif titleColor NEQ "">#titleColor#</cfif>">#title#</h1>
					</div>
				</cfif>
			</div>
		</div>
		<cfif splashtext NEQ "">
			<div class="tpl6-grid-50 tpl6-heigth-100">
			<div class="prototypepos2 anim" data-inanimation="1.3-scaleTextUp-0.5" >
				<article class="prototypestyle2" > #splashtext# </article>
			</div>
		</cfif>
		
		<div class="tpl6-grid-100 tpl6-heigth-20 tpl6-overflow">
		<div class="tpl6-heigth-100 <cfif leadPos EQ 0>tpl6-leadpos0<cfelseif leadPos EQ 1>tpl6-leadpos1<cfelseif leadPos EQ 2>tpl6-leadpos2<cfelseif leadPos EQ 3>tpl6-leadpos3<cfelseif leadPos EQ 4>tpl6-leadpos4</cfif>" >
			<cfif lead NEQ "">
				<h2 <cfif leadAnimation NEQ "">class="anim tpl6-lead" data-inanimation="#setting_leadanimation_delay#-<cfif leadanimation EQ 1>fadeIn<cfelseif leadanimation EQ 2>slideInLeft<cfelseif leadanimation EQ 3>slideInRight<cfelseif leadanimation EQ 4>slideInTop<cfelseif leadanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_leadanimation_duration#"</cfif> style="color:<cfif leadColor NEQ ''>#leadColor#<cfelse>##ccc</cfif>">#lead#</h2>
			</cfif>
		</div>
		</div>
		<!--- layout 1 left aligned --->
		<cfelseif setting_layout EQ 1>
		<div style="width:70%; height:100%; float:left;" >
			<div class=" tpl6-heigth-60 tpl6-overflow" >
				<div class="tpl6-heigth-100 <cfif imgpos EQ 0>tpl6-imgstyle0<cfelseif imgpos EQ 1>tpl6-imgstyle1</cfif>" style="background-image:url(../upload/magazine/#img#); background-position: center center; background-size:cover;"></div>
			</div>
			<div class="tpl6-heigth-20" >
				<div class="<cfif titlePos EQ 0>tpl6-titlepos0<cfelseif titlePos EQ 1>tpl6-titlepos1<cfelseif titlePos EQ 2>tpl6-titlepos2<cfelseif titlePos EQ 3>tpl6-titlepos3<cfelseif titlepos EQ 4>tpl6-titlepos4</cfif>">
					<cfif title NEQ"">
						<h1 <cfif titleAnimation NEQ "">class="anim tpl6-title" data-inanimation="#setting_titleAnimation_delay#-<cfif titleAnimation EQ 1>fadeIn<cfelseif titleAnimation EQ 2>slideInLeft<cfelseif titleAnimation EQ 3>slideInRight<cfelseif titleAnimation EQ 4>slideInTop<cfelseif titleAnimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_titleanimation_duration#" </cfif> style="color:<cfif titleColor NEQ "">#titleColor#</cfif>">#title#</h1>
					</cfif>
				</div>
			</div>
			<div class="tpl6-heigth-20 tpl6-overflow overflow" >
				<div class="tpl6-heigth-100 <cfif leadPos EQ 0>tpl6-leadpos0<cfelseif leadPos EQ 1>tpl6-leadpos1<cfelseif leadPos EQ 2>tpl6-leadpos2<cfelseif leadPos EQ 3>tpl6-leadpos3<cfelseif leadPos EQ 4>tpl6-leadpos4</cfif><cfif leadAnimation NEQ ""> anim</cfif>" data-inanimation="#setting_leadanimation_delay#-<cfif leadanimation EQ 1>fadeIn<cfelseif leadanimation EQ 2>slideInLeft<cfelseif leadanimation EQ 3>slideInRight<cfelseif leadanimation EQ 4>slideInTop<cfelseif leadanimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_leadanimation_duration#">
					<cfif lead NEQ "">
						<h2 class="tpl6-lead" style="color:<cfif leadColor NEQ ''>#leadColor#<cfelse>##ccc</cfif>">#lead#</h2>
					</cfif>
				</div>
			</div>
		</div>
		<div class="tpl6-grid-30 tpl6-heigth-100 tpl6-overflow">
			<div class="tpl6-heigth-100" style="margin-top:10em; padding-right:1em;">
				<cfif splashtext NEQ "">
					<div class="prototypepos2 anim" data-inanimation="#setting_splashanimation_delay#-<cfif splashanimation EQ 1>fadeIn<cfelseif splashanimation EQ 2>slideInLeft<cfelseif splashanimation EQ 3>slideInRight<cfelseif splashanimation EQ 4>slideInTop<cfelseif splashanimation EQ 5>slideInBottom<cfelseif splashanimation EQ 6 >scaleTextUp</cfif>-#setting_splashanimation_duration#" >
						<article class="prototypestyle2" >#splashtext#</article>
					</div>
				</cfif>
			</div>
		</div>
		<div class="clear"></div>
		<!--- layout 2: Top Picture, Title and Lead below aligned --->
		<cfelseif setting_layout EQ 2>
		<!--- 1st row 100 --->
		<div class="tpl6-grid-100 tpl6-heigth-50" >
			<div class="tpl6-grid-100 tpl6-heigth-100">
				<div class=" tpl6-heigth-100 tpl6-overflow" >
					<div class="tpl6-heigth-100 <cfif imgpos EQ 0>tpl6-imgstyle0<cfelseif imgpos EQ 1>tpl6-imgstyle1</cfif>" style="background-image:url(../upload/magazine/#img#); background-position:<cfif imgpos EQ 1>center right;<cfelse>center center;</cfif>background-size:cover;" >&nbsp;</div>
				</div>
			</div>
		</div>
		<!--- 2nd row 50/50  --->
		<div style="width:100%; height:50%; float:left;" >
			<div style="width:50%; height:100%; float:left;" class="tpl6-overflow">
				<div style="padding-top:5%;">
					<div class="tpl6-heigth-100 <cfif titlePos EQ 0>tpl6-titlepos0<cfelseif titlePos EQ 1>tpl6-titlepos1<cfelseif titlePos EQ 2>tpl6-titlepos2<cfelseif titlePos EQ 3>tpl6-titlepos3<cfelseif titlepos EQ 4>tpl6-titlepos4</cfif>" >
						<cfif title NEQ "">
							<div class="tpl6-heigth-100" <cfif boxed EQ 1>style="background-color:#box_bgcolor#; opacity:#box_opacity#;"</cfif> >
								<h1 <cfif titleAnimation NEQ "">class="anim tpl6-title" data-inanimation="#setting_titleAnimation_delay#-<cfif titleAnimation EQ 1>fadeIn<cfelseif titleAnimation EQ 2>slideInLeft<cfelseif titleAnimation EQ 3>slideInRight<cfelseif titleAnimation EQ 4>slideInTop<cfelseif titleAnimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_titleanimation_duration#" </cfif> style="color:<cfif titleColor NEQ "">#titleColor#</cfif>">#title#</h1>
							</div>
						</cfif>
					</div>
				</div>
			</div>
			<div style="width:50%; height:100%; float:left;" class="tpl6-overflow">
				<div style="padding-top:5%;">
					<div class="<cfif leadPos EQ 0>tpl6-leadpos0<cfelseif leadPos EQ 1>tpl6-leadpos1<cfelseif leadPos EQ 2>tpl6-leadpos2<cfelseif leadPos EQ 3>tpl6-leadpos3<cfelseif leadPos EQ 4>tpl6-leadpos4</cfif>" >
						<cfif lead NEQ "">
							<h2 <cfif leadAnimation NEQ "">class="anim tpl6-lead" data-inanimation="#setting_leadanimation_delay#-<cfif leadanimation EQ 1>fadeIn<cfelseif leadanimation EQ 2>slideInLeft<cfelseif leadanimation EQ 3>slideInRight<cfelseif leadanimation EQ 4>slideInTop<cfelseif leadanimation EQ 5>slideInBottom<cfelseif leadanimation EQ 6>scaleTextUp</cfif>-#setting_leadanimation_duration#"</cfif> style="color:<cfif leadColor NEQ ''>#leadColor#<cfelse>##ccc</cfif>">#lead#</h2>
						</cfif>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--- layout 3: Big Title, no Picture, no lead--->
		<cfelseif setting_layout EQ 3>
		<div class="tpl6-grid-100 tpl6-heigth-100">
			<div <cfif titlePos EQ 0>style="text-align:center; padding-top:33%; height:100%;" class="tpl6-titlepos0" 
		<cfelseif titlePos EQ 1>style="text-align:center; padding-top:4%; height:100%;"  class="tpl6-titlepos1"
		<cfelseif titlePos EQ 2>style="text-align:left; padding-left:4%; padding-top:10%; height:100%;"  class="tpl6-titlepos2"
		<cfelseif titlePos EQ 3>style="text-align:right; padding-right:4%; padding-top:10%; height:100%;"  class="tpl6-titlepos3"
		<cfelseif titlePos EQ 4>style="text-align:center; padding-bottom:10%; height:100%;"  class="tpl6-titlepos4"</cfif> >
				<div  class="tpl6-heigth-100" <cfif boxed EQ 1>style="background-color:#box_bgcolor#; opacity:#box_opacity#;"</cfif> >
					<cfif title NEQ"">
						<h1 <cfif titleAnimation NEQ "">class="anim tpl6-title_big" data-inanimation="#setting_titleAnimation_delay#-<cfif titleAnimation EQ 1>fadeIn<cfelseif titleAnimation EQ 2>slideInLeft<cfelseif titleAnimation EQ 3>slideInRight<cfelseif titleAnimation EQ 4>slideInTop<cfelseif titleAnimation EQ 5>slideInBottom<cfelse>scaleTextUp</cfif>-#setting_titleanimation_duration#" </cfif> <cfif titleColor NEQ "">style="color:#titleColor#"</cfif>>#title#</h1>
					</cfif>
				</div>
			</div>
		</div>
	</cfif>
</cfoutput></cfprocessingdirective>
