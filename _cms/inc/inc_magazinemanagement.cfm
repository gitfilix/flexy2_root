<cfprocessingdirective pageencoding="utf-8" />


<cfhtmlhead text="
	<script type='text/javascript' src='/admin/js/ckeditor/ckeditor.js'></script>
" />

<!--- gleiches stylesheet wie pabgemanagement  --->
<link  rel="stylesheet" type="text/css" href="/admin/css/pagemanagement.css"  >


<!--- 
<cfdump var="#session.rechte.module#"> --->
<style>
 
/* colors für status*/
#activ{
	color:#3F3;
	}

#inactiv{
	color:#9FF;
	}
	
/*:nth-child(2n){*/

table tr,table tr table tr{
	background:#949494;
	}
	
table td{
	vertical-align:top;
	padding:5px 5px;
	}
	
table td:first-child{
	padding-top:8px;
	}
	
table tr:nth-child(2n+1),table tr:nth-child(2n+1) table tr{
	background:#B2B2B2;
	}	
	
#gray1{
	color:#039;
	letter-spacing:2px;
	background:#9A9A9A;
	}

#gray2{
	color:#039;
	letter-spacing:2px;
	background:#B2B2B2;
	}

#gray3{
	color:#039;
	letter-spacing:2px;
	background:#D6D6D6;
	}	
	
input[type=text],input[type=file],textarea,select{
	width:98%;
	border:1px solid silver;
	padding:2px;	
	font-family:Tahoma, Geneva, sans-serif;
	font-size:13px;
}

select{
	width:99%;
}
</style>

<!--- rechte für dieses modul: --->
<cfloop array="#session.rechte.module#" index="i">
	<cfif i.id EQ session.moduleid>
		<cfset rightEdit = i.edit />
		<cfset rightDel = i.del />
		<cfset rightAdd = i.add />
		<cfset rightCopy = i.copy />
		<cfbreak>
	</cfif>
</cfloop>
<cfif arrayLen(session.rechte.module) EQ 0>
	<cfset rightEdit = 0 />
	<cfset rightDel = 0 />
	<cfset rightAdd = 0 />
	<cfset rightCopy = 0 />
</cfif>

<!--- -------------- form prozessors ------------------ --->

<!--- alle magazine auslesen --->
<cfquery name="getMagazines" datasource="#application.dsn#">
SELECT	M.id,
		M.creator,
		M.createDate,
		M.modifydate,
		M.mandant,
		M.titel,
		M.isActive,
		A.id as aid,
		A.magazinID,
		A.isActive as aisactive,
		A.ausgabe,
		A.releaseDate,
		K.kapitel,
		K.id as kid,
		K.magazinAusgabeID,
		S.id as sid,
		S.titel as stitel,
		S.autoLaunch,
		S.contentTopPanel,
		S.contentBottomPanel,
		S.contentLeftPanel,
		S.contentRightPanel,
		S.contentLightbox,
		S.parent 
FROM	(((magazine M LEFT JOIN
		magazinAusgaben A ON A.magazinID = M.id) LEFT JOIN
		magazinKapitel K ON K.magazinAusgabeID = A.id) LEFT JOIN
		magazinSeiten S ON S.parent = K.id)
WHERE	M.mandant = #session.mandant#
ORDER	BY M.id,A.id,K.id,S.id
</cfquery>

<!--- zu bearbeitendes magazin aus db lesen (aufgrund seiner übermittelten ID) --->
<cfif isdefined("url.editMagazine") AND isNumeric(url.editMagazine) AND url.editMagazine GT 0>
	<cfquery name="editMagazine" datasource="#application.dsn#">
	SELECT	*
	FROM	magazine
	WHERE	id = #url.editMagazine# AND
			mandant = #session.mandant#
	</cfquery>
</cfif>

<!--- zu bearbeitende magazinkapitel aus db lesen (aufgrund seiner übermittelten ID) --->
<cfif isdefined("url.editMagazineEdition") AND isNumeric(url.editMagazineEdition) AND url.editMagazineEdition GT 0>
	<cfquery name="editMagazineEdition" datasource="#application.dsn#">
	SELECT	*
	FROM	magazinausgaben
	WHERE	id = #url.editMagazineEdition#
	</cfquery>
