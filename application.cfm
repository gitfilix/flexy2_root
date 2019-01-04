<!--- WIRD NUR BEI domain root access ausgeführt um zu mandanten redirect.  --->
<!--- Name muss uniqe sein um im CF Ram allozieiren und frontend-root initierung --->
<cfapplication name="felix_root" sessionmanagement="yes">



<cfif cgi.SCRIPT_NAME DOES NOT contain "robots.cfm">
	<!--- NEW www-domain: MAKE SURE to add domain to MANDANTENSPRACHEN  --->
	<!--- hier werden mandanten-domain abgefangen und entsprechend umgeleitet --->
	<!--- alle Mandanten Sprachen und Damains aus zwischentabelle auslesen datasource application --->
	<cfquery name="getDomainAndLang" datasource="atelier_schief_ch">
	SELECT	*
	FROM	mandantensprachen
	WHERE 	isActive = 1
			<!--- 1. www-replacement if not there  --->
			AND <cfif CGI.SERVER_NAME contains "www.">domain = "#replace(CGI.SERVER_NAME, 'www.', '')#"<cfelse> domain = "#CGI.SERVER_NAME#"</cfif>
	</cfquery>
	
	
	
	<cfoutput query="getDomainAndLang">
		<!--- SUB-Query: wenn domain in der DB (case mit und ohne "www") domain der datenbank entspricht - rederict auf den mandantenordner--->
		<cfquery name="getMandant" datasource="atelier_schief_ch">
		SELECT	*
		FROM	mandanten
		WHERE 	isActive = 1
				AND id = #mandant# 	
		</cfquery>	
		<!--- redirect auf mandanten-ordner  --->
		
		
		<cfinclude template="/#getMandant.directoryname#/application.cfm">
		<cfinclude template="/#getMandant.directoryname#/index.cfm"><cfabort>
		
		
		
		<cflocation addtoken="no" url="http://#cgi.server_name#/#getMandant.directoryname#/" />
	</cfoutput>
	
	
	<!---  HARD CODED HACK for Atelierschief ALIAS  --->
	<!--- Redirect für Domain alias - hier atelierschief.ch -> atelier-schief.ch --->
	<cfif cgi.SERVER_NAME EQ "www.atelierschief.ch" OR cgi.SERVER_NAME EQ "atelierschief.ch"> 
		<cflocation addtoken="no" url="http://www.atelier-schief.ch" statuscode="301" />
	</cfif>

</cfif>

<!---  HARD CODED HACK for Atelierschief ALIAS  --->
<!--- Redirect für Domain alias - hier atelierschief.ch -> atelier-schief.ch
<cfif cgi.SERVER_NAME EQ "www.webkanal.ch" OR cgi.SERVER_NAME EQ "webkanal.ch"> 
	<cflocation addtoken="no" url="http://www.web-kanal.ch" statuscode="301" />
</cfif>
 --->