<cfoutput query="getFooter">
	<div id="footer">
		<div>
			<cfinclude template="footernav.cfm"><br />
		</div>
		<div>
			<h5>Webkanal</h5>
		</div>
		<div>
			<address class="footertext">#adresse# <br /> Tel: #telnummer# <br /> e-Mail: <a href="mailto:#e_mail#">#e_mail#</a></address>
		</div>
		<div>
			<span class="author">
			Design &
			Code:
			<a target="_blank" href="http://www.web-kanal.ch">&copy; web-kanal</a>
			</span>
		</div>
		<!--- <div class="copy">
			&copy; #copyright#</h5>
		</div> --->
	</div>
</cfoutput>