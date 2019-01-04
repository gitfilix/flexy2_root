<div>
	<div class="flexslider">
		<ul class="slides"> 
			<cfloop query="getHeaderPanels">
				<li>
					<cfoutput> 
						<div class="pagetitel">
							<h2>#titel#</h2>
						</div>
					</cfoutput>
				</li>
			</cfloop>
		</ul>	
	</div>
</div>	
	