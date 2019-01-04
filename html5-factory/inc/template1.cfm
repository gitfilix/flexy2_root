<!--outer wrap start-->
<div id="wrap-outer">
	<div id="app" class="nav-closed" >
		<nav id="left-navig"> 
			<div id="nav-wrapper">
				<div id="company">
					<h1>Webkanal</h1>
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
<!--close outer wrap-->
</div>