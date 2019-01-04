<cfprocessingdirective pageencoding="utf-8">
<!--- lets try to include gallery output here --->
	
<cfhtmlhead text="
	<script type='text/javascript' >
 	 $(window).load(function() {
    $('.flexslider').flexslider();
 	 });
	</script>

"	>
	
<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = #albumid#
</cfquery>

	


<!--- <img src="/#session.serverpath#/upload/galleries/#imageThumbPath#"> --->

<div class="flexslider">
	<ul class="slides">	
	<!--- 2x cfoutput weil Left Joint querries 1.output gruppiert alle Albums: 1 
		2. Output loopt über die Albums und gibt inhaltselemente aus !! --->
		<cfoutput query="getAlbumWithImages" group="albumid">
			<cfoutput>
			<li>
				<img src="/#session.serverpath#/upload/galleries/#imagePath#" class="slide_img">
				<br>
				<h3>#IMAGECAPTION#</h3> 
			</li>
			
			</cfoutput>
		 </cfoutput>
		</ul>	
</div>

	
	



<!--- <cfdump var="#getAlbumWithImages#">  --->
