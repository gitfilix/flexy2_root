<cfprocessingdirective pageencoding="utf-8" />

<cfinclude template="prc_pageprocessing.cfm" />

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
<!--- RECHTE UND MASKENFREIGABEN --->
<cfquery name="getMandantenModules" datasource="#application.dsn#">
SELECT 	* 
FROM 	mandantenmodules
WHERE	mandantenID = '#session.mandant#'
</cfquery>
<cfset MandantenModules = "" />
<cfoutput query="getMandantenModules">
	<cfset MandantenModules = listAppend(MandantenModules,moduleid) />
</cfoutput>
<!--- wenn der mandant dieses users das modul headerpanels hat. der wert 4 ist hardgecodede moduleID --->
<cfif ListFind(MandantenModules,4)>
	<cfset HasHeaderPanels = true />
<cfelse>
	<cfset HasHeaderPanels = false />
</cfif> 
<!--- wenn der mandant dieses users das modul gallerymanagement hat. der wert 6 ist hardgecodede moduleID --->
<cfif ListFind(MandantenModules,6)>
	<cfset HasGallery = true />
<cfelse>
	<cfset HasGallery = false />
</cfif> 
<!--- wenn der mandant dieses users das modul teasermanagagement hat. der wert 3 ist hardgecodede moduleID --->
<cfif ListFind(MandantenModules,3)>
	<cfset HasSidebar = true />
	<cfset HasTeasers = true />
<cfelse>
	<cfset HasSidebar = false />
	<cfset HasTeasers = false />
</cfif> 
<!--- wenn der mandant dieses users das modul closed user gfroup hat. der wert 3 ist hardgecodede moduleID --->
<cfif ListFind(MandantenModules,13)>
	<cfset hasCUG = true />
<cfelse>
	<cfset hasCUG = false />
</cfif> 
<!--- wenn der mandant dieses users das modul NEWS hat. der wert 9 ist hardgecodede moduleID --->
<cfif ListFind(MandantenModules,9)>
	<cfset hasNews = true />
<cfelse>
	<cfset hasNews = false />
</cfif> 
<!--- wenn der mandant dieses users das modul TEAM hat. der wert 14 ist hardgecodede moduleID --->
<cfif ListFind(MandantenModules,14)>
	<cfset hasTeam = true />
<cfelse>
	<cfset hasTeam = false />
</cfif> 
<!--- hier können noch spezifische funktionsfreigaben vergeben werden --->
<!--- ENDE RECHTE UND MASKENFREIGABEN --->


<!--- ---------------------------------------------------------------------------------------------------------- --->
<!--- create function of creating pagerow with content --->
<cffunction name="displayPageWithContents" access="public" returntype="string" output="yes">
	<cfargument name="pageId" required="yes" />
	<cfargument name="level" required="yes" />
	
	<cfquery name="getPage" datasource="#application.dsn#">
	SELECT	*
	FROM	pages
	WHERE	id = #arguments.pageid# AND
			mandant = #session.mandant# AND
			lang = '#session.lang#'
	</cfquery>
	
	<cfoutput query="getPage">
	<tr>
		<td><input  type="checkbox"/></td>
		<td style="padding-left:<cfif arguments.level EQ 1>6<cfelseif arguments.level EQ 2>20<cfelseif arguments.level EQ 3>40<cfelseif arguments.level EQ 3>60<cfelseif arguments.level EQ 4>80<cfelseif arguments.level EQ 5>100</cfif>px;"> #pagetitel#</td>
		<td>
			<cfif isactive EQ 1>
				aktiv
			<cfelse>
				inaktiv
			</cfif>
		</td>
		<td>
			#template#
		</td>
		<td class="options-width">
		<cfif rightEdit EQ 1><a href="#cgi.SCRIPT_NAME#?editpage=#id#" title="Edit" class="icon-1 info-tooltip"></a></cfif>
		<cfif rightDel EQ 1><a href="#cgi.SCRIPT_NAME#?delpage=#id#" onclick="return confirm('Sind Sie sicher?');" title="Edit" class="icon-2 info-tooltip"></a></cfif>
		<cfif rightCopy EQ 1><a href="#cgi.SCRIPT_NAME#?copypage=#id#" title="Edit" class="icon-3 info-tooltip"></a></cfif>
		<cfquery name="getContentsByChildPageID" datasource="#application.dsn#">
		SELECT	*
		FROM	content
		WHERE	pageid = #id#
		ORDER	BY reihenfolge
		</cfquery>
		
		<cfif rightAdd EQ 1>
			<a href="#cgi.SCRIPT_NAME#?action=addContent&pageID=#id#" class="icon-5 info-tooltip"></a>
		</cfif>
		</td>
		<td class="contents-width">
		<cfif getContentsByChildPageID.recordcount GT 0>
			<a href="javascript:$('##inhalte#id#a').toggle();void(0);" class="icon-4 info-tooltip"></a>
		</cfif>
		</td>
	</tr>
	#displayContents(pageid=arguments.pageid,level=level)#
	</cfoutput>
