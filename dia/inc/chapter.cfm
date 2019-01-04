<cfset actChapter = fs.getChapter(issueID=session.issueID,chapterID=url.chapterid)/>
<cfset prevChapterID = fs.getPrevChapter(chapterID=actChapter[1].chapterid) />
<cfset nextChapterID = fs.getNextChapter(chapterID=actChapter[1].chapterid) />



<cfoutput>
	<li class="mainslide" id="centerSlide" data-chapterid="#url.chapterid#" <cfif nextChapterID NEQ 0>data-nextchapterid="#nextChapterID#"</cfif>  <cfif prevChapterID NEQ 0>data-prevchapterid="#prevChapterID#"</cfif>>
		<ul class="subslides">
			<li class="subslide" style="background:white;height:100%;"></li>
			<li data-id="#actChapter[1].slides[1]#" <cfif arrayLen(actChapter[1].slides) GTE 2 AND actChapter[1].slides[2] NEQ 0>data-nextID="#actChapter[1].slides[2]#"</cfif> class="subslide activeSlide" style="position:relative;height:100%;background:silver;">						
				<cfset templateID = fs.getSlide(slideID=actChapter[1].slides[1]).template />
				<cfset url.slideID = actChapter[1].slides[1] />
				<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />	
			</li>
			<li <cfif arrayLen(actChapter[1].slides) GTE 2 AND actChapter[1].slides[2] NEQ 0>data-id="#actChapter[1].slides[2]#"</cfif> <cfif arrayLen(actChapter[1].slides) GTE 3 AND actChapter[1].slides[3] NEQ 0>data-nextID="#actChapter[1].slides[3]#"</cfif> <cfif arrayLen(actChapter[1].slides) GTE 3 AND actChapter[1].slides[1] NEQ 0>data-prevID="#actChapter[1].slides[1]#"</cfif> class="subslide" style="position:relative;height:100%;">
				<cfif arrayLen(actChapter[1].slides) GTE 2 AND actChapter[1].slides[2] NEQ 0>
					<cfset templateID = fs.getSlide(slideID=actChapter[1].slides[2]).template />
					<cfset url.slideID = actChapter[1].slides[2] />
					<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />	
				</cfif>
			</li>
		</ul>
	</li>
</cfoutput>