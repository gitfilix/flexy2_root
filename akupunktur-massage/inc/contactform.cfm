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
		$.post('/akupunktur-massage/inc/sendContact.cfm?formSubmited=true', $('#kontaktformular').serialize(),function(data){
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
<!--- <cfdump var="#getcontent#"> --->
	<cfoutput>		
		<article class="content">
			<header>
			<!--- Print a Title --->	
			<cfif titel NEQ "">
					<cfif url.id EQ session.startID>
						<h3>#titel#</h3>
					<cfelse>
						<h1>#titel#</h1>
					</cfif>
					
			</cfif>
			<!---  PRint the lead --->
			<cfif lead NEQ "">
				<div>
				 	<cfif url.id EQ session.startID>
						<h4>#lead#</h4>
					<cfelse>
						<h2>#lead#</h2>
					</cfif>
				</div>
				<br />	
			<cfelse>
				&nbsp;
			</cfif>
			<article>
				<cfif fliesstext NEQ "" AND fliesstext NEQ "<br>">
				<div class="fliesstext">#fliesstext#</div>
				<cfelse>
				&nbsp;
				</cfif>
			</header>
		</article>	
	</cfoutput>
	<cfoutput>
	<div class="webform">
	<form action="javascript:submitContactForm();void(0);" method="post" enctype="multipart/form-data" class="forms columnar" id="kontaktformular" >
		<fieldset>
		<ul> 
			<li>
				 <label for="contactname" class="bold">Name</label>
   				 <input type="text" size="30" name="contactname" placeholder="Ihr Name" required class="seven input-gray" id="contactname" title="Name" />
    			<div class="descr"></div>
			</li>
			<li>
				 <label for="contactmail" class="bold">Email</label>
   				 <input type="email" size="30" name="contactmail" required class="seven input-gray"  placeholder="Ihre E-Mail Adresse" id="contactmail" title="E-Mail" />
			</li>
			<li>
				<label for="telnummer" class="bold">Telephonnummer&nbsp; (optional)</label>
				<input type="tel" size="30" name="contacttel" placeholder="Ihre Telefonnummer" id="contacttel" title="Telefonnummer" />
			</li>
			<li>
              <section><label class="bold" for="contactmessage">Mitteilung</label></section>
              <textarea class="width-50" style="height: 100px;" id="contactmessage" name="contactmessage" placeholder="Ihre Anfrage"></textarea>
            </li>
			<li>
				<fieldset class="captcha" style="background:none;border:0;padding:0;margin:0;font-size:0;line-height:0;"> </fieldset>
			</li>
			<li style="float:right;">
				<input type="hidden" id="iAmNotAbot" name="iAmNotAbot" value="notSureYet">
			</li>
			 <li class="push">
			 	<div class="response"></div>
                <input type="submit" class="btn" id="submit-btn" name="Kontaktsenden" value="Kontaktaufnahme Akupunktur Massage" />
				<!--- Hiddenfilds zum contact-/ reciever adressen übergeben --->
				<input type="hidden" name="contactReciever" value="#contactReciever#">
				<input type="hidden" name="contactsender" value="#contactsender#">
				<input type="hidden" name="contactSubject" value="#contactSubject#">
				<input type="hidden" name="agb" value="1">
            </li>
		</ul>	
		</fieldset>
	 </form>
	</div>
		
		<br />
		<br />
	</cfoutput>
	
</div>