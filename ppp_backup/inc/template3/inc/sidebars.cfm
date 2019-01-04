<!---alle Sidebar contents aus der db lesen und pasten--->

<cfoutput query="getSidebarElems">
<div class="third bg_gray">
	<cfif titel NEQ "">
		<h2>#titel#</h2>
	<cfelse>
		<h2>hello kitty</h2>
	</cfif>
	<cfif image NEQ "">
		<img src="upload/img/#image#" width="100%" alt="" hspace="3" />
	<cfelse>
		<br>-no pix<br>
	</cfif>
	<br>
	<article>
	<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />" >
		<p>#fliesstext#</p>
	</article>
		<cfelse>
	<!--- print some lorem  --->
	tudin ac sodales sed, malesuada ut arcu. Fusce placerat aliquam scelerisque. 
	<br>Quisque leo tellus, aliquet semper commodo a, aliquam in tortor. Nullam tincidunt fermentum est... 
	</p>
	</cfif>
</div>
</cfoutput>

<!--- 			


<cfoutput query="getSidebarElems">
	<div class="sidebar-elem">
		<cfif titel NEQ "">
			<div class="bold" style="padding:20px;">#titel#</div>
		</cfif>
		<cfif image NEQ "">
			<img src="upload/img/#image#" width="100%" alt="" hspace="3" />
		</cfif>
		<div style="padding:20px;">
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
				#fliesstext#
			</cfif>
			<cfif href NEQ "" AND hreflabel NEQ "">
				<a href="#href#" title="#hreflabel#" target="_blank">#hreflabel#</a>
			</cfif>
		</div>
	</div>
</cfoutput> --->