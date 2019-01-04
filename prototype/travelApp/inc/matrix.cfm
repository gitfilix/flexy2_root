<cfprocessingdirective pageencoding="utf-8" />

<cfset ct = 1 />
<cfoutput query="matrix" group="kid">
	<div class="ft-section" data-id="section-#ct#">
		<cfset cnt = 1 />
		<cfoutput>
			<cfif id NEQ "">
				<div id="/section-#ct#/page-#cnt#" class="ft-page" data-ajaxcontent="tpl-#template#.cfm?slideID=#id#" data-alloweddirections="0,1,0,0" data-id="page-#cnt#" data-title="#label#" data-background="#bgimage#" data-backgroundsmall="#bgimage#"></div>
				<cfset cnt = cnt + 1 />
			</cfif>
		</cfoutput>
	</div>
<cfset ct = ct + 1 />
</cfoutput>


<!--- <div class="ft-section" data-id="section-2">
	<div id="/section-2/page-1" class="ft-page" data-ajaxcontent="_2-1.cfm" data-background="hongkong2.jpg" data-backgroundsmall="hongkong2_small.jpg" data-alloweddirections="0,0,1,0" data-id="page-1"></div>
	<div id="/section-2/page-2" class="ft-page" data-ajaxcontent="_2-1.cfm" data-background="subway1.jpg" data-backgroundsmall="subway1_small.jpg" data-alloweddirections="1,0,1,0" data-id="page-2"></div>
	<div id="/section-2/page-3" class="ft-page" data-ajaxcontent="_2-3.cfm" data-background="london1.jpg" data-backgroundsmall="london1_small.jpg" data-alloweddirections="1,0,0,0" data-id="page-3"></div>
</div>

<div class="ft-section" data-id="section-3">
	<div id="/section-3/page-1" class="ft-page" data-ajaxcontent="_3-1.cfm" data-background="sidney1.jpg" data-backgroundsmall="sidney1_small.jpg" data-alloweddirections="0,1,1,1" data-id="page-1"></div>
	<div id="/section-3/page-2" class="ft-page" data-ajaxcontent="_3-2.cfm" data-background="taj1.jpg" data-backgroundsmall="taj1_small.jpg" data-alloweddirections="1,1,0,0" data-id="page-2"></div>
</div>

<div class="ft-section" data-id="section-4">
	<div id="/section-4/page-1" class="ft-page" data-ajaxcontent="_4-0.cfm" data-background="tokyo1.jpg" data-backgroundsmall="tokyo1_small.jpg" data-alloweddirections="0,1,0,1" data-id="page-1"></div>
</div>

<div class="ft-section" data-id="section-5">
	<div id="/section-5/page-1" class="ft-page" data-ajaxcontent="_5-0.cfm" data-background="hongkong2.jpg" data-backgroundsmall="hongkong2_small.jpg" data-alloweddirections="0,0,0,1" data-id="page-1"></div>
</div>

<div class="ft-section" data-id="section-6">
	<div id="/section-6/page-1" class="ft-page" data-ajaxcontent="_6-0.cfm" data-background="beachpano_part1_3.jpg" data-backgroundsmall="beachpano_part1_3.jpg" data-alloweddirections="0,0,0,1" data-id="page-1"></div>
</div>

<div class="ft-section" data-id="section-7">
	<div id="/section-7/page-1" class="ft-page" data-ajaxcontent="_7-0.cfm" data-background="beachpano_part2_3.jpg" data-backgroundsmall="beachpano_part2_3.jpg" data-alloweddirections="0,0,0,1" data-id="page-1"></div>
</div>

<div class="ft-section" data-id="section-8">
	<div id="/section-8/page-1" class="ft-page" data-ajaxcontent="_8-0.cfm" data-background="beachpano_part3_3.jpg" data-backgroundsmall="beachpano_part3_3.jpg" data-alloweddirections="0,0,0,1" data-id="page-1"></div>
</div>
 --->