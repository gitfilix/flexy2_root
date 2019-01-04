<cfloop query="getcontent">
	<!---ge-groupter querry da left join--->
	<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
	SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
	FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
	WHERE A.id = #albumid#
	</cfquery>
	<!---da groupter output, darf output in output hier abgefragt werden--->
	<!--- 	<cfdump var="#getAlbumWithImages#">  --->
	
	<div class="slider-wrapper uppercontent">
		<ul class="bxslider">
			<cfoutput query="getAlbumWithImages" group="albumid">	
			<cfoutput>	
				<li> 
					<img src="/#session.serverpath#/upload/galleries/#imagepath#" alt="d" />
					 <div class="slider-desc">	
						<h3>#imageTitle#</h3>
						<br />
						<p>#imageCaption#</p>
						<br />
						<h4>Webkanal Work</h4>
						<br />
						<p>#imageowner#</p>
					</div>
				</li>
			</cfoutput>
		</cfoutput>
		</ul>
	</div>
</cfloop>
	<!--- lower content part here --->
<cfoutput query="getcontent">
<!--- switch if there are sidebars- 80% content - else 100%  --->
<cfif getSidebarElems.recordcount NEQ 0>
 	<div class="units-split no-margin cnt-wrapper">
		<div class="unit-70" id="text-80">
			<div class="lowercontent" >
				<article class="text-content">
						<h2>#lead#</h2>
						<br />
						<!--- Print out Fliesstext --->
						<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
							<section>
								#fliesstext#		
							</section>
						<cfelse>
						<!--- OR: Print some hardcoded LoremIpsum  --->
						&nbsp;
						</cfif>
						<!--- Href link  --->
						<cfif href NEQ "">
							<br />
							<div class="contentlink" >
								<a href="#href#" >
									#hreflabel#
								</a>
							</div>					
						</cfif>
						<!--- 	additional links if there are more then one --->
						<cfquery name="getAdditionalLinks" datasource="#application.dsn#">
						SELECT 	*
						FROM	links2pages
						WHERE	contentid = #id#
						</cfquery>
						<cfif getAdditionalLinks.recordcount GT 0>
							<cfloop query="getAdditionalLinks">
								<div class="contentlink">
									<a href="#HREF#" >#HREFLABEL#</a><br/>
								</div>
							</cfloop>
						</cfif>
						<!--- doc link --->
						<cfif doc NEQ "">
							<div>
								<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank" >
									#doclabel#
								</a>
							</div>
						</cfif>
						<!--- 	additional docs if there are more then one --->
						<cfquery name="getAdditionaldocs" datasource="#application.dsn#">
						SELECT 	*
						FROM	docs2pages
						WHERE	contentid = #id#
						</cfquery>
						<cfif getAdditionaldocs.recordcount GT 0>
							<cfloop query="getAdditionaldocs">
								<div>
								<a href="/#session.serverpath#/upload/doc/#dok#" target="_blank">
									#doklabel#
								</a>
								</div>
							</cfloop>
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
					<h2>#lead#</h2>
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
					<div  class="contentlink">
					<a href="#href#" target="_blank" >
						#hreflabel#
					</a>
					</div>
				</cfif>
				<!--- 	additional links if there are more then one --->
				<cfquery name="getAdditionalLinks" datasource="#application.dsn#">
					SELECT 	*
					FROM	links2pages
					WHERE	contentid = #id#
				</cfquery>
				<cfif getAdditionalLinks.recordcount GT 0>
					<cfloop query="getAdditionalLinks">
						<div  class="contentlink">
							<a href="#HREF#">#HREFLABEL#</a><br/>
						</div>
					</cfloop>
				</cfif>
				<!--- doc link --->
				<cfif doc NEQ "">
					<div  class="contentlink">
					<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank" >
						#doclabel#
					</a>
				</cfif>
				<!--- 	additional docs if there are more then one --->
				<cfquery name="getAdditionaldocs" datasource="#application.dsn#">
					SELECT 	*
					FROM	docs2pages
					WHERE	contentid = #id#
				</cfquery>
				<cfif getAdditionaldocs.recordcount GT 0>
					<cfloop query="getAdditionaldocs">
						<div class="contentlink">
						<a href="/#session.serverpath#/upload/doc/#dok#" target="_blank">
							#doklabel#
						</a>
						</div>
					</cfloop>
				</cfif>	
			</article>
		</div>
	</div>
</cfif>
</cfoutput>

<!--- <cfdump var="#getAlbumWithImages#"> ---> 