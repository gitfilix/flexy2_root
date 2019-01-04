


<cfoutput query="editMagazine">
<form action="#cgi.SCRIPT_NAME#?action=submittedEditedMagazine" method="post" enctype="multipart/form-data">
	<table width="100%">
	<tr>
		<td>
			Titel
		</td>
		<td>
			<input type="text" name="titel" value="#titel#" />
		</td>
	</tr>
	<tr>
		<td>
			Status
		</td>
		<td>
			<input type="radio" name="isActive" value="1" <cfif isActive EQ 1>checked="checked"</cfif> /> aktiv 
			<input type="radio" name="isActive" value="0" <cfif isActive EQ 0>checked="checked"</cfif> /> inaktiv 
		</td>
	</tr>
	<tr>
		<td>
			Public?
		</td>
		<td>
			<input type="radio" name="isPublic" value="1" <cfif isPublic EQ 1>checked="checked"</cfif> /> Ja 
			<input type="radio" name="isPublic" value="0" <cfif isPublic EQ 0>checked="checked"</cfif> /> Nein 
		</td>
	</tr>
	<tr>
		<td>
			Bezahlt?
		</td>
		<td>
			<input type="radio" name="paid" value="1" <cfif paid EQ 1>checked="checked"</cfif> /> Ja 
			<input type="radio" name="paid" value="0" <cfif paid EQ 0>checked="checked"</cfif> /> Nein 
		</td>
	</tr>
	<tr>
		<td colspan="6">
			<input type="hidden" name="magazinID" value="#id#" />
			<input type="submit" value="speichern" />  <input type="button" value="abbrechen" onclick="location.href='#cgi.SCRIPT_NAME#';">
		</td>
	</tr>
	</table>
</form>
</cfoutput>