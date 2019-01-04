<cfquery name="getSlideBackgroundImage" datasource="#application.dsn#">
SELECT bgimage,bgcolor,parent,label FROM magazinSlides
WHERE id = #url.slideID#
</cfquery>
<cfquery name="getSlideContent" datasource="#application.dsn#">
SELECT * FROM magazinslidetpl_103
WHERE slideid = #url.slideID#
</cfquery>


<cfoutput query="getSlideContent">
<!--- Layouttype 1: big lead- little text --->

<cfif getSlideContent.layout EQ 1>
<div style="background:#getSlideBackgroundImage.bgcolor#;color:##333;font-family:'league gothic'; height:100%;position:relative;" class="tpl-103" >	
	
	
	<div style="width:400px;height:300px;text-align:center;position:absolute;z-index:12;" class="anim center" data-inanimation="0.0-fadeIn-0.5" data-outanimation="4.0-scaleTextDown-0.4" >
		<h1 style="font-size:6em;">#titel#</h1>
	</div>
	
	<div style="width:400px;height:200px;text-align:center;position:absolute;z-index:13;color:##333;font-size:2em;" class="anim center overthrow" data-inanimation="4.2-fadeIn-0.3" data-outanimation="6.5-scaleTextDown-0.4"  >
		#lead#
	</div>
	
	<div style="width:400px;height:200px;text-align:center;position:absolute;z-index:13;color:##333;font-size:2em;" class="anim center overthrow" data-inanimation="6.7-scaleTextUp-0.3"   data-outanimation="9-slideOutRight-0.3">
		#text#
	</div>
	
	<img src="/dia/img/ipad.png" style="max-width:600px;position:absolute;z-index:10;" data-inanimation="0-fadeIn-5" data-outanimation="9-slideOutRight-0.3" class="center anim">
	
	<img src="/dia/img/ipad.png" style="max-width:600px;position:absolute;z-index:10;" data-inanimation="10-slideInLeft-0.3" class="valign anim">
	<img src="/dia/img/ipad.png" style="max-width:600px;position:absolute;z-index:10;" data-inanimation="10-slideInRight-0.3" class="valign anim">
	
	<div style="width:550px;padding-left:50px;position:absolute;height:300px;z-index:20;text-align:center;font-size:6em;" data-inanimation="11-slideInLeft-0.3" class="anim valign">
		HEY
	</div>
	<div style="width:550px;position:absolute;padding-right:50px;height:300px;z-index:20;text-align:center;font-size:6em;" data-inanimation="11-slideInRight-0.3" class="anim valign">
		JOE
	</div>
	
	
</div>


</cfif>
</cfoutput>