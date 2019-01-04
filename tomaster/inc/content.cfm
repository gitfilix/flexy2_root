<cfoutput query="getcontent">
	<cfif HASCONTACT EQ 1>
			<cfinclude template="contactform.cfm">
	<cfelse>
	<article class="content">
		<header>
			<!--- Print a Title --->	
			<cfif titel NEQ "">
					<h1>#titel#</h1>
			</cfif>
			
			<!---  PRint the lead --->
			<cfif lead NEQ "">
				<div>
				 	<h2>#lead#</h2>
				</div>	
			<cfelse>
					 <!--- 	 Print some hardcoded Lorem Ipsum ---> 
					Fusce varius purus id mauris feugiat vestibulum. Proin non sem purus, eget fringilla lorem. 
			</cfif>
		</header>
		
		 <!--- Show Content Image --->
		 <cfif bildname NEQ "">
			<figure class="image-left">
				<img src="/#session.serverpath#/upload/img/#bildname#" alt="alt tag" >
			</figure> 
		</cfif>
		<!--- Print out Fliesstext --->
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<section>#fliesstext#</section>
		<cfelse>
		<!--- OR: Print some hardcoded LoremIpsum  --->
			 Praesent venenatis egestas enim, et tincidunt velit porta tempor! Quisque eu placerat leo!
		</cfif>
		<!--- Href link  --->
		<cfif href NEQ "">
			<br />
			<div class="contentlink" >
				<a href="#href#" target="_blank" >
					#hreflabel#
				</a>
			</div>					
		</cfif>
		<!--- 	additional links if there are more then one --->
		<cfquery name="getAdditionalLinks" datasource="#application.dsn#">
		SELECT 	*
		FROM	links2pages
		WHERE	contentid = #id#
		</cfquery>
		<cfif getAdditionalLinks.recordcount GT 0>
			<cfloop query="getAdditionalLinks">
				<div class="contentlink">
					<a href="#HREF#" target="_blank">#HREFLABEL#</a><br/>
				</div>
			</cfloop>
		</cfif>
		<!--- doc link --->
		<cfif doc NEQ "">
			<div>
				<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank" >
					#doclabel#
				</a>
			</div>
		</cfif>
		<!--- 	additional docs if there are more then one --->
		<cfquery name="getAdditionaldocs" datasource="#application.dsn#">
		SELECT 	*
		FROM	docs2pages
		WHERE	contentid = #id#
		</cfquery>
		<cfif getAdditionaldocs.recordcount GT 0>
			<cfloop query="getAdditionaldocs">
				<div>
				<a href="/#session.serverpath#/upload/doc/#dok#" target="_blank">
					#doklabel#
				</a>
				</div>
			</cfloop>
		</cfif>	
	</article>
	</cfif> 
	<!--- include gallery, if there is one --->
	<cfif albumid NEQ 0>
		<cfinclude template="gallery.cfm">
	</cfif>
</cfoutput>