</cffunction>

<cffunction name="displayContents" access="public" returntype="string">
	<cfargument name="pageId" required="yes" />
	<cfargument name="level" required="yes" />
	
	<cfquery name="getContents" datasource="#application.dsn#">
	SELECT	*
	FROM	content
	WHERE	pageid = #arguments.pageid#
	</cfquery>
	
	<cfif getContents.recordcount GT 0>
		<tr >
			<td colspan="7" <cfif session.viewPages EQ 0>style="display:none;"</cfif> <cfoutput>id="inhalte#arguments.pageid#a"</cfoutput>>
				<div style="background-color:#e2e2e2;">
					<table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
					<tr>
						<th class="table-header-check"><a id="toggle-all" ></a></th>
						<th class="table-header-repeat line-left minwidth-1"><a href="">Inhalts-Titel</a></th>
						<th class="table-header-options line-left"><a href="">Options</a></th>
					</tr>	
					<cfoutput query="getContents">
						<tr>
							<td><input  type="checkbox"/></td>
							<td style="padding-right:<cfif arguments.level EQ 1>20<cfelseif arguments.level EQ 2>40<cfelseif arguments.level EQ 3>60<cfelseif arguments.level EQ 3>60<cfelseif arguments.level EQ 4>80<cfelseif arguments.level EQ 5>120</cfif>px;">Inhalt: #titel#</td>
							<td>
								<cfif rightEdit EQ 1><a href="#cgi.SCRIPT_NAME#?editcontent=#id#" title="Edit" class="icon-1 info-tooltip"></a></cfif>
								<cfif rightDel EQ 1><a href="#cgi.SCRIPT_NAME#?delcontent=#id#" onclick="return confirm('Sind Sie sicher?');" title="Edit" class="icon-2 info-tooltip"></a></cfif>
								<cfif rightCopy EQ 1><a href="#cgi.SCRIPT_NAME#?copycontent=#id#" title="Edit" class="icon-3 info-tooltip"></a></cfif>
							</td>
						</tr>
					</cfoutput>
					</table>
				</div>
			</td>
		</tr>
	</cfif>
	
</cffunction>

<!--- liste mit allen Seiten darstellen mit eingerückten kindern --->
<cfif cgi.QUERY_STRING EQ "" OR isdefined("url.module") OR isdefined("url.viewx") OR isdefined("url.lang")>

<!--  start page-heading -->
<div id="page-heading">
	<h1>CMS | Seiten &amp; Inhalts-Management</h1>
</div>
<!-- end page-heading -->

<div id="table-content">
<table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
<tr>
	<th rowspan="3" class="sized"><img src="images/shared/side_shadowleft.jpg" width="20" height="300" alt="" /></th>
	<th class="topleft"></th>
	<td id="tbl-border-top">&nbsp;</td>
	<th class="topright"></th>
	<th rowspan="3" class="sized"><img src="images/shared/side_shadowright.jpg" width="20" height="300" alt="" /></th>
