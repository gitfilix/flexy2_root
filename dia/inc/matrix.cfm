<cfprocessingdirective pageencoding="utf-8" />
<cfset matrix = fs.getInitialMatrix(issueID=session.issueID,startSlide=url.slideid) />

<cfoutput>
	
		<ul id="mag-wrapper" style="position:relative;left:0;top:0;">
			<li class="mainslide" id="leftSlide">
				<ul class="subslides">
					<li class="subslide" style="background:white;height:100%;"></li>
					<li class="subslide" style="background:white;height:100%;"></li>
					<li class="subslide" style="background:white;height:100%;"></li>
				</ul>
			</li>
			<li class="mainslide" id="centerSlide" data-chapterid="#matrix[3].chapterid#" data-nextchapterid="#matrix[4].chapterid#">
				<ul class="subslides">
					<li class="subslide" style="background:white;height:100%;"></li>
					<li data-id="#matrix[3].slides[3]#" <cfif arrayLen(matrix[3].slides) GTE 4 AND matrix[3].slides[4] NEQ 0>data-nextID="#matrix[3].slides[4]#"</cfif> class="subslide activeSlide" style="position:relative;height:100%;background:silver;">						
						<cfset templateID = fs.getSlide(slideID=matrix[3].slides[3]).template />
						<cfset url.slideID = matrix[3].slides[3] />
						<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />		
					</li>
					<li <cfif arrayLen(matrix[3].slides) GTE 4 AND matrix[3].slides[4] NEQ 0>data-id="#matrix[3].slides[4]#"</cfif> <cfif arrayLen(matrix[3].slides) GTE 5 AND matrix[3].slides[5] NEQ 0>data-nextID="#matrix[3].slides[5]#"</cfif> <cfif arrayLen(matrix[3].slides) GTE 3 AND matrix[3].slides[4] NEQ 0>data-prevID="#matrix[3].slides[3]#"</cfif> class="subslide" style="position:relative;height:100%;">
						<cfif arrayLen(matrix[3].slides) GTE 4 AND matrix[3].slides[4] NEQ 0>
							<cfset templateID = fs.getSlide(slideID=matrix[3].slides[4]).template />
							<cfset url.slideID = matrix[3].slides[4] />
							<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />	
						</cfif>
					</li>
				</ul>
			</li>
			<li class="mainslide" id="rightSlide" data-chapterid="#matrix[4].chapterid#" data-nextchapterid="#matrix[5].chapterid#" data-prevchapterid="#matrix[3].chapterid#">
				<ul class="subslides">
					<li class="subslide" style="background:white;height:100%;"></li>
					<li data-id="#matrix[4].slides[1]#" data-nextID="#matrix[4].slides[2]#"  class="subslide" style="background:silver;height:100%;">
						<cfset templateID = fs.getSlide(slideID=matrix[4].slides[1]).template />
						<cfset url.slideID = matrix[4].slides[1] />
						<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />	
					</li>
					<li data-id="#matrix[4].slides[2]#" <cfif arrayLen(matrix[4].slides) GTE 3 AND matrix[4].slides[3] NEQ 0>data-nextID="#matrix[4].slides[3]#"</cfif> data-prevID="#matrix[4].slides[1]#" class="subslide" style="height:100%;">
						<cfset templateID = fs.getSlide(slideID=matrix[4].slides[2]).template />
						<cfset url.slideID = matrix[4].slides[2] />
						<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />	
					</li>		
				</ul>
			</li>
		</ul>
		<div style="clear:both;"></div>

</cfoutput>