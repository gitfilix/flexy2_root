<!--- INSERT HERE Mandant specific TEMPLATE --->
<!-- outer wrapper-->
<div id="outer-wrap"> 
<!-- inner wrapper-->
<div id="inner-wrap">
	<div class="units-row">
		<div class="unit-100">
			<cfinclude template="logo.cfm">
		</div>
	</div>
	<!--start Service nav -->
	<div class="units-row">
		<div class="unit-100 tschaga-display ">
			&nbsp;
			<cfinclude template="tschagga-special.cfm">
		</div>
	</div>
	<!--content starts here-->
	<div class="units-row">
		<div class="unit-75">
			<!--start content Content & Team views here -->
			<cfinclude template="content.cfm">
			<cfif pageProperties.showTeam EQ 1>
				<cfinclude template="team.cfm">
			</cfif>
		</div>
		<div class="unit-25">
		<!--start Service nav -->
			<div class="servicenav verticalline">
				<cfinclude template="servicenav.cfm">
			</div>
		<!--start Teasers bars below -->
			<br />
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