<div>
	<cfif pageProperties.headerbild NEQ "">
		<cfoutput><img class="headerpannel" src="/#session.serverpath#/upload/img/#pageProperties.headerbild#" alt="" /></cfoutput>
	<cfelse>
		&nbsp;
	</cfif>
</div>