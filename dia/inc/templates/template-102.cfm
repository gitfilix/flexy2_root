<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor,parent,label FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>
<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_102
WHERE slideid = #url.slideID#
</cfquery>


<cfoutput>
<!--- Layouttype 1: big lead- normal text --->

<cfif getSlideContent.layout EQ 1>
<div style="background:#getSlideBackgroundImage.bgcolor#; height:100%;" class="tpl-102" >	
	<div class="units-row" style="height:100%; padding:3em;  ">
		<div class="unit-50" style="height:100%;">
			<div class="bigtitel">
				<div class="black-dot anim" data-inanimation="0.1-fadeIn-0.3">&nbsp;</div>
				<h1>#getSlideContent.titel#</h1>
			</div>	
		
			<div class="biglead anim" data-inanimation="0.3-fadeIn-0.7">
				<h2>#getSlideContent.lead#</h2>
<!--- 				<p style="background:##F2F2FF">biglead</p> --->
			</div>			
		</div>
		<div class="unit-10">
			<div class="redbutton">&nbsp;</div>
		</div>	
		<div class="unit-40 ftScrollerVertical anim" style="height:95%; overflow:hidden;" id="sdfsfsdff#url.slideid#" data-inanimation="1.0-fadeIn-0.5">
			<div class="fliesstext" id="sdfsfsdff#url.slideid#" >
			#getSlideContent.text#
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>
<cfelseif getSlideContent.layout EQ 2>
<!--- Layouttype 2: small lead- more text right --->

<div style="background:#getSlideBackgroundImage.bgcolor#; height:100%;" class="tpl-102" >	
	<div class="units-row" style="height:100%; padding:3em;  ">
		<div class="unit-30" style="height:100%;">
			<div class="bigtitel">
				<div class="black-dot anim" data-inanimation="0.1-fadeIn-0.3">&nbsp;</div>
				<h1>#getSlideContent.titel#</h1>
			</div>	
			<div class="smalllead anim" data-inanimation="0.3-fadeIn-0.7">
				<h2>#getSlideContent.lead#</h2>
		<!--- 		<p style="background:##FF00FF">smalllead</p> --->
			</div>	
		</div>
		<div class="unit-10">
			<div class="redbutton">&nbsp;</div>
		</div>	
		<div class="unit-60 ftScrollerVertical anim" style="height:95%; overflow:hidden;" id="sdfsfsdff#url.slideid#" data-inanimation="0-fadeIn-0.3">
			<div class="fliesstext-long" id="sdfsfsdff#url.slideid#" >
			#getSlideContent.text#
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>
<!--- Layouttype 3: big lead- very few words down right --->

<cfelseif getSlideContent.layout EQ 3>
<div style="background:#getSlideBackgroundImage.bgcolor#; height:100%;" class="tpl-102" >	
	<div class="units-row" style="height:100%; padding:3em;  ">
		<div class="unit-50" style="height:100%;">
			<div class="bigtitel">
				<div class="black-dot anim" data-inanimation="0.1-fadeIn-0.3">&nbsp;</div>
				<h1>#getSlideContent.titel#</h1>
			</div>	
			<div class="biglead" data-inanimation="0.3-fadeIn-0.7">
				<h2>#getSlideContent.lead#</h2>
<!--- 				<p style="background:##F2F2FF">small-TExtright</p> --->
			</div>			
		</div>
		<div class="unit-10">
		 	<div class="redbutton">&nbsp;</div> 
		</div>
		<div class="unit-40" style="height:95%; overflow:hidden;">
		<div style="height:50%"> &nbsp;</div> 
		 <div style="height:50%" class="fliesstext-few anim" data-inanimation="0.8-fadeIn-0.3">
			 #getSlideContent.text#
		 </div>
		</div>	
		<div class="clear"></div>
	</div>
</div>
</cfif>
</cfoutput>