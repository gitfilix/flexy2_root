<cfprocessingdirective pageencoding="utf-8" />
<cfoutput query="getFooter">
<div id="footernav-pos">
	<div class="footernav">
		<cfinclude template="footernav.cfm"><br />
	</div>	
</div>
	<div id="footer">	
		<h5>HTML-5 Manufaktur</h5>
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