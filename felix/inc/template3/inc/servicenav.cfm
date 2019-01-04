<cfprocessingdirective pageencoding="utf-8" />
<ul>
	<cfoutput query="getServiceNav">
	<li>
		<a href="/#session.serverpath#/#urlshortcut#/">
			#navtitel#
		</a>
	 </li>
	</cfoutput>
</ul>
