<cfoutput query="getcontent">
<!--- switch if there are sidebars- 80% content - else 100%  --->
<cfif getSidebarElems.recordcount NEQ 0>
 	<div class="units-split no-margin cnt-wrapper">
		<div class="unit-70" id="text-80">
			<div class="lowercontent" >
				<article class="text-content">
						<h3>#lead#</h3>
						<br />
						<!--- Print out Fliesstext --->
						<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
							<section>
								#fliesstext#		
							</section>
						<cfelse>
						<!--- OR: Print some hardcoded LoremIpsum  --->
						 Praesent venenatis egestas enim, et tincidunt velit porta tempor! Quisque eu placerat leo!
						</cfif>
						<!--- Href link  --->
						<cfif href NEQ "">
							<br />
							<div <!--- class="contentlink" --->>
							<a href="#href#" target="_blank" >
								#hreflabel#
							</a>
							</div>
							<br />
						</cfif>
						<!--- doc link --->
						<cfif doc NEQ "">
							<br />
							<div <!--- class="contentlink" --->>
							<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank" >
								#doclabel#
							</a>
							</div>
							<br />
						</cfif> 	
				</article>
			</div>	
		</div>
		<div class="unit-30" id="text-20" >
			<cfinclude template="sidebars.cfm">
		</div>
		<div class="clear"></div>
	</div>
	<cfelse>
	<div class="unit-100">
		<div class="lowercontent">
			<article class="text-content">
					<h3>#lead#</h3>
					<br />
					<!--- Print out Fliesstext --->
				<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
					<section>
						#fliesstext#		
					</section>
				<cfelse>
				<!--- OR: Print some hardcoded LoremIpsum  --->
				 Praesent venenatis egestas enim, et tincidunt velit porta tempor! Quisque eu placerat leo!
				</cfif>
				<!--- Href link  --->
				<cfif href NEQ "">
					<br />
					<div <!--- class="contentlink" --->>
					<a href="#href#" target="_blank" >
						#hreflabel#
					</a>
					</div>
					<br />
				</cfif>
				<!--- doc link --->
				<cfif doc NEQ "">
					<br />
					<div <!--- class="contentlink" --->>
					<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank" >
						#doclabel#
					</a>
					</div>
					<br />
				</cfif> 	
			</article>
		</div>
	</div>
</cfif>
</cfoutput>