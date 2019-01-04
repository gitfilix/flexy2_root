<cfprocessingdirective pageencoding="utf-8" />
		
<cfset ct = 1 />

<cfif isdefined("matrix")>
	<cfquery name="reorder" dbtype="query">
	SELECT * FROM matrix
	ORDER BY reihenfolge,sreihenfolge
	</cfquery>
	
	<cfoutput query="reorder" group="kid">		
		
		<cfif direction EQ 1>
		<section style="height:100%;">
		</cfif>
			<cfset cnt = 1 />
			<cfoutput>
				<cfquery name="getTemplateSkin" datasource="#application.dsn#">
				SELECT	*
				FROM	magazinslidetpl_#template#
				WHERE	slideID = #id#
				</cfquery>
				<cfif id NEQ "">
					<section class="<cfif getTemplateSkin.recordcount NEQ 0 AND isDefined("getTemplateSkin.setting_skin")>tpl#template#-skin#getTemplateSkin.setting_skin#</cfif>" style="height:100%;padding:0;" id="slide#id#" data-template="#template#"  
					 data-background="<cfif bgimage NEQ "">/prototype/upload/magazine/#bgimage#<cfelse>#bgcolor#</cfif>"
				 	 data-transition="#transitiontype#"><cfset url.slideID = #id# /><cfset url.cfid = session.CFID /><cfset url.cftoken = session.CFToken /><cfinclude template="/prototype/travelapp/ajax/tpl-#template#-md.cfm" /></section>
					<cfset cnt = cnt + 1 />
				</cfif>
			</cfoutput>
		<cfif direction EQ 1>	
		</section>
		</cfif>
		<cfset ct = ct + 1 />
	</cfoutput>
</cfif>


