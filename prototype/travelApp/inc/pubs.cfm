<cfprocessingdirective pageencoding="utf-8" />

<cfset pubs = fs.getPublications() />

<div id="pubWrapper" style="max-width:80%;margin:0 auto;">
	<!--- <h1 style="font-size:5em;margin-bottom:0.2em;">Willkommen auf travelAPP!</h1>
	<h2 style="margin-bottom:2em;font-size:2em;">Wählen Sie Publikation und Ausgabe</h2> --->
	
	<cfoutput query="pubs">
		<!--- get issues from this publication --->
		<cfset issues = fs.getIssues(pubID = id) />
		<div style="width:30%;float:left;margin-right:2%;background-color:white;color:##333;height:300px;font-size:2em;position:relative;">
			<a href="javascript:void(0);" class="issue">
				<!--- #titel# --->
				<img src="/#session.serverpath#/upload/magazine/#image#" style="width:100%;" />
			</a>
			<div id="issue#currentrow#" style="display:none;font-size:0.7em;line-height:normal;position:absolute;bottom:1em;text-align:left;padding:0 1em 0 1em;">
				<cfif issues.recordcount GT 0>
					Ausgabe wählen:<br/>
					<cfloop query="issues">
						<a href="#cgi.SCRIPT_NAME#?pubID=#id#&issueID=#id#&#session.URLToken#">#ausgabe#</a> <cfif issues.recordcount GT 1>|</cfif>
					</cfloop>
				<cfelse>
					<span style="color:grey;">Keine Ausgaben</span>
				</cfif>
			</div>
		</div>
	</cfoutput>
	<div style="clear:both;"></div>
</div>

