<cfoutput query="getFooter">

	<div class="units-row">
		<div class="unit-25">
			<cfinclude template="footernav.cfm"><br />
			&copy; #copyright#
		</div>
		<div class="unit-50">
			<address class="footertext">#adresse# - Tel: #telnummer# - e-Mail: <a href="mailto:#e_mail#">#e_mail#</a></address>
		</div>
		<div class="unit-25">
			<span class="author">
			Design &
			Code:
			<br /> 
			NET-MAN a.k.a <br /> 
			<a target="_blank" href="http://www.web-kanal.ch">&harr; web-kanal</a>
			<!--- (viu besser als Mediator-Nerd!) --->
			</span>
		</div>
	</div>	

</cfoutput>