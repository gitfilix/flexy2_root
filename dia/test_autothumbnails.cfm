
<cffunction access="public" name="makeURLthumbNail" returntype="any" output="yes">
	
	<cfargument name="urladdress" type="string" required="yes" />
	<cfargument name="width" type="numeric" required="no" default="640" />
	<cfargument name="height" type="numeric" required="no" default="480" />
	<cfargument name="format" type="string" required="no" default="png" />
	<cfargument name="screen" type="numeric" required="no" default="1024" />

	<cfset urlx = "http://api.webthumbnail.org/" />
	<cfset param_width = arguments.width />
	<cfset param_height = arguments.height />
	<cfset param_format = arguments.format />
	<cfset param_screen = arguments.screen />
	<cfset param_url = arguments.urladdress />
	
	<cfset defurl = "#urlx#?width=#param_width#&height=#param_height#&screen=#param_screen#&format=#param_format#&url=#param_url#&uid=#createuuid()#" />
	
	<cfoutput>#defurl#</cfoutput>
	
	<cftry>
		<cfhttp method="get" url="#defurl#" name="test"  getasbinary="yes" result="xxx"></cfhttp>
		<cfimage action="writetobrowser" name="test2" source="#test#" />
		<cfdump var="#xxx#">
		<cfcatch type="any">
			<cfoutput><cfdump var="#cfcatch#"></cfoutput>
		</cfcatch>
	</cftry> 
	
</cffunction>

<html>
	<body>
		<cfoutput>
			#makeURLthumbNail(urladdress="http://www.futurescreen.ch/dia/",width=320,height=240,format="png")#
		</cfoutput>
	</body>
</html>