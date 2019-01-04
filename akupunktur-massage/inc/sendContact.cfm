<cfprocessingdirective pageencoding="utf-8" />

<!--- send contactform --->
<cfif isDefined("url.formSubmited") AND trim(form.iAmNotAbot) CONTAINS "itSeemsIamAhuman">
	<!--- Check if ContactLONG FORM --->
	<!--- Serverseitige checks: is Valid and ischecked agbs  --->
	<cfif isValid('email',form.contactmail)>

		
		<cfif form.contactsubject EQ "">
			<cfset x = "Kontakt von der Website">
		<cfelse>
			<cfset x = form.contactsubject />
		</cfif>
	<!--- 	#contactReciever# ist empfänger, 	Sender  is: #contactsender# subject ist hier von dem Formular übernommen
	--->
		
<cfmail type="html" from="#form.contactsender#" to="#form.contactReciever#" subject="#form.contactsubject#" replyto="kuenstlername@gmail.com" wraptext="72">
<strong>Hallo Cécile!</strong> <br /><br /> <strong>Halleluja! </strong> <br />Ein Formular von Deiner Akupunktur-Website wurde übermittelt:<br/>
Folgende Kontaktdaten wurden übermittelt:
<br/>
<table width="400">
<tr>
	<td>Name:</td>
	<td>#form.contactname#</td>
</tr>
<br />
<tr>
	<td>Email:</td>
	<td>#form.contactmail#</td>
</tr>
<br />
<tr>
	<td>Telefonnummer:</td>
	<td>#form.contacttel#</td>
</tr>
<br />
<tr>
	<td style="vertical-align:top">Nachricht:</td>
	<td>#form.contactmessage#</td>
</tr>
 <tr>
	<td colspan="2">
		<img src="http://www.akupunktur-radloff.ch/akupunktur-massage/img/sunneblueme.png" />
	</td>
</tr> 
</table>
<br />
<p>
<!--- Embed image via the local file system. --->
<!--- 
 <cfmailparam
file="#ExpandPath('/akupunktur-massage/img/sunneblueme.png')#"
contentid="logo"
disposition="inline"
/>  --->
<!---<img src="cid:girl" width="350" height="261" alt="" /><br />--->
</p>
  

<br/>
<br/>
Dieser elektronischer Brieftaubenservice wurde Ihnen präsentiert von 
-------------------------------------------------------------<br/>
webkanal #year(now())# - <a href="http://www.web-kanal.ch">ww.web-kanal.ch</a><br/>
<br/>
<br/>

</cfmail>
		
<cfoutput query="getcontent">
 	<article class="content">
		#form.contactThanks#
		<br />
		<h3>Danke für Ihre Nachricht</h3>
	</article>
</cfoutput>	
	 <br /><br />
	 
	<h2>Danke für Ihre Kontaktaufnahme.</h2>	
	<br /><br />
	
	
	
	<cfelse>
	<h2>Es ist ein Fehler aufgetreten.</h2> <br/>
	<p>Bitte akzeptieren Sie die AGB's	</p>.
		
	</cfif>	
</cfif>