<cfprocessingdirective pageencoding="utf-8" />

<!--- 1) lightbox YOXVIEW laden
2) on Document ready YOXVIEW auf class="yoxview" anwenden
3) thumbnails innerhalb ihres div vertikal zentrieren --->
<cfhtmlhead text='
	<script type="text/javascript" src="/#session.serverpath#/inc/yoxview/yoxview-init.js"></script>
	<script>
	$(document).ready(function(){
		$(".yoxview").yoxview({
			lang: "de"
		});
		//$(".thumbBox").vAlign();
	});
	</script>
' />


<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = #albumid#
ORDER BY #REIHENFOLGE#
</cfquery>
<!--- wenn getWith image path nicht leer ist  --->


<cfif getAlbumWithImages.imagePath NEQ "">

<cfoutput query="getAlbumWithImages" group="albumid">

<div class="as_gallery">
	<h3>#albumtitle#</h3>	
	<h4>#albumdescription#</h4>
		<div class="yoxview">	
			<ul>
			<cfset cnt = 1 />
			<cfset pixcnt = 0 />
			<cfoutput>
				<cfif cnt EQ 1  >
				<!--- erstes bild gross darstellen --->
					<li id="first_pix">
						<a href="/#session.serverpath#/upload/galleries/#imagePath#">
							<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" />
								
						</a>
						<div>
							<p class="gal-img-title">#imageTitle#</p><p class="gal-img-desc">#imageCaption#</p><p class="gal-img-fotograph">Photograph:&nbsp;#imageOwner#</p>
						</div>
					</li>	
				</cfif>			
				<cfif cnt GT 1 AND cnt LT 5>
					<li class="pix_row">
						<a href="/#session.serverpath#/upload/galleries/#imagePath#">
							<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" />
								
						</a>
						<p class="gal-img-title">#imageTitle#</p>
					</li>
				<cfelseif cnt NEQ 1>
					<li style="display:none;">
						<a href="/#session.serverpath#/upload/galleries/#imagePath#">
							<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" />
								
								
						</a>
					</li>	
				</cfif>	
				<cfset cnt = cnt + 1 />
			</cfoutput>
			</ul>
				<div class="clear"></div>
					
		</div>
	</div>
</cfoutput>	

</cfif>



    
   
