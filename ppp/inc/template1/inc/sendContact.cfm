<cfprocessingdirective pageencoding="utf-8" />



<!--- send contactform for PPP -temp send to flx --->
<cfif isDefined("url.formSubmited") AND trim(form.iAmNotAbot) CONTAINS "itSeemsIamAhuman">
	<!--- Check if ContactLONG FORM --->
	<!--- Serverseitige checks: is Valid and ischecked agbs  --->
	<cfif isValid('email',form.contactmail)<!---  AND isdefined("form.agb") --->>

		
		<cfif form.contactsubject EQ "">
			<cfset x = "Kontakt von der Website">
		<cfelse>
			<cfset x = form.contactsubject />
		</cfif>
	<!--- 	#contactReciever# ist empfänger, 	Sender  is: #contactsender# subject ist hier von dem Formular übernommen
	--->
		
		<cfmail type="html" from="#form.contactsender#" to="#form.contactReciever#" subject="#form.contactsubject#" replyto="kuenstlername@gmail.com" wraptext="72">
<strong>Hallo Pascal,</strong> Folgender Techie- Nerd-Text und ein Formular wurde übermittelt:<br/>

Fields in Ajax-POST-Back Request:<br/>
<br/>
<table width="400">
<tr>
	<td>Name:</td>
	<td>#form.contactname#</td>
</tr>
<tr>
	<td>Email:</td>
	<td>#form.contactmail#</td>
</tr>
<tr>
	<td>Tel:</td>
	<td>#form.contacttel#</td>
</tr>
<tr>
	<td>Company:</td>
	<td>#form.contactcompany#</td>
</tr>
<tr>
	<td>Betreff:</td>
	<td>#form.contactsubject#</td>
</tr>

<tr>
	<td>Nachricht:</td>
	<td>#form.contactmessage#</td>
</tr>

<!--- <tr>
	<td colspan="2">
		<img src="http://www.webkanal.ch/webdesign/upload/img/blume_400_blue.jpg" />
	</td>
</tr> --->
</table>
<br />
<p>
<!--- Embed image via the local file system. --->
<!--- 
<cfmailparam
file="#ExpandPath('/webdesign/upload/img/blume_400_blue.jpg')#"
contentid="girl"
disposition="inline"
/>
<img src="cid:girl" width="350" height="261" alt="" /><br />
</p>
   --->

<br/>
<br/>
-------------------------------------------------------------<br/>
ppp #year(now())# - <a href="http://www.web-kanal.ch">ww.webkanal.ch</a><br/>
<br/>
<br/>

	</cfmail>
		
<cfoutput>
		#form.contactThanks#<br>
</cfoutput>	 
	
	
	
	<cfelse>
	<h2>Es ist ein Fehler aufgetreten.</h2> <br/>
	<!---<p>Bitte akzeptieren Sie die AGB's	</p>.--->
		
	</cfif>	
</cfif>
