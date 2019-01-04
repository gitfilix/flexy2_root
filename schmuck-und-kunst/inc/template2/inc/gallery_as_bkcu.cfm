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
</cfquery>
<!--- wenn getWith image path nicht leer ist  --->


<cfif getAlbumWithImages.imagePath NEQ "">

<cfoutput query="getAlbumWithImages" group="albumid">
<cfset pixcnt = 0 />
		<div class="as_gallery">
			<h3>#albumtitle#</h3>
		
			<h4>#albumdescription#</h4>
			<div class="yoxview">
				<cfoutput>
				
				<cfimage source="#expandPath('/' & session.serverpath & '/upload/galleries/') & imageThumbPath#" name="myImage"> 
				<div class="row container">
					<div class="imagecontainer">
						<cfif pixcnt LT 1 >	
							<a href="/#session.serverpath#/upload/galleries/#imagePath#">
							<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" 
							 />
							</a>
							
							<div class="clear"></div>
							<p class="gal-img-title">#imageTitle#</p>
							<p class="gal-img-desc">#imageCaption#</p>
							<br>
							<p class="gal-img-fotograph">Photograph:&nbsp;#imageOwner#</p>
						</cfif>	

					</div>
				</div>
			
				

				</cfoutput>
				<div class="clear"></div>
			</div>
		<br/>
	</div>
	
<cfset pixcnt = pixcnt + 1>
</cfoutput>	

</cfif>



    
   