</cfif>

<!--- zu bearbeitende magazinseiten aus db lesen (aufgrund seiner übermittelten ID) --->
<cfif isdefined("url.editMagazinPage") AND isNumeric(url.editMagazinPage) AND url.editMagazinPage GT 0>
	<cfquery name="editMagazinePage" datasource="#application.dsn#">
	SELECT	*
	FROM	magazinseiten
	WHERE	id = #url.editMagazinPage#
	</cfquery>
</cfif>

<!--- zu bearbeitende magazinausgabe aus db lesen (aufgrund seiner übermittelten ID) --->
<cfif isdefined("url.editMagazineChapter") AND isNumeric(url.editMagazineChapter) AND url.editMagazineChapter GT 0>
	<cfquery name="magazineChapters" datasource="#application.dsn#">
	SELECT	*
	FROM	magazinkapitel
	WHERE	id = #url.editMagazineChapter#
	</cfquery>
</cfif>

<cfif isdefined("url.delMagazine") AND isNumeric(url.delMagazine) AND url.delMagazine GT 0>
	<cfset flexyLib = createObject('component','admin.cfc.flexy') />
	<cfset flexyLib.delMag(magId=url.delMagazine) />
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.delMagazineEdition") AND isNumeric(url.delMagazineEdition) AND url.delMagazineEdition GT 0>
	
	<cfset flexyLib = createObject('component','admin.cfc.flexy') />
	<cfset x = flexyLib.delMagEdition(magEditionId=url.delMagazineEdition) />
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.delMagazineChapter") AND isNumeric(url.delMagazineChapter) AND url.delMagazineChapter GT 0>
	<cfset flexyLib = createObject('component','admin.cfc.flexy') />
	<cfset flexyLib.delMagChapter(magChapterId=url.delMagazineChapter) />
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.delMagazinePage") AND isNumeric(url.delMagazinePage) AND url.delMagazinePage GT 0>
	<cfset flexyLib = createObject('component','admin.cfc.flexy') />
	<cfset flexyLib.deleteMagazinePage(magPageId=url.delMagazinePage) />
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedNewMagazinePage">
	<cfquery name="addMagazineChapter" datasource="#application.dsn#">
	INSERT 
	INTO	magazinseiten(
			titel,
			parent 
	)
	VALUES(
		'#form.titel#',
		#form.magazinChapterID#
	)
	</cfquery>
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedEditedMagazinePage">
	<cfquery name="updateMagazinePage" datasource="#application.dsn#">
	UPDATE	magazinkapitel
	SET		titel = '#form.titel#'
	WHERE	id = #form.magazinPageID#
	</cfquery>
	
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedNewMagazineChapter">
	<cfquery name="addMagazineChapter" datasource="#application.dsn#">
	INSERT 
	INTO	magazinkapitel(
			kapitel,
			magazinAusgabeID 
	)
	VALUES(
		'#form.kapitel#',
		#form.magazinEditionID#
	)
	</cfquery>
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedEditedMagazineChapter">
	<cfquery name="updateMagazineChapter" datasource="#application.dsn#">
	UPDATE	magazinkapitel
	SET		kapitel = '#form.kapitel#'
	WHERE	id = #form.magazinChapterID#
	</cfquery>
	
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedNewMagazineEdition">
	<cfquery name="addMagazineEdition" datasource="#application.dsn#">
	INSERT 
	INTO	magazinAusgaben(
			magazinID,
			isActive,
			ausgabe,
			releaseDate,
			orientation 
	)
	VALUES(
		#form.magazinID#,
		#form.isActive#,
		'#form.Ausgabe#',
		#createODBCDate(form.releasedate)#,
		#form.orientation#
	)
	</cfquery>
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedEditedMagazineEdition">
	<cfquery name="updateMagazineEdition" datasource="#application.dsn#">
	UPDATE	magazinausgaben
	SET		isActive = #form.isActive#,
			ausgabe = '#form.ausgabe#',
			releasedate = #createODBCDate(form.releasedate)#,
			publishState = #form.publishState#
	WHERE	id = #form.magazinID#
	</cfquery>
	
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedNewMagazine">
	<cfquery name="addMagazine" datasource="#application.dsn#">
	INSERT 
	INTO	magazine(
			creator,
			createDate,
			mandant,
			titel,
			isActive,
			isPublic,
			uid,
			paid
	)
	VALUES(
		#session.userId#,
		#createODBCDate(now())#,
		#session.mandant#,
		'#form.titel#',
		#form.isActive#,
		#form.isPublic#,
		'#replace(createUUID(),'-','','ALL')#',
		#form.paid#
	)
	</cfquery>
	
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>

