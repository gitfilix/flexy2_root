<!--- INSERT HERE Mandant specific TEMPLATE --->
<div id="outer-wrapper">
	<div class="units-row">
		<div class="unit-100" >
		&nbsp;
		</div>
	</div>
	<div class="units-row ">
		<div class="unit-70 ">
			<div class="logo">
				<cfinclude template="logo.cfm">
			</div>
		</div>
		<div class="unit-30">
			<div id="top-right">
			 <nav class="servicenav">
				<cfinclude template="servicenav.cfm">
			 </nav>
			</div>
		</div>
	</div>
	<div class="units-row">
		<div class="unit-100">
			<div class="accordion">
				<!--start acordeon blog with themennav content: content_blog includes themennav-->
				<cfif url.id eq session.startid>
					<cfinclude template="content_blog.cfm">
				</cfif>	
				<!--else start service Nav content without acordeon-->
				<cfinclude template="content_servicenav.cfm"> 
			</div>
		</div>
	</div>
	<div class="units-row">
		<div class="unit-100 footer">
			<cfinclude template="footer.cfm">
		</div>
	</div>
<!--close outer wrapper-->
</div>