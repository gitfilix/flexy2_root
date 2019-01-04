<cfprocessingdirective pageencoding="utf-8">
<cfhtmlhead text="
	<script type='text/javascript' src='/admin/js/ckeditor/ckeditor.js'></script>
" />
<cfoutput><form action="#cgi.SCRIPT_NAME#?action=submittedNewTeamMember" method="post" enctype="multipart/form-data">
	<table width="100%">
	<tr>
		<td>Status</td>
		<td>
			<input type="radio" name="active" value="1" checked="checked"> aktiv  &nbsp; &nbsp;
			<input type="radio" name="active" value="0"> inaktiv
		</td>
	</tr>
	<tr>
		<td>
			Anrede
		</td>
		<td>
			<select name="anrede">
				<option value="1">Herr</option>
				<option value="2">Frau</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			Name
		</td>
		<td>
			<input type="text" name="name">
		</td>
	</tr>
	<tr>
		<td>
			Vorname
		</td>
		<td>
			<input type="text" name="vorname">
		</td>
	</tr>
	<tr>
		<td>
			URL-Shortcut
		</td>
		<td>
			<input type="text" name="urlshortcut">
		</td>
	</tr>
	<tr>
		<td>
			Bild
		</td>
		<td>
			<input type="file" name="bild">
		</td>
	</tr>
	
	<tr>
		<td>
			Adresse
		</td>
		<td>
			<textarea name="adresse" rows="0" cols="0" style="width:98%;height:80px;"></textarea>
		</td>
	</tr>
	<tr>
		<td>
			PLZ / ort
		</td>
		<td>
			<input type="text" name="plz" size="4"> / <input type="text" name="ort" />
		</td>
	</tr>
	<tr>
		<td>
			Land
		</td>
		<td>
			<select name="strCountryChoice">
				<option value="FI">Finland (Finnland)</option>
				<option value="FR">France (Frankreich)</option>
				<option value="GR">Greece (Griechenland)</option>
				<option value="GB">Create Britain (Großbritannien)</option>
				<option value="IE">Ireland (Irland)</option>
				<option value="IS">Iceland (Island)</option>
				<option value="IT">Italy (Italien)</option>
				<option value="HR">Croatia (Kroatien)</option>
				<option value="LV">Latvia (Lettland)</option>
				<option value="LI">Liechtenstein (Liechtenstein)</option>
				<option value="LT">Lithuania (Litauen)</option>
				<option value="LU">Luxembourg (Luxemburg)</option>
				<option value="MT">Malta (Malta)</option>
				<option value="MK">Macedonia, The Former Yugoslav Republic Of (Mazedonien)</option>
				<option value="MC">Monaco (Monaco)</option>
				<option value="NL">Netherlands (Niederlande)</option>
				<option value="NO">Norway (Norwegen)</option>
				<option value="AT">Austria (Österreich)</option>
				<option value="PL">Poland (Polen)</option>
				<option value="PT">Portugal (Portugal)</option>
				<option value="RO">Romania (Rumänien)</option>
				<option value="SE">Sweden (Schweden)</option>
				<option value="CH" selected="selected">Switzerland (Schweiz)</option>
				<option value="CS">Serbien und Montenegro (Serbien und Montenegro)</option>
				<option value="SK">Slovakia (Slowakei)</option>
				<option value="SI">Slovenia (Slowenien)</option>
				<option value="ES">Spain (Spanien)</option>
				<option value="CZ">Czech Republic (Tschechische Republik)</option>
				<option value="TR">Turkey (Türkei)</option>
				<option value="UA">Ukraine (Ukraine)</option>
				<option value="HU">Hungary (Ungarn)</option>
				<option value="BY">Belarus (Weißrussland)</option>
				<option value="CY">Cyprus (Zypern)</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			Tel
		</td>
		<td>
			<input type="text" name="tel">
		</td>
	</tr>
	<tr>
		<td>
			Mobile
		</td>
		<td>
			<input type="text" name="mobile">
		</td>
	</tr>
	<tr>
		<td>
			Fax
		</td>
		<td>
			<input type="text" name="fax">
		</td>
	</tr>
	<tr>
		<td>
			E-Mail
		</td>
		<td>
			<input type="text" name="email">
		</td>
	</tr>
	<tr>
		<td>
			Website
		</td>
		<td>
			<input type="text" name="www">
		</td>
	</tr>
	<tr>
		<td>
			Skype
		</td>
		<td>
			<input type="text" name="skype">
		</td>
	</tr>
	<tr>
		<td>
			Xing
		</td>
		<td>
			<input type="text" name="xing">
		</td>
	</tr>
	<tr>
		<td>
			LinkedIn
		</td>
		<td>
			<input type="text" name="linkedin">
		</td>
	</tr>
	<tr>
		<td>
			Facebook
		</td>
		<td>
			<input type="text" name="facebook">
		</td>
	</tr>
	<tr>
		<td>
			Twitter
		</td>
		<td>
			<input type="text" name="twitter">
		</td>
	</tr>
	<tr>
		<td>
			Funktion
		</td>
		<td>
			<textarea name="funktion" rows="0" cols="0" style="width:98%;height:80px;"></textarea>
		</td>
	</tr>
	<tr>
		<td>
			Ausbildung
		</td>
		<td>
			<textarea name="ausbildung" rows="0" cols="0" style="width:98%;height:80px;"></textarea>
		</td>
	</tr>
	<tr>
		<td>
			Motto / Statement
		</td>
		<td>
			<textarea name="motto" rows="0" cols="0" style="width:98%;height:80px;"></textarea>
		</td>
	</tr>
	<tr>
		<td>
			CV
		</td>
		<td>
			<textarea name="cv" class="ckeditor" rows="0" cols="0"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="6">
			<input type="submit" value="speichern" />  <input type="button" value="abbrechen" onclick="location.href='#cgi.SCRIPT_NAME#';">
			<input type="hidden" name="catID" value="#url.teamcategoryID#" />
		</td>
	</tr>
	</table>
</form>
</cfoutput>