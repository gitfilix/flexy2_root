<cfprocessingdirective pageencoding="utf-8" />
<!---  index of TEMPLATE 3 (with fancy-blue bar ! ) --->
<cfhtmlhead text="
	<link rel='stylesheet' href='/#session.serverpath#/inc/template3/js/flexslider/flexslider.css' type='text/css'>
	<script src='/#session.serverpath#/inc/template2/js/flexslider/jquery.flexslider.js'></script>
	<!--- 	Template 3 but CSS  nummer 7 include  --->
	<link rel='stylesheet' href='/#session.serverpath#/inc/template3/css/template7.css' />
	<!--- logo glow up funciton in template 2  --->
	<script type='text/javascript' src='/#session.serverpath#/inc/template3/js/template3.js'></script>
	<!--- google lato font  --->
	<link href='http://fonts.googleapis.com/css?family=Lato:400,300,700' rel='stylesheet' type='text/css'>

">


<body>

<!--- mainwrapper start  --->
<div class="main-wrapper">

	<div class="row">
		<!--- Main Pannel start --->
		<div class="quarter">
			<div class="bluepannel">
			<!--- 	include logo and flx test --->
				<cfinclude template="inc/logo.cfm">
				
			<!--- 	Themennav starts here --->
				<div class="themennav">
					<cfinclude template="inc/themennav.cfm">
				</div>
				<div class="quotetext">
					<p>
					Contrary to popular belief, Lorem Ipsum is not simply random text. 
					It has roots in a piece of classical Latin literature from 45 BC,
					 making it over 2000 years old.
					</p>
				</div>
			</div>
		</div>
	<!--- 	main pannel end --->
	<!--- 	Main container start --->
		<div class="threequarter container specialgap">
			<div class="row">
				<div>
					<div>
						<cfinclude template="inc/headerbild.cfm">
					</div>
				</div>
			</div>
			<div class="row">
				<!--- MAIN CONTENT container --->
				<div class="threequarter">
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
				<div class="quarter">
				<!--- 	secondary nav right start  --->
					<div class="servicenav">
						 <cfinclude template="inc/servicenav.cfm">
					</div>
					<!--- 	secondary nav end  --->
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
			<div class="row">
				<div>
					<cfinclude template="inc/footer.cfm">
				</div>
			</div>
		<!--- small Footer end  --->
		</div>
	</div>
</div>
<!--- mainwrapper end --->
</div>
<!---  <cfdump var=#getcontent#>  --->
</body>
</html>