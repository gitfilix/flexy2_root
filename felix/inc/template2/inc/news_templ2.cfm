<!--- News comes here --->

<cfoutput query="getnews">
	<div class="news-elem">
		<span class="news-date">#dateFormat(datum,"dd.mm.yyyy")#</span>
		<h3>#titel#</h3>
		<p>#fliesstext#</p>
	</div>
</cfoutput>