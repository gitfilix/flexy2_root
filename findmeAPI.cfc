<cfcomponent displayname="findmeAPP">
	<cfprocessingdirective pageencoding="utf-8" suppresswhitespace="yes">
	<cfheader statuscode="200" statustext="OK" />
	<cfcontent reset="true" type="application/javascript" />
	
	<cffunction name="getPlaces" access="remote" output="yes" returnType="any" returnFormat="plain">
	
		<cfquery name="getPlaces" datasource="atelier_schief_ch">
		SELECT	*
		FROM	app_place
		<!--- WHERE	isActive = 1 --->
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="getPlaces">
				<li>
					 <a href='placedetail.html' data-transition='slide' onClick='sessionStorage.place="#id#";'>
						<img src='http://#cgi.SERVER_NAME#/felix/upload/img/app/#place_img#' class='smalllist_img' />
						
						<h3>
							#place_name#
						</h3>
						<p class="list_name">#place_type#</p>
						<br>
				
					  </a>
				</li>
			</cfoutput>
		</cfsavecontent>
	
		<cfset placeList = queryNew("html", "varchar")>
		<cfset queryAddRow(placeList, 1)>	
		<cfset querySetCell(placeList, "html", x, 1)>
		<cfset data = "rest" & "(" & serializeJSON(placeList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
	

	<cffunction name="getPlaceByID" access="remote" output="yes" returnType="any" returnFormat="plain">
		<cfargument name="PlaceID" type="numeric" required="yes">
	
		<cfquery name="getPlaceByID" datasource="atelier_schief_ch">
		SELECT	*
		FROM	app_place
		WHERE	isActive = 1 AND id = #arguments.PlaceID#
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="getPlaceByID">
				
				<h1>
				#place_name#
				</h1>
				<img src='http://#cgi.SERVER_NAME#/felix/upload/img/app/#place_img#' style='text-align:center;' class='picturebig' />
				<p>#place_type#</p>
				<br>
			<!--- 	<div id="placeNews"></div>
				<br>
				<div id="placeMenu"></div> --->
				
			</cfoutput>
		</cfsavecontent>
	
		<cfset placeList = queryNew("html", "varchar")>
		<cfset queryAddRow(placeList, 1)>	
		<cfset querySetCell(placeList, "html", x, 1)>
		<cfset data = "rest" & "(" & serializeJSON(placeList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
		
	<!--- function to get all news restaurants  --->
	<cffunction name="getNewsbyPlaceID" access="remote" output="yes" returnType="any" returnFormat="plain">
		<cfargument name="PlaceID" type="numeric" required="yes">
	
		<cfquery name="getNewsbyPlaceID" datasource="atelier_schief_ch">
		SELECT	*
		FROM	app_news
		WHERE	isActive = 1 AND place_id=#arguments.PlaceID#
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="getNewsbyPlaceID">
				<h3>
					#news_title#
				</h3>
				<p>Hier isst man gut!</p>	
				
			</cfoutput>
		</cfsavecontent>
	
		<cfset newsList = queryNew("html", "varchar")>
		<cfset queryAddRow(newsList, 1)>	
		<cfset querySetCell(newsList, "html", x, 1)>
		<cfset data = "rest2" & "(" & serializeJSON(newsList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
	
	<!--- function to get meues by restaurants  --->
	<cffunction name="getDishbyPlaceID" access="remote" output="yes" returnType="any" returnFormat="plain">
		<cfargument name="PlaceID" type="numeric" required="yes">
	
		<cfquery name="getDishbyPlaceID" datasource="atelier_schief_ch">
		SELECT	*
		FROM	app_dish
		WHERE	isActive = 1 AND placeid=#arguments.PlaceID#
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="getDishbyPlaceID">
				
				<li>
					 <a href='menudetail.html' data-transition='slide' onClick='sessionStorage.dish="#id#";'>
						<img src='http://#cgi.SERVER_NAME#/felix/upload/img/dish/#dish_image#' class="smalllist_img" />
						
						<p class="list_name">
							#dish_name#
						</p>
						 </a>
					 
				</li>
				
				
			</cfoutput>
		</cfsavecontent>
	
		<cfset dishList = queryNew("html", "varchar")>
		<cfset queryAddRow(dishList, 1)>	
		<cfset querySetCell(dishList, "html", x, 1)>
		<cfset data = "rest" & "(" & serializeJSON(dishList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
	
	
	<!--- function to get meues by id  --->
	<cffunction name="getDishbyDishID" access="remote" output="yes" returnType="any" returnFormat="plain">
		<cfargument name="dishID" type="numeric" required="yes">
	
		<cfquery name="getDishbyDishID" datasource="atelier_schief_ch">
		SELECT	*
		FROM	app_dish
		WHERE	isActive = 1 AND id=#arguments.dishID#
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="getDishbyDishID">
				<img src='http://#cgi.SERVER_NAME#/felix/upload/img/dish/#dish_image#' style='text-align:center;' />
				
									#dish_name#<br/>
				
			</cfoutput>
		</cfsavecontent>
	
		<cfset dishList = queryNew("html", "varchar")>
		<cfset queryAddRow(dishList, 1)>	
		<cfset querySetCell(dishList, "html", x, 1)>
		<cfset data = "rest" & "(" & serializeJSON(dishList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
	
	
	
<!---  	
	<cffunction name="insertSubmittedData" access="remote" output="yes" returnType="any" returnFormat="plain">
	
	
		<cfmail from="info@web-kanal.ch" to="felix.adam@webkanal.ch" subject="Restaurant Stuff" type="html">
			name: #url.name#<br/>
			E-Mail: #url.email#<br/>
			Tel: #url.telefon#<br/>
			Art der Anfrage: #url.artAnfrage# <br/>
			Anfrage: #url.anfrage#
		</cfmail>
		
		
		<cfsavecontent variable="x">
			<p>Danke</p>	
		</cfsavecontent>
	
		<cfset dishList = queryNew("html", "varchar")>
		<cfset queryAddRow(dishList, 1)>	
		<cfset querySetCell(dishList, "html", x, 1)>
		<cfset data = "rest" & "(" & serializeJSON(dishList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
	--->
	
</cfprocessingdirective>
</cfcomponent>