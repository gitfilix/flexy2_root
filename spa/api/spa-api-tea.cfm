<!--- allow from every port than 80  same domain policy hack  --->
<cfheader name="Access-Control-Allow-Origin" value="*">
<cfsetting showdebugoutput="yes">
<cfprocessingdirective pageencoding="utf-8" >
<cfset temp = setlocale("German (Swiss)") />
<!---get all teasers from mandant  76 --->
<cfquery name="spaApiTeaser2" datasource="atelier_schief_ch">
	SELECT 	* 
	FROM 	sidebar
	WHERE	Mandant =  76

</cfquery>



 <!---outer json structure: Array for each entry--->
<cfset allteasers = arrayNew(1) />



<!---Create an Output in JSON Array--->
<cfoutput query="spaApiTeaser2" >
	<cfset teasers = structNew() />
	<cfset teasers['titel'] = titel />
	<cfset teasers['teasertext'] = fliesstext />
	<cfset teasers['hreflabel'] = hreflabel />
	<cfset teasers['hreftarget'] = href />
	<cfset teasers['createDate'] = createDate />
	<cfset teasers['imagepath'] = "http://www.web-kanal.ch/spa/upload/img/"&image />
	<cfset arrayAppend(allteasers,teasers) />
</cfoutput>


<cfdump var="#spaApiTeaser2#" >

<!---<cfabort>--->
<cfcontent  type="application/javascript" >

<cfoutput>
	#serializeJSON(allteasers)#
</cfoutput>
