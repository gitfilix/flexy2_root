<cfprocessingdirective pageencoding="utf-8" />

<cfquery name="wartungsCheck" datasource="#application.dsn#">
SELECT	*
FROM	maintainance
WHERE 	id = 1
</cfquery>

<cfquery name="mandantenfunktionsfreigaben" datasource="#application.dsn#" result="returnQuery">
SELECT 	* 
FROM 	mandantenfunktionsfreigaben
WHERE	mandant = '#session.mandant#'
</cfquery>
<cfloop list="#returnQuery.columnlist#" index="i">
	<cfif evaluate('mandantenfunktionsfreigaben.' & i) EQ 1>
		<cfset "#i#" = true />
	<cfelse>
		<cfset "#i#" = false />
	</cfif>
</cfloop>

<cfif session.module NEQ "inc_welcome">
	<cfquery name="feldfreigaben" datasource="#application.dsn#" result="returnQuery">
	SELECT 	* 
	FROM 	mandantenfeldfreigaben
	WHERE	<!--- mandant = '#session.mandant#' AND --->
			moduleID = #session.moduleid#
	</cfquery>
<cfelse>
	<cfif session.admin EQ 1>
		<cfquery name="getLoggedInUsers" datasource="#application.dsn#">
		SELECT 	* 
		FROM 	userLoggedIn
		</cfquery>
	</cfif>
</cfif>

<cfif session.loggedIn EQ false>

	<!DOCTYPE html>
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Internet Dreams</title>
	<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen" title="default" />
	<!--  jquery core -->
	<script src="js/jquery/jquery-1.4.1.min.js" type="text/javascript"></script>
	
	<!-- Custom jquery scripts -->
	<script src="js/jquery/custom_jquery.js" type="text/javascript"></script>
	
	<!-- MUST BE THE LAST SCRIPT IN <HEAD></HEAD></HEAD> png fix -->
	<script src="js/jquery/jquery.pngFix.pack.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function(){
	$(document).pngFix( );
	});
	</script>
	</head>
	<body id="login-bg"> 
	 
	<!-- Start: login-holder -->
	<div id="login-holder">
	
		<!-- start logo -->
		<div id="logo-login">
			<a href="index.html"><img src="images/shared/logo.png" width="156" height="40" alt="" /></a>
		</div>
		<!-- end logo -->
		
		<div class="clear"></div>
		
		<!--  start loginbox ................................................................................. -->
		<div id="loginbox">
		
		<!--  start login-inner -->
		<div id="login-inner">
			
			<!---wenn username und pw defined ist, und sessionvariable false ist -> fehlermeldung werfen--->
			<cfif isdefined("form.username") AND isdefined("form.password") AND session.loggedIn EQ false>
				Versuch fehlgeschlagen. versuchen Sie es erneut.
			</cfif>
			
			<cfif wartungscheck.maintainance EQ 1 AND NOT isdefined("url.admin")>
				<div style="background-color:red;color:white;font-weight:bold;padding:1.5em;width:50%;margin-bottom:1.5em;">
					Im Moment sind Wartungsarbeiten im Gange.<br/>Login leider nicht möglich!
				</div>
			<cfelseif (wartungscheck.maintainance EQ 1 AND isdefined("url.admin")) OR wartungscheck.maintainance EQ 0>
				<!---login -form:--->
				<cfoutput>
				<form action="#cgi.SCRIPT_NAME#<cfif isdefined('url.admin')>?admin</cfif>" method="post" id="login">
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>Benutzername</th>
					<td><input type="text"  class="login-inp" name="username" /></td>
				</tr>
				<tr>
					<th>Passwort</th>
					<td><input type="password" value="************"  onfocus="this.value='';" class="login-inp" name="password" /></td>
				</tr>
				<tr>
					<th></th>
					<td valign="top"><input type="checkbox" class="checkbox-size" id="login-check" /><label for="login-check">eingeloggt bleiben</label></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="button" class="submit-login" onclick="$('##login').submit();"  /></td>
				</tr>
				</table>
				</form>
				</cfoutput>
			</cfif>
	
		</div>
		<!--  end login-inner -->
		<div class="clear"></div>
		<a href="" class="forgot-pwd">Passwort vergessen?</a>
	 </div>
	 <!--  end loginbox -->
	 
		<!--  start forgotbox ................................................................................... -->
		<div id="forgotbox">
			<div id="forgotbox-text">Wir senden Ihnen das Passwort auf untenstehende E-Mail Adresse</div>
			<!--  start forgot-inner -->
			<div id="forgot-inner">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>E-mail Adresse:</th>
				<td><input type="text" value=""   class="login-inp" /></td>
			</tr>
			<tr>
				<th> </th>
				<td><input type="button" class="submit-login"  /></td>
			</tr>
			</table>
			</div>
			<!--  end forgot-inner -->
			<div class="clear"></div>
			<a href="" class="back-login">zurück zum Login</a>
		</div>
		<!--  end forgotbox -->
	
	</div>
	<!-- End: login-holder -->
	</body>
	</html>

