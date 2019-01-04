<!DOCTYPE html>
<html lang="de">
<head>
    <cfprocessingdirective pageencoding="utf-8" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="webkanal test ">
    <title>webkanal - pure index</title>
   
    <style>
		 /* -- Inline Styles sind total legitim solange man 3 fucking Anweisungen für eine ganze seite braucht. 1 request weniger. und jaaaa, es ist nicht ganz schwarz & weiss - aber was ist schon absolut in diesen tagen?*/
		/*wäutaull ich dunku wien ne sou*/
        body{
            background: #000;
        }
        /* --lass es einen ungefaehren goldenen schnitt machen- damit die Graphiker einen Ständer haben*/
        article{
            font-size:1.2rem;
            line-height: 1.65rem;
            color: #222;
        }
		.wrapper{
            margin: 0 auto;
			max-width: 80%;
            padding: 1.6rem;
			background:  #FDFDFD;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Webkanal webroot</h2>
    </header>
    <p>hier ist nix..</p>

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
			<cfdump var="#getMandant#"></cfdump>
	</cfoutput>

</div>
</body>
</html>