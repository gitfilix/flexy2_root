<cfprocessingdirective pageencoding="utf-8" />
<!--- index TEMPLATE 2 Schmuck und Kunst  --->
<cfhtmlhead text="
	<link rel='stylesheet' type='text/css' href='/#session.serverpath#/css/kube.css'>
	<link rel='stylesheet' type='text/css' href='/#session.serverpath#/inc/template2/css/template2.css' />
	<link rel='stylesheet' type='text/css' href='/#session.serverpath#/inc/template2/css/template2_mq.css' />
	<link rel='stylesheet' type='text/css' href='/#session.serverpath#/inc/template2/css/flexslider.css' />
	<link href='http://fonts.googleapis.com/css?family=Lato:400,300|Source+Sans+Pro' rel='stylesheet' type='text/css'>
	
	<script src='/#session.serverpath#/inc/FlexSlider/jquery.flexslider.js'></script>
	
	<script type='text/javascript' src='/#session.serverpath#/inc/template2/js/template2.js'></script>
">

<!--- Main Wrapper starts here --->
<div class="main-wrapper">
	<div class="row" style="margin-bottom: 0.3em;">
		<div class="fifth">
			&nbsp;
		</div>
		<!--- 	service Navigation in HEADER --->
		<div class="threefifth">
			<nav class="servicenav">
			<cfinclude template="inc/servicenav.cfm">
			</nav>
		</div>
		<!--- 	adress - shortcuts  or teaser --->
		<div class="fifth">
			<div class="topright">
			<a href="http://www.atelier-schief.ch/schmuck-und-kunst/ch-de/Anfahrt/">
				<address>
					atelier schief<br>Sonnenbergstrasse 2<br>5408 Ennetbaden
				</address>
			</a>
			</div>	
		</div>
	</div>
	<!--- 	Main Title comes here --->
	<div class="row">
		<div class="fifth">
		 	<cfinclude template="inc/logo.cfm">
			<h1 class="hideme_desktop">atelier schief</h1>
		</div>
		<div class="fourfifth" >
			<div class="title_as"><h1>atelier schief</h1></div>
		</div>
	</div>
	<!--- image container for Flexslider or still image --->
	<div class="row">
		<cfinclude template="inc/headerpanel_flex.cfm">
	</div>
	<!--- container Themen Nav in 1 row--->
	<div class="row" style="border-bottom:#999 1.5px solid">
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
		<!---  include Subnavigation here --->
			<nav class="subnav">
				<cfinclude template="inc/subnav.cfm">
			</nav>
		</div> 
			<div class="twothird">
				<cfinclude template="inc/content.cfm">
			</div>
		<div class="fourfifth">
			&nbsp;
		</div> 
	</div>
	<!--- second row for sidebar elements  --->
	<div class="row container">
		<div class="fifth">
			&nbsp;
		</div> 
		<!--- 	Hack manual shift to right by pushing left --->
		<div class="twothird" >
			<cfinclude template="inc/sidebars.cfm" >	
		</div>
	</div>

	<!--- footer --->
	<div class="row container">
		<div class="footerrow">
			<cfinclude template="inc/footer.cfm">
		</div>
 	</div>
<!--- close Wrapper --->
</div>