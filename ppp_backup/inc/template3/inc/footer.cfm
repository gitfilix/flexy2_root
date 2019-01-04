<!---Footer content aus der DB lesen und pasten--->

<cfoutput query="getFooter">
<footer>
	<div class="fifth footercopy">
		&copy; #copyright#
	</div>
	<div class="threefifth ">	
		<span>
				<address class="footertext">#adresse# - Tel: #telnummer# - e-Mail: <a href="mailto:#e_mail#">unsere E-mailadresse</a></address>
		</span>
	</div>
	<div class="fifth">
	<cfif #aktualisierung# EQ 1 >
			<h7><small>last update: #modifyDate# </small></h7>
	<cfelse>
			<h7>keine Aktuelle Daten vorhanden</h7>
	</cfif>
	
	</div>	

</footer>
</cfoutput>


<!--- <div class="third bg_gray">
	<cfif titel NEQ "">
		<h2>#titel#</h2>
	<cfelse>
		<h2>hello kitty</h2>
	</cfif>
	<cfif image NEQ "">
		<img src="upload/img/#image#" width="100%" alt="" hspace="3" />
	<cfelse>
		<br>-no pix<br>
	</cfif>
	<br>
	<article>
	<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />" >
		<p>#fliesstext#</p>
	</article>
		<cfelse>
	<!--- print some lorem  --->
	tudin ac sodales sed, malesuada ut arcu. Fusce placerat aliquam scelerisque. 
	<br>Quisque leo tellus, aliquet semper commodo a, aliquam in tortor. Nullam tincidunt fermentum est... 
	</p>
	</cfif>
</div>
 --->


 