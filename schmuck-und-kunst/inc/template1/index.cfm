<cfprocessingdirective pageencoding="utf-8" />
<!--- index TEMPLATE 1 schmuckundkunst Mit Flexslyder --->

<cfhtmlhead text="
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/css/template1.css' />
	<link href='http://fonts.googleapis.com/css?family=Lato:400,300|Source+Sans+Pro' rel='stylesheet' type='text/css'>

	
	
	<!--- Flexslider integration --->
	<!--- <link rel='stylesheet' href='/#session.serverpath#/inc/FlexSlider/flexslider.css' type='text/css'> --->
	<!--- <script src='/#session.serverpath#/inc/template1/js/jquery-1.9.0.min.js'></script> --->
	<script src='/#session.serverpath#/inc/FlexSlider/jquery.flexslider.js'></script>
<!--- Load Template-specific JS here  --->
	<script type='text/javascript' src='/#session.serverpath#/inc/template1/js/template1.js'></script>
	
">



<!--- Main Wrapper starts here --->
<div class="main-wrapper">
	<div class="row" style="margin-bottom: 0.3em;">
		<div class="fifth">
			&nbsp;
		</div>
		<!--- 	service Navigation in HEADER --->
		<div class="threefifth">
			<div class="servicenav">
			<cfinclude template="inc/servicenav.cfm">
			</div>
		</div>
		<!--- 	adress - shortcuts  or teaser --->
		<div class="fifth small topright">
			<a href="http://www.atelierschief.ch/schmuck-und-kunst/Anfahrt/">
				<div>atelier schief<br>Sonnenbergstrasse 2<br>5408 Ennetbaden</div>
			</a>
		</div>
	</div>
	<!--- 	Main Title comes here --->
	<div class="row">
		<div class="fifth">
		 <cfinclude template="inc/logo.cfm">
		</div>
	
		<div class=" threefifth">
			<div class="title_as">
				<h2>atelier Schief</h2>
			</div>
		</div>
		<div class="fifth">
			&nbsp;
		</div>
	</div>

	<!--- KEIN 2. image container im Template 2 --->

	<!--- container Themen Nav in 1 row--->
	<div class="row" style="border-bottom:#999 1.5px solid; border-top:#333 1.5px solid; padding-top:2.4em;">
		<div class="fifth">
				&nbsp;
		</div>
		<div class="fourfifth themennav">
				<cfinclude template="inc/themennav.cfm">
		</div>
	</div>
	
	<!--- 	Content start here: Container Content --->
	
	<div class="row container">
		<div class="fifth">
			<div class="subnav">
				<cfinclude template="inc/subnav.cfm">
			</div>
		</div>
		<div class="twothird">
			<!--- 	gallerie output @ flexslider --->
			<div>	
				<cfinclude template="inc/content_templ1.cfm">
			</div>
		</div>
		
	</div>

	
	<!--- footer --->
	<div class="row footerrow">
	
		<div class="">
			<cfinclude template="inc/footer.cfm">
		</div>
 	</div>

<!--- close Wrapper --->
</div>


