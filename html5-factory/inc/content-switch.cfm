
<!--- load all the content --->
<cfoutput query="getcontent">
	
	<!--- is there a contact form then contact --->
	<cfif HASCONTACT EQ 1>
			<cfinclude template="contactform.cfm">
	<!--- is there a album load it  --->
	<cfelseif albumid NEQ 0>
		<cfinclude template="content_bxslider.cfm">
	</cfif>
	<!--- all normal cases: load content top and contact text --->
	<cfif HASCONTACT EQ 0 AND albumid EQ 0>
		<!--- include subnav on top --->
		<cfinclude template="subnav.cfm">
		<cfinclude template="content-top.cfm">
		<cfinclude template="content-text.cfm">	
	</cfif>	
</cfoutput>