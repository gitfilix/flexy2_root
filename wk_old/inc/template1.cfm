<cfprocessingdirective pageencoding="utf-8" />

<div>
	<cfinclude template="mobile_nav.cfm">
</div>
<div class="clear"></div>	
<div class="row container split" id="first">
	<div class="quarter">
		<!--- 	blue bar on top --->
		<div class="bluebartop">
			&nbsp;
		</div>	
	</div>
	<!--- service- and langnav  --->
	<div class="threequarter">
		<div class="langnav">
			<cfinclude template="langnav.cfm">
		</div>	
		<div class="servicenav"> 
			<cfinclude template="servicenav.cfm">
		</div>
	</div>
	<div class="clear"></div>
</div>
<div class="row container orange_bg" >
	<div id="second">
		<div class="row split container" >
			<div id="whitesquare" class="quarter"  >
			 <!---  logo white --->
			 	<cfinclude template="logo.cfm">
			</div>
			<div class="threequarter orange_bg">
				<!--- headerpannel  --->
				<div id="Header" style="background:#fb9133;">
					<cfinclude template="headerpanel.cfm">
				</div>
				<div class="clear"></div>
			</div>
			
		</div>
	</div>
</div>
<div class="row split container" >
	<div id="lastRow">
		<div class="row split container">
			<div class="quarter" id="BlueBar">
				<div class="bluepanel">
					<!--- 	Themennav & include Subnav starts here --->
					<div class="themennav">
						<cfinclude template="themennavplus.cfm">
					</div>
					<blockquote class="quotetext">
						<p>
							&laquo;Es soll die Aussage im Vordergrund stehen, das Handwerk im Hintergrund um die Qualität zu gewährliesten.&raquo;
						</p>
						<br />
						- Tim Berners Lee<br/> ("Erfinder" des Internets)
					</blockquote>
				</div>
				<div class="clear"></div>
			<!--- END OF BLUEBAR CONTAINER	 --->
			</div>
			<div class="threequarter mq450100pro">
				<div class="row container" id="eqHeightRef">
					<div class="twothird mq800100pro">
						<div id="MainContent">	
							<cfinclude template="content.cfm">
						</div>
					</div>
					<div class="third ">
						<div id="sidebar">
							<cfinclude template="sidebars.cfm">
						</div>
					</div>
					<div class="clear"></div>
					<!--- Bigfooter mit 3 Teasers --->
					<div id="footerbar">
						<div class="footercontainer row container">
							<cfinclude template="footerteaser.cfm"> 
						</div>
					</div>
					<div id="footer">
						<div class="footerbottom">
							<cfinclude template="footer.cfm">
						</div>	
					</div>
				</div>
			</div>	
			<div class="clear"></div>
			
		</div>
	</div>
<!--- end last row --->
</div> 