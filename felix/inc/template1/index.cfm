<cfprocessingdirective pageencoding="utf-8" />
<!---  index of TEMPLATE 1 version2 (with fancy-blue bar & subnavig ) --->
<cfhtmlhead text="
	<!--- <link rel='stylesheet' href='/#session.serverpath#/inc/template1/js/flexslider/flexslider.css' type='text/css'> --->
	
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/css/template1.css' />
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/css/mediaqueries.css' />
	<script src='/#session.serverpath#/inc/template1/js/flexslider/jquery.flexslider.js'></script>
	<!--- 	Template 1  CSS  include  --->
	
	<!--- google lato font  --->
	<link href='http://fonts.googleapis.com/css?family=Lato:400,300,700' rel='stylesheet' type='text/css'>

<script type='text/javascript' charset='utf-8'>
  $(window).load(function() {
  $('.flexslider').flexslider();
    if($('.specialgap').height()  > $('.bluepannel').height()){
		$('.bluepannel').height($('.specialgap').height());	
	}
  });
</script>


">


<body>

<!--- mainwrapper start  --->
<div class="main-wrapper">
	<div class="servicenav">	
		<ul>
			<cfoutput query="getServiceNav">
			<li>
				<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
					#navtitel#
				</a>
			 </li>
			 </cfoutput>
			 <li>
				&nbsp;
			 </li>
			 <cfquery name="checkForAcceptedLangs" datasource="#application.dsn#">
				SELECT * FROM mandantensprachen
				WHERE mandant = #session.mandant# 
			</cfquery>
			<cfif checkForAcceptedLangs.recordcount GT 1>
				<cfoutput query="checkForAcceptedLangs">
					<li style="padding-right:1em;">
					<!--- 	wenn aktuelle Sprache NICHT die  Mandantensprache ist  --->
						<cfif session.lang NEQ languageParam>
						<!--- 	zeige link auf andere sprache --->
							<a href="#cgi.SCRIPT_NAME#?id=#url.id#&lang=#languageParam#" title="#language#" class="lang_switch">
								#listLast(languageParam,'-')#
							</a>
						<cfelse>
					<!---aktuelle Sprache unverlinkt - listlast (letzet Position mit delimter "-"  der DB language-param ) --->
							<a href="#cgi.SCRIPT_NAME#?id=#url.id#&lang=#languageParam#" title="#language#">
								#listLast(languageParam,'-')#
							</a>
						</cfif>
					</li>
				</cfoutput>
			</cfif>
		</ul>
		<div class="clear"></div>
	</div>
	<div class="inner-wrapper">
		<div class="row">
			<!--- Main Pannel start --->
			<div class="quarter">
				<div class="bluepannel">
				<!--- 	include logo and flx test --->
					<cfinclude template="inc/logo.cfm">
				<!--- 	Themennav & include Subnav starts here --->
					<div class="themennav">
						<cfinclude template="inc/themennavplus.cfm">
					</div>
					<div class="quotetext">
						<p>
						“Es soll die Aussage im Vordergrund stehen, das Handwerk im Hintergrund um die Qualität zu gewährliesten.”
						- Tim Berners Lee</p>
					</div>
				</div>
			</div>
		<!--- 	main pannel end --->
		<!--- 	Main container start --->
			<div class="threequarter container specialgap">
				<div class="row">
					<div>
						<div>
							<cfinclude template="inc/headerpanel.cfm">
						</div>
					</div>
				</div>
				<div class="row">
					<!--- MAIN CONTENT container --->
					<div class="twothird">
						<div class="content">
							 <cfinclude template="inc/content.cfm">
						</div>
					<!--- 	Newmodul content comes after Content  --->
						<cfif pageproperties.showAllNews EQ 1>
							<div class="newscontainer">
								<cfinclude template="inc/news_templ3.cfm" />
							</div>
						</cfif>
					</div>
					<div class="third">
						<!--- container for sidebars right start--->
						<div class="sidebar_container_right">
							<cfinclude template="inc/sidebars.cfm">
						</div>
						<!--- container for sidebars right end--->	
					</div>
				</div>
				<!--- 	Heavy Footer comes here --->
				<div class="row">
					<div class="footer footercontainer" >
						<div class="container">
								<cfinclude template="inc/footerteaser.cfm">			
						 </div>
					</div>
				</div>
				<!--- small Footer start here  --->
				<div class="row smallfooter">
					<cfinclude template="inc/footer.cfm">
				</div>
			<!--- small Footer end  --->
			</div>
		</div>
	<!--- innerwrapper end --->
	</div>
</div>
<!--- mainwrapper end --->

</body>
</html>