<cfprocessingdirective pageEncoding="utf-8"> 
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>template_1</title>
<!--- Tempate 1 für atelierschief - Grosses Bild -Gallerie --->
<!--- open Sans als Frutiger alternative --->


<link href='http://fonts.googleapis.com/css?family=Lato:400,300|Source+Sans+Pro' rel='stylesheet' type='text/css'>

<link  rel="stylesheet" type="text/css" href="css/kube.css" >
<link  rel="stylesheet" type="text/css" href="css/template1.css">

<!--- flexslider integration --->
<link rel="stylesheet" type="text/css" href="js/FlexSlider/flexslider.css">

<script src="js/jquery-1.9.0.min.js"></script>
<script src="js/FlexSlider/jquery.flexslider.js"></script>


<script type="text/javascript" charset="utf-8">
  $(window).load(function() {
    $('.flexslider').flexslider({
		controlNav: true,   
		directionNav:true,
		randomize:false,
		touch: true,     
		animationSpeed: 1600,
		});
  });
</script>


</head>

<body>

<!--- Main Wrapper starts here --->
<div class="main-wrapper">


	<div class="row" <!--- style="border-bottom:#999 1.5px solid" ---> >
		<div class="sixth">
			<div >
				<img id="logo" src="pix/logo.jpg">
			</div>
		</div>
	<!--- 	service Navigation in HEADER --->
		<div class="twothird">
			<div class="servicenav">
			<ul>
				<li>
				<a href="bla.txt">
			 		Bilder
				</a>
				 </li>
				 <li>
				 <a href="bla.txt">
					Schmuck
				</a>
				 </li>
			 	<li>
				<a href="bla.txt">
					Objekte
				</a>
			 	</li>
			</ul>
			</div>
		</div>
	<!--- 	Page title or teaser --->
		<div class="sixth push-righ small topright">
			<a href="some">
				<span>Atelier Schief<br>Gügerigüstrasse 64, <br>5408 Ennetbaden</span>
			</a>
		</div>
		<div class="title_as push-right fourfifth ">
			<h2>Atelier Schief</h2>
		</div>
	</div>

	<!--- image container for slider or still image --->
	<div class="row">
		<img src="pix/objekte960.jpg"> 
	</div>
	
	
<!--- container Themen Nav in 1 row--->
	<div class="row" style="border-bottom:#999 1.5px solid">
		<div class="themennav">
			<nav>
				<ul>
					<li>
						<a href="#">link to A</a>
					</li>
					<li>
						<a href="#">link to B</a>
					</li>
					<li>
						<a href="#">link to C</a>
					</li>
					<li>
						<a href="#">link to D</a>
					</li>
					<li>
						<a href="#">link to F</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
	
	<!--- 	Content start here: Container Content --->
	
	<div class="row container">
		<div class="sixth">
			<nav>
				<ul>
				<li>
					link 1
				</li>
				<li>
					link 2
				</li>
				<li>
					link 3
				</li>
				</ul>
			</nav>
		</div>
		<div class=" fivesixth">
			<div class="flexslider big_pix">
			<figure>
				<ul class="slides">
				<li>
					<img src="pix/flexslider/k1.jpg" />
					 <p class="flex-caption">Quisque leo tellus, aliquet semper commodo a</p>
				</li>
				<li>
					<img src="pix/flexslider/k2.jpg" />
					 <p class="flex-caption">Nullam tincidunt fermentum est, non tempus sapien sodales vitae.</p>
				</li>
				<li>
					<img src="pix/flexslider/k3.jpg" />
					<p class="flex-caption">Aliquet semper commodo a, aliquam in tortor.</p>
				</li>			
				</ul>
			</figure>
		 </div>
		<div class="bilddesc">
			<h3>Bildbeschreibung</h3>
			<br>
			<p>
			Quisque leo tellus, aliquet semper commodo a, aliquam in tortor. Nullam tincidunt fermentum est, non tempus sapien sodales vitae.
			</p>
		</div>
	</div>	
</div>	
	
	
	
	<!--- <div class="row container">
		<div class="sixth">
			<nav>
				<ul>
				<li>
					link 1
				</li>
				<li>
					link 2
				</li>
				<li>
					link 3
				</li>
				</ul>
			</nav>
		</div>
		<div class="twothird big_pix">
			<figure>
				<img src="pix/kenna4.jpg" alt="" >
				<br>
				<p>
				Lorem Ipsum In commodo tincidunt purus et.
				</p>
				<br> 
			</figure>
		 </div>
		<div class="sixth bilddesc">
			<h3>Bildbeschreibung</h3>
			<br>
			<p>
			Quisque leo tellus, aliquet semper commodo a, aliquam in tortor. Nullam tincidunt fermentum est, non tempus sapien sodales vitae.
			</p>
		</div>
	</div>	 --->
	
		
	
	<!--- footer --->
	<div class="row footerrow">
		<div class="sixth copy">
			&copy; 2013 by FLX
		</div>
		<div class="twothird">	
		<span>
			<address>Kitty Cat, Cutie-Street 43, 8844 Kitchingen</address>
		</span>
		</div>
		<div class="sixth">
			<h7><small>Last update: some useless text come here</small></h7>
		</div>	
 	</div>

<!--- close Wrapper --->
</div>




</body>
</html>