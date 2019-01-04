<!--- Main Content Container for Template 2 Schmuckund kunst --->
<div class="content-container">
<cfoutput query="getcontent">
			<div class="lead">
				<header>
				<cfif titel NEQ "">
					<h2>#titel#</h2>
					<br>
				<cfelse>
					<h2>Willkommen</2>
				</cfif>
					</header>
					<!---  PRint the lead --->
				<cfif lead NEQ "">
					 <div class="leadtext">#lead#</div>
				</cfif>
			</div>
			<!--- New Dark Container mit Fliesstext -pix right and links  or full length --->
			<div>
				<div class="pix_n_desc">
					<cfif bildname NEQ "">
						<figure	<cfif imagePos EQ 0>id="PixPos_left"<cfelseif imagePos EQ 1>	id="PixPos_right"<cfelseif imagePos EQ 2>id="PixPos_large"</cfif>>
							<img src="/#session.serverpath#/upload/img/#bildname#" alt="#bildname#" />
							<cfif IMAGECAPTION NEQ "">
								<div <!--- class="pix_description" --->>
									<p>#IMAGECAPTION#</p>
								</div>
							</cfif>
						</figure>
					</cfif>
				</div>
				<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<!--- Print out Fliesstext --->
					<article class="fliesstext">
						<div>#fliesstext#</div>
						</article>
						<br />
					</cfif>
					<!--- 	additional links if there are more then one --->
					<cfquery name="getAdditionalLinks" datasource="#application.dsn#">
					SELECT 	*
					FROM	links2pages
					WHERE	contentid = #id#
					</cfquery>
					<cfif HREFLABEL NEQ "">
						<div class="content_link"><br/>
							<a href="#HREF#">#HREFLABEL#</a>
						</div>
					</cfif>
					<cfif getAdditionalLinks.recordcount GT 0>
						<cfloop query="getAdditionalLinks">
							<div class="content_link">
								<a href="#HREF#">#HREFLABEL#</a><br/>
							</div>
						</cfloop>
					</cfif>
					<cfif doc NEQ "">
						<br/>
							<div class="contenthref">
							<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank">
								#doclabel#
							</a>
							</div>
					</cfif>
					
					<div class="clear"></div>
	
				
					
					<!--- if contact formular is defined - include here --->
					<cfif hasContact EQ 1>
						<div class="contact_container">
							<cfinclude template="contactform.cfm">
						</div>
					</cfif> 
				<!--- 	include YoxView gallery  --->
					<cfif albumid NEQ 0>
							<cfinclude template="gallery_as.cfm">
					</cfif>	
			</div>		
		<!---	<cfinclude template="inc/gallery.cfm">	--->
</cfoutput>

</div>