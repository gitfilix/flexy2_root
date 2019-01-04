<cfprocessingdirective pageencoding="utf-8">
<!--- javascript  form goes here: (wegen templateblödsinn) --->
<script>
function submitContactForm(){
	contact = '#kontaktformular';
	// append hidden captcha / human detection into DOM
	$hiddenInput = $('<input/>',{type:'hidden',id:'hiddenCheckbox',name:'iAmNotAbot',value:'itSeemsIamAhuman'});
	$hiddenInput.prependTo('.captcha',contact);
	//disable send-button to prevent multiple clicks
	$('#send').attr('disabled', 'disabled');
	$('#send').addClass('disabled');
	// from send
	$('#kontaktformular').fadeOut(1000,function(){
		$.post('/<cfoutput>#session.serverpath#</cfoutput>/inc/template2/inc/sendContact.cfm?formSubmited=true', $('#kontaktformular').serialize(),function(data){
			$('#kontaktformular').before('<span id="thx">'+data+'</span>');
			if(data.indexOf('Danke')>-1){
				$('#kontaktformular').remove();
			}
			else{
					$('#kontaktformular').fadeIn();
			}
			
			//setTimeout(function() {$('#thx').fadeOut().remove()}, 2000);
		});
	});	
}
</script>
<cfoutput>
	<!--- <div>
		Kontaktreciever is: #contactReciever#
	</div>
	<div>
		Konakt subject is: #contactSubject#
	</div>
	<div>
		Kontakt mit Atelier schief aufnehmen:
	</div> --->
	<form action="javascript:submitContactForm();void(0);" method="post" enctype="multipart/form-data" id="kontaktformular" >
	<fieldset>
	 <table >
	 	<tr>
			<td>Name:</td>
			<td><input 
				type="text"
				name="contactname"
				placeholder="ihr Name" 
				maxlength="40"
				required="required"
				size="30" >
			</td>
		</tr>
		<tr>
			<td>Email Adresse:</td>
			<td><input
				type="email"
			 	name="contactemail"
				placeholder="Ihre Emailadresse"
				required="yes"
				size="30"
				maxlength="40"
				required="required" />
			</td>
		</tr>
		<tr>
			<td>Telephonnummer:<br>(optional)</td>
			<td><input 
				type="tel"
				name="contacttel"
				placeholder="Ihre Telephonnummer"
				size="30"
				maxlength="40"/>
			</td>
		</tr>
		<tr>
			<td>Betreff:</td>
			<td><input 
				type="text"
				name="contactsubject"
				size="30"
				placeholder="betreffend..."
				maxlength="40">
			</td>
		</tr>
		<tr>
			<td valign="bottom">Nachricht:</td>
			<td><textarea 
				style="width:100%;height:80px;" 
				name="contactmessage"
				maxlength="500">&nbsp;</textarea>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset class="captcha" style="background:none;border:0;padding:0;margin:0;font-size:0;line-height:0;"> </fieldset>
			</td>
		</tr>
		<tr>
			<td>
				<input type="hidden" id="iAmNotAbot" name="iAmNotAbot" value="notSureYet">
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td> 
			 <input id="submit-btn" type="submit" class="btn"  name="Kontaktsenden" value="Kontakt mit Atelier Schief" >
			<!--- Hiddenfilds zum contact-/ reciever adressen übergeben --->
				<input type="hidden" name="contactReciever" value="#contactReciever#">
				<input type="hidden" name="contactsender"   value="#contactsender#">
				<input type="hidden" name="contactSubject"  value="#contactSubject#">
			</td>
		</tr>
	 </table>
	 <br>
	 </fieldset>
	 </form>
</cfoutput>		