
<!--- Content with Glisse- Gallery auf Inhaltsbild --->

<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = #albumid#
ORDER BY #REIHENFOLGE#
</cfquery>
<!--- wenn getWith image path nicht leer ist  --->
<cfif getAlbumWithImages.imagePath NEQ "">

<cfoutput query="getAlbumWithImages" group="albumid">
<div class="album_content">
	
	 <ul>
		<cfset cnt = 1 />
		<cfset pixcnt = 0 />
		<cfoutput>
			<cfif cnt EQ 1>
			<!--- erstes Bild gross darstellen --->
				<li>
					<img class="pics" src="/#session.serverpath#/upload/galleries/#imagePath#" data-glisse-big="/#session.serverpath#/upload/galleries/#imagePath#" title="#getAlbumWithImages.imageCaption#" rel="group#albumid#"  alt="#imagePath#" />
					<cfset cnt = cnt + 1 />
					<cfset pixcnt = pixcnt + 1 />
				</li>
			<cfelseif cnt LT 6> 
			<!--- 4 Bilder von mit counter cnt 3,4,5,6 in Reihe darstellen, aber nicht erstes Bild (da pixcount ab 2, 3, 4, 5) --->
				<li id="pix_row" >
					<img class="pics" src="/#session.serverpath#/upload/galleries/#imagePath#"   data-glisse-big="/#session.serverpath#/upload/galleries/#imagePath#" title="#getAlbumWithImages.imageCaption#" rel="group#albumid#"  alt="#imagePath#" />
					<!--- 	<div style="background:##CCC;">#cnt#</div>  <div style="background:##EEE; color:##900">#pixcnt#</div> --->
					<cfset cnt = cnt + 1 />
					<cfset pixcnt = pixcnt + 1 />
				</li>
			<cfelse>
				<!--- 	alle übrigen bilder listen aber display none mit holy STYLE-ISLE --->
				<li style="display:none">
					<img class="pics" style="max-width:100%;"  data-glisse-big="/#session.serverpath#/upload/galleries/#imagePath#" title="#getAlbumWithImages.imageCaption#" rel="group#albumid#"  src="/#session.serverpath#/upload/galleries/#imagePath#" alt="#imagePath#" />
					<cfset cnt = cnt + 1 />
					<cfset pixcnt = pixcnt + 1 />
				</li>
			</cfif>
		</cfoutput>
	</ul>
	<div class="clear"></div>
	<br>
	<div class="albumdesc">
		<h3>#albumtitle#</h3>
		<br>
		<h4>#albumdescription#</h4>
	</div>
</div>

  <!--- <cfdump var="#getAlbumWithImages#">  --->
</cfoutput>
</cfif>

