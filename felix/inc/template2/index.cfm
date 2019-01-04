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
							<cfinclude template="inc/langswitch.cfm"> 
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
			<div class="contentbox contentSortable">
			<!--- include content (template 2) here  --->
				<cfinclude template="inc/content_templ2.cfm" />
			</div>
		<!--- 	Newmodul content comes after Content  --->
			<cfif pageproperties.showAllNews EQ 1>
				<div class="newscontainer">
					<cfinclude template="inc/news_templ2.cfm" />
				</div>
			</cfif>
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
 	</div>
<!--- close Wrapper --->
</div>




