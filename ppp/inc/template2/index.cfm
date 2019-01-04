<cfprocessingdirective pageencoding="utf-8" />
<!---  index of TEMPLATE 2 (with fancy-slopy-sly-flex-slider! ) --->
<cfhtmlhead text="
	<link rel='stylesheet' href='/#session.serverpath#/inc/template2/js/flexslider/flexslider.css' type='text/css'>
	<script src='/#session.serverpath#/inc/template2/js/flexslider/jquery.flexslider.js'></script>
	<link rel='stylesheet' href='/#session.serverpath#/inc/template2/css/template2.css' />
	<!--- logo glow up funciton in template 2  --->
	<script type='text/javascript' src='/#session.serverpath#/inc/template2/js/template2.js'></script>
	<!--- google lato font  --->
	<link href='http://fonts.googleapis.com/css?family=Lato:400,300,700' rel='stylesheet' type='text/css'>

">


<!--- Main Wrapper starts here --->
<div class="main-wrapper">

	<!---image container WITH LOGO included for slider  --->
	 <div class="row">
		<div class="flexslyder_FLX">
				<cfinclude template="inc/headerpanel.cfm" />	
		</div>
	</div>	
	<!--- logo / header ends here --->

<!---  navigElements themen nav big / service nav small --->
	<div class="row ">
		<div class="nav_wrapper">
			<div class="twothird">
				<div class="themennav">
					<cfinclude template="inc/themennav.cfm">
				</div>
			</div>
			<div class="third container">
				<div class="third">
						&nbsp;
				</div>
				<div class="third">
					<div class="small">
						<div class="bggray" >
							<a href="flx-media.ch/admin">	
							> Login Backend
							</a>
							&nbsp;
							<br>
							<a href="flx-media.ch/admin">	
							> Kundenlogin
							</a>
					
							
						</div>
					</div>
				</div>
				<div class="third">
					<div class="small">
						<div class="bggray" >
							<cfquery name="checkForAcceptedLangs" datasource="#application.dsn#">
							SELECT * FROM mandantensprachen
							WHERE mandant = #session.mandant# 
							</cfquery>
							<cfif checkForAcceptedLangs.recordcount GT 0>
								
								<ul>Sprache: <br>
									<cfoutput query="checkForAcceptedLangs">
										<li style="padding-right:1em;">
											
											<cfif session.lang NEQ languageParam>
												<a href="#cgi.SCRIPT_NAME#?id=#url.id#&lang=#languageParam#" title="#language#">
													> #listLast(languageParam,'-')#
												</a>
											<cfelse>
												#listLast(languageParam,'-')#
											</cfif>
										</li>
									</cfoutput>
								</ul>
							</cfif>
						</div>
					</div>
				</div>
			</div>
		</div>



	<!--- Navigation Themen  / image container for slider  --->
	<div class="row">
		<div class="half"> 
			<cfinclude template="inc/headline.cfm">
		</div>	
		<div class="half">
			<div class="servicenav">
				<nav>
					<cfinclude template="inc/servicenav.cfm">
				</nav>
			</div>
		</div>
	</div>
	
	
	<!--- 	Content start here: Container Content --->
	<div class="row">   
		<div class="quarter">
			<cfif getsubnav.recordcount GT 0>
				<div class="subnav">
					<cfinclude template="inc/subnav.cfm" />
				</div>
			<cfelse>
			<!--- if no subnav, then sidebar elements  --->
			<div class="left_sidebars" >
				<cfinclude template="inc/sidebars.cfm" />
			</div>
			</cfif>	
		</div>
		<div class="half">
			<div class="contentbox">
			<!--- include content (template 2) here  --->
				<cfinclude template="inc/content_templ2.cfm" />
			</div>
		</div>
		<!--- sidebar elements  --->
		<div class="quarter">
			<cfinclude template="inc/sidebars.cfm" />
		</div>	
	</div>



	<!--- second row for sidebar elements  --->
	<div class="row container">
		<div class="footer_teaser">
			<cfinclude template="inc/teasers.cfm" />
		</div>	
	</div>	
		
		
		
	
	<!--- footer --->
	<div class="row footerrow">
	
	
		<cfinclude template="inc/footer.cfm">
	<!--- 	<div class="sixth copy">
			&copy; 2013 by FLX
		</div>
		<div class="twothird">	
		<span>
			<address>Kitty Cat, Cutie-Street 43, 8844 Kitchingen</address>
		</span>
		</div>
		<div class="sixth">
			<h7><small>Last update: some useless text come here</small></h7>
		</div>	 --->
 	</div>
<!--- close Wrapper --->
</div>







<!---  Old Site 
<div class="main-wrapper" >


	<nav class="row container servicenav" style="text-align:right;">
		<cfinclude template="inc/servicenav.cfm" />
	</nav>
	
	<cfinclude template="inc/headerpanel.cfm" />
	
	<nav class="themennav">
		<cfinclude template="inc/themennav.cfm" />
	</nav>
	
	<div class="row" style="padding:20px;">
		<!--- Wenn es eine subpage existiert dann zeige dies an. sonst zeige hier die Teaserelemente an.  --->
		<cfif getsubnav.recordcount gt 0>
		<div class="quarter">
			<cfinclude template="inc/subnav.cfm" />
		</div>
		<cfelse>
		<!--- zeige teaser  --->
		<div class="quarter">
		<cfinclude template="inc/sidebars.cfm">
		</div>
		
		</cfif>
		
		<!--- include Main content  --->
		<div class="threequarter">
			<cfinclude template="inc/content.cfm" />
		</div>	
			
	</div>

	
	
	 <!--- start container footer --->
	 <div class="row container footer">
			<ul class="block-four">
				<li>
					<div>
					<cfinclude template="inc/teasers.cfm">
					</div>
				</li>	
				<li>
					<cfinclude template="inc/teasers.cfm">
				</li>
				<li>
					<div>
					<cfinclude template="inc/teasers.cfm">
					</div>
				</li>
				<li>
					<a href="" title="">
						Thema 4
					</a>
				</li>
			</ul>
		</div>
	</div>
	<cfquery name="getTemplateNO"  datasource="#application.dsn#">
	SELECT *
	FROM  pages
	WHERE template = 1 AND isactive = 1 
	</cfquery>


<div id="logobg">
			<div class="logostyle">
				<table>
					<tr>
						<td>
							<div class="logocircle">+</div>
						</td>
						<td>
						<div class="flx_style">
							 <h1>FLX _media</h1>
						 </div>
						</td>
					</tr>
				</table>
			</div>




<!--- close wrapper --->
</div>
 --->

