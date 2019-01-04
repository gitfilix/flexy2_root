<cfoutput query="getcontent">
	
		<div class="desc_aside">
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
			<!--- Print out Fliesstext --->
	
				<h3>#Lead#</h3>
			<br>
				<div class="desc_text">
					#fliesstext#
				</div>
			<div>
				<!--- include documents  --->
			<cfquery name="getAdditionalDocs" datasource="#application.dsn#">
			Select	*
			FROM	docs2pages
			WHERE	contentid = #id#
			</cfquery>
			<cfif doc NEQ "">
				<div class="doc_link">
					<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank">
						#doclabel#
					</a>
					<br/>
				</div>
			</cfif>
			<cfif getAdditionalDocs.recordcount GT 0>
				<cfloop query="getAdditionalDocs">
					<div class="doc_link">
						<a href="/#session.serverpath#/upload/doc/#dok#" target="_blank">
							#doklabel#
						</a>
						<br/>
					</div>
				</cfloop>
			</cfif>
			</div>	
		</cfif>
	</div>

</cfoutput>


