<!---Footer content aus der DB lesen und pasten--->
<!---  kube grid: 1/4/ ---/2 ---  1/4  --->
<cfoutput query="getFooter">
<footer>
	<div class="quarter footercopy">
		&copy; #copyright#
	</div>
	<div class="half ">	
		<span>
				<address class="footertext">#adresse# - Tel: #telnummer# - e-Mail: unsere <a href="mailto:#e_mail#">#e_mail#</a></address>
		</span>
	</div>
	<div class="quarter">
	<cfif #aktualisierung# EQ 1 >
			<h7><small>last update: #modifyDate# </small></h7>
	<cfelse>
			<h7>keine Aktuelle Daten vorhanden</h7>
	</cfif>
	
	</div>	

</footer>
</cfoutput>




 