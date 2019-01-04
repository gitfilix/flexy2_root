<cfprocessingdirective pageencoding="utf-8" />
<ul>
	<!--- get all Themennav --->
	<cfoutput query="getThemenNav">
		<!--- if Themennav is first of Navtree its Active -> add class --->
	<li <cfif listfirst(session.navtree) EQ id>class="themennav_active"</cfif>>
		<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#" <cfif id EQ listFirst(session.navtree)>class="themennav_active" style="color:##A33 !important; <!--- border-bottom:##933 1px solid --->"</cfif>>
			#navtitel#
		</a>
		<!--- second, get subnavigation from actual Themennav-id--->
		<cfquery name="getsubnav2" datasource="#application.dsn#">
		SELECT * FROM pages
		WHERE 	parentid = #id# 
				AND isactive = 1 
		ORDER 	BY navorder
		</cfquery>
		<!--- if there are subnav-pages AND they have a parent id (Trägerseite) EQ id --->
		<cfif getsubnav2.recordcount NEQ 0 AND listfirst(session.navtree) EQ id> 
			<ul class="subnav">	
				<!--- loope through the subpages and list them  --->
				<cfloop query="getsubnav2">
				<!--- if list-last in session.navtree -> then subnav active --->
				<li <cfif listlast(session.navtree) EQ id>class="subnav_active"</cfif>>
					<a  class="arrow" href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#" <cfif id EQ listLast(session.navtree)>style="color:##A33 !important;"</cfif>>
						#navtitel#
					</a>
				</li>
				</cfloop>
			</ul>
		</cfif> 
	</li>
	</cfoutput>
</ul>