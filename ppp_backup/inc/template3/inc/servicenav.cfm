<cfprocessingdirective pageencoding="utf-8" />
<ul>
	<cfoutput query="getServiceNav">
	<li>
		<a href="/#session.serverpath#/#urlshortcut#/">
			#pagetitel#
		</a>
	 </li>
	</cfoutput>
</ul>
