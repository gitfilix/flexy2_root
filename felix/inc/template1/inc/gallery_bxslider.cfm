<cfprocessingdirective pageencoding="utf-8" />

<!--- 1) GAllery wird als slider angezeigt bx-slider laden
2) on Document ready YOXVIEW auf class="yoxview" anwenden
3) thumbnails innerhalb ihres div vertikal zentrieren --->
<cfhtmlhead text='
	<script type="text/javascript" src="/#session.serverpath#/inc/bxslider/jquery.bxslider.js"></script> 
	<script type="text/javascript">
		$(document).ready(function(){
			$(".bxslider").bxSlider({
			mode:"fade",
			auto:true,
			controls: false,
			autoControls:false,
			autoStart: true,
	<!--- 	touchEnabled: true, --->
			adaptiveHeight:false,
			 speed:1250,
			 slideMargin:50,
			infiniteLoop:true
			});
		});
	</script>
	<link rel="stylesheet" type="text/css" href="/#session.serverpath#/inc/bxslider/jquery.bxslider.css"> 
' />

<br/>
<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = #albumid#
</cfquery>

<cfoutput query="getAlbumWithImages" group="albumid">

<h2>#albumtitle#</h2>
<br/>
<p>#albumdescription#</p>
<br>
<ul class="bxslider">
<cfoutput>
<div class="bx-custumizer">
	<cfimage source="#expandPath('/' & session.serverpath & '/upload/galleries/' & imageThumbPath)#" name="myImage"> 
	<cfset bildbreite = ImageGetWidth(myImage) />
	<cfset bildhoehe = ImageGetHeight(myImage) />
	
	<cfset bildformat = "" />
	<cfif bildbreite GT bildhoehe>
		<cfset bildformat = "quer" />
	<cfelse>
		<cfset bildformat = "hoch" />
	</cfif>
	
		<li>
			<img src="/#session.serverpath#/upload/galleries/#imagePath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" />
		<h3>#imageTitle#</h3><br><p>#imageCaption#</p>
		</li>
	</div>
			
		
	<!--- <div style="height:85px;width:85px;background-color:##e1e1e1;overflow:hidden;float:left;margin-right:1.5em;text-align:center;">
		<a href="/#session.serverpath#/upload/galleries/#imagePath#"><img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" <cfif bildformat EQ "hoch">style="height:85px;"<cfelse>style="width:85px;"</cfif> /></a>
	</div> --->
</cfoutput>
</ul>
<div class="clear"></div>

</cfoutput>

<!--- <cfdump var="#getAlbumWithImages#"> --->



    
   
