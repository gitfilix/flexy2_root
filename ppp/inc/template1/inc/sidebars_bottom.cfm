<!---alle Sidebar contents aus der db lesen und pasten--->

<cfoutput query="getSidebarElems">
<div class="teaserdown">
		<cfif titel NEQ "">
			<h3>#titel#</h3>
		</cfif>
		<cfif image NEQ "">
			<img src="/#session.serverpath#/upload/img/#image#"  alt="" hspace="3" />
		</cfif>
		<div>
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
				#fliesstext#
			</cfif>
			<cfif href NEQ "" AND hreflabel NEQ "">
				<a href="#href#" title="#hreflabel#" target="_blank">#hreflabel#</a>
			</cfif>
		</div>
</div>
	<script type="text/javascript">
	
	$(window).load(function(){
	hgt = 0;	
		$('.teaserdown').each(function(){
			if($(this).height()>hgt){
				} hgt = $(this).height();
			});
			console.log(hgt);
		$('.teaserdown').height(hgt); 
		$('.teaserdown').css('padding-bottom','20px'); 
	});
	</script>	 
</cfoutput>
