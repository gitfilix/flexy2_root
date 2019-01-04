
<cfoutput query="getnews">
	<div class="newscontainer">
		<h3><span class="news-date">#dateFormat(datum,"dd.mm.yyyy")#</span></h3>
		<h2>#titel#</h2>
	<!--- 	<img src="/#session.serverpath#/upload/img/##image#" /> --->
		<p>#fliesstext#</p>
		<br>
		<div class="newslink">
			<a href="#href#">#hreflabel#</a>
		</div>
	</div>
	<!--- <cfdump var="#getnews#"> --->
</cfoutput>

	
	