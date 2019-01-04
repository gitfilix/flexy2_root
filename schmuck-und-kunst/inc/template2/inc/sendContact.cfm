<cfprocessingdirective pageencoding="utf-8" />

<!--- send contactform  for Atelier Schief--->
<cfif isDefined("url.formSubmited") AND trim(form.iAmNotAbot) CONTAINS "itSeemsIamAhuman">
	<!--- Check if ContactLONG FORM --->
	<!--- Serverseitige checks: email is Valid   --->
	<cfif isValid('email',form.contactemail)>

	
		<cfif form.contactsubject EQ "">
			<cfset x = "Kontakt von der Website">
		<cfelse>
			<cfset x = form.contactsubject />
		</cfif>
	<!--- 	#contactReciever# ist empfänger, 	Sender  is: #contactsender# subject ist hier von dem Formular übernommen
	--->
		<!--- wrapptext wraptext="72" im html-type funktioniert nicht --->
		<cfmail type="html" from="#form.contactsender#" to="#form.contactReciever#" subject="#form.contactsubject#" replyto="cornelia.obrist@atelierschief.ch" >
<!--- hier IMMER links alinieren im CFMail tag, damit diese einrückungen nicht das Mail-layout zerstören! MIESer Trick 34 --->
<strong>Hallo Cony,</strong> 
ein Formular von der Webseite wurde übermittelt:<br/>
Folgende Felder waren im POST Request:<br/>
<br/>
<table width="400">
<tr>
	<td>Name:</td>
	<td>#form.contactname#</td>
</tr>
<tr>
	<td>Email:</td>
	<td>#form.contactemail#</td>
</tr>
<tr>
	<td>Tel:</td>
	<td>#form.contacttel#</td>
</tr>
<tr>
	<td>Nachricht:</td>
	<td>#form.contactmessage#</td>
</tr>

</table>
<br />
<p>
<!--- Embed image via the local file system. --->

<cfmailparam
file="#ExpandPath('/schmuck-und-kunst/upload/img/atelier1.jpg')#"
contentid="girl"
disposition="inline"
/>
<img src="cid:girl" width="350" height="261" alt="" /><br />
</p>
  

<br/>
<br/>
-------------------------------------------------------------<br/>
<small>
Atelier Schief #year(now())# - a <strong>nice</strong> website by <a href="http://www.web-kanal.ch">ww.webkanal.ch</a><br/>
</small>
<br/>
<br/>

	</cfmail>
		
	
		
	<br /><br />
	<div class="lead">
		<h2>Danke für Ihre Kontaktaufnahme.</h2>	
		<br /><br />
		<h4>Wir melden uns bald.</h4>
	</div>
	
	<cfelse>
	<h2>Es ist ein Fehler aufgetreten.</h2> “ sendcontact<br/>
	
		
	</cfif>	
</cfif>