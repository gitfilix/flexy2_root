<cfprocessingdirective pageencoding="utf-8">
<!--- include Logo, isch logo odr ? bedenke mit absoluten pfanden dass die Startseite index--->
<cfoutput>
	<span><!---  alle links und sources müssen mit session serverpath --->
		<img  id="logo" src="/#session.serverpath#/inc/template#pageProperties.template#/img/as_logo_150.png" alt="logo atelier schief" />
	</span>
</cfoutput>