<cfprocessingdirective pageencoding="utf-8" />
	<nav>
		<ul>
		<cfoutput query="getServiceNav">
			<li <cfif id EQ url.id>class="servicenav_active"</cfif>>
				<!--- homelink --->
				<cfif id EQ session.startID AND ownDomain NEQ "">
					<a href="http://www.#ownDomain#">
						#pagetitel#
					</a>
				<!--- jeder andere link --->
				<cfelse>
					<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
						#pagetitel#
					</a>
				</cfif>
			</li>	
		</cfoutput>
		</ul>	
	</nav>