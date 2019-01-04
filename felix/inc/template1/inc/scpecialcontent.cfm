<h2>I AM special 2!</h2>
<cfoutput query="getContent">
<div id="specialcontent" style="background:#F00;">	
		<figure>
			<cfif BILDNAME NEQ "">
					<img src="/#session.serverpath#/upload/img/#bildname#" alt="hi" />
			</cfif>
		</figure>
		<br />
		<p id="pic_desc">#IMAGECAPTION#</p>
</div>
</cfoutput>