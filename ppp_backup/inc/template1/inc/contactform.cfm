
<cfprocessingdirective pageencoding="utf-8">
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
		$.post('/ppp/inc/template1/inc/sendContact.cfm?formSubmited=true', $('#kontaktformular').serialize(),function(data){
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

<div>
	<h2>Kontakt mit pazanda photography</h2>
	<br />
</div>

<cfoutput >
	
	<form class="pp_contactform" action="javascript:submitContactForm();void(0);" method="post" enctype="multipart/form-data" id="kontaktformular">
	 <table>
	 	<tr>
			<td>Name:</td>
			<td><input 
				type="text"
				name="contactname" 
				maxlength="40"
				required="yes"
				>
			</td>
		</tr>
		<tr>
			<td>Firma: &nbsp;(optional)</td>
			<td><input 
				type="text"
				name="contactcompany"
				maxlength="40"
				>
			</td>
		</tr>
		<tr>
			<td>Email Adresse:</td>
			<td><input
				type="email"
			 	name="contactmail"
				required="yes"
				size="30"
				maxlength="40">
			</td>
		</tr>
		<tr>
			<td>Telephonnummer: &nbsp; (optional)</td>
			<td><input 
				type="tel"
				name="contacttel"
				id="stylelikeothers"
				>
			</td>
		</tr>
		<tr>
			<td>Betreff &nbsp; (optional)</td>
			<td><input 
				type="text"
				name="contactsubject"
				size="30"
				maxlength="40"
				>
			</td>
		</tr>
		<tr>
			<td  style="vertical-align:top;">Nachricht:</td>
			<td><textarea 
				style="height:90px; margin-top:20px;" 
				name="contactmessage"
				maxlength="500"
				required="yes"></textarea>
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
			<td style="padding-top:30px;">&nbsp;</td>
			<td>
			
			<input id="submit-btn" class="btn" type="submit"  name="Kontaktsenden" value="Kontakt mit pazanda photography">
			<!--- Hiddenfilds zum contact-/ reciever adressen übergeben --->
				<input type="hidden" name="contactReciever" value="#contactReciever#">
				<input type="hidden" name="contactsender"   value="#contactsender#">
				<input type="hidden" name="contactSubject"  value="#contactSubject#">
				<input type="hidden" name="contactThanks"  value="#contactThanks#">
			</td>
			
		</tr>
	 </table>
	 </form>
</cfoutput>		