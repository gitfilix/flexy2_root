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
		$(".thumbBox").vAlign();
	});
	</script>
' />

<br/>
<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = #albumid#
</cfquery>

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
	
	<div style="height:85px;width:85px;background-color:##e1e1e1;overflow:hidden;float:left;margin-right:1.5em;text-align:center;">
		<a href="/#session.serverpath#/upload/galleries/#imagePath#"><img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" <cfif bildformat EQ "hoch">style="height:85px;"<cfelse>style="width:85px;"</cfif> /></a>
	</div>
</cfoutput>
<div class="clear"></div>
</div>
<br/>
</cfoutput>





    
   
