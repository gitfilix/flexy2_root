<!--- allow from every port than 80  same domain policy hack  --->
<cfheader name="Access-Control-Allow-Origin" value="*">
<cfsetting showdebugoutput="yes">
<cfset temp = setlocale("German (Swiss)") />
<cfif isDefined("form.albumList")>	
	<!--- check if new or existant album --->
	<cfif form.albumList EQ "new">
		<!--- new album --->
		<cfset newAlbumName = form.albumTitle />
		<!--- create new album --->
		<cfquery name="insertNewAlbum" datasource="atelier_schief_ch">
		INSERT
		INTO	albums(
					albumTitle,
					createDate,
					albumImage,
					mandant   
				)
		VALUES(
			'#newAlbumName#',
			#createODBCDate(now())#,
			<!--- process albumimage upload 
			<cffile action="upload" filefield="bilder" destination="#expandPath('/spa/upload/galleries')#" nameconflict="makeunique"> 
			<cfimage action="resize" source="#expandPath('/spa/upload/galleries/#cffile.serverfile#')#" destination="#expandPath('/spa/upload/galleries/#cffile.serverfile#')#" width="480" height="" overwrite="yes">
			--->
			
			<cfset myImage = ImageReadBase64(listFirst(form.bilder))> 
			<cfset fnx = createUUID() & '.jpg' />
			<cfimage source="#myImage#" destination="#expandPath('/spa/upload/galleries/') & fnx#" action="write">			
			'#fnx#',
			76
		)
		</cfquery>
		
		<cfquery name="getLatestAlbumID" datasource="atelier_schief_ch">
			SELECT MAX(id) as maxID FROM albums
		</cfquery>
		
		<!--- alle bilder aufs mal uploaden, und das resulatet in der var "uploadResulat" speichern 
		<cffile action="uploadAll" filefield="bilder" destination="#expandPath('/spa/upload/galleries')#" result="uploadResulat" nameconflict="makeunique"> --->

		<cfloop list="#form.bilder#" index="i">
			
			<!--- <cfimage action="resize" source="#expandPath('/spa/upload/galleries/#i.SERVERFILE#')#" destination="#expandPath('/spa/upload/galleries/#i.SERVERFILE#')#" width="600" height="" overwrite="yes"> --->
			<cfset myImage = ImageReadBase64(i)> 
			<cfset fnx = createUUID() & '.jpg' />
			<cfimage source="#myImage#" destination="#expandPath('/spa/upload/galleries/') & fnx#" action="write">
				
			<cfquery name="setImages" datasource="atelier_schief_ch">
			INSERT
			INTO	albumimages(
						imagePath,
						albumID,
						createDate
					)
			VALUES(
				'#fnx#',
				#getLatestAlbumID.maxID#,
				#createODBCDate(now())#
			)
			</cfquery>
		</cfloop>
		
		
	<cfelse>
		<!--- existing album --->
		<cfset albumId = form.albumlist />
		
		<cfloop list="#form.bilder#" index="i">
			
			<cfset myImage = ImageReadBase64(i)> 
			<cfset fnx = createUUID() & '.jpg' />
			<cfimage source="#myImage#" destination="#expandPath('/spa/upload/galleries/') & fnx#" action="write">
			
			<cfquery name="setImages" datasource="atelier_schief_ch">
			INSERT
			INTO	albumimages(
						imagePath,
						albumID,
						createDate
					)
			VALUES(
				'#fnx#',
				#albumId#,
				#createODBCDate(now())#
			)
			</cfquery>
		</cfloop>
		
	</cfif>
	<cfabort>

</cfif>

 
<!--- get all albums with images from mandant 76 --->
<cfquery name="spaApi" datasource="atelier_schief_ch">
	SELECT		A.id AS aId, 
				A.albumTitle AS aAlbumTitle,
				A.albumDescription AS aAlbumDescription,
				A.createDate AS aCreateDate,
				A.modifyDate AS aModifyDate,
				A.creator AS aCreator,
				A.albumImage AS aAlbumImage,
				A.mandant AS aMandant,
				I.id,
				I.imageTitle,
				I.imagePath,
				I.albumID,
				I.imageCaption,
				I.imageThumbPath,
				I.reihenfolge,
				I.createDate,
				I.modifyDate,
				I.creator,
				I.imageOwner
	
	FROM		albums A LEFT JOIN 
				albumimages I ON I.albumID=A.ID
	WHERE		A.mandant = 76
	ORDER BY	A.ID
	
</cfquery>



<cfset albums = structNew() />
<cfset gallery = arrayNew(1) />

<cfoutput query="spaApi" group="aid">
	<cfquery name="getUsername" datasource="atelier_schief_ch">
		SELECT vorname,name FROM user
		WHERE id = #acreator#
	</cfquery>
	<cfif getUsername.recordcount NEQ 0>
		<cfset acreatorNew = getUsername.vorname & " " & getUsername.name />
	<cfelse>
		<cfset acreatorNew = "App User" />
	</cfif>
	<cfset album = structNew() />
	<cfset album['albumID'] = aId /> 
	<cfset album['albumtitel'] = aAlbumTitle /> 
	<cfset album['albumstate'] = 1 /> 
	<cfset album['creator'] = acreatorNew />
	<cfset album['createdate'] = LSdateformat(aCreateDate,'DDDD, d. MMMM YYYY') />  
		<cfset album['images'] = arrayNew(1) />
		<cfoutput>
			<cfset image = structNew() /> 
			<cfset image['imgtitel'] = imageTitle />  
			<cfset image['imgpath'] = "http://www.web-kanal.ch/spa/upload/galleries/"&imagePath />
			<cfset image['imgCaption'] = imageCaption />  
			<cfset arrayAppend(album.images,image) />
		</cfoutput>
	<cfset arrayAppend(gallery,album) />
</cfoutput> 



<cfcontent  type="application/javascript" >

<cfoutput>
	#serializeJSON(gallery)#
</cfoutput>