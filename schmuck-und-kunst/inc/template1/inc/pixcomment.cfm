<cfprocessingdirective pageencoding="utf-8" />

<cfoutput query="getcontent">

	<cfif titel NEQ "">
	<h3>#titel#</h3>
				<br>
	</cfif>	
	<cfif lead NEQ "">	
			<p>
			#lead#
			<cfelse>
			Quisque leo tellus, aliquet semper commodo a, aliquam in tortor. Nullam tincidunt fermentum est, non tempus sapien sodales vitae.
			</p>
			</cfif>	
</cfoutput>