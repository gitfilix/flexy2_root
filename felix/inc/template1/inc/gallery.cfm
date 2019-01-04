<cfprocessingdirective pageencoding="utf-8" />

<!--- 1) lightbox YOXVIEW laden
2) on Document ready YOXVIEW auf class="yoxview" anwenden
3) thumbnails innerhalb ihres div vertikal zentrieren --->
<cfhtmlhead text='
	<script>
	
	if(Modernizr.touch){
		$(document).ready(function(){
			$(".yoxview").yoxview({
				lang: "de",
				autoHideInfo: false,
				autoHideMenu: false
				
			});
			$(".thumbBox").vAlign();
		});
	}
	else{
		$(document).ready(function(){
			$(".yoxview").yoxview({
				lang: "de"				
			});
			$(".thumbBox").vAlign();
		});
	}
	
	</script>
' />

<br/>
<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = #albumid#
</cfquery>


<!--- THUMBNAIL LISTE --->
<cfif getcontent.albumtype EQ 1>


	<cfoutput query="getAlbumWithImages" group="albumid">
		#albumtitle#<br/>
		<div class="yoxview">
			<cfoutput>
				<cfimage source="#expandPath('/' & session.serverpath & '/upload/galleries/' & imageThumbPath)#" name="myImage"> 
				<cfset bildbreite = ImageGetWidth(myImage) />
				<cfset bildhoehe = ImageGetHeight(myImage) />
				
				<cfset bildformat = "" />
				<cfif bildbreite GT bildhoehe>
					<cfset bildformat = "quer" />
				<cfelse>
					<cfset bildformat = "hoch" />
				</cfif>
				
				<div class="thumbnailGalleryElem">
					<a href="/#session.serverpath#/upload/galleries/#imagePath#">
						<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#" title="#imageCaption#" class="thumbBox <cfif bildformat EQ "hoch">hochformat<cfelse>querformat</cfif>" />
					</a>
					<div style="position:absolute;right:0.2em;bottom:0.2em;">
						<img src="/#session.serverpath#/inc/template3/img/lupe.png" class="enlargeLupe" width="12" alt="vergrössern" />
					</div>
				</div>
			</cfoutput>
			<div class="clear"></div>
		</div>
		<br/>
	</cfoutput>

<!--- volles Album --->
<cfelseif getcontent.albumtype EQ 2>

	<cfoutput query="getAlbumWithImages" group="albumid">
		#albumtitle#<br/>
		<div class="yoxview">
			<cfoutput>
				<cfimage source="#expandPath('/' & session.serverpath & '/upload/galleries/' & imageThumbPath)#" name="myImage"> 
				<cfset bildbreite = ImageGetWidth(myImage) />
				<cfset bildhoehe = ImageGetHeight(myImage) />
				
				<cfset bildformat = "" />
				<cfif bildbreite GT bildhoehe>
					<cfset bildformat = "quer" />
				<cfelse>
					<cfset bildformat = "hoch" />
				</cfif>
				
				<div class="fullGalleryElem">
					<a href="/#session.serverpath#/upload/galleries/#imagePath#">
						<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#" title="#imageCaption#" class="thumbBox <cfif bildformat EQ "hoch">hochformatGROSS<cfelse>querformatGROSS</cfif>" />
					</a>
					<div style="position:absolute;right:0.2em;bottom:0.2em;">
						<img src="/#session.serverpath#/inc/template3/img/lupe.png" class="enlargeLupe" width="12" alt="vergrössern" />
					</div>
				</div>
			</cfoutput>
			<div class="clear"></div>
		</div>
		<br/>
	</cfoutput>
	


</cfif>








    
   
