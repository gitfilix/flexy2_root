<cfprocessingdirective pageencoding="utf-8" />

<!--- !! index TEMPLATE 3  (hellokitty)!--->

<cfhtmlhead text="
	<!--- <link rel='stylesheet' href='template3.css' /> --->
	<!--- <link  rel='stylesheet' type='text/css' href='css/template3.css'> --->
	<!--- <link rel='stylesheet' type='text/css' href='inc/template3/css/template3_fancy.css'> --->
	<script type='text/javascript' src='/#session.serverpath#/inc/template3/js/template3.js'></script>
">


<div class="main-wrapper" style="max-width:960px;margin:0 auto;border:1px solid grey;">
	<!--- just a red row --->
	<div class="bg_red">
	&nbsp;
	</div>
		<!--- Logo  --->
	<div class="row" style="border-bottom:#999 1.5px solid">
		<div class="sixth">
		
			<h1 style="padding-left:10px;">hi !</h1>
			<div class="forms" ><img src="/#session.serverpath#/upload/img/Felixcat1.jpg" style=" height:90px; width:90px; padding-left:10px; padding-bottom:0px; padding-top:5px;"> </img></div>
			<br>
		</div>
		<!--- 	service Navigation in HEADER --->
		<div class="twothird">
			<div class="topnav">
				<cfinclude template="inc/servicenav.cfm">
			</div>
		</div>
		<!--- 	Page title or teaser --->
		<div class="push-righ sixth topright">
			
			<cfset F_datum = Now()>
			 as Time goes by:<br>
			<cfoutput><font size="+1">#TimeFormat(F_datum, "hh:mm:ss")#</font></cfoutput>
					
		</div>
		<div class="push-right fourfifth big">
			<h1>you are here, thats nice!</h1>
		</div>
	</div>
<!--- container Nav & content start --->
<div class="Inhaltcontainer" >
	<div class="row">
		<div class="fifth" >
			<nav class="sidenav" >
				<cfinclude template="inc/themennav.cfm">
			</nav>
		</div>
	<!---  END of Subnav --->
	<!--- 	ontainer Content --->
	<!---  first row --->
		<div class="fourfifth" >
			 <cfinclude template="inc/content.cfm">
			</div>
	<!--- second row: for sidebar elements  --->
			<div class="row container">
				 <cfinclude template="inc/sidebars.cfm">
				<div class="third bg_red">
						<h2>hello kitty</h2>
						<br>
						<p>How to get the count of spaces before the string starts<br>
							How to get rid of last comma when generating a list?<br>
							How to access the object created by a cffile upload in coldfusion treiben die Richter die Regierung vor sich her. </p>
				</div>
				<div class="third bg_gray">
						<h2>hello kitty</h2>
						<br>
						<p>Lorem Ipsum In commodo tincidunt purus, ut bibendum elit suscipit et. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin risus </p>
					
				</div>
			</div>
				
		</div>	
	</div>

<div class="row footerrow">
 	<cfinclude template="inc/footer.cfm">
</div>




<!--- end of Wrapper --->

</div>


	<cfquery name="getTemplateNO"  datasource="#application.dsn#">
	SELECT *
	FROM  pages
	WHERE template = 3 AND isactive = 1 
	</cfquery>
	
</div>


