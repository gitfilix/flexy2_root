<cfoutput query="getFooter">
<footer class="footer">
		<div class="unit-20">
			<p>
				&copy; #copyright#
			</p>
			<br />
			<div class="footernav">
				<cfinclude template="footernav.cfm">
			</div>
		</div>
		<div class="unit-60 mobile-80">
			<address class="footertext">#adresse# <br /> Tel: <a href="tel:0774197503"> #telnummer#</a><br /> e-Mail: <a href="mailto:#e_mail#">#e_mail#</a><br /></address>
		</div>
		<div class="unit-20 mobile-wk">
			<span class="author">
			Design &
			Code:
			<br /> 
			<br /> 
			<a target="_blank" href="http://www.web-kanal.ch">&harr; web-kanal</a>
			</span>
		</div>
</footer>
</cfoutput>