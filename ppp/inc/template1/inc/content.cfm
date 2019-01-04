<cfoutput query="getcontent">
	<div>
		<cfif bildname NEQ "">
			<figure  class="big-pix">
				<img src="/#session.serverpath#/upload/img/#bildname#" alt="#BILDNAME#">
			</figure> 
		</cfif>
		
		
		<!--- include glisse gallery --->
		<cfif albumid NEQ 0>
			<cfinclude template="content_gallery_glisse.cfm" />
		</cfif>
		
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
		<!--- Print out Fliesstext --->
		<!--- <div class="gallery_text">
			Description comes here:
			#fliesstext#
		</div>	 --->
		</cfif>
		<!--- include contact form if any --->
		<cfif hascontact EQ 1>
			<cfinclude template="contactform.cfm">
		</cfif>
	</div>
</cfoutput>

