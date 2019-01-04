<cfprocessingdirective pageencoding="utf-8">
<!--- get all content first --->

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
			<cfif AlbumID NEQ "" >
			<!--- lets try to include gallery output here --->
			<div class="flex_gallery">
				<cfinclude template="slider_gallery.cfm">
			</div>
			</cfif>
			
			
			<!--- New Dark Container mit Fliesstext -pix right and links  or full length --->
			<div class="fliesstext">
				<cfif bildname NEQ "">
					<figure>
						<img src="/#session.serverpath#/upload/img/#bildname#" alt="" 
						<cfif imagePos EQ 0>
							class="PixPos_left"
						<cfelseif imagePos EQ 1>
							class="PixPos_right"
						<cfelseif imagePos EQ 2>
							class="PixPos_large"
						</cfif> />
					</figure>
				</cfif>
				<cfif IMAGECAPTION NEQ "">
					<p class="pix_description">#IMAGECAPTION#</p>
				</cfif>
				<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<!--- Print out Fliesstext --->
					<article>
						<div class="fliesstext>"#fliesstext# </div>	
						</article>
						<br />
					</cfif>
					<!--- 	Print Link label  --->
					<cfif href NEQ "">
						<br/>
							<div class="contenthref">
								<a href="#href#" target="_blank">
									#hreflabel#
								</a>
							</div>
					</cfif>
					<!--- if contact formular is defined - include here --->
					<cfif hasContact EQ 1>
						<div class="contact_container">
							<cfinclude template="contactform.cfm">
						</div>
					</cfif>
					<cfif doc NEQ "">
						<br/>
							<div class="contenthref">
							<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank">
								#doclabel#
							</a>
							</div>
							<br/>
					</cfif> 
	
			</div>
</cfoutput>

</div>