<cfelse>

	<!DOCTYPE html>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Flxy-CMS</title>
	<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen" title="default" />
	<!--[if IE]>
	<link rel="stylesheet" media="all" type="text/css" href="css/pro_dropline_ie.css" />
	<![endif]-->
	
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/start/jquery-ui.css" type="text/css" rel="Stylesheet" />
	<link rel='stylesheet' href='/admin/js/jquery.fancybox-1.3.4/fancybox/jquery.fancybox-1.3.4.css' type='text/css'>
	<link rel="shortcut icon" type="image/x-icon" href="fav.ico">
	<link rel="shortcut icon" type="image/png" href="fav.png">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/admin/js/jquery.fancybox-1.3.4/fancybox/jquery.fancybox-1.3.4.js"></script>
	<script type="text/javascript" src="/admin/js/cfSessionTimeout.js"></script>
	<script src="js/jquery/ui.checkbox.js" type="text/javascript"></script>
	<script src="js/jquery/jquery.bind.js" type="text/javascript"></script>
	<script type="text/javascript" src="/admin/js/scripts.js"></script>
	
	<cfif isdefined("url.alreadyLoggedIn") AND session.loggedIn EQ false AND not isdefined("url.admin")>
		<script>
			function closeBox(){
				$.fancybox.close();
				window.clearTimeout(m);
			}
			
			$(document).ready(function(){
				$.fancybox({
					content: 'Es ist bereits ein Benutzer mit denselben Angaben am System angemeldet.',
					onClosed: function(){
						window.clearTimeout(t);
						window.clearTimeout(m);
					},
					onComplete: function(){
						 m = setTimeout('closeBox()',5000);
					}
				});
			});
		</script>
	</cfif>
	
	<cfif session.loggedIn EQ true>
		<cfset d = ((application.timeout*60000)-60000) />
		<cfset w = 4 />
		
		<!--- message listener --->
		<script>
			var t=setTimeout('checkForMessage()',20000)
			
			function closeBox(){
				$.fancybox.close();
				window.clearTimeout(m);
			}
			
			function checkForMessage(){
				$.get('/admin/inc/ajax_checkMessage.cfm',{},function(data){
					if(data!=''){
						$.fancybox({
							content: data,
							onClosed: function(){
								 window.clearTimeout(t);
								 window.clearTimeout(m);
							},
							onComplete: function(){
								 m = setTimeout('closeBox()',10000);	
							}
						});
					}
				});	
			}
	
			var l=setTimeout('informUserOfSessionTimeout()',<cfoutput>#d#</cfoutput>);
				
			function informUserOfSessionTimeout(){
				$.fancybox({
					content: 'Ihre Session läuft in ca. 1 Minute ab. Bitte speichern Sie Ihre getätigten Eingaben, ansonsten Sie automatisch abgemeldet werden und die Mutationen verloren gehen.',
					onComplete: function(){	
						//$("#fancybox-wrap, #fancybox-overlay").delay(5000).fadeOut(); 	
						m = setTimeout('closeBox()',8000);	
						}
				});	
				window.clearTimeout(l);
			}
			$(document).ready(function() {	
				$('span#timeout').sessionTimeout({
					warningTime: <cfoutput>#w#</cfoutput>, // seconds
					onWarning: function(){
						$.fancybox({
							content: 'Sie werden in wenigen Augenblicken ausgeloggt!',
							showCloseButton: false,
							hideOnOverlayClick: false
						});	
					},
					onExpire: function(){
						location.href='/admin/?logout=true';	
					}
				});
			});
		</script>
	</cfif>
	
	<script type="text/javascript">
	$(function(){
		$('input').checkBox();
		$('#toggle-all').click(function(){
		$('#toggle-all').toggleClass('toggle-checked');
		$('#mainform input[type=checkbox]').checkBox('toggle');
		return false;
		});
	});
	</script>  
	
	<![if !IE 7]>
	
	<!--  styled select box script version 1 -->
	<script src="js/jquery/jquery.selectbox-0.5.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$('.styledselect').selectbox({ inputClass: "selectbox_styled" });
	});
	</script>
	 
	
	<![endif]>
	
	<!--  styled select box script version 2 --> 
	<script src="js/jquery/jquery.selectbox-0.5_style_2.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$('.styledselect_form_1').selectbox({ inputClass: "styledselect_form_1" });
		$('.styledselect_form_2').selectbox({ inputClass: "styledselect_form_2" });
	});
	</script>
	
	<!--  styled select box script version 3 --> 
	<script src="js/jquery/jquery.selectbox-0.5_style_2.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$('.styledselect_pages').selectbox({ inputClass: "styledselect_pages" });
	});
	</script>
	
	<!--  styled file upload script --> 
	<script src="js/jquery/jquery.filestyle.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8">
	  $(function() {
		  $("input.file_1").filestyle({ 
			  image: "images/forms/choose-file.gif",
			  imageheight : 21,
			  imagewidth : 78,
			  width : 310
		  });
	  });
	</script>
	
	<!-- Custom jquery scripts -->
	<script src="js/jquery/custom_jquery.js" type="text/javascript"></script>
	 
	<!-- Tooltips -->
	<script src="js/jquery/jquery.tooltip.js" type="text/javascript"></script>
	<script src="js/jquery/jquery.dimensions.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(function() {
		$('a.info-tooltip ').tooltip({
			track: true,
			delay: 0,
			fixPNG: true, 
			showURL: false,
			showBody: " - ",
			top: -35,
			left: 5
		});
	});
	</script> 
	
	
	<!--  date picker script -->
	<link rel="stylesheet" href="css/datePicker.css" type="text/css" />
	<script src="js/jquery/date.js" type="text/javascript"></script>
	<script src="js/jquery/jquery.datePicker.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8">
			$(function()
	{
	
	// initialise the "Select date" link
	$('#date-pick')
		.datePicker(
			// associate the link with a date picker
			{
				createButton:false,
				startDate:'01/01/2005',
				endDate:'31/12/2020'
			}
		).bind(
			// when the link is clicked display the date picker
			'click',
			function()
			{
				updateSelects($(this).dpGetSelected()[0]);
				$(this).dpDisplay();
				return false;
			}
		).bind(
			// when a date is selected update the SELECTs
			'dateSelected',
			function(e, selectedDate, $td, state)
			{
				updateSelects(selectedDate);
			}
		).bind(
			'dpClosed',
			function(e, selected)
			{
				updateSelects(selected[0]);
			}
		);
		
	var updateSelects = function (selectedDate)
	{
		var selectedDate = new Date(selectedDate);
		$('#d option[value=' + selectedDate.getDate() + ']').attr('selected', 'selected');
		$('#m option[value=' + (selectedDate.getMonth()+1) + ']').attr('selected', 'selected');
		$('#y option[value=' + (selectedDate.getFullYear()) + ']').attr('selected', 'selected');
	}
	// listen for when the selects are changed and update the picker
	$('#d, #m, #y')
		.bind(
			'change',
			function()
			{
				var d = new Date(
							$('#y').val(),
							$('#m').val()-1,
							$('#d').val()
						);
				$('#date-pick').dpSetSelected(d.asString());
			}
		);
	
	// default the position of the selects to today
	var today = new Date();
	updateSelects(today.getTime());
	
	// and update the datePicker to reflect it...
	$('#d').trigger('change');
	});
	</script>
	
	<!-- MUST BE THE LAST SCRIPT IN <HEAD></HEAD></HEAD> png fix -->
	<script src="js/jquery/jquery.pngFix.pack.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function(){
	$(document).pngFix( );
	});
	</script>
	</head>
	<body> 
	<!-- Start: page-top-outer -->
	<div id="page-top-outer">    
	
	<!-- Start: page-top -->
	<div id="page-top">
	
		<!-- start logo -->
		<div id="logo">
		<a href=""><img src="images/shared/logo.png" width="156" height="40" alt="" /></a>
		</div>
		<!-- end logo -->
		
		<!--  start top-search -->
		<div id="top-search">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
			<td><button style="border:0;background:none;color:white;">Session Timeout in <span id="timeout"></span> Minuten&nbsp;&nbsp;</button></td>
			<td><input type="text" value="Search" onblur="if (this.value=='') { this.value='Search'; }" onfocus="if (this.value=='Search') { this.value=''; }" class="top-search-inp" /></td>
			<td>
			<select  class="styledselect">
				<option value=""> All</option>
				<option value=""> Products</option>
				<option value=""> Categories</option>
				<option value="">Clients</option>
				<option value="">News</option>
			</select> 
			</td>
			<td>
			<input type="image" src="images/shared/top_search_btn.gif"  />
			</td>
			
			<td style="padding-left:10px;">
			<cfquery name="getLangs" datasource="#application.dsn#">
			SELECT	*
			FROM	mandantensprachen
			WHERE	mandant = #session.mandant#
			</cfquery>
			<cfif getLangs.recordcount GT 1>
				<select  class="styledselect" onchange="location.href='#cgi.SCRIPT_NAME#?lang='+$(this).val();">
					<cfoutput query="getLangs">
						<option value="#languageParam#" <cfif languageParam EQ session.lang>selected="selected"</cfif>>
							#language#
						</option>
					</cfoutput>
				</select>
			</cfif>
			
			</td>
			
			</tr>
			</table>
		</div>
		<!--  end top-search -->
		<div class="clear"></div>
	
	</div>
	<!-- End: page-top -->
	
	</div>
	<!-- End: page-top-outer -->
		
	<div class="clear">&nbsp;</div>
	 
	<!--  start nav-outer-repeat................................................................................................. START -->
	<div class="nav-outer-repeat"> 
	<!--  start nav-outer -->
	<div class="nav-outer"> 
	
			<!-- start nav-right -->
			<div id="nav-right">
			
				<div class="nav-divider">&nbsp;</div>
				<cfif session.admin EQ 1><div class="showhide-account"><img src="images/shared/nav/nav_myaccount.gif" width="93" height="14" alt="" /></div>
				<div class="nav-divider">&nbsp;</div></cfif>
				<cfif session.loggedIn EQ true>
				<a href="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>?logout=true" id="logout"><img src="images/shared/nav/nav_logout.gif" width="64" height="14" alt="" /></a></cfif>
				<div class="clear">&nbsp;</div>
				<cfif session.admin EQ 1>
				<!--  start account-content -->	
				<div class="account-content">
				<div class="account-drop-inner">
					<a href="" id="acc-settings">Settings</a>
					<div class="clear">&nbsp;</div>
					<div class="acc-line">&nbsp;</div>
					<a href="" id="acc-details">Personal details </a>
					<div class="clear">&nbsp;</div>
					<div class="acc-line">&nbsp;</div>
					<a href="" id="acc-project">Project details</a>
					<div class="clear">&nbsp;</div>
					<div class="acc-line">&nbsp;</div>
					<a href="" id="acc-inbox">Inbox</a>
					<div class="clear">&nbsp;</div>
					<div class="acc-line">&nbsp;</div>
					<a href="" id="acc-stats">Statistics</a> 
				</div>
				</div>
				</cfif>
				<!--  end account-content -->
			
			</div>
			<!-- end nav-right -->
	
	
			<!--  start nav -->
			<div class="nav">
			<div class="table">
			
			<ul class="select"><li><a href="#nogo"><b>Startseite / Dashboard</b><!--[if IE 7]><!--></a><!--<![endif]-->
			<!--[if lte IE 6]><table><tr><td><![endif]-->
			</a>
			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
			</ul>
			
			<div class="nav-divider">&nbsp;</div>
			
			<cfoutput>
			<cfloop list="#session.moduleList#" index="i">
			<cfquery name="getModules" datasource="#application.dsn#">
			SELECT	*
			FROM	modules
			WHERE	id = #i#
			</cfquery>
			<cfif (getModules.variable EQ "mandantenmanagement" AND session.admin EQ 1) OR getModules.variable NEQ "mandantenmanagement">
			
			<ul class="select"><li><a href="#cgi.SCRIPT_NAME#?module=inc_#getModules.variable#"><b>#getModules.module#</b><!--[if IE 7]><!--></a><!--<![endif]-->
			<!--[if lte IE 6]><table><tr><td><![endif]-->
			</a>
			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
			</ul>
			
			<div class="nav-divider">&nbsp;</div>
			</cfif>
			</cfloop>
			</cfoutput>
			
			<div class="clear"></div>
			</div>
			<div class="clear"></div>
			</div>
			<!--  start nav -->
	
	</div>
	<div class="clear"></div>
	<!--  start nav-outer -->
	</div>
	<!--  start nav-outer-repeat................................................... END -->
	
	  <div class="clear"></div>
	 
	<!-- start content-outer ........................................................................................................................START -->
	<div id="content-outer">
	<!-- start content -->
	<div id="content">
		<cfinclude template="/_cms/inc/#session.module#.cfm">
	</div>
	<!--  end content -->
	<div class="clear">&nbsp;</div>
	</div>
	<!--  end content-outer........................................................END -->
	
	<div class="clear">&nbsp;</div>
		
	<!-- start footer -->         
	<div id="footer">
	<!-- <div id="footer-pad">&nbsp;</div> -->
		<!--  start footer-left -->
		<div id="footer-left">
			Admin Skin &copy; Internet Dreams Ltd. <a href="">www.netdreams.co.uk</a>. All rights reserved.<br/>
			&copy; 2013 web-kanal.ch
		</div>
		<!--  end footer-left -->
		<div class="clear">&nbsp;</div>
	</div>
	<!-- end footer -->
	 
	</body>
	</html>
	
</cfif>
