<!---alle Teasers contents aus der db lesen und pasten--->

<cfoutput query="getTeaserElems">
	<div class="quarter">
		<div class="teaser-elem">
		<cfif titel NEQ "">
			<div>#titel#</div>
		</cfif>
		<cfif image NEQ "">
			<img src="/#session.serverpath#/upload/img/#image#" width="100%" alt="" hspace="3" />
		</cfif>
		<cfif (fliesstext NEQ "" AND fliesstext NEQ "<br />") OR (href NEQ "" AND hreflabel NEQ "")>
			<div style="padding:0px;">
				<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
					#fliesstext#
				</cfif>
				<cfif href NEQ "" AND hreflabel NEQ "">
					<a href="#href#" title="#hreflabel#" target="_blank">#hreflabel#</a>
				</cfif>
			</div>
		</cfif>
	</div>
	</div>
</cfoutput>
 <div class="clear"></div>