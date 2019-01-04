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
		<!--- 1. CHECK HERE path is correct --->
		$.post('/webdesign/inc/sendContact.cfm?formSubmited=true', $('#kontaktformular').serialize(),function(data){
			$('#contactformfeedback').html(data);
			
			//if(data.indexOf('Danke')>-1){
				$('#kontaktformular').remove();
			/*}
			else{
					$('#kontaktformular').fadeIn();
			}*/
			
			//setTimeout(function() {$('#thx').fadeOut().remove()}, 2000);
		});
	});	
}
</script>
<div>
	<cfoutput>	
	<!--- include content top --->
		<cfinclude template="content-top.cfm">	
	</cfoutput>
<cfoutput>

<cfif getSidebarElems.recordcount NEQ 0>
<div class="units-split no-margin cnt-wrapper">
	<div class="unit-70" id="text-80">
		<div class="lowercontent" >
			<article class="webformular-content">
			<div >
				<h2>Kontakt mit Webkanal</h2>
			</div>
			<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<section>
					#fliesstext#		
				</section>
			</cfif>
			
				<div class="webform">
				
					<div id="contactformfeedback"></div>
				
					<form action="javascript:submitContactForm();void(0);" method="post" enctype="multipart/form-data" class="forms columnar" id="kontaktformular" >
						<fieldset>
						<ul> 
							<li>
								 <label for="contactname" class="bold">Name</label>
								 <input type="text" size="30" name="contactname" placeholder="Ihr Name" required class="seven input-gray" id="contactname" title="Name" />
								<div class="descr"></div>
							</li>
							<li>
								 <label for="contactmail" class="bold">E-mail</label>
								 <input type="email" required size="30" name="contactmail"  class="seven input-gray"  placeholder="Ihre E-Mail Adresse" id="contactmail" title="E-Mail" />
							</li>
							<li>
							 <label class="bold" for="contactmessage">Nachricht</label>
							  <textarea class="width-50" style="height: 100px;" id="contactmessage" name="contactmessage" placeholder="Text"></textarea>
							</li>
							<li>
								<fieldset class="captcha" style="background:none;border:0;padding:0;margin:0;font-size:0;line-height:0;"> </fieldset>
							</li>
							<li style="float:right;">
								<input type="hidden" id="iAmNotAbot" name="iAmNotAbot" value="notSureYet">
							</li>
							 <li class="push">
								<div class="response"></div>
								<input type="submit" class="btn" id="submit-btn" name="Kontaktsenden" value="Nachricht senden" />
								<!--- Hiddenfilds zum contact-/ reciever adressen übergeben --->
								<input type="hidden" name="contactReciever" value="#contactReciever#">
								<input type="hidden" name="contactsender" value="#contactsender#">
								<input type="hidden" name="contactSubject" value="#contactSubject#">
								<input type="hidden" name="contactThanks" value="#contactThanks#">
							</li>
						</ul>	
						</fieldset>
					 </form>
				</div>
		</article>
		</div>
	<br />
	</div>
	<div class="unit-30" id="text-20" >
		<cfinclude template="sidebars.cfm">
	</div>
	<div class="clear"></div>
</div>
</cfif>
</cfoutput>
</div>