<cfprocessingdirective pageencoding="utf-8" />

<!--- send contactform --->
<cfif isDefined("url.formSubmited") AND trim(form.iAmNotAbot) CONTAINS "itSeemsIamAhuman">
	<!--- Check if ContactLONG FORM --->
	<!--- Serverseitige checks: is Valid   --->
	<cfif isValid('email',form.contactmail)>
		
		
		<cfif form.contactsubject EQ "">
			<cfset x = "Kontakt von der Website">
		<cfelse>
			<cfset x = form.contactsubject />
		</cfif>
		<!--- 	#contactReciever# ist empfänger, 	Sender  is: #contactsender# subject ist hier von dem Formular übernommen
		--->
			
		<cfmail type="html" from="#form.contactsender#" to="#form.contactReciever#" subject="#form.contactsubject#" replyto="felix.adam@webkanal.ch">
<strong>Hallo Felix,</strong> ein Formular wurde übermittelt:<br/>
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

<cfmailparam
file="#ExpandPath('/webdesign/img/logo-100.jpg')#"
contentid="logo"
disposition="inline"
/> 
<img src="cid:logo" /><br />
</p>
  

<br/>
<br/>
-------------------------------------------------------------<br/>
webkanal #year(now())# - <a href="http://www.web-kanal.ch">www.webkanal.ch</a><br/>
<br/>
<br/>
		</cfmail>
			
		<cfoutput>#form.contactThanks#</cfoutput>
	<cfelse>
		<h2>Bitte geben Sie eine korrekte E-Mail Adresse an</h2> <br/>
	<!--- 	<p>Bitte akzeptieren Sie die AGB's	</p>. --->
	</cfif>	
</cfif>