<cfprocessingdirective pageencoding="utf-8" />
		<ul>
		<cfoutput query="getsubnav">
			<li>
				<a href="/#session.serverpath#/#urlshortcut#" class="arrow">
				#pagetitel#
				</a>
			</li>
		</cfoutput>
		</ul>

