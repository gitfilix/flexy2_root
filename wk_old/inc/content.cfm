<cfoutput query="getcontent">
	<div class="content_box">
		<div class="content_title">
			<cfif titel NEQ "">
				<h2>#Titel#</h2>
			<cfelse>
				<h1>Title: Hello World</h1>
			</cfif>
		</div>
		<div class="lead">
			<cfif lead NEQ "">
				<h3>#lead#</h3>
			</cfif>
		</div>		
		<div class="content_text">
			<!--- wenn ein bild aber kein album (normales unverlinktes content-bild)--->
			<cfif bildname NEQ "" AND albumtype NEQ 3>
				<figure <cfif imagePos EQ 0>id="PixPos_left"<cfelseif imagePos EQ 1>id="PixPos_right"<cfelseif imagePos EQ 2>id="PixPos_large"</cfif>>
					<img src="/#session.serverpath#/upload/img/#bildname#" alt="" />
					<div>
						<p>#imagecaption#</p>	
					</div>
				</figure>
			<!--- wenn ein album UND Gallerie album aktiv auf Inhaltsbild gewählt wurde--->
			<cfelseif albumid NEQ 0 AND albumtype EQ 3>
				<!--- left joint query für album UND Bilder  --->
				<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
				SELECT A.id as albumid, A.albumimage, A.Albumtitle,A.albumdescription,I.*
				FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
				WHERE A.id = #albumid#
				</cfquery>
				<!--- 	Alle Bilder des Albums  --->
				<cfquery name="getImages" datasource="#application.dsn#">
				SELECT *
				FROM albumimages
				WHERE albumid = #albumid#
				</cfquery>
						
				<!--- 	completer CF block in Variable ToHead speichern, weil nicht möglich output in output --->
				<cfsavecontent variable="toHead">
					<script>
					<!--- 	für touch devices legende und buttons immer anzeigen --->
					if(Modernizr.touch){
						$(document).ready(function(){
							$("##multipleExample#currentrow#").yoxview({
								lang: "de",
								autoHideInfo: false,
								autoHideMenu: false,
								images: [
									<cfset imagecounter = 1>
									<cfloop query="getImages">
									<cfif imagecounter gt 1 >
									{ media: { src: "/#session.serverpath#/upload/galleries/#imagePath#", title: "#imagecaption#" }},
									</cfif>
									<cfset imagecounter = imagecounter + 1>
									</cfloop>
								]
								
							});
							$(".thumbBox").vAlign();
						});
					}
					<!--- 	desktop version mit yoxview-default --->
					else{
						$(document).ready(function(){
							$("##multipleExample#currentrow#").yoxview({
								lang: "de",
								autoHideInfo: false,
								<!--- bilder müssen im javascript header sein, wenn 1Bild -multiple bilder gallerie -yoxview halt --->
								images: [
									<cfset imagecounter = 1>
									<cfloop query="getImages">
									<cfif imagecounter gt 1 >
									{ media: { src: "/#session.serverpath#/upload/galleries/#imagePath#", title: "#imagecaption#" }},
									</cfif>
									<cfset imagecounter = imagecounter + 1>
									</cfloop>
								]
								
							});
							<!--- 	thumpnails verical einmitten  --->
							$(".thumbBox").vAlign();
						});
					}
					</script>
				</cfsavecontent>
				<cfhtmlhead text='#toHead#' />		
				<!--- Gallerie mit album typ 3 (gallerie auf inhaltsbild gewählt) --->
				<!--- wenn bereits ein inhaltsbild vorhanden --->
				<figure>
					<cfif bildname NEQ "">
						<a href="/#session.serverpath#/upload/galleries/#getAlbumWithImages.imagePath#" class="yoxview" id="multipleExample#currentrow#">
							<img src="/#session.serverpath#/upload/img/#bildname#" alt="" title="#getAlbumWithImages.imageCaption#" class="thumbBox <cfif imagePos EQ 0>PixPos_left<cfelseif imagePos EQ 1>PixPos_right<cfelseif imagePos EQ 2>PixPos_large</cfif>" >
						</a>
					<!--- wenn kein inhaltsbild vorhanden, dann nemhme Albumbild --->
					<cfelseif bildname EQ "">
						<!--- wenn ein albumbild vorhanden --->
						<cfif getAlbumWithImages.albumimage NEQ "">
							<a href="/#session.serverpath#/upload/galleries/#getAlbumWithImages.imagePath#" class="yoxview" id="multipleExample#currentrow#">
								<img src="/#session.serverpath#/upload/galleries/#getAlbumWithImages.albumimage#" alt="" class="thumbBox <cfif imagePos EQ 0>PixPos_left<cfelseif imagePos EQ 1>PixPos_right<cfelseif imagePos EQ 2>PixPos_large</cfif>" >
							</a>
						<!--- wenn kein albumbild vorhanden, nimm erstes bild aus galerie --->
						<cfelse>
							<a href="/#session.serverpath#/upload/galleries/#getAlbumWithImages.imagePath#" class="yoxview" id="multipleExample#currentrow#">
								<img src="/#session.serverpath#/upload/galleries/#getAlbumWithImages.imageThumbPath#" alt="" class="thumbBox <cfif imagePos EQ 0>PixPos_left<cfelseif imagePos EQ 1>PixPos_right<cfelseif imagePos EQ 2>PixPos_large</cfif>" >
							</a>
						</cfif>
					</cfif>
				</figure>
			</cfif>
			<!--- bildbeschreibung  --->
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<div>
					#fliesstext#
				</div>
			</cfif>
			<!--- include links --->
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
			<!--- include documents  --->
			<cfquery name="getAdditionalDocs" datasource="#application.dsn#">
			Select	*
			FROM	docs2pages
			WHERE	contentid = #id#
			</cfquery>
			<cfif doc NEQ "">
				<div class="doc_link">
					<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank">
						#doclabel#
					</a>
					<br/>
				</div>
			</cfif>
			<cfif getAdditionalDocs.recordcount GT 0>
				<cfloop query="getAdditionalDocs">
					<div class="doc_link">
						<a href="/#session.serverpath#/upload/doc/#dok#" target="_blank">
							#doklabel#
						</a>
						<br/>
					</div>
				</cfloop>
			</cfif>
			<cfif pageproperties.showAllNews EQ 1>
				<cfinclude template="news.cfm" />
			</cfif>
		</div>
	</div>
	<div class="clear"></div>
	<!--- AlbumID muss gegeben werden da im getContent -SQL  --->
	<cfif albumid NEQ 0>
		<div class="photo-slider">
			<cfinclude template="gallery.cfm" />
		</div>
	</cfif>
	<!--- 	Konaktformular laden wenn hascontact =1 and Contaktform complex  --->
	<cfif HASCONTACT EQ 1 AND CONTACTTYPE EQ 1>
		<div class="formstyle">
			<cfinclude template="contactLongForm.cfm">
		</div>
	</cfif>
	<!--- 	Kontaktformular easy style --->
	 <cfif HASCONTACT EQ 1 AND CONTACTTYPE EQ 0>
		<div class="formstyle">
			<cfinclude template="contactShortForm.cfm">
		</div>
	</cfif> 
</cfoutput>
<!--- dieser nbsp ist wichtig, damit es mindestens ETWAS inhalt hat - MIESer trick 63 --->
&nbsp;