<cfif isdefined("url.action") AND url.action EQ "submittedEditedMagazine">
	<cfquery name="updateMagazine" datasource="#application.dsn#">
	UPDATE	magazine
	SET		modifydate = #createODBCDate(now())#,
			titel = '#form.titel#',
			isActive = #form.isActive#,
			isPublic = #form.isPublic#,
			paid = #form.paid#
	WHERE	id = #form.magazinID#
	</cfquery>
	
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no">
</cfif>
<!--- -------------- ENDE form prozessors ------------------ --->

	<table width="100%">
		<cfoutput query="getMagazines" group="id">
			<cfquery name="getEditions" datasource="#application.dsn#">
			SELECT	*
			FROM	magazinAusgaben
			WHERE	magazinID = #id#
			</cfquery>
			<tr>
				<td width="50%">#titel#</td>
				<td>
					<cfif rightEdit EQ 1>
						<a href="#cgi.SCRIPT_NAME#?editMagazine=#id#">
							bearbeiten
						</a>
					</cfif>
				</td>
				<td>
					<cfif rightDel EQ 1>
						<a href="#cgi.SCRIPT_NAME#?delMagazine=#id#" onclick="return confirm('Sind Sie sicher?\nEs werden alle Ausgaben des Magazins ebenfalls gelöscht');">
							löschen
						</a>
					</cfif>
				</td>
				<td>
					<cfif getEditions.recordcount GT 0>
					<a href="javascript:$('##ausgaben#id#').toggle();void(0);">
						Magazin-Ausgaben
					</a>
					</cfif>&nbsp;
					<cfif rightAdd EQ 1>
						<a href="#cgi.SCRIPT_NAME#?action=addMagazinAusgabe&magazin=#id#">
							Magazin-Ausgaben +
						</a>
					</cfif>	
				</td>
			</tr>
			<tr>
				<td colspan="5">
					<div style="background-color:##e1e1e1;" id="ausgaben#id#">
						<table width="100%">
							<cfoutput group="aid">
							<cfif isNumeric(aid)>
							<cfquery name="getChapters" datasource="#application.dsn#">
							SELECT	*
							FROM	magazinKapitel
							WHERE	magazinAusgabeID = #aid#
							</cfquery>
							<tr>
								<td width="50%">#ausgabe#</td>
								<td>
									<cfif rightEdit EQ 1>
										<a href="#cgi.SCRIPT_NAME#?editMagazineEdition=#aid#">
											bearbeiten
										</a>
									</cfif>
								</td>
								<td>
									<cfif rightDel EQ 1>
										<a href="#cgi.SCRIPT_NAME#?delMagazineEdition=#aid#" onclick="return confirm('Sind Sie sicher?\nEs werden alle Kaptitel dieser Ausgabe ebenfalls gelöscht');">
											löschen
										</a>
									</cfif>
								</td>
								<td>
									<cfif getChapters.recordcount GT 0>
									<a href="javascript:$('##kapitel#aid#').toggle();void(0);">
										Magazin-Kapitel
									</a>
									</cfif>&nbsp;
									<cfif rightAdd EQ 1>
										<a href="#cgi.SCRIPT_NAME#?action=addMagazineChapter&magazinAusgabe=#aid#">
											Magazin-Kapitel +
										</a>
									</cfif>	
								</td>
							</tr>
							<tr>
								<td colspan="5">
									<div style="background-color:##e1e1e1;" id="kapitel#aid#">
										<table width="100%">
										<cfoutput group="kid">
											<cfif isNumeric(kid)>
											<cfquery name="getPages" datasource="#application.dsn#">
											SELECT	*
											FROM	magazinSeiten
											WHERE	parent = #kid#
											</cfquery>
											<tr>
												<td width="50%">#kapitel#</td>
												<td>
													<cfif rightEdit EQ 1>
														<a href="#cgi.SCRIPT_NAME#?editMagazineChapter=#kid#">
															bearbeiten
														</a>
													</cfif>
												</td>
												<td>
													<cfif rightDel EQ 1>
														<a href="#cgi.SCRIPT_NAME#?delMagazineChapter=#kid#" onclick="return confirm('Sind Sie sicher?\nEs werden alle Magazin-Seiten des Kapitels ebenfalls gelöscht');">
															löschen
														</a>
													</cfif>
												</td>
												<td>
													<cfif getPages.recordcount GT 0>
													<a href="javascript:$('##seiten#kid#').toggle();void(0);">
														Magazin-Seiten
													</a>
													</cfif>&nbsp;
													<cfif rightAdd EQ 1>
														<a href="#cgi.SCRIPT_NAME#?action=addMagazinPage&magazineChapter=#kid#">
															Magazin-Seite +
														</a>
													</cfif>	
												</td>
											</tr>
											<tr>
												<td colspan="5">
													<div style="background-color:##e1e1e1;" id="seiten#kid#">
														<table width="100%">
														<cfoutput group="sid">
															<cfif isNumeric(sid)>
															<tr>
																<td width="70%">#stitel#</td>
																<td>
																	<cfif rightEdit EQ 1>
																		<a href="#cgi.SCRIPT_NAME#?editMagazinPage=#sid#">
																			bearbeiten
																		</a>
																	</cfif>
																</td>
																<td>
																	<cfif rightDel EQ 1>
																		<a href="#cgi.SCRIPT_NAME#?delMagazinPage=#sid#" onclick="return confirm('Sind Sie sicher?\nEs werden alle Inhalte der Seite ebenfalls gelöscht');">
																			löschen
																		</a>
																	</cfif>
																</td>
															</tr>
															</cfif>
															</cfoutput>
														</table>
													</div>
												</td>
											</tr>
											</cfif>
											</cfoutput>
										</table>
									</div>
								</td>
							</tr>
							</cfif>
							</cfoutput>
						</table>
					</div>
				</td>
			</tr>
		</cfoutput>
	</table>
	<cfoutput><a href="#cgi.SCRIPT_NAME#?action=addMagazine">neues Magazin eröffnen</a></cfoutput>

	<br><br>
	
	<cfif isdefined("url.action") AND url.action EQ "addMagazine">
		<cfinclude template="inc_addMagazine.cfm" />
	</cfif>
	
	<cfif isdefined("url.editMagazine") AND isNumeric(url.editMagazine) AND url.editMagazine GT 0>
		<cfinclude template="inc_editMagazine.cfm" />
	</cfif>
	
	<cfif isdefined("url.editMagazineChapter") AND isNumeric(url.editMagazineChapter) AND url.editMagazineChapter GT 0>
		<cfinclude template="inc_editMagazineChapter.cfm" />
	</cfif>
	
	<cfif isdefined("url.action") AND url.action EQ "addMagazineChapter">
		<cfinclude template="inc_addMagazineChapter.cfm" />
	</cfif>
	
	<cfif isdefined("url.action") AND url.action EQ "addMagazinAusgabe">
		<cfinclude template="inc_addMagazineAusgabe.cfm" />
	</cfif>
	
	<cfif isdefined("url.editMagazineEdition") AND isNumeric(url.editMagazineEdition) AND url.editMagazineEdition GT 0>
		<cfinclude template="inc_editMagazineAusgabe.cfm" />
	</cfif>
	
	<cfif isdefined("url.action") AND url.action EQ "addMagazinPage">
		<cfinclude template="inc_addMagazinePage.cfm" />
	</cfif>
	
	<cfif isdefined("url.editMagazinPage") AND isNumeric(url.editMagazinPage) AND url.editMagazinPage GT 0>
		<cfinclude template="inc_editMagazinePage.cfm" />
	</cfif>

