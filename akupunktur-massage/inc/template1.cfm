<cfprocessingdirective pageencoding="utf-8" />
<!-- outer wrapper-->
<div id="outer-wrap">
	<!-- inner wrapper-->
	<div id="inner-wrap">
		<div class="units-row">
			<div class="unit-100">
				&nbsp;
			</div>
		</div>
		<div class="units-row units-split ">
			<div class="unit-60">
				<div class="logo">
					<cfif url.id EQ session.startID>
						<h1>Akupunktur Massage</h1>
					<cfelse>
						<div class="h1">Akupunktur Massage</div>
					</cfif>		
					<div class="underline">&nbsp;</div>
					<br />		
					<cfif url.id EQ session.startID>
						<h2>Praxis für ganzheitliche Behandlung nach Radloff</h2>
					<cfelse>
						<div class="h2">Praxis für ganzheitliche Behandlung nach Radloff</div>
					</cfif>
				</div>
			</div>
			<div class="unit-20" >
				<cfoutput>
					<img id="flower" src="/#session.serverpath#/img/sonnenblume_70.png" alt="sunne" />
				</cfoutput>
			</div>
			<div class="unit-20 unit-push-right mobile-80">
				<div class="topadress">
					<address>
						Cécile Imbach<br />
						Therapeutin APM<br />
						Pflegefachfrau HF<br />
						Weihermattstrasse 2<br />
						5507 Mellingen<br />
						<a href="tel:0774197503">077 419 75 03</a><br />
					</address>
				</div>
			</div>
		</div>	
		<div class="unit-100">
			<div>
				<!--start flexslider or static mobile picture here-->
				<cfinclude template="headerpanel.cfm">
				<cfinclude template="header-mobile.cfm">
			</div>
		</div>
		<!--start Servicenavigation here-->	
		<div class="units-row">
			<div class="unit-100 servicenav">
				<cfinclude template="servicenav.cfm">
			</div>
		</div>
		<!--start Subnav here-->
		<div class="units-row">
			<div class="unit-100">
				<cfinclude template="subnav.cfm">
			</div>
		</div>
		<!--content starts here-->
		<div class="units-row">
			<div class="unit-20 mobile-10">
				&nbsp;
			</div>
			<section class="unit-60 mobile-80">
				<cfinclude template="content.cfm">
			</section>
			<div class="unit-push-right" id="right-space">
				&nbsp;
			</div>
		</div>	
		<!--footer starts here-->
		<div class="units-row bg-footer">
			<div class="unit-100">
				<cfinclude template="footer.cfm">
			</div>
		</div>
	<!--inner wrapper end-->
	</div>
<!--outer wrapper end-->
</div>
