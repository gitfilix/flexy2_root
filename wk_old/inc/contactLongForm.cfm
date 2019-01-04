<cfprocessingdirective pageencoding="utf-8" />


contact form goes here:
<br>
<cfoutput>
	<div>
		Contactform is #CONTACTTYPE#
	</div>
	<div>
		Kontaktreciever is: #contactReciever#
	</div>
	<div>
		Konakt subject is: #contactSubject#
	</div>
	<div>
		Sender  is: #contactsender#
	</div>
	<br>
	<h2>Kontakt mit WEBkanal aufnehmen: long</h2>	
	
	<div class="webform">
	
	<form action="javascript:submitContactForm();void(0);" method="post" enctype="multipart/form-data" id="kontaktformular" class="forms columnar">
		<fieldset>
		<ul> 
			<li>
				 <label for="contactname" class="bold">Name*</label>
   				 <input type="text" size="30" name="contactname" placeholder="Ihr Name" required class="seven input-gray" id="contactname" title="Name" />
    			<div class="descr"></div>
			</li>
			<li>
				 <label for="contactmail" class="bold">Email*</label>
   				 <input type="email" size="30" name="contactmail" required class="seven input-gray" id="contactmail" title="E-Mail" />
   				 <div class="descr">Ihre E-Mail Adresse.</div>
			</li>
			<li>
			  <div class="descr"> <label for="ausgangslage" class="bold">Ausgangslage: Ich... </label>
            	<select name="ausgangslage" id="ausgangslage">
					<option>möchte Informationen</option>
					<option>habe keine Webseite</option>
					<option>habe bereits eine Webseite</option>
					<option>habe Fragen bezüglich</option>
				</select>
				</div>
			</li>
			<li>
				 <label for="contactsubject" class="bold">Betreff</label>
				<input type="text" size="30"  maxlength="100" class="seven input-gray" id="contactsubject" name="contactsubject" />
			</li>
			<li>
              <section><label class="bold" for="contactmessage">Textarea</label></section>
              <textarea class="width-50" style="height: 100px;" id="contactmessage" name="contactmessage" placeholder="schreiben Sie hier Ihre Fragen"></textarea>
            </li>
			<li>
              <section><label class="bold" for="abg">AGBs</label></section>
            <input type="checkbox" value="1" id="agb" name="agb" title="AGBs akzeptieren" />
            </li>
			<li>
				<fieldset class="captcha" style="background:none;border:0;padding:0;margin:0;font-size:0;line-height:0;"> </fieldset>
			</li>
			<li style="float:right;">
				<input type="hidden" id="iAmNotAbot" name="iAmNotAbot" value="notSureYet">
			</li>
			 <li class="push">
			 	<div class="response"></div>
                <input type="submit" class="btn"  name="Kontaktsenden" value="Kontakt mit WEBkanal aufnehmen" />
				<!--- Hiddenfilds zum contact-/ reciever adressen übergeben --->
				<input type="hidden" name="contactReciever" value="#contactReciever#">
				<input type="hidden" name="contactsender" value="#contactsender#">
				<input type="hidden" name="contactSubject" value="#contactSubject#">
            </li>
		</ul>
		
		</fieldset>
	 </form>
	</div>
</cfoutput>