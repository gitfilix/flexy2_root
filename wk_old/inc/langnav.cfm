<cfprocessingdirective pageencoding="utf-8">
<cfquery name="checkForAcceptedLangs" datasource="#application.dsn#">
	SELECT * FROM mandantensprachen
	WHERE mandant = #session.mandant# 
</cfquery>
<cfif checkForAcceptedLangs.recordcount GT 1>
<ul>
	<cfoutput query="checkForAcceptedLangs">
		<li>
		<!--- 	wenn aktuelle Sprache NICHT die  Mandantensprache ist  --->
			<cfif session.lang NEQ languageParam>
			<!--- 	zeige link auf andere sprache --->
			<a href="#cgi.SCRIPT_NAME#?id=#url.id#&amp;lang=#languageParam#" title="#language#" class="lang_switch">
				#listLast(languageParam,'-')#
			</a>
			<cfelse>
			<!---aktuelle Sprache unverlinkt - listlast (letzet Position mit delimter "-"  der DB language-param ) --->
			<a href="#cgi.SCRIPT_NAME#?id=#url.id#&amp;lang=#languageParam#" title="#language#">
				#listLast(languageParam,'-')#
			</a>
			</cfif>
		</li>
	</cfoutput>
</ul>	
<div class="clear"></div>
</cfif>