<cfoutput query="getcontent">

	<!---  <cfdump var="#getcontent#">   --->
	<!--- <cfif HASCONTACT EQ 1>
			<cfinclude template="contactform.cfm">
	<cfelse> --->
	<article class="content">
		<header>
			<!--- Print a Title --->	
			<cfif titel NEQ "">
					<h1>#titel#</h1>
			</cfif>
		</header>
		<!---  PRint the lead is Weapons --->
		<cfif lead NEQ "">
				<div>
				 	<h2>#lead#</h2> 
					<br />
				</div>	
		<cfelse>
			<!--- OR: Print some hardcoded LoremIpsum  --->
			&nbsp;
		</cfif>
		
		
		 <!--- Show Content Image --->
		 <cfif bildname NEQ "">
			<figure>
				<img src="/#session.serverpath#/upload/img/#bildname#" alt="alt tag" >
				<p>#IMAGECAPTION#</p>
			</figure> 
		</cfif>
		<!--- Print out Fliesstext --->
		<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<section>#fliesstext#</section>
		<cfelse>
		<!--- OR: Print some hardcoded LoremIpsum  --->
			&nbsp;
		</cfif>
		<!--- Href link  --->
		<cfif href NEQ "">
			<br/>Lesen Sie mehr:<br/>
			<a href="#href#" target="_blank">
				#hreflabel#
			</a>
		</cfif>
		<!--- doc link --->
		<cfif doc NEQ "">
			PDF:<br/>
			<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank">
				#doclabel#
			</a><br/>
		</cfif> 
	</article>
	<div class="clear"></div>
	<!--- include gallery, if there is one --->
	 <cfif CUSTOMINCLUDE NEQ "">
	 <article class="content">
		<cfinclude template="custom/#CUSTOMINCLUDE#">
	</article>
	<cfelse>
		&nbsp;
	</cfif> 
</cfoutput>

<!--- <cfoutput query="getTeammembers">
<cfdump var="#getTeammembers#">

</cfoutput> --->