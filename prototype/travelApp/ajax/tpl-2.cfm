<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>

<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_2
WHERE slideid = #url.slideID#
</cfquery>

<!--- <cfoutput query="getSlideContent">
#getSlideBackgroundImage.bgimage#, 
#titel#,
#lead#,
#bild#,
#bildlegende#,
#ytvideo#,
#slideID#  

</cfoutput> --->

<style>
#right-pannel{
	font-family: 'Quicksand', sans-serif;
	position:absolute;
	width:25em;
	background:rgba(68,68,68,0.6);
	left:0;
	top:0;
	bottom:0;
	padding:2em;
	}

#right-pannel h1{
	font-size:2.2em;
	color:rgba(236,236,236,1.00);
	padding-bottom:0.5em;
	border-bottom:1px dashed #D33;
	padding-top:0.1em;
	border-top:1px solid #D33;
	background:rgba(63,63,63,1.00);
	}
#right-pannel p{
	font-size:1.1em;
	color:#EFEFEF;
	line-height:1.8em;
	}

#bildlegende{
	font-family: 'Quicksand', sans-serif;
	position:absolute;
	bottom:1em;
	right:1em;
	background:rgba(237,237,237,0.57);
	padding:1em;
	padding: 1em;
	color:#222;
	}
	
</style>



<cfoutput query="getSlideContent">
	
	<div id="right-pannel" >
		<div>
			<h1>#titel#</h1>
			<br />
			<p>#lead#</p>
		</div>
	</div>
	<div id="bildlegende">
		<p>#bildlegende#</p>
	</div>
</cfoutput>
