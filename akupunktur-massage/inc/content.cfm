<cfoutput query="getcontent">
	<cfif HASCONTACT EQ 1>
			<cfinclude template="contactform.cfm">
	<cfelse>
	<article class="content">
		<header>
			<!--- Print a Title --->	
			<cfif titel NEQ "">
					<cfif url.id EQ session.startID>
						<h3>#titel#</h3>
					<cfelse>
						<h1>#titel#</h1>
					</cfif>
			</cfif>
			<!---  PRint the lead --->
			<cfif lead NEQ "">
				<div>
				 	<cfif url.id EQ session.startID>
						<h4>#lead#</h4>
					<cfelse>
						<h2>#lead#</h2>
					</cfif>
				</div>	
			<cfelse>
				&nbsp;<br />
			</cfif>
		</header>
		 <!--- Show Content Image --->
		 <cfif bildname NEQ "">
				<figure
					<cfif imagePos EQ 0>
						id="PixPos_left"
						<cfelseif imagePos EQ 1>
						id="PixPos_right"
						<cfelseif imagePos EQ 2>
						id="PixPos_large"
					</cfif> >
					<img src="/#session.serverpath#/upload/img/#bildname#" alt="#bildname#" />
					<cfif IMAGECAPTION NEQ "">
						<div class="image-desc-box">
							<p>#IMAGECAPTION#</p>
						</div>
					</cfif>
				</figure>	
		</cfif>
		<!--- Print out Fliesstext --->
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<div class="fliesstext">#fliesstext#</div>
			<cfelse>
		<!--- OR: Print some hardcoded LoremIpsum  --->
			 Praesent venenatis egestas enim, et tincidunt velit porta tempor! Quisque eu placerat leo!
		</cfif>
		<!--- Href link  --->
		<cfif href NEQ "">
			<br/><br/>
			<a href="#href#" target="_blank">
				#hreflabel#
			</a>
		</cfif>
		<!--- doc link --->
		<cfif doc NEQ "">
			<br/><br/>
			<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank">
				#doclabel#
			</a><br/><br/>
		</cfif>
		<div class="clear"></div> 
	</article>
	</cfif> 
	<!--- include gallery, if there is one --->
	<cfif albumid NEQ 0>
		<cfinclude template="gallery.cfm">
	</cfif>
</cfoutput>