</tr>
<tr>
	<td id="tbl-border-left"></td>
	<td>
	<!--  start content-table-inner ...................................................................... START -->
	<div id="content-table-inner">
	
		<!--  start table-content  -->
		<div id="table-content">

			<!--  start product-table ..................................................................................... -->
			<form id="mainform" action="">
			<!--- pageansicht toggeln --->
			<script>
			function toggler(){
				if($('#toggler:checked').val()==1){
					x = 1;
				}
				else{
					x = 0;
				}	
				<cfoutput>location.href='#cgi.SCRIPT_NAME#?viewx='+x;</cfoutput>
			}
			</script>
			<cfif cgi.QUERY_STRING EQ "" OR isdefined("url.viewx") OR isdefined("url.module") OR isdefined("url.lang")>
			<input type="checkbox" name="toggler" value="1" onchange="toggler()" id="toggler" <cfif session.viewpages EQ 1>checked="checked"</cfif> /> Alle offen anzeigen
			<br/><br/></cfif>
			<!--- ENDE pageansicht toggeln --->
			<table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
			<tr>
				<th class="table-header-check"><a id="toggle-all" ></a> </th>
				<th class="table-header-repeat line-left minwidth-1"><a href="">Seitename</a>	</th>
				<th class="table-header-repeat line-left minwidth-1"><a href="">Status</a></th>
				<th class="table-header-repeat line-left"><a href="">Template</a></th>
				<th class="table-header-options line-left"><a href="">Options</a></th>
				<th class="table-header-contents line-left"><a href="">Inhalte</a></th>
			</tr>
			<cfset posType = 0 />
			<cfset pageidx = 0 />
			<cfoutput query="getAll5Levels" group="pid">
				<cfset posType = pnavpos />
				#displayPageWithContents(pageid=pid,level=1)#
				<cfoutput group="paid">
					<cfif anzahlLevels GTE 2>
						<cfif paid NEQ "">
							#displayPageWithContents(pageid=paid,level=2)#
						</cfif>
						<cfoutput group="pbid">
							<cfif anzahlLevels GTE 3>
								<cfif pbid NEQ "">
									#displayPageWithContents(pageid=pbid,level=3)#
								</cfif>
								<cfoutput group="pcid">
									<cfif anzahlLevels GTE 4>
										<cfif pcid NEQ "">
											#displayPageWithContents(pageid=pcid,level=4)#
										</cfif>
										<cfoutput group="pdid">
											<cfif anzahlLevels EQ 5>
												<cfif pdid NEQ "">
													#displayPageWithContents(pageid=pdid,level=5)#
												</cfif>
											</cfif>
										</cfoutput>
									</cfif>
								</cfoutput>
							</cfif>
						</cfoutput>
					</cfif>
				</cfoutput>
			</cfoutput>
			</table>
			<!--  end product-table................................... --> 
			</form>
		</div>
		<!--  end content-table  -->
	
		<!--  start actions-box ............................................... -->
		<div id="actions-box">
			<a href="" class="action-slider"></a>
			<div id="actions-box-slider">
				<cfif NOT isdefined("url.editPage")>
				<a href="" class="action-edit">Neue Seite anlegen</a>
				</cfif>
				<a href="" class="action-delete">gewählte löschen</a>
			</div>
			<div class="clear"></div>
		</div>
		<!-- end actions-box........... -->
		
		<!--  start paging..................................................... -->
		<!--- <table border="0" cellpadding="0" cellspacing="0" id="paging-table">
		<tr>
		<td>
			<a href="" class="page-far-left"></a>
			<a href="" class="page-left"></a>
			<div id="page-info">Page <strong>1</strong> / 15</div>
			<a href="" class="page-right"></a>
			<a href="" class="page-far-right"></a>
		</td>
		<td>
		<select  class="styledselect_pages">
			<option value="">Number of rows</option>
			<option value="">1</option>
			<option value="">2</option>
			<option value="">3</option>
		</select>
		</td>
		</tr>
		</table> --->
		<!--  end paging................ -->
		
		<div class="clear"></div>
	 
	</div>
	<!--  end content-table-inner ............................................END  -->
	</td>
	<td id="tbl-border-right"></td>
</tr>
<tr>
	<th class="sized bottomleft"></th>
	<td id="tbl-border-bottom">&nbsp;</td>
	<th class="sized bottomright"></th>
</tr>
</table>
	
</div>
<div class="clear">&nbsp;</div>

<br/>
</cfif>
<!--- dies erscheint nur wenn neue page hinzufügen gewählt wurde --->
<cfoutput>
<cfif isdefined("url.action") AND url.action EQ "addPage">
	<cfinclude template="inc_addPage.cfm" />
</cfif>
</cfoutput>

<!--- dies erscheint nur wenn Seite bearbeiten gewählt wurde --->
<cfif isdefined("url.editPage") AND isNumeric(url.editPage) AND url.editPage GT 0>
	<cfinclude template="inc_editPage.cfm" />
</cfif>
<br><br>
<cfif isdefined("url.action") AND url.action EQ "addContent">
	<cfinclude template="inc_addContent.cfm" />
</cfif>

<cfif isdefined("url.editcontent") AND isNumeric(url.editcontent) AND url.editcontent GT 0>
	<cfinclude template="inc_editContent.cfm" />
</cfif>