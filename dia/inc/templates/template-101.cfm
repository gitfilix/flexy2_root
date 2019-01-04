<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor,parent,label FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>
<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_101
WHERE slideid = #url.slideID#
</cfquery>

	

<cfoutput>
	<div class="animatedBackground" style="height:100%;background:url(/dia/upload/magazine/#getSlideBackgroundImage.bgimage#) center center no-repeat;background-size:cover;position:relative;">

		<div class="animatedBackground anim" data-inanimation="0-fadeIn-2"  style="height:100%;background:url(/dia/upload/magazine/ny00.jpg) center center no-repeat;background-size:cover;z-index:1;position:absolute;width:100%;">&nbsp;</div>
		<div class="animatedBackground anim" data-inanimation="10-fadeIn-3" style="height:100%;background:url(/dia/upload/magazine/ny01.jpg) center center no-repeat;background-size:cover;z-index:2;position:absolute;width:100%;">&nbsp;</div>
		<div class="animatedBackground anim" data-inanimation="20-fadeIn-3" style="height:100%;background:url(/dia/upload/magazine/ny02.jpg) center center no-repeat;background-size:cover;z-index:3;position:absolute;width:100%;">&nbsp;</div>
		<div class="animatedBackground anim" data-inanimation="30-fadeIn-3" style="height:100%;background:url(/dia/upload/magazine/ny03.jpg) center center no-repeat;background-size:cover;z-index:4;position:absolute;width:100%;">&nbsp;</div>
		<div class="animatedBackground anim" data-inanimation="40-fadeIn-3" style="height:100%;background:url(/dia/upload/magazine/ny04.jpg) center center no-repeat;background-size:cover;z-index:5;position:absolute;width:100%;">&nbsp;</div>
		<div class="animatedBackground anim" data-inanimation="50-fadeIn-3" style="height:100%;background:url(/dia/upload/magazine/ny05.jpg) center center no-repeat;background-size:cover;z-index:6;position:absolute;width:100%;">&nbsp;</div>
		<div class="animatedBackground anim" data-inanimation="60-fadeIn-3" style="height:100%;background:url(/dia/upload/magazine/ny06.jpg) center center no-repeat;background-size:cover;z-index:7;position:absolute;width:100%;">&nbsp;</div>
		<div class="animatedBackground anim" data-inanimation="70-fadeIn-2" style="height:100%;background:url(/dia/upload/magazine/ny04.jpg) center center no-repeat;background-size:cover;z-index:8;position:absolute;width:100%;">&nbsp;</div>

		<cfswitch expression="#getSlideContent.layout#">
			<cfcase value="1">
				<div class="center" style="position:absolute;width:30%;z-index:10;">					
					<h1 data-inanimation="0-slideInTop-0.5" class="anim">
						#getSlideContent.titel#
					</h1>
					<h2 data-inanimation="0.5-slideInBottom-0.5" class="anim">
						#getSlideContent.lead#
					</h2>
				</div>
			</cfcase>
			<cfcase value="2">
				<div style="width:40%;background:rgba(255,255,255,0.7);height:49%;position:relative;margin:0 auto 1% auto;" class="anim" data-inanimation="0.5-slideInTop-0.5">
					<div style="position:absolute;bottom:1em;" class="anim" data-inanimation="2-fadeIn-0.5">
						<h1 style="text-align:center;">#getSlideContent.titel#</h1>
					</div>
				</div>
				<div style="width:40%;background:rgba(255,255,255,0.7);height:49%;position:relative;bottom:0;margin:0 auto;" class="anim" data-inanimation="1.2-slideInBottom-0.5">
					<div style="position:absolute;top:1em;" class="anim" data-inanimation="2.3-fadeIn-0.5">
						<h2 style="text-align:center;">#getSlideContent.titel#</h2>
					</div>
				</div>
			</cfcase>
			<cfcase value="3">
				<div style="width:49%;background:rgba(255,255,255,0.7);height:25%;position:absolute !important;left:0;margin-top:20%;" class="anim" data-inanimation="0.5-slideInLeft-0.5">
					<div style="position:absolute;bottom:1em;" class="anim" data-inanimation="2-fadeIn-0.5">
						<h1 style="text-align:center;">#getSlideContent.titel#</h1>
					</div>
				</div>
				<div style="width:49%;background:rgba(255,255,255,0.7);height:25%;position:absolute !important;right:0;margin-top:20%;" class="anim" data-inanimation="1.2-slideInRight-0.5">
					<div style="position:absolute;top:1em;" class="anim" data-inanimation="2.3-fadeIn-0.5">
						<h2 style="text-align:center;">#getSlideContent.titel#</h2>
					</div>
				</div>
			</cfcase>
			<cfcase value="4">
				<audio src="/dia/upload/mp3/shaft.mp3" autoplay style="position:absolute;left:9999px;"></audio>
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:0;z-index:100;" class="anim" data-inanimation="2.5-slideInRight-0.5" data-outanimation="10-slideOutRight-0.5">
					<div style="position:absolute;bottom:1em;" class="anim center" data-inanimation="3-scaleTextUp-0.3" data-outanimation="5-fadeOut-0.5">
						<h1 style="text-align:center; font-size:7em; font-family:'league gothic';  color:white;">Start spreading <br>the news</h1>
					</div>					
				</div>
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;bottom:0;z-index:100;" class="anim" data-inanimation="3.2-slideInLeft-0.5" data-outanimation="10-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="3.8-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:8em;  font-family:'league gothic'; color:##162942;">I am leaving today</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="12-slideInTop-0.5" data-outanimation="16-slideOutRight-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="13-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:9em;  font-family:'league gothic'; color:white;">I want to be<br />a part of it</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:-50%;bottom:0;z-index:100;" class="anim" data-inanimation="12-slideInBottom-0.5" data-outanimation="16-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="14-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:11em; font-family:'league gothic'; color:white;">New York<br>New York</h2>
					</div>
				</div>	
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:0;z-index:100;" class="anim" data-inanimation="17-slideInRight-0.5" data-outanimation="23-slideOutRight-0.5">
					<div style="position:absolute;bottom:1em;" class="anim center" data-inanimation="18-scaleTextUp-0.3" data-outanimation="22-fadeOut-0.5">
						<h1 style="text-align:center; font-size:7em; font-family:'league gothic';  color:white;">New York<br>New York</h1>
					</div>					
				</div>
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;bottom:0;z-index:100;" class="anim" data-inanimation="17-slideInLeft-0.5" data-outanimation="23-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="18-scaleTextUp-0.3" data-outanimation="22-fadeOut-0.5">
						<h2 style="text-align:center; font-size:8em;  font-family:'league gothic';color:##162942;">These vagabond shoes</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="24-slideInTop-0.5" data-outanimation="28-slideOutRight-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="25-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:9em;  font-family:'league gothic'; color:##162942;">Are longing to stray</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:-50%;bottom:0;z-index:100;" class="anim" data-inanimation="24-slideInBottom-0.5" data-outanimation="28-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="25-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:8em; font-family:'league gothic'; color:white;">Right through the very heart of it</h2>
					</div>
				</div>
				
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="29-slideInTop-0.5" data-outanimation="34-slideOutRight-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="30-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:10em;  font-family:'league gothic'; color:white;">New York<br>New York</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:-50%;bottom:0;z-index:100;" class="anim" data-inanimation="29-slideInBottom-0.5" data-outanimation="34-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="30-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:10em; font-family:'league gothic'; color:white;">New York<br>New York</h2>
					</div>
				</div>

				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="36-slideInTop-0.5" data-outanimation="41-slideOutRight-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="37-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:8em;  font-family:'league gothic'; color:white;">I want to wake up in that city</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:-50%;bottom:0;z-index:100;" class="anim" data-inanimation="36-slideInBottom-0.5" data-outanimation="41-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="37-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:10em; font-family:'league gothic'; color:white;">That doesn't sleep</h2>
					</div>
				</div>
					<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="44-slideInTop-0.5" data-outanimation="50-slideOutRight-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="45-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:8em;  font-family:'league gothic'; color:white;">And find I'm king <br/> of the hill</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:-50%;bottom:0;z-index:100;" class="anim" data-inanimation="44-slideInBottom-0.5" data-outanimation="50-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="45.5-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:10em; font-family:'league gothic'; color:white;">Top of the heap</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="52-slideInTop-0.5" data-outanimation="57-slideOutRight-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="53-scaleTextUp-0.6">
						<h2 style="text-align:center; font-size:10em;  font-family:'league gothic'; color:white;">New York<br>New York</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(7,26,51,0.7);height:50%;position:absolute !important;right:-50%;bottom:0;z-index:100;" class="anim" data-inanimation="52-slideInBottom-0.5" data-outanimation="56-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="54.5-scaleTextUp-0.6">
						<h2 style="text-align:center; font-size:10em; font-family:'league gothic'; color:white;">New York<br>New York</h2>
					</div>
				</div>
				
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="57-slideInTop-0.5" data-outanimation="62-slideOutTop-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="58-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:10em; font-family:'league gothic'; color:white;">If I can make it there</h2>
					</div>
				</div>	
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;bottom:0;z-index:100;" class="anim" data-inanimation="57-slideInBottom-0.5" data-outanimation="62-slideOutBottom-0.5">
					<div style="position:absolute;bottom:1em;" class="anim center" data-inanimation="58.5-scaleTextUp-0.3">
						<h1 style="text-align:center; font-size:7em; font-family:'league gothic';  color:white;">I'll make it anywhere</h1>
					</div>					
				</div>
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;bottom:0;z-index:100;" class="anim" data-inanimation="63-slideInLeft-0.5" data-outanimation="68-slideOutLeft-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="64-scaleTextUp-0.3" >
						<h2 style="text-align:center; font-size:8em;  font-family:'league gothic';color:##162942;">It's up to you</h2>
					</div>
				</div>
				<div style="width:50%;background:rgba(255,156,0,0.7);height:50%;position:absolute !important;left:0;top:0;z-index:100;" class="anim" data-inanimation="63-slideInTop-0.5" data-outanimation="68-slideOutRight-0.5">
					<div style="position:absolute;top:1em;" class="anim center" data-inanimation="65-scaleTextUp-0.3">
						<h2 style="text-align:center; font-size:10em;  font-family:'league gothic'; color:##162942;">New York<br>New York</h2>
					</div>
				</div>
			</cfcase>
		
		
		</cfswitch>
		
	</div>
</cfoutput>