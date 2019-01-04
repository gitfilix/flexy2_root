
<cfloop query="getcontent">
	<!---ge-groupter querry da left join--->
	<cfquery name="getAlbumWithImages" datasource="#application.dsn#">
	SELECT A.id as albumid, A.Albumtitle,A.albumdescription,I.*
	FROM	albums A LEFT JOIN albumimages I ON I.albumID = A.id
	WHERE A.id = #albumid#
	</cfquery>
	<!---da groupter output, darf output in output hier abgefragt werden--->
	<!--- 	<cfdump var="#getAlbumWithImages#">  --->
	<div class="slider-wrapper">
		<ul class="bxslider">
			<cfoutput query="getAlbumWithImages" group="albumid">	
			<cfoutput>	
				<li> 
					<img src="/#session.serverpath#/upload/galleries/#imagepath#" alt="d" />
					 <div class="slider-desc">	
						<h5>#imageTitle#</h5>
						<br />
						<h4>#imageCaption#</h4>
						<br/ >
						<p>Webkanal Work:</p>
						<br />
						<h2>#imageowner#</h2>
					</div>
				</li>
			</cfoutput>
		</cfoutput>
		</ul>
	</div>
</cfloop>
	<!--- lower content part here --->
<cfoutput query="getcontent">
	<div class="lowercontent">
		<article class="text-content">
					<h3>#lead#</h3>
					<br />
					<!--- Print out Fliesstext --->
				<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
					<section>
						#fliesstext#		
					</section>
				<cfelse>
				<!--- OR: Print some hardcoded LoremIpsum  --->
				 Praesent venenatis egestas enim, et tincidunt velit porta tempor! Quisque eu placerat leo!
				</cfif>
				<!--- Href link  --->
				<cfif href NEQ "">
					<br />
					<div class="contentlink">
					<a href="#href#" target="_blank" >
						#hreflabel#
					</a>
					</div>
					<br />
				</cfif>
				<!--- doc link --->
				<cfif doc NEQ "">
					<br />
					<div class="contentlink">
					<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank" >
						#doclabel#
					</a>
					</div>
					<br />
				</cfif> 	
		</article>
	</div>
</cfoutput>



<!--- <cfdump var="#getAlbumWithImages#"> ---> 