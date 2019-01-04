<!--- navigation for mobiles only --->
<cfprocessingdirective pageencoding="utf-8" />
<header>
	<nav>
	<div id="mobileNav">
		
		<div class="mobileNav_logo">WEBkanal.ch</div>
		
		<a href="">
			<cfoutput><img src="/#session.serverpath#/img/settings.gif" alt="" /></cfoutput>
		</a>

		<!--- <cfoutput>#application.com.nav.GenerateNav(navpos=3,ParentID=0,level=0,type=4,usergroup=0,mandant=session.mandant,lang=session.lang)#</cfoutput> --->
			
		<ul <!--- style="background-color:#022e51;" --->>
		<!--- Themennavigation PLUS subnavigation  --->
			<!--- get all Themennav --->
			<cfoutput query="getNavMobile">
				<!--- if Themennav is first of Navtree its Active -> add class --->
			<li <cfif listfirst(session.navtree) EQ id>class="themennav_active"</cfif>>
				
				<!--- second, get subnavigation from actual Themennav-id--->
				<cfquery name="getsubnav2" datasource="#application.dsn#">
				SELECT * FROM pages
				WHERE 	parentid = #id# 
						AND isactive = 1 
				ORDER 	BY navorder
				</cfquery>
				<a <cfif getSubnav2.recordcount GT 0>onclick="$(this).next().slideToggle();"</cfif> href="<cfif getSubnav2.recordcount GT 0>javascript:void(0);<cfelse>#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#</cfif>" <cfif id EQ listFirst(session.navtree)>class="themennav_active" style="color:##f15200 !important; <!--- border-bottom:##933 1px solid --->"</cfif>>
					#navtitel#
				</a>
				<!--- if there are subnav-pages AND they have a parent id (Trägerseite) EQ id --->
				<cfif getsubnav2.recordcount NEQ 0> 
					<ul class="subnav" style="display:none;">	
						<li>
							<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
								#navtitel#
							</a>
						</li>
						<!--- loope through the subpages and list them  --->
						<cfloop query="getsubnav2">
						<!--- if list-last in session.navtree -> then subnav active --->
						<li <cfif listlast(session.navtree) EQ id>class="subnav_active"</cfif>>
							<a  class="arrow" href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
								#navtitel#
							</a>
						</li>
						</cfloop>
					</ul>
				</cfif> 
			</li>
			</cfoutput>
		</ul>
	</div>
	</nav>
</header>
<div class="clear"></div>