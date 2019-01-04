<cfprocessingdirective pageencoding="utf-8" />
<ul>
	<cfoutput query="getThemenNav">
	<li <cfif listfirst(session.navtree) EQ id>class="themennav_active"</cfif>>
		<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#" <cfif id EQ listFirst(session.navtree)>class="themennav_active"</cfif>>
			#navtitel#
		</a>
		<cfquery name="getsubnav2" datasource="#application.dsn#">
		SELECT * FROM pages
		WHERE 	parentid = #id# 
				AND isactive = 1 
		ORDER 	BY navorder
		</cfquery>
		<cfif getsubnav2.recordcount NEQ 0 AND listfirst(session.navtree) EQ id> 
			<ul>
				<cfloop query="getsubnav2">
				<li <cfif listlast(session.navtree) EQ id>class="subnav_active"</cfif>>
					<a  class="arrow" href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#" <cfif id EQ listLast(session.navtree)>style="color:red !important;"</cfif>>
						#navtitel#
					</a>
				</li>
				</cfloop>
			</ul>
		</cfif> 
	</li>
	</cfoutput>
</ul>