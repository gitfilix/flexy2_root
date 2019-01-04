<!---Footer content aus der DB lesen und pasten--->
<!---  kube grid: 1/4/ ---/2 ---  1/4  --->
<cfoutput query="getFooter">

	<div class="fifth copy">
		&copy; #copyright#
	</div>
	<div class="threefifth">	
		<span>
			<address class="footertext">#adresse# - Tel: #telnummer# - e-Mail: <a href="mailto:#e_mail#">#e_mail#</a></address>
			
			<cfif #aktualisierung# EQ 1 >
				<h7 class="footertext"><small>last update: #DateFormat(modifyDate)# </small></h7>
			<cfelse>
				<h7>&nbsp; </h7>
			</cfif>
		</span>
	</div>
	<div class="fifth">
		<span class="author">
		Design &
		Programmierung:
		<br>
		<a target="_blank" href="http://www.web-kanal.ch">&harr; web-kanal</a>
		</span>
	</div>	


</cfoutput>




 