<!--- Lang-wechsel snippet: zeige die verfügbarnen sprachen und verlinke dementsprechend --->
<!--- wird NUR agezeigt wenn mehr als 1 Sprache  vorhanden (zwischentabelle mandantensprachen) --->
	<cfquery name="checkForAcceptedLangs" datasource="#application.dsn#">
	SELECT * FROM mandantensprachen
	WHERE mandant = #session.mandant# 
	</cfquery>
	<cfif checkForAcceptedLangs.recordcount GT 1>
		
		<ul>Sprache: <br>
			<cfoutput query="checkForAcceptedLangs">
				<li style="padding-right:1em;">
				<!--- 	wenn aktuelle Sprache NICHT die  Mandantensprache ist  --->
					<cfif session.lang NEQ languageParam>
					<!--- 	zeige link auf andere sprache --->
						<a href="#cgi.SCRIPT_NAME#?id=#url.id#&lang=#languageParam#" title="#language#">
							> #listLast(languageParam,'-')#
						</a>
					<cfelse>
				<!---aktuelle Sprache unverlinkt - listlast (letzet Position mit delimter "-"  der DB language-param ) --->
						#listLast(languageParam,'-')#
					</cfif>
				</li>
			</cfoutput>
		</ul>
	</cfif>