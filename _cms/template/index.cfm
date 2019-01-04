<cfprocessingdirective pageencoding="utf-8" />

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Login admin panel</title>
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0" />
		
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		
        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
		
        <link rel="stylesheet" href="css/reset.css" />
		<link rel="stylesheet" href="css/kube/css/kube.css"> 
        <link rel="stylesheet" href="css/animate.css" />
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
		<link rel="stylesheet" href="css/styles.css" />
		
		

		<!--[if lt IE 9]>
		<script>
			var head = document.getElementsByTagName('head')[0], style = document.createElement('style');
			style.type = 'text/css';
			style.styleSheet.cssText = ':before,:after{content:none !important';
			head.appendChild(style);
			setTimeout(function(){ head.removeChild(style); }, 0);
		</script>
		<![endif]-->
		
        <script src="js/modernizr.js"></script>
		
		<style type="text/css">
		html,body{
			height:100%;
			overflow:hidden;
		}
		
		body{
			height:100%;
			background-color:#eee;
		}
		
		#main-wrapper{
			/*max-width:1140px;
			margin:0 auto;*/
			height:100%;
			overflow:hidden;
		}
		
		#inner-wrapper{
			overflow:hidden;
			margin: 0 auto;
			height:100%;
			position:relative;
		}
		
		#header-bar{
			line-height:50px;
			padding:0px 20px 0 20px;
			background-color:black;
			color:white;
			
			
		}
		
		#module-bar{
			height:130px;
			border-bottom:1px solid silver;
			background-color:#ddd;
			
		}
		
		#content-wrapper{
		
			/*height:100%;*/
		}
		
		#nav-area{
			height:100%;
			border-right:1px solid silver;
			overflow-y:auto;
			overflow-x:hidden;
			-webkit-overflow-scrolling: touch;
		}
		
		#height80{
			
			overflow-y:auto;
			background-color:white;
			position:relative;
			z-index:5;
			-webkit-overflow-scrolling: touch;
		}
		
		.icn-edit{
			margin:4px auto;
			float:left;
			width:11px;
			height:13px;
			
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_064_edit.png');
		}
		
		.icn-del{
			margin:4px auto;
			width:11px;
			height:13px;
			float:left;
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_019_trash.png');	
		
		}
		
		.icn-active{
			margin:4px auto;
			
			width:11px;
			height:13px;
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_104_eye-open.png');
			float:left;
		}
		
		.icn-inactive{
			margin:4px auto;
			
			width:11px;
			height:13px;
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_105_eye-close.png');
			float:left;	
		}
		
		.icn-add{
			margin:4px auto;
			
			width:11px;
			height:11px;
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_097_plus.png');
			float:left;	
		}
		
		.icn-down{
			margin:4px auto;
			
			width:9px;
			height:11px;
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_093_arrow-down.png');
			float:left;	
		}
		
		.icn-up{
			margin:4px auto;
			width:9px;
			height:11px;
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_092_arrow-up.png');
			float:left;	
		}
		
		.icn-content{
			margin:4px auto;
			width:11px;
			height:12px;
			background:transparent url('css/glyphicons_all/glyphicons_halflings/png/glyphicons_halflings_031_list-alt.png');
			float:left;	
		}
		
		#mobile-header-bar{
			display:none;
			line-height:50px;
			padding:0px 20px 0 20px;
			background-color:black;
			color:white;	
		}
		
		@media all and (max-width: 1024px){
			#nav-area > table > tbody > tr > td:first-child,
			#nav-area > table > tbody > tr > td:nth-child(2),
			#nav-area > table > tbody > tr > td:nth-child(4),
			#nav-area > table > tbody > tr > td:nth-child(5),
			#nav-area > table > tbody > tr > td:nth-child(6),
			
			#nav-area > table > thead > tr > th:first-child,
			#nav-area > table > thead > tr > th:nth-child(2),
			#nav-area > table > thead > tr > th:nth-child(4),
			#nav-area > table > thead > tr > th:nth-child(5),
			#nav-area > table > thead > tr > th:nth-child(6){
				display:table-cell;	
			}
			
			/*#nav-area > table > tbody > tr > td:first-child,
			#nav-area > table > tbody > tr > td:nth-child(2),
			#nav-area > table > thead > tr > th:first-child,
			#nav-area > table > thead > tr > th:nth-child(2){
			
				display:none;	
			}*/
			
		}
		
		@media all and (max-width: 768px){
			
			#mobile-header-bar{
				display:block;	
			}
			
			#header-bar{
				display:none;	
			}
			
			#nav-area > table > tbody > tr:nth-child(odd) > td:first-child,
			#nav-area > table > tbody > tr:nth-child(odd) > td:nth-child(2),
			#nav-area > table > tbody > tr:nth-child(odd) > td:nth-child(5),
			#nav-area > table > tbody > tr:nth-child(odd) > td:nth-child(6),
			
			#nav-area > table > thead > tr:nth-child(odd) > th:first-child,
			#nav-area > table > thead > tr:nth-child(odd) > th:nth-child(2),
			#nav-area > table > thead > tr:nth-child(odd) > th:nth-child(5),
			#nav-area > table > thead > tr:nth-child(odd) > th:nth-child(6){
				display:none;	
			}
			
			/*#nav-area > table > tbody > tr:nth-child(even) > td > div > td:first-child,
			#nav-area > table > tbody > tr:nth-child(even) > td > div > td:nth-child(2),
			#nav-area > table > tbody > tr:nth-child(even) > td > div > td:nth-child(5),
			#nav-area > table > tbody > tr:nth-child(even) > td > div > td:nth-child(6),
			
			#nav-area > table > thead > tr:nth-child(even) > td > div > th:first-child,
			#nav-area > table > thead > tr:nth-child(even) > td > div > th:nth-child(2),
			#nav-area > table > thead > tr:nth-child(even) > td > div > th:nth-child(5),
			#nav-area > table > thead > tr:nth-child(even) > td > div > th:nth-child(6){
				display:table-cell;	
			}*/
			
		}
		
		@media all and (max-width: 500px){
			#nav-area > table > tbody > tr > td:first-child,
			#nav-area > table > tbody > tr > td:nth-child(2),
			#nav-area > table > tbody > tr > td:nth-child(4),
			#nav-area > table > tbody > tr > td:nth-child(5),
			#nav-area > table > tbody > tr > td:nth-child(6),
			
			#nav-area > table > thead > tr > th:first-child,
			#nav-area > table > thead > tr > th:nth-child(2),
			#nav-area > table > thead > tr > th:nth-child(4),
			#nav-area > table > thead > tr > th:nth-child(5),
			#nav-area > table > thead > tr > th:nth-child(6){
				display:table-cell;	
			}
			
		}
		</style>
 
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
		
		
		
		<div id="main-wrapper">
			<div id="inner-wrapper">
				<div id="header-bar">
					
						<div style="width:30%;float:left;">
							<strong>Flxy-CMS 0.9 BETA</strong> | M. Grossniklaus
						</div>
						<div style="width:70%;float:left;">
							
							
								<div style="width:50%;float:left;">
									Module: 
									<select name="" id="" style="margin-right:20px;">
										<cfoutput>
										<cfloop from="1" to="10" index="o">
										<option value="">Modul #o#</option>
										</cfloop>
										</cfoutput>
									</select> 
									Session-Timeout <strong>2:41 Min.</strong>
								</div>
								<div style="width:50%;float:left;">
									<nav class="nav-pills" style="padding-top:10px;margin-bottom:0;">
									<ul>
										<li style="float:right;padding-left:20px;margin-bottom:0;">
											<a href="">abmelden</a>
										</li>
										<!--- <li style="float:right;padding-left:20px;margin-bottom:0;">
											<a href="Profil">mein Profil</a>
										</li> --->
										
									</ul>
									</nav>
								</div>
								<div class="clear"></div>
							
							
							
						</div>
						<div class="clear"></div>
				</div>
				<div id="mobile-header-bar">
					<div style="width:30%;float:left;">
						<strong>Flxy-CMS 0.9 BETA</strong>
					</div>
					<div style="width:70%;float:left;">
						Module: 
						<select name="" id="" style="margin-right:20px;">
							<cfoutput>
							<cfloop from="1" to="10" index="o">
							<option value="">Modul #o#</option>
							</cfloop>
							</cfoutput>
						</select> 
						<nav class="nav-pills" style="padding-top:10px;margin-bottom:0;width:100px;float:right;">
						<ul>
							<li style="float:right;padding-left:20px;margin-bottom:0;">
								<a href="">abmelden</a>
							</li>
							<!--- <li style="float:right;padding-left:20px;margin-bottom:0;">
								<a href="Profil">mein Profil</a>
							</li> --->
							
						</ul>
						</nav>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
				<!--- <div id="module-bar"></div> --->
				<div id="content-wrapper" class="units-row-end units-split">
					<div id="nav-area" class="unit-30">
						
						<ul id="nav">
							<cfloop from="1" to="5" index="i">
							<li>
								<a href="">Ein Titel</a>
								<!-- UL node only needed for children - omit if there are no children -->
								<ul>
									<cfloop from="1" to="3" index="i">
									<li>
										<a href="">Ein Titel</a>
										<ul>
											<cfloop from="1" to="3" index="i">
												<li>
													<a href="">Ein Titel</a>
												</li>
											</cfloop>
										</ul>
									</li>
									</cfloop>
								</ul>
							</li>
							</cfloop>
							<cfloop from="1" to="10" index="i">
							<li>
								<a href="">Ein Titel</a>
								<!-- UL node only needed for children - omit if there are no children -->
								<ul>
									<cfloop from="1" to="4" index="i">
									<li>
										<a href="">Ein Titel</a>
										<ul>
											<cfloop from="1" to="2" index="i">
												<li>
													<a href="">Ein Titel</a>
												</li>
											</cfloop>
										</ul>
									</li>
									</cfloop>
								</ul>
							</li>
							</cfloop>
						</ul>		
						
						<!--- <table class="width-100 table-bordered table-hovered">
							<thead>
								<tr>
									<th colspan="10">Service Navigation</th>	
								</tr>
							</thead>
							<tbody>
								<cfoutput>
								<cfloop from="1" to="5" index="i">
								<tr>
									<td class="width-10"><div class="halflings icn-down"></div></td>
									<td class="width-10"><div class="halflings icn-up"></div></td>
									<td class="width-40">Ein Titel</td>
									<td class="width-10"><div class="halflings icn-active"></div></td>
									<td class="width-10"><div class="halflings icn-edit"></div></td>
									<td class="width-10"><div class="halflings icn-del"></div></td>
									<td class="width-10"><div class="halflings icn-add"></div></td>	
								</tr>
								<tr>
									<td colspan="10" style="padding:0;border:0;">
										<div style="display:none;">
											<table class="width-100 table-hovered subtable" id="subtable#i#" style="border:0;margin:0;">
											<!--- <thead>
												<tr>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-40" style="border:0;">Inhalte</th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													
												</tr>
											</thead> --->
											<tbody>
												<cfoutput>
												<cfloop from="1" to="2" index="u">
												<tr>
													<td><div class="halflings icn-down"></div></td>
													<td><div class="halflings icn-up"></div></td>
													<td><div class="halflings icn-content"></div> &nbsp;&nbsp;Ein Titel</td>
													<td><div class="halflings icn-active"></div></td>
													<td><div class="halflings icn-edit"></div></td>
													<td><div class="halflings icn-del"></div></td>
													<td><div style="width:11px;">&nbsp;</div></td>
												</tr>
												
												</cfloop>
												</cfoutput>
											</tbody>
											</table>
											<table class="width-100 table-hovered subtable" id="subtable#i#" style="border:0;margin:0;">
											<!--- <thead>
												<tr>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-40" style="border:0;">Unterseiten 2. Level</th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													
												</tr>
											</thead> --->
											<tbody>
												<cfoutput>
												<cfloop from="1" to="3" index="u">
												<tr>
													<td><div class="halflings icn-down"></div></td>
													<td><div class="halflings icn-up"></div></td>
													<td><div class="halflings icn-add"></div> &nbsp;&nbsp;Ein Titel</td>
													<td><div class="halflings icn-active"></div></td>
													<td><div class="halflings icn-edit"></div></td>
													<td><div class="halflings icn-del"></div></td>
													
												</tr>
												<tr>
													<td colspan="10" style="padding:0;">
														<div style="display:none;">
															<table class="width-100 table-hovered subtable" id="subtable#u#" style="border:0;margin:0;">
															<!--- <thead>
																<tr>
																	<th class="width-10" style="border:0;"></th>
																	<th class="width-10" style="border:0;"></th>
																	<th class="width-40" style="border:0;">Inhalte</th>
																	<th class="width-10" style="border:0;"></th>
																	<th class="width-10" style="border:0;"></th>
																	<th class="width-10" style="border:0;"></th>
																	
																	
																</tr>
															</thead> --->
															<tbody>
															
															</tbody>
															</table>
														</div>
													</td>
												</tr>
												</cfloop>
												</cfoutput>
											</tbody>
											</table>
										</div>
									</td>
								</tr>
								</cfloop>
								</cfoutput>
							</tbody>
						</table>
						<br/>
						<table class="width-100 table-bordered table-hovered">
							<thead>
								<tr>
									<th colspan="10">Themen Navigation</th>	
								</tr>
							</thead>
							<tbody>
								<cfoutput>
								<cfloop from="1" to="25" index="i">
								<tr>
									<td class="width-10"><div class="halflings icn-down"></div></td>
									<td class="width-10"><div class="halflings icn-up"></div></td>
									<td class="width-40">Ein Titel</td>
									<td class="width-10"><div class="halflings icn-active"></div></td>
									<td class="width-10"><div class="halflings icn-edit"></div></td>
									<td class="width-10"><div class="halflings icn-del"></div></td>
									<td class="width-10"><div class="halflings icn-add"></div></td>	
								</tr>
								<tr>
									<td colspan="10" style="padding:0;border:0;">
										<div style="display:none;" id="test">
											<table class="width-100 table-hovered subtable" id="subtable#i#" style="border:0;margin:0;">
											<thead>
												<tr>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-40" style="border:0;">Inhalte</th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													
												</tr>
											</thead>
											<tbody>
												<cfoutput>
												<cfloop from="1" to="2" index="u">
												<tr>
													<td><div class="halflings icn-down"></div></td>
													<td><div class="halflings icn-up"></div></td>
													<td>Ein Titel</td>
													<td><div class="halflings icn-active"></div></td>
													<td><div class="halflings icn-edit"></div></td>
													<td><div class="halflings icn-del"></div></td>
													<td><div style="width:11px;">&nbsp;</div></td>
												</tr>
												
												</cfloop>
												</cfoutput>
											</tbody>
											</table>
											<table class="width-100 table-hovered subtable" id="subtable#i#" style="border:0;margin:0;">
											<thead>
												<tr>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-40" style="border:0;">Unterseiten 2. Level</th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													<th class="width-10" style="border:0;"></th>
													
												</tr>
											</thead>
											<tbody>
												<cfoutput>
												<cfloop from="1" to="3" index="u">
												<tr>
													<td><div class="halflings icn-down"></div></td>
													<td><div class="halflings icn-up"></div></td>
													<td>Ein Titel</td>
													<td><div class="halflings icn-active"></div></td>
													<td><div class="halflings icn-edit"></div></td>
													<td><div class="halflings icn-del"></div></td>
													<td><div class="halflings icn-add"></div></td>
												</tr>
												
												</cfloop>
												</cfoutput>
											</tbody>
											</table>
										</div>
									</td>
								</tr>
								</cfloop>
								</cfoutput>
							</tbody>
						</table> --->
						
					</div>
					<div id="main-area" class="unit-70" style="height:100%;">
					
						
							
						<div id="height80" style="height:80%;overflow:hidden;">
							<form class="forms forms-columnar">
							
							<div id="tabHeader" style="height:60px;">
								<nav class="nav-tabs" data-toggle="tabs" data-height="equal" style="margin:20px;">
									<ul>
										<li><a href="#tab1" class="active">Inhalt</a></li>
										<li><a href="#tab2">Assoziationen</a></li>
										<li><a href="#tab3">Konfiguration</a></li>				
										
									</ul>
								</nav>
							</div>
							
							<div id="tabContent" style="overflow-y:auto;-webkit-overflow-scrolling:touch;position:relative;">
								
								
								
								<div id="tab1" style="margin:0 20px 20px 20px;">
									
									<form method="post" action="" class="forms forms-columnar" style="margin:0;">
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
										<p>
											<label>Name</label>
											<input type="text" name="user-name" class="width-100" />
										</p>
								</div>
								<div id="tab2" style="margin:20px;">
									Assoziationen
								</div>
								<div id="tab3" style="margin:20px;">
									Konfiguration
								</div>
							</div>
							<div id="tabFooter" style="height:70px;position:relative;">
								
								<div style="background-color:#eee;position:absolute;bottom:20px;right:20px;width:100px;height:30px;z-index:5;">
									<input type="submit" value="Senden" style="background:none;border:0;width:100%;height:100%;" />
								</div>
								<div style="background-color:#eee;position:absolute;bottom:20px;right:125px;width:100px;height:30px;z-index:5;">
									<input type="button" value="Abbrechen" style="background:none;border:0;width:100%;height:100%;" />
								</div>
								
								
							</div>
							
								
							</form>
						</div>
						<div style="height:20%;border-top:1px solid #999;">
							<div style="padding:20px;">
								Info-Area
							</div>
						</div>
					
					
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>

		
		
		<div id="sleepMode" style="display:none;color:white;text-align:center;">
			<h1>flx-CMS Sleep mode</h1>
			move your mouse to reactivate screen
		</div>
		
 	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
       	<script type="text/javascript" src="css/kube/js/kube.buttons.js"></script>
		<script type="text/javascript" src="css/kube/js/kube.tabs.js"></script>
	    <script type="text/javascript" src="js/list.js"></script>
		<script type="text/javascript" src="js/jquery-pageswipe/pageswipe/jquery.pageswipe.min.js"></script>
		<script type="text/javascript" src="plugins/jstree/jquery.jstree.js"></script>
        <script src="js/main.js"></script>
		
		<script>
					
			$(document).on('mousemove touchstart keyup',function(e){
				if($('#c').css('display')=='block'){
					window.clearTimeout(mrz);
					mrz = window.setTimeout("hideAndReactivate();",60000);
				}
				else{
					reactivate()
				}
			});
			
			
			
			function reactivate(){	
				if($('#loginPanelWrapper').css('display')=='none'){
					$('#loginPanelWrapper').fadeIn();
					$('body').css('background-image','url("images/bg.jpg")').fadeIn(1000,function(){
						$('#sleepMode').fadeOut();
						
					});
				}	
			}
			
			function hideAndReactivate(){
				$('#loginPanelWrapper').fadeOut(500,function(){
					$('body').fadeOut();
					$('#sleepMode').center();
					$('body').css('background-image','url("http://sport-ness.com/wp-content/uploads/2013/06/man-asleep-on-desk.jpg")').fadeIn(1000,function(){
						$('#sleepMode').fadeIn();
					});
					
				});
				reactivate();
			}
			
			// hide loginpanel after 1 min, and reactivate on mousemove
			var mrz = window.setTimeout("hideAndReactivate();",60000);
			
			function adjustLayout(){
				headerHeight = $('#header-bar').height();
				mobileheaderHeight = $('#mobile-header-bar').height();
				
				
				
				
				if($(window).width()<=768){
					winDiff = $(window).height()-mobileheaderHeight;
				}
				else{
					winDiff = $(window).height()-headerHeight;
				}
				$('#content-wrapper').height(parseInt(winDiff));
				
				tabheaderheight = $('#tabHeader').height();
				tabfooterheight = $('#tabFooter').height();
				tabcontentheight = 0;
				
				tabcontentheight = $('#height80').height()-(tabheaderheight+tabfooterheight);
				$('#tabContent').height(tabcontentheight);
			}
			
			$(document).ready(function(){
				adjustLayout();
				
				
				$("#nav").jstree({
						"plugins" : ["themes","html_data","ui"]
					});
				
				
				/*$('.icn-add').on('click',function(){
					
					//$('table>div','#nav-area').hide();
					
					nxt = $(this).parent().parent().next();
					state = $('div',nxt).css('display');
					prv = $(this).parent().parent();
					if(state=='none'){
						$('div',nxt).show();
						
						nxt.css('background-color','white');
					}
					else{
						$('div',nxt).hide();	
						
						nxt.css('background','none');
					}
				});*/

			});
			
			$(window).on('resize',function(){
				adjustLayout();
			});
			
			window.setTimeout('adjustLayout()',1000);
		</script>
      
        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
        <script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','UA-XXXXX-X');ga('send','pageview');
        </script>
    </body>
</html>
