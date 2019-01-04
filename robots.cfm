User-agent: *
<!--- anweisungen für webkanal --->
<cfif cgi.SERVER_NAME CONTAINS "kanal">

<cfelseif cgi.SERVER_NAME CONTAINS "aku">
<cfelseif cgi.SERVER_NAME CONTAINS "gasser">
<cfelseif cgi.SERVER_NAME CONTAINS "future">
disallow: /
</cfif>