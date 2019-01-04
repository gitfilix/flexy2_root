<cfcomponent displayname="restAPP">
	<cfprocessingdirective pageencoding="utf-8" suppresswhitespace="yes">
	<cfheader statuscode="200" statustext="OK" />
	<cfcontent reset="true" type="application/javascript" />
	
	<cffunction name="getDishes" access="remote" output="yes" returnType="any" returnFormat="plain">
	
		<cfquery name="getDishes" datasource="atelier_schief_ch">
		SELECT	*
		FROM	app_dish
		<!--- WHERE	isActive = 1 --->
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="getDishes">
				<li>
					<a href='gericht-detail.html' data-transition='slide' onclick='javascript:sessionStorage.gericht="#id#"'>
						<img src='http://#cgi.SERVER_NAME#/mirza-in-progress/upload/img/dish/#dish_image#' />
						<h3>
							#dish_name#
						</h3>
						<p>#dish_desc#</p>
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
	
	
	<cffunction name="getDishByID" access="remote" output="yes" returnType="any" returnFormat="plain">
		<cfargument name="dishID" type="numeric" required="yes">
	
		<cfquery name="getDishes" datasource="atelier_schief_ch">
		SELECT	*
		FROM	app_dish
		WHERE	isActive = 1 AND id = #arguments.dishID#
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="getDishes">
				<img src='http://#cgi.SERVER_NAME#/mirza-in-progress/upload/img/dish/#dish_image#' style='text-align:center;' />
				<h3>
					#dish_name#
				</h3>
				<p>#dish_desc#</p>	
			</cfoutput>
		</cfsavecontent>
	
		<cfset dishList = queryNew("html", "varchar")>
		<cfset queryAddRow(dishList, 1)>	
		<cfset querySetCell(dishList, "html", x, 1)>
		<cfset data = "rest" & "(" & serializeJSON(dishList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
	
	<!--- function to get all restaurants  --->
	<cffunction name="getRest" access="remote" output="yes" returnType="any" returnFormat="plain">
	
	
		<cfquery name="all_Rest" datasource="atelier_schief_ch">
		SELECT	distinct(rest_name)
		FROM	app_dish
		WHERE	isActive = 1
		</cfquery>
		
		<cfsavecontent variable="x">
			<cfoutput query="all_Rest">
				<h3>
					#Rest_name#
				</h3>
				<p>Hier isst man gut!</p>	
				
			</cfoutput>
		</cfsavecontent>
	
		<cfset dishList = queryNew("html", "varchar")>
		<cfset queryAddRow(dishList, 1)>	
		<cfset querySetCell(dishList, "html", x, 1)>
		<cfset data = "rest" & "(" & serializeJSON(dishList) & ")">
	
		<cfreturn replace(replace(replace(data,'\n','','ALL'),'\r','','ALL'),'\t','','ALL') />
	</cffunction>
	
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
	
	
</cfprocessingdirective>
</cfcomponent>