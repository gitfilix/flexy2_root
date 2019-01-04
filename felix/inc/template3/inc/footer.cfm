<!---Footer content aus der DB lesen und pasten--->

<cfoutput query="getFooter">
<footer>
	
	
		<span>
				&copy; #copyright#	<address>#adresse# - Tel: #telnummer# - e-Mail: <a href="mailto:#e_mail#">unsere E-mailadresse</a></address>
		</span>
	
</footer>
</cfoutput>



 