<cfprocessingdirective pageencoding="utf-8" />
	<cfoutput query="getThemenNav">
	<!--- get inhalte --->
	<cfquery name="getcontent" datasource="#application.dsn#">
	SELECT 	* FROM content
	WHERE 	pageid = #id# AND isactive = 1
	ORDER	BY reihenfolge
	</cfquery>
	<dt class="panel">
			<a href="#trim(application.com.nav.rewriteLinkById(id=id,lang=lang))#">
			<img src="/#session.serverpath#/upload/img/#headerbild#" class="headerpix" >
				<h1>#navtitel#</h1>
			</a>
		 	<!---  <cfdump var="#getcontent#">  --->
			<dd class="content">
			<cfloop query="getcontent">	
				<h2>#titel#</h2>
				<h3>#lead#</h3>
				<br/>
				<cfif bildname NEQ "">
				<div class="pix-content">
					<figure>
						<img src="/#session.serverpath#/upload/img/#bildname#" alt="alt tag" >
						<figcaption>#IMAGECAPTION#</figcaption>
					</figure>
				</div>
				</cfif>
				<article >
					#fliesstext#
				</article>
				<cfif hreflabel NEQ "">
					<div class="content-service-link">
					<a href="#HREF#" target="_blank">#hreflabel#</a>
						</div>
				</cfif>
				<div class="clear"></div>
				<!--- include Gallery albumm thumbnails herer --->
				<cfif albumid NEQ 0>
					<div class="gallery-content">
						<cfinclude template="gallery.cfm">
					</div>
					<br/ >		
				</cfif>
			</cfloop>
			</dd>
			<br/ >				
	</dt>
</cfoutput>
