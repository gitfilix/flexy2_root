<cfoutput query="getcontent">
<div class="content_box">
	<div class="content_title">
		<cfif titel NEQ "">
		<h2>#Titel#</h2>
		<cfelse>
		<h1>Title: Hello World</h1>
		</cfif>
	</div>
	<div class="lead">
		<cfif lead NEQ "">
			<h3>#lead#</h3>
		</cfif>
	</div>
		

				
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
			<div>
				#fliesstext#
			</div>
		</cfif>
	</div>
	
</div>
