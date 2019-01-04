<div class="headerpanel">
	<cfif pageProperties.headerbild NEQ "">
		<cfoutput>	
		
			<img src="/#session.serverpath#/upload/img/#pageProperties.headerbild#" alt="" style="display:block;" />
		
		</cfoutput>
	<cfelse>
		<h2>no headerpannel bild</h2>
	</cfif>
	<!--- a shadow box --->
	<div class="header-bottom">&nbsp;</div>
</div>