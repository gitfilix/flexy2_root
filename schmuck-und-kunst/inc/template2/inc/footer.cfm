<cfprocessingdirective pageencoding="utf-8">
<cfoutput query="getFooter">
	<div class="fifth copy">
		&copy; 2013 by #copyright#
		
	</div>
	<div class="twothird">	
		<div class="footradress">Atelier Schief, #adresse#</div>
		<br />
		<span class="lastupdate">Letztes Update: #DateFormat(modifyDate)#</span>
	</div>	
	<div >
	 	<span class="author">Design & Code:<br />
			<a href="http://www.web-kanal.ch" target="_blank">&harr; web-kanal</a>
		</span>
	</div>	
	
</cfoutput>	
