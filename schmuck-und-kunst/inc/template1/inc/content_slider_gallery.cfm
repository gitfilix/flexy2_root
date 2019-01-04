<cfprocessingdirective pageencoding="utf-8">
<!--- get all content first --->

<cfoutput query="getcontent">
	<article>
		<header>
			
				<cfif titel NEQ "">
					<h1 style="font-size:2.1em; padding-top:20px;">#titel#</h1>
				</cfif>
			
	
			<cfif lead NEQ "">
				<!---  PRint the lead --->
				 <h2 style="margin-bottom:1.3em;">#lead#</h2>
			</cfif>
		</header>
		<cfif bildname NEQ "">
			<figure class="image-left" style="width:33%;">
				<img src="/#session.serverpath#/upload/img/#bildname#" alt="">
			</figure> 
		</cfif>
		
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
		<!--- Print out Fliesstext --->
			#fliesstext#
		</cfif>
		
		<cfif bildname NEQ ""><div class="clear"></div></cfif>
		<cfif href NEQ "">
			<br/>
			<a href="#href#" target="_blank">
				#hreflabel#
			</a>
		</cfif>
		
		<cfif AlbumID NEQ "" >
			<h2>content hat ein Album</h2>
			
		<!--- lets try to include gallery output here --->
		<cfinclude template="slider_gallery.cfm">
	
		</cfif>
</cfoutput>






