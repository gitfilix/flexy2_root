<cfprocessingdirective pageencoding="utf-8" />
<!--- index TEMPLATE 1 für PPP  --->

<cfhtmlhead text="
	<link rel='stylesheet' href='/#session.serverpath#/css/kube.css'>
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/css/template1.css' />
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/css/template1_mq.css' />
	<!--- Load Gliss - CSS  --->
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/css/glisse.css' />
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/css/glisse_app.css' />
	<!--- Load Gliss -javascript --->
	<script type='text/javascript' src='/#session.serverpath#/js/glisse.js'></script>
	<!--- Load Template-specific JS here  --->
	<script type='text/javascript' src='/#session.serverpath#/inc/template1/js/template1.js'></script>
	<!--- google lato font  --->
	<link href='http://fonts.googleapis.com/css?family=Lato:400,300,700' rel='stylesheet' type='text/css'>
">

<script>
function showCUGLogin(){
	formular = $('<div id="loginFormular" ><form action="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>" method="post"><table><tr><td>Benutzername</td><td><input type="text" name="cugusername"></td></tr><tr><td>Passwort</td><td><input type="password" name="cugpassword"></td></tr><tr><td>&nbsp;</td><td><button type="submit" value="anmelden">anmelden</button></td></tr></table></form></div>');
	$('.loginbutton').append(formular);
	if($('#loginFormular').css('display')=='block'){
		$('#loginFormular').fadeOut();	
	}
	else{
		$('#loginFormular').fadeIn();
	}
}
</script>
<script>
$(function () {
    $('.pics').glisse({
        changeSpeed: 450, 
        speed: 500,
        effect:'fadeBig',
        fullscreen: false
    }); 
});
</script>


<!--- open wrapper --->
<div class="main-wrapper">
	<!--- first header row --->
	<div class="row">
		<div class="login">
			<div class="loginbutton" style="position:relative;">
				<cfif session.cugLoggedIn EQ 0>
				<a href="javascript:void(0);" onclick="showCUGLogin();">Login</a>
				<cfelse>
				<cfoutput><a href="#cgi.SCRIPT_NAME#?id=#url.id#&cuglogoff=true">abmelden</a></cfoutput>
				</cfif>
			</div>
		</div>
	</div>
	<!--- 	still header /logo  --->
	<div class="row">
		<div class="third">
			&nbsp;
		</div>
		<div class="twothird">
			<div class="logo">
				<h1><span class="pp_name">pascal pazanda</span> <span class="pp_photo">photography</class></h1>
			</div>
		</div>
	</div>
	<!--- 	Service Nav right  --->
	<div class="row">
		<div class="third">
			&nbsp;
		</div>
		<div class="twothird">
			<nav class="servicenav">
				<cfinclude template="inc/servicenav.cfm">
			</nav>
		</div>
	</div>

	<!--- 	Subnav here  nav left  --->
	<div class="row row_line">
		<div class="twothird">
			<nav class="subnav">		
				<cfinclude template="inc/subnav.cfm">
			</nav>
		</div>
		<div class="third">
			&nbsp;
		</div>
	</div>

	<!--- 	content begins here --->
	<div class="row">
		<div class="fifth">
			
			<cfinclude template="inc/content_desc.cfm"> 
		
		</div>
		<div class="fourfifth">
			<div class="gallery_container">
				<cfinclude template="inc/content.cfm">
			</div>
		</div>
		
		
	</div>
	<!--- 	content ends here --->
	<!--- add teaser in bottom --->
	<div class="row">
		<div class="fifth">
			&nbsp;
		</div>
		<div class="fourfifth" class="sidebar_same_height">
			<cfinclude template="inc/sidebars_bottom.cfm">
		</div>
	</div>
	
	
	<!--- footer begin here  --->
	<div class="row container footerrow">	
			<cfinclude template="inc/footer.cfm">
	</div>
	<!--- footer ends here  --->


<!--- close wrapper --->
</div>
<!--- 
<script type="text/javascript">
	$(document).ready(function(){
	hgt = 0;	
		$('.teaserdown').each(function(){
			if($(this).height()>hgt){
				} hgt = $(this).height();
			});
			console.log(hgt);
		$('.teaserdown').height(hgt); 
		$('.teaserdown').css('padding-bottom','30px'); 
	});
</script> --->