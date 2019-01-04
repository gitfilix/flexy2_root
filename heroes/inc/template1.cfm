<!--- INSERT HERE Mandant specific TEMPLATE --->
<!-- outer wrapper-->
<link href="../css/hero-style.css" rel="stylesheet" type="text/css">
<link href="../css/kube_f.css" rel="stylesheet" type="text/css">

<div id="outer-wrap"> 
<!-- inner wrapper-->
<div id="inner-wrap">
	<div class="units-row">
		<div class="unit-100">
			&nbsp;
		</div>
	</div>
	<!--start Service nav -->
	<div class="units-row">
		<div class="unit-66">
			<cfinclude template="logo.cfm">
		</div>
		<div class="unit-33 servicenav">
			<cfinclude template="servicenav.cfm">
		</div>
	</div>
	<!--start head logo and themen nav  -->
	<div class="units-row">
		<div class="unit-66">
			<!--- <cfinclude template="logo.cfm"> --->
		</div>
		<!--- service navigation --->
		<div class="unit-33 themennav">
			<cfinclude template="themennav.cfm">
		</div>
	</div>
	<div class="units-row">
		<div class="unit-100 ">
			&nbsp;
		</div>
	</div>
	<!---  NO subnavigation here  --->
	<div class="units-row">
		<div class="unit-100">
			&nbsp;
		</div>
	</div>
	<!--content starts here-->
	<div class="units-row">
		<!---  subnavigation here  --->
		<div class="unit-25">
			<cfif getsubnav.recordcount NEQ 0>
			<div class="subnav" style="padding-left:2em;">
				<cfinclude template="subnav.cfm">
			</div>	
			<cfelse>
				&nbsp;
			</cfif>
		</div>
		<div class="unit-50">
			<!--start content with gallery slider here-->
			<cfinclude template="content.cfm">
			<cfif pageProperties.showTeam EQ 1>
				<cfinclude template="team.cfm">
			</cfif>
		</div>
		<div class="unit-25">
			<cfinclude template="sidebars.cfm">	
		</div>
	</div>
	<!--footer starts here-->
	<div class="units-row">
		<footer class="footer">
			<cfinclude template="footer.cfm">
		</footer>
	</div>
<!--inner wrapper-->
</div>
<!--outer wrapper end-->
</div>