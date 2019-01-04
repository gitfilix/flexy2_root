<cfprocessingdirective pageencoding="utf-8" />

<!--Team Detail -->
	<div class="content">
<cfif isdefined("url.team")>

	<cfoutput query="getTeam" group="tid">
<cfdump var="#getTeam#">
	
	
	<cfif teamvorname NEQ "">
		hero name:
		<h1>#teamvorname#</h1> 
	<br />
	</cfif>
	<cfif teamname NEQ "">
		aka:
		<h1>#teamname#</h1> 
	<br />
	</cfif>	
	
	<cfif teamBildBig NEQ "">
			<p>Custom Picture is:</p> <br />
			<img  src="/#session.serverpath#/upload/img/team/#teamBildBig#" width="100%;" >
			
	</cfif>
	<br />
	
		
	
	
	
	<cfif TEAMTESTIMONIAL NEQ "">
		<h2>my motto:</h2><p>#TEAMTESTIMONIAL#</p>
	</cfif>
	<br />
	
	
	<br />
	<!--- Print a Title --->	
	<cfif TEAMADRESSE NEQ "">
			<h2>my Powers:</h2><p>#TEAMADRESSE#</p>
	</cfif>
	<br/ >
	<div style="float:right;width:30%;background-color:##EEE;font-size:0.85em;padding:1.5em;">
					<cfif teamadresse NEQ "">#teamAdresse#<br/></cfif>
					<cfif teamLand NEQ "" AND teamOrt NEQ "" AND teamPLZ NEQ "">#teamLand# - #teamPLZ# #teamOrt#<br/></cfif>
					<cfif teamTel NEQ "">T: #teamTel#<br/></cfif>
					<cfif teamMobile NEQ "">M: #teamMobile#<br/></cfif>
					<cfif teamFax NEQ "">F: #teamFax#<br/></cfif>
					<cfif teamemail NEQ "" AND isValid('email',teamemail)>
						#teamemail#
					</cfif>
	</div>
	
	
	</div>
	<div style="clear:both;"></div>
	</cfoutput>
	
	

<!--team overview -->
<cfelse>
	<article id="content_#id#">
	<cfoutput query="getTeam" group="tid">
	
<cfdump var="#getTeam#">
		<h2>#label#</h2>
		<cfoutput>		
			<cfif teamname NEQ "">
			<div>
				<cfif teamBildThumb NEQ "" AND fileExists(expandPath('/#session.serverpath#/upload/img/team/') & teamBildThumb)>
					<figure style="float:left;margin-right:1.5em;width:20%;margin-bottom:1.5em;">
						<img src="/#session.serverpath#/upload/img/team/#teamBildThumb#" alt="" width="100%" />	
						<figcaption style="font-style:italic;">
							#replace(teamTestimonial,"#chr(13)##chr(10)#","<br />","ALL")#
						</figcaption>
					</figure> 		
				</cfif>
				
				<div style="float:right;width:30%;background-color:##EEE;font-size:0.85em;padding:1.5em;">
					<cfif teamadresse NEQ "">#teamAdresse#<br/></cfif>
					<cfif teamLand NEQ "" AND teamOrt NEQ "" AND teamPLZ NEQ "">#teamLand# - #teamPLZ# #teamOrt#<br/></cfif>
					<cfif teamTel NEQ "">T: #teamTel#<br/></cfif>
					<cfif teamMobile NEQ "">M: #teamMobile#<br/></cfif>
					<cfif teamFax NEQ "">F: #teamFax#<br/></cfif>
					<cfif teamemail NEQ "" AND isValid('email',teamemail)>
						#teamemail#
					</cfif>
				</div>
				
				<h3 style="margin:0;">#teamvorname# #teamname#</h3>
				
				<cfif teamfunktion NEQ "" OR teamausbildung NEQ "">
					
						<cfif teamfunktion NEQ "">
							<p>#replace(teamfunktion,"#chr(13)##chr(10)#","<br/>","ALL")#</p>
						</cfif>
						
						<cfif teamausbildung NEQ "">
							<p>#replace(teamausbildung,"#chr(13)##chr(10)#","<br/>","ALL")#</p>
						</cfif>		
				
				</cfif>
				
			<!--- 	link to detail view --->
					<a href="#cgi.SCRIPT_NAME#?id=#url.id#&team=#id#"  title=""><!--- onclick="$('.testimonial#id#').toggle();" --->
						Mehr Informationen über Held id #url.id#&team=#id#
					</a>
					<br/>
				
				<div style="display:none;clear:both;" class="testimonial#id#">
					<h4>Curriculum vitae</h4>
					<cfif teamCV NEQ "">
						#teamCV#<br/>
					</cfif>
				</div>
				
				<cfif teamBildThumb NEQ "" AND fileExists(expandPath('/#session.serverpath#/upload/img/team/') & teamBildThumb)>
					<div style="clear:both;"></div>
				</cfif>
				
				
			</div>	
			</cfif>
		</cfoutput>
	
	</cfoutput>
	</article>
	<div style="clear:both;"></div>
</cfif>







