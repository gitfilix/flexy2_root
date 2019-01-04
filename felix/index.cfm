<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]--><head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

	 <!--- Das ALLGEMEINE HTML state-of-the-art header und initialisierungs INDEX.  --->
	<!--- 	--> nachher wird alles durch den template loader reingeladen - > und dann mit einzelnen templates mit incluedes reingepfiffn --->
     
	 
	    <!--- <link rel="stylesheet" href="css/normalize.min.css">
        <link rel="stylesheet" href="css/main.css"> --->
		
		
    <cfoutput><link rel="stylesheet" href="/#session.serverpath#/css/kube.css">
	
		<link rel="stylesheet" href="/#session.serverpath#/css/master.css">
		<!--- <link rel="stylesheet" href="/#session.serverpath#/inc/template3/css/template3_fancy.css"> --->
		<link rel='stylesheet' href='/admin/js/jquery.fancybox-1.3.4/fancybox/jquery.fancybox-1.3.4.css' type='text/css'>
		
		
		

        <script src="/#session.serverpath#/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script></cfoutput>
		
		<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
		<!--[if lt IE 9]>
		  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		
		<cfoutput> 
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
			<script>window.jQuery || document.write('<script src="/#session.serverpath#/js/vendor/jquery-1.8.3.min.js"><\/script>')</script>
			<script src="/#session.serverpath#/js/plugins.js"></script>
			<script src="/#session.serverpath#/js/main.js"></script>
			<script type="text/javascript" src="/#session.serverpath#/inc/yoxview/yoxview-init.js"></script>
			<script type='text/javascript' src='/admin/js/jquery.fancybox-1.3.4/fancybox/jquery.fancybox-1.3.4.js'></script>
			<cfinclude template="/admin/inc/fee.cfm" />
		</cfoutput>

	<!--- 
		<!-- Fav and touch icons -->
		<link rel="apple-touch-icon-precomposed" sizes="144x144" href="precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="114x114" href="precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="72x72" href="precomposed.png">
		<link rel="apple-touch-icon-precomposed" href="57-precomposed.png">
		<link rel="shortcut icon" href="favicon.png"> --->
		
    </head>
    <body oncontextmenu="return false;">
        <!--[if lt IE 8]>
            <p class="chromeframe">Sie haben einen <strong>wirklich alten</strong> Browser! >> Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->
		<!--- lade das Template -loader MANDANTEN-Template hier in den Code rein, also das HTML mit CSS --->
        <cfinclude template="inc/templateLoader.cfm" />

        <script>
            var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,'script'));
        </script>
    </body>
</html>
