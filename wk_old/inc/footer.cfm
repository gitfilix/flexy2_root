<!---Footer content aus der DB lesen und pasten--->
<cfoutput query="getFooter">
<footer>
	<div class="footernav">
			<cfinclude template="footernav.cfm">
		</div>
	<div>
		<address>WEBkanal: &nbsp; #adresse#  &nbsp; Tel: #telnummer# &nbsp; <br>E-Mail: &nbsp;<a href="mailto:#e_mail#">Kontakt WEBkanal</a></address>
		
	</div>
	<div class="copyright">
		<cfif aktualisierung EQ 1>
			Last Update: #DateFormat(modifyDate)#
		</cfif>
		<br>
		&copy; #copyright#
	</div>
	<div class="clear"></div>
</footer>
</cfoutput>
