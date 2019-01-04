<cfprocessingdirective pageencoding="utf-8" />

<!--- 1) lightbox YOXVIEW laden
2) on Document ready YOXVIEW auf class="yoxview" anwenden
3) thumbnails innerhalb ihres div vertikal zentrieren --->



<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
WHERE A.id = <cfif isdefined("getActivePage.albumid")>#getActivePage.albumid#<cfelse>#albumid#</cfif>
</cfquery>


<cfif getAlbumWithImages.imagePath NEQ "">

<cfoutput query="getAlbumWithImages" group="albumid">
<cfif albumtitle NEQ "">
	<h2>#albumtitle#</h2>
</cfif> 
<cfif albumdescription NEQ "">
	<h3>#albumdescription#</h3>
</cfif>

<cfif isdefined("getActivePage.albumid")>
	<cfset albumtype = getActivePage.albumtype />
<cfelse>
	<cfset albumtype = getContent.albumtype />
</cfif>

<!--- hier der template switch zwischen thumbnail-liste und vollem album --->

<!--- thumbnail-liste --->
<cfif albumtype EQ 1>
	<div class="yoxview">
	<cfoutput>
		<cfimage source="#expandPath('/' & session.serverpath & '/upload/galleries/') & imageThumbPath#" name="myImage"> 
		<cfset bildbreite = ImageGetWidth(myImage) />
		<cfset bildhoehe = ImageGetHeight(myImage) />
		
		<cfset bildformat = "" />
		<cfif bildbreite GT bildhoehe>
			<cfset bildformat = "quer" />
		<cfelse>
			<cfset bildformat = "hoch" />
		</cfif>
		
		<div  class="gal_pix_small"  <!--- style="height:80px;width:80px;background-color:##e1e1e1;overflow:hidden;float:left;margin-right:1.5em;text-align:center;" --->>
			<a href="/#session.serverpath#/upload/galleries/#imagePath#"><img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" <cfif bildformat EQ "hoch">style="height:auto;"<cfelse>style="width:220px;"</cfif> /></a>
		<!--- <a href="/#session.serverpath#/upload/galleries/#imagePath#"><img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="thumbBox" <cfif bildformat EQ "hoch">style="height:auto;"<cfelse>style="width:220px;"</cfif> /></a> --->
		</div>
	</cfoutput>
	<div style="clear:both;"></div>
	</div>
<!--- volles album --->
<cfelse><div class="grid-wrap works yoxview" style="margin-left:0;">
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

	
	
		<figure class="gal_pix_big" <!--- style="text-align:center;padding-left:0;padding-bottom:1em;margin-bottom:1em;" --->>
			<a href="/#session.serverpath#/upload/galleries/#imagePath#" <!--- style="height:200px;padding-top:0;border:0;" id="d#currentrow#" --->>
				<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" <!--- <cfif bildformat EQ "hoch">style="height:200px;"<cfelse>style="width:100%;"</cfif> ---> />
				<!--- <img alt="" src="img/img.jpg" style="opacity: 1;"> --->
			</a>
			<figcaption class="gal_imageCaption">
				<p>#imageCaption#</p>
				<!--- <p>Lorem ipsum dolor set amet</p> --->
			</figcaption>
		</figure>

	

	</cfoutput></div>
</cfif>

<br/>
<br/>
</cfoutput>


</cfif>


    
   
