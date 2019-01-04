<cfoutput query="getcontent">
	<article>
		<header class="lead">
			<h1>
				<cfif titel NEQ "">
					<h2>#titel#</h2>
				</cfif>
			</h1>
			<cfif lead NEQ "">
				<div>
				<!---  PRint the lead --->
				 <h5>#lead#</h5>
				 <cfelse>
				 <!--- 	 Print some hardcoded Lorem Ipsum ---> 
				Fusce varius purus id mauris feugiat vestibulum. Proin non sem purus, eget fringilla lorem. 
				</div>
			</cfif>
		</header>

	
	<div class="contentframe">
		<cfif bildname NEQ "">
			<figure>
				<img <!--- class="content_pix" ---> src="/#session.serverpath#/upload/img/#bildname#" alt="" >
			</figure> 
		</cfif>
		
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
		<!--- Print out Fliesstext --->
		<div class="fliesstext">
			#fliesstext#
		</div>
		<cfelse>
			<!--- Print some hardcoded LoremIpsum  --->
			Suspendisse potenti.Nullam felis lacus; iaculis eget cursus ac, varius vitae ante. Aliquam malesuada blandit quam, eu malesuada sapien placerat ut. Donec diam massa, euismod sed fermentum ut, viverra nec risus. Praesent auctor varius odio vitae ullamcorper! Curabitur leo urna, tempus at sagittis vel, molestie id est. Praesent venenatis egestas enim, et tincidunt velit porta tempor! Quisque eu placerat leo!
		</cfif>
		

		<cfif href NEQ "">
			<br/><br/>
			<a href="#href#" target="_blank">
				#hreflabel#
			</a>
		</cfif>
		
		<cfif doc NEQ "">
			<br/><br/>
			<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank">
				#doclabel#
			</a><br/><br/>
		</cfif>
	 </div>	
	 <div class="clear"></div>
	 
	<!--- 	AlbumID muss gegeben werden da im getContent -SQL  --->
		<cfif albumid NEQ 0>
			<cfinclude template="gallery.cfm" />
		</cfif>
		
	</article>
</cfoutput>



<!--- 

	<div class="lead">
					<h2>Willkommen</h2>
					<br>
					<p>Ut molestie quam viverra lectus lobortis rutrum. Vestibulum vitae ante augue. Cras mattis sodales mauris, eget.</p>
					<br>
			</div> 
			<div class="fliesstext">
					<figure>
						<img  class="pix_right" src="pix/kenna4.jpg" alt="">
					</figure>
					<article>
						Nam metus mi, elementum ut pellentesque eget, sodales eu purus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
						<br>Ipsum facilisis dapibus et non velit. Quisque viverra dictum tincidunt. Fusce vitae nisl a massa porttitor tincidunt.
						 Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
					</article>
						<br>
						<a href="#" >
						link to 1
						</a>
					<br>
			</div> --->