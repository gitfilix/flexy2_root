<!-- outer wrapper-->
<!--- <div id="outer-wrap"> --->
<cfinclude template="outerwrap.cfm">
<!-- inner wrapper-->
<div id="inner-wrap">
	<div class="units-row">
		<div class="unit-100 bg-gray2">
		 &nbsp;
		</div>
	</div>
	<div class="units-row">
		<div class="unit-25">
			<cfinclude template="logo.cfm">
		</div>
		<div class="unit-50">
			&nbsp;
		</div>
		<!--- service navigation --->
		<div class="unit-25 servicenav">
			<cfinclude template="servicenav.cfm">
		</div>
	</div>
	<div class="units-row">
		<div class="unit-100 line_cyan">
			&nbsp;
		</div>
	</div>
	<!--content starts here-->
	<div class="units-row">
		<div class="unit-75">
			<!--start gallery slider here-->
			<cfinclude template="content_big.cfm">
			<!--- <cfinclude template="content_flexslider.cfm">  --->
		</div>
		<div class="unit-25">
			<cfinclude template="text.cfm">
			
			<br />
			<cfinclude template="text_gal.cfm">
		</div>
	</div>
	<!--footer starts here-->
	<div class="units-row" id="no-margin">
		<footer class="footer">
			<cfinclude template="footer.cfm">
		</footer>
	</div>
<!--inner wrapper-->
</div>
<!--outer wrapper end-->
</div>