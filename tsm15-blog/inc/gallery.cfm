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
	<h3>#albumtitle#</h3>
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
		<cfimage source="#expandPath('/' & session.serverpath & '/upload/galleries/' & imageThumbPath)#" name="myImage"> 
		<cfset bildbreite = ImageGetWidth(myImage) />
		<cfset bildhoehe = ImageGetHeight(myImage) />
		
		<cfset bildformat = "" />
		<cfif bildbreite GT bildhoehe>
			<cfset bildformat = "quer" />
		<cfelse>
			<cfset bildformat = "hoch" />
		</cfif>
		
		<div class="thumbBox">
			<a href="/#session.serverpath#/upload/galleries/#imagePath#"><img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" class="gal-thumbs" <cfif bildformat EQ "hoch">style="height:120px;"<cfelse>style="width:120px;"</cfif> /></a>
		</div>
	</cfoutput>
	<div style="clear:both;"></div>
	<cfif albumdescription NEQ "">
		<h4>#albumdescription#</h4>
	</cfif>
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

	
	
		<figure class="grid col-one-third mq1-col-one-half mq2-col-one-third mq3-col-full work_1" style="text-align:center;padding-left:0;padding-bottom:1em;margin-bottom:1em;">
			<a href="/#session.serverpath#/upload/galleries/#imagePath#" style="height:200px;padding-top:0;border:0;" id="d#currentrow#">
				<img src="/#session.serverpath#/upload/galleries/#imageThumbPath#" alt="#imageTitle#"  title="#imageCaption#" <cfif bildformat EQ "hoch">style="height:200px;"<cfelse>style="width:100%;"</cfif> />
				<!--- <img alt="" src="img/img.jpg" style="opacity: 1;"> --->
				<span style="opacity: 0;" class="zoom"></span>
			</a>
			<figcaption>
				<p>Lorem ipsum dolor set amet</p>
			</figcaption>
		</figure>

	

	</cfoutput></div>
</cfif>

<br/>
<br/>
</cfoutput>


</cfif>


    
   
