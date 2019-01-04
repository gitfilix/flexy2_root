<!---Footer content aus der DB lesen und pasten--->

<cfoutput query="getFooter">
<footer>
	<div class="threequarter">
		<address>WEBkanal Location: &nbsp; #adresse#  &nbsp; Tel: #telnummer# &nbsp; E-Mail:<a href="mailto:#e_mail#">Kontakt WEBkanal</a></address>
	</div>
	<div class="quarter copyright">
		<cfif aktualisierung EQ 1>
			Last Update: #modifyDate#
		</cfif>
		<br>
		&copy; #copyright#
	</div>	
	<cfinclude template="footernav.cfm">
</footer>
</cfoutput>



 