<cfprocessingdirective pageencoding="utf-8" />

<!--Team Detail -->


<div class="heroes-view">
<cfif isdefined("url.team")>

	<cfoutput query="getTeam" group="tid">
<!---  <cfdump var="#getTeam#"> --->   
	
	<div class="hero-detail" >
		
			<div class="hero-desc" >
			<cfif teamBildBig NEQ "">
			<figure >
			<img src="/#session.serverpath#/upload/img/team/#teamBildBig#" width="100%;" >
			</figure>
			</cfif>
		
			<br/ >
			<div class="clear"></div>
				
		
			<div class="units-row">
				<div class="unit-50 hero-detail-left">
					<h1>#teamvorname#</h1>
					<cfif TEAMCV NEQ "">
					<h3>Skills:</h3><br /><p>#TEAMCV#</p>
					</cfif>
					<br/ >
					<cfif TEAMFUNKTION NEQ "">
					<h3>Weapons:</h3> <br /> <p>#TEAMFUNKTION#</p>
					</cfif>
					<br/ >
					<cfif TEAMAUSBILDUNG NEQ "">
					<h3>Beruf:</h3> <p>#TEAMAUSBILDUNG#</p>
					</cfif>
					<br/ >
				</div>
				<div class="unit-50 hero-detail-right">
					<h2> #teamname#</h2>
					<cfif teamOrt NEQ "" AND teamPLZ NEQ "">
					<h3>Homebase:</h3> <br /><p>#teamPLZ# - #teamOrt#</p>
					</cfif>
					<br />
					<cfif teamemail NEQ "" AND isValid('email',teamemail)>
					<h3>E-Mail:</h3> <br /><p>#teamemail#</p>
					</cfif>
					<br/ >				
					<cfif TEAMXING NEQ "" >
					<h3>Xing-Profil:</h3> <br /><p><a href="#TEAMXING#" target="_blank">
					<img src="/#session.serverpath#/img/xing-icon-256.png" alt="xing" style="height:32px;"></a></p>
					</cfif>
					<br/ >
					<cfif TEAMURL NEQ "" >
					<h3>Website:</h3>  <br />
					<a href="#TEAMURL#" target="_blank">#TEAMURL#</a></p>
					</cfif>
					<br/ >
					<cfif TEAMTWITTER NEQ "" >
					<h3>Twitter:</h3> <br /><a href="#TEAMTWITTER#" target="_blank">
					<img src="/#session.serverpath#/img/twitter-icon-256.png" alt="twitter" style="height:32px;"></a></p>
					</cfif>
					<br/ >
					<cfif TEAMFACEBOOK NEQ "" >
					<h3>Facebook:</h3> <br /><a href="#TEAMFACEBOOK#" target="_blank">
					<img src="/#session.serverpath#/img/facebook-icon-256.png" alt="fb" style="height:32px;"></a></p>
					</cfif>
				</div>
			</div>
			<br/ >

		</div>
		<div class="clear"></div>
	</div>
	
	</cfoutput>
	
	

<!--team overview -->
<cfelse>

	<article class="heroes-overview" >
	<h1>all Heroes of TSM 15</h1>
	<br />
		<cfoutput query="getTeam" group="tid">
	
		<!--- <cfdump var="#getTeam#"> --->
		<!--- 	<div style="border: 1px solid blue;"> --->
			<cfoutput>	
			
				<cfif teamname NEQ "">
					<div >
					<cfif teamBildThumb NEQ "" AND fileExists(expandPath('/#session.serverpath#/upload/img/team/') & teamBildThumb)>
					<div class="hero-box">
							<figure>
							<a class="team-hover" href="#cgi.SCRIPT_NAME#?id=#url.id#&team=#id#" >
								<img src="/#session.serverpath#/upload/img/team/#teamBildThumb#" alt="#teamBildThumb#" />	
								</a>
							</figure>
							<br />
							<!--- #teamvorname#
								link to detail view --->
							<a href="#cgi.SCRIPT_NAME#?id=#url.id#&team=#id#"  title=""><!--- onclick="$('.testimonial#id#').toggle();" --->
							<h3>#teamvorname#</h3>		
							</a>
							<br/>
					</div>
					</div>	
					</cfif>
				
				<!--- <!--- <div style="clear:both;"></div> ---> --->
				</cfif>
				
		</cfoutput>
		<!--- </div> --->		
	</cfoutput>
	</article>
	
	<div style="clear:both;"></div>
</cfif>
</div>






