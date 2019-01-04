<cfprocessingdirective pageencoding="utf-8" />

<cffunction name="rpHash" access="public" returntype="string" output="false">
   <cfargument name="capText" type="string" required="true" />
		
   <cfset var theHash = 5381 />
   <cfset var theValue = UCase(ARGUMENTS.capText) />

   <cfloop from="1" to="#Len(Trim(theValue))#" index="i">
      <cfset theHash = (bitSHLN(theHash,5) + theHash) + Asc(Mid(theValue,i,1)) />
   </cfloop>
		
   <cfreturn theHash />
</cffunction>

<cfset un = "mies" />
<cfset pw = "mies" />
<cfset em = "info@reziprok.ch" />
<cfparam name="session.count" default="0" />
<cfparam name="session.captcha" default="0" />

<cfif isdefined("url.checkSessionCount")>
	<cfoutput>#session.count#</cfoutput>
	<cfabort>
</cfif>

<cfif isdefined("form.login_un") AND isdefined("form.login_pw") AND isdefined("url.checkLogin")>
	
	
	<cfif form.login_un NEQ un OR form.login_pw NEQ pw>
		0
		<cfset session.count = session.count + 1 />
		
	<cfelseif rpHash(FORM.antispam) EQ FORM.undefinedHash>
		1
		<cfset session.count = 0 />
		<cfset session.captcha = 0 />	
	<cfelse>
		<cfoutput>0</cfoutput>
	</cfif>
	
	<cfif session.count GT 2>
		<cfset session.count = 3 />
		<cfset session.captcha = 1 />	
	</cfif>
	
	<cfabort>
</cfif>

<cfif isdefined("form.login_email") AND isdefined("url.checkRequestPassword")>
	<cfif form.login_email NEQ em>
		0
		<cfabort>
	<cfelse>
		1
		<cfabort>
	</cfif>
</cfif>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Login admin panel</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <link rel="stylesheet" href="css/reset.css">
        <link rel="stylesheet" href="css/login.css">
		<link rel="stylesheet" href="css/animate.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.realperson.css"> 
        <script src="js/modernizr.js"></script> 
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
		
		<noscript>
			 <div id="loginPanelWrapper">
			 	<span class="logo">
					<img src="/webdesign/img/logo-f32.png" alt="" style="width:20px;" align="absmiddle" /> &nbsp;&nbsp;web-kanal admin panel
				</span>
				<div id="loginPanel">
					Ihr Browser unetrstützt kein Javascript oder es wurde im Browser deaktiviert.<br/><br/>
					<strong>Ohne Javascript funktioniert diese Applikation leider nicht.</strong>
				</div>
			 </div>
		</noscript>

		
       <div id="loginPanelWrapper" class="hide animated bounceInLeft">
			<span class="logo">
				<img src="/webdesign/img/logo-f32.png" alt="" style="width:20px;" align="absmiddle" /> &nbsp;&nbsp;<a href="">web-kanal admin panel</a>
			</span>
			<span class="info">
				<strong>
					<a href="">?</a>
				</strong>
			</span>
			<div id="loginPanel">
				<form id="loginFormWrapper" name="loginFormWrapper" action="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>" method="post">
					<div class="switch" <cfif isdefined("form.submitType") AND form.submitType EQ "rp">style="display:none;"</cfif> id="loginForm">
						<table>
					
							<tr>
								<td class="label">Username*:</td>
								<td>
									<input type="text" name="" id="login_un" class="required" />
								</td>
							</tr>
							<tr>
								<td class="label">Password*:</td>
								<td>
									<input type="password" name="" id="login_pw" class="required" />
								</td>
							</tr>
							<tr id="captcha" <cfif session.captcha EQ 0>style="display:none;"</cfif>>
								<td class="label"><div id="123"></div></td> 
								<td>
									<input type="text" name="" id="antispam" class="required" />
								</td>
							</tr>
							<tr>
								<td class="label">
									Keep login 
								</td>
								<td>
									<input type="checkbox" name="" id="login_keep" /> 
									<input type="submit" name="" id="btnSubmit" value="login" style="float:right;"  />
								</td>
							</tr>
							<!--- <tr>
								
								<td colspan="2">
									<input type="submit" name="" id="btnSubmit" value="login" />
								</td>
							</tr> --->
						
						</table>
					</div>
				
					<div class="switch" id="forgetPassword"  <cfif isdefined("form.submitType") AND form.submitType EQ "rp">style="display:block;"</cfif>>
						
							<table <cfif isdefined("form.submitType")>style="display:none;"</cfif>>
						
								<tr>
									<td class="label">Your E-Mail*:</td>
									<td>
										<input type="text" name="" id="login_email" class="required" />
									</td>
								</tr>
								<tr>
									
									<td colspan="2">
										<input type="submit" name="" id="btnRequestPassword" value="send" style="float:right;" />
									</td>
								</tr>
							
							</table>
						
						<div id="requestAnswer" <cfif NOT isdefined("form.submitType")>style="display:none;"</cfif>>
							Your password will be sent to your e-mail within minutes.
						</div>
					</div>
					
					
					
					<input type="hidden" name="submitType" id="submitType" value="" />
				</form>
				<div id="panelFooter">
					<a href="" id="panelSwitcher">
						<cfif isdefined("form.submitType") AND form.submitType EQ "rp">
							back to loginform					
						<cfelse>
							forgot password?
						</cfif>
					</a>
				</div>
				<div id="message">
					<!--- <strong>Information</strong>:<br/> --->
					<span></span>
				</div>
			</div>	
			<div id="infopanel">
				<h1 style="margin:0;">Version 0.9 BETA</h1><br/>
				<strong>flxy-CMS</strong><br/>
				Flx like to thanks to all contributers, who made this possible.	Be a pirate! But be fair!
			</div>
			<!--- <div id="footer">
				flxy-CMS &copy; 2013 | <a href="" style="color:cyan;">www.web-kanal.ch</a>
			</div> --->
		</div>
		
		<div id="sleepMode" style="display:none;color:white;text-align:center;">
			<h1>flx-CMS Sleep mode</h1>
			move your mouse to reactivate screen
		</div>
		

       	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
       <!---  <script src="plugins/plugins.js"></script> --->
	    <script type="text/javascript" src="js/jquery.realperson.js"></script>
        <script src="js/main.js"></script>
		
		<script>
			$(window).on('resize',function(){
				$('#loginPanelWrapper').center();	
			});
			
			$(document).on('mousemove touchstart keyup',function(){
				if($('#loginPanelWrapper').css('display')=='block'){
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
			
			function showCaptcha(){
				$('#captcha').show();	
				$('#captcha input').val('');	
				$('#captcha div').html('');	
				$('#captcha div').realperson({length: 3});	
				$('#message').show().delay(3000).fadeOut();
				$('#message span').html('Too many attempts. Provide captcha code');
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
			
			$(document).ready(function(){
				$('#login_pw').val('');
				$('#login_un').val('');
				$('#loginPanelWrapper').center();
				$('.hide').show();
				window.setTimeout("$('#loginPanelWrapper').removeClass('animated');$('#loginPanelWrapper').removeClass('bounceInLeft');$('#login_un').focus();",1000)
				<cfif isdefined("form.submitType")>
					<cfoutput>
						<cfif form.submitType EQ "lg">
							alert('#form.submitType#. You will be redirected to the Startscreen of the admin panel')
						</cfif>
					</cfoutput>
				</cfif>
				<cfif session.captcha EQ 1>
					showCaptcha();
				</cfif>
				
				$('#panelSwitcher').on('click',function(e){
					e.preventDefault();
					$('input').removeClass('error-required')
					$('#message').hide()	
					if($('#loginForm').css('display')=='block'){
						$('#loginForm').hide();
						$('#login_un').val('');
						$('#login_pw').val('');
						$('#forgetPassword').show();	
						$('#login_email').focus();
						$('#panelSwitcher').text('back to loginform');	
					}
					else{
						$('#loginForm').show();
						$('#login_un').focus();
						$('#forgetPassword').hide();	
						$('#login_email').val('');
						$('#requestAnswer').hide();
						$('#forgetPassword table').show();
						$('#panelSwitcher').text('forgot password? ');	
						$('#email').val('');
					}
				});
				
				$('.info').on('click',function(e){
					e.preventDefault();
					$('input').removeClass('error-required')
					$('#message').hide()
					$('#loginPanel').hide();
					$('#infopanel').show();		
					$('#loginForm').show();
					$('#forgetPassword').hide();
					$('.logo').css({
						'background-color':'#999999',
						'z-index': 0
					});
					$('.info').css({
						'background-color':'#C0C0C0',
						'z-index': 1
					});
				});
				
				$('.logo').on('click',function(e){
					e.preventDefault();
					$('input').removeClass('error-required')
					$('#message').hide()
					$('#loginPanel').show();
					$('#infopanel').hide();
					$('#login_un').focus();
					$('.logo').css({
						'background-color':'#C0C0C0',
						'z-index': 1
					});
					$('.info').css({
						'background-color':'#999999',
						'z-index': 0
					});
					$('.info').css('background-color','#999999')		
				});
				
				$('#loginFormWrapper').on('submit',function(e){
					// validate loginform
					if($('#loginForm').css('display')=='block'){
						$('#loginPanelWrapper').removeClass('animated')	
						$('#loginPanelWrapper').removeClass('shake')	
						$('input').removeClass('error-required')		
						if($('#login_un').val()=='' || $('#login_pw').val()==''){
							
							$('#loginPanelWrapper').addClass('animated shake')	
							
							if($('#login_un').val()==''){
								$('#login_un').addClass('error-required');
							}
							if($('#login_pw').val()==''){
								$('#login_pw').addClass('error-required');
							}
							
							$('#login_pw').val('');
							$('#login_un').val('');
							
							$('#message').show().delay(1500).fadeOut();
							$('#message span').html('Please provide login data');
							$('#login_un').focus();
							$('#loginPanelWrapper').center();
							
							window.setTimeout("$('#loginPanelWrapper').removeClass('animated');$('#loginPanelWrapper').removeClass('shake');$('#loginPanelWrapper').center();",2100)
							return false;
						}
						// send form
						else{
							$('#submitType').val('lg');
							$.post('<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>?checkLogin=1',{
								login_un: $('#login_un').val(),
								login_pw: $('#login_pw').val(),
								antispam: $('#antispam').val(),
								undefinedHash: $('input.realperson-hash').val()
								},function(data){
								
								var cnt = 0;
								$.get('<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>',{'checkSessionCount':1},function(data2){
									cnt = parseInt(data2);
								
								
									if(data.indexOf('1')>-1){
										$('#loginPanelWrapper').addClass('animated bounceOutRight');
										window.setTimeout("$('<div/>', {id: 'fader',style: 'width:100%;height:100%;background-color:white;position:absolute;top:0;left:0;z-index:3;display:none;'}).appendTo('body').fadeIn(300,function(){location.href='/_cms/template/index.cfm'});",1000)		
									}
									else{
										$('#loginPanelWrapper').addClass('animated shake')	
										
										if($('#login_un').val()==''){
											$('#login_un').addClass('error-required');
										}
										if($('#login_pw').val()==''){
											$('#login_pw').addClass('error-required');
										}
										$('#login_pw').val('');
										$('#login_un').val('');
										$('#antispam').val('');
										$('#message span').html('Wrong login data');
										
										delai = 1500;
									
										if(cnt == 3){
											showCaptcha();
											$('#message span').append('<br/>Wrong captcha code.');
											delai = 3000 
										}
										
										$('#message').show().delay(delai).fadeOut();
										$('#login_un').focus();
										$('#loginPanelWrapper').center();
										window.setTimeout("$('#loginPanelWrapper').removeClass('animated');$('#loginPanelWrapper').removeClass('shake');$('#loginPanelWrapper').center();",2100)
									}
								
								});
								
							})
							return false;
						}
					}
					// validate request pw form
					else{
						$('#loginPanelWrapper').removeClass('animated')	
						$('#loginPanelWrapper').removeClass('shake')	
						$('input').removeClass('error-required')	
						if($('#login_email').val()=='' || validateEmail($('#login_email').val())==false){
							$('#loginPanelWrapper').addClass('animated shake')
							$('#login_email').addClass('error-required');
							$('#message').show().delay(1500).fadeOut();
							$('#message span').html('Please provide an E-Mail address');
							$('#login_email').focus();
							$('#loginPanelWrapper').center();
							window.setTimeout("$('#loginPanelWrapper').removeClass('animated');$('#loginPanelWrapper').removeClass('shake');$('#loginPanelWrapper').center();",2100)
							return false;
						}
						else{
							$('#submitType').val('rp');	
							$.post('<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>?checkRequestPassword=1',{
								login_email: $('#login_email').val()
								},function(data){
								if(data.indexOf('1')>-1){
									alert('success');	
								}
								else{
									$('#loginPanelWrapper').addClass('animated shake')	
									$('#login_email').addClass('error-required');
									$('#message').show().delay(1500).fadeOut();
									$('#message span').html('No such user');
									$('#login_email').focus();
									$('#loginPanelWrapper').center();
									window.setTimeout("$('#loginPanelWrapper').removeClass('animated');$('#loginPanelWrapper').removeClass('shake');$('#login_email').val('');$('#loginPanelWrapper').center();",2100)
								}
								
							})
							return false;
						}
						
					}
				});
				
				$('.required').on('keyup',function(e){
					if($(this).attr('id')=='login_email'){
						if($(this).val()=='' || validateEmail($('#login_email').val())==false){
							$(this).addClass('error-required');
						}
						else{
							$(this).removeClass('error-required');
						}	
					}
					else{
						if($(this).val()==''){
							$(this).addClass('error-required');
						}
						else{
							$(this).removeClass('error-required');
						}	
					}
					
				});
			})
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
