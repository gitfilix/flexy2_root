<cfprocessingdirective pageencoding="utf-8" />

<cfoutput query="magazineChapters">
	<form action="#cgi.SCRIPT_NAME#?action=submittedEditedMagazineChapter" method="post" enctype="multipart/form-data">
		<table width="100%">
		<tr>
			<td>
				Kapitel
			</td>
			<td>
				<input type="text" name="kapitel" value="#kapitel#" />
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<input type="hidden" name="magazinChapterID" value="#id#" />
				<input type="submit" value="speichern" />  <input type="button" value="abbrechen" onclick="location.href='#cgi.SCRIPT_NAME#';">
			</td>
		</tr>
		</table>
	</form>
</cfoutput>