<cfoutput query="getcontent">
	<div class="big-pix">
		<cfif bildname NEQ "">
			<figure class="content_pix">
				<img src="/#session.serverpath#/upload/img/#bildname#" alt="#bildname#">
			</figure> 
		</cfif>
		
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
		<!--- Print out Fliesstext --->
		<div class="gallery_text">
			Description comes here: <br>About<br> Agency<br> Date<br> and some text<br>
			#fliesstext#
		</div>	
		</cfif>
		
	</div>
</cfoutput>

