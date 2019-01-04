<!--outer wrap start-->
<div id="wrap-outer">
	<!-- content side on the right -->
	<div id="app" class="nav-closed" >
		<div id="main">
			<div style="padding-left:100px;">
				<div class="no-margin units-row" >
					<div class="unit-100">
						<div class="content">
							<cfinclude template="content-switch.cfm">
						</div>
					</div>
				</div>	
			</div>
		<!--close content -->
		</div>
	<!--close app-->
	</div>
	<nav id="left-navig" class="nav-closed"> 
		<div id="nav-wrapper">
			<div id="company">
				<cfinclude template="logo.cfm">
			</div>
			<nav id="nav-list">
				<cfinclude template="themennav.cfm">
			</nav>
			<cfinclude template="footer.cfm">
		</div>
		<div id="graybar">
			<!-- imporant for jquerry-->
			<cfinclude template="greybar.cfm">
		</div>
	</nav>
<!--close outer wrap-->
</div>