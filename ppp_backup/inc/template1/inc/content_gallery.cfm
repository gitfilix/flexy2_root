
<!--- Content with Glisse Gallery --->
<cfoutput query="getcontent">
	<div>
		<cfif bildname NEQ "">
			<ul>
				<li>
					<img class="pics"  data-glisse-big="/#session.serverpath#/upload/img/#bildname#" title="my awesome picture 1" rel="group1"  src="/#session.serverpath#/upload/img/#bildname#" alt="#bildname#">
				</li>
			</ul>
		</cfif>
		
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
		<!--- Print out Fliesstext --->
		<div class="gallery_text">
			Description comes here:<br>
			#fliesstext#
		</div>	
		</cfif>
		
	</div>
</cfoutput>

