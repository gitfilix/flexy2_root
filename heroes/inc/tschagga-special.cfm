<cfoutput query="pageProperties">
	<cfif  HEADERBILD NEQ "" >
		<div id="aniMe" style="padding-left:10em;">
			<img  class="animated tada wobble" src="/#session.serverpath#/upload/img/#HEADERBILD#" alt="nix">
		</div>
	<cfelse>
	&nbsp;
	</cfif>
</cfoutput>