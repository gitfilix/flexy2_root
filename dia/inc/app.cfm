<cfprocessingdirective pageencoding="utf-8" />

<div style="z-index:100;position:absolute;left:10px;top:10px;padding:10px;background:darkred;color:white;display:none;" id="debugToggler">Toggle degubMode</div>
<div id="slidedin" style="opacity:0;position:absolute;top:100px;left:40%;z-index:9999;width:200px;padding:10px;margin-top:15%;background:white;border-radius:10px;text-align:center;">I slided into the Viewport</div>
<div id="moving" style="opacity:0;position:absolute;top:100px;left:40%;z-index:9999;width:200px;padding:10px;margin-top:15%;background:white;border-radius:10px;text-align:center;">sliding</div>
<div id="loading" style="display:none;position:absolute;top:0;left:0;z-index:10000;width:100%;height:100%;background:rgba(120,120,120,1);border-radius:10px;text-align:center;">
	<div style="position:absolute;top:100px;left:40%;z-index:9999;width:200px;padding:10px;margin-top:15%;background:white;border-radius:10px;text-align:center;">loading</div>
</div>
<div id="rotate" style="height:100%;width:100%;display:none;">
	<div style="color:white;">Rotate your device</div>
</div>
<div id="outofbounds" style="opacity:0;position:absolute;top:100px;left:40%;z-index:9999;width:200px;padding:10px;margin-top:15%;background:white;border-radius:10px;text-align:center;">out of bounds</div>
<div id="dirIndicator" style="margin:20px 20px 0 0;width:80px;position:absolute;top:0;right:0;padding:20px;background:white;border-radius:10px;border:1px solid grey;display:none;">
	<div id="uarrow" style="margin-left:25px;display:inline-block;width:25px;text-align:center;color:white;cursor:pointer;">
		&uArr;
	</div><br/>
	<div id="larrow" style="display:inline-block;width:25px;text-align:center;color:white;cursor:pointer;">
		&lArr;
	</div>
	<div id="rarrow" style="margin-left:25px;display:inline-block;width:25px;text-align:center;color:white;cursor:pointer;">
		&rArr;
	</div><br/>
	<div id="darrow" style="margin-left:25px;display:inline-block;width:25px;text-align:center;color:white;cursor:pointer;">
		&dArr;
	</div>
</div>
<div id="scrollDebug" style="position:fixed;top:1em;right:1em;background:white;padding:1em;display:none;"></div>

<div id="offcanvas" style="z-index:199;position:absolute;left:-320px;top:0;background-color:#333333;height:100%;width:320px;">
	Hier kommt die Navig
</div>

<div id="overlay-infowindow" class="overlay infowindow" style="display:none;">
	Hier kommt eine Information
</div>

<div id="dimmer2" style="height:100%;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;position:absolute;left:0;top:0;display:none;">&nbsp;</div>

<div id="overlay-bottom" class="overlay" style="position:absolute;bottom:0;display:none;left:0;width:100%;height:320px;background-color:#333333;z-index:200;">
	<form class="inset">
	  <label class="block-label">Email</label>
	  <input type="email" name="email" placeholder="Email" class="input-text">
	  <label class="block-label">Password</label>
	  <input type="password" name="password" placeholder="Password" class="input-text">
	  <div class="form-actions">
		<input type="submit" class="btn btn-block" value="Submit">
		<button type="button" class="btn btn-block">Cancel</button>
	  </div>
	</form>
</div>

<div id="overlay-top" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:250px;background-color:#333333;z-index:199;">
	Hier kommt weiteres
</div>

<div id="overlay-top-1" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:100px;background-color:#333333;z-index:199;">
	Hier kommt weiteres
</div>

<div id="overlay-top-2" class="overlay" style="position:absolute;top:0;display:none;left:0;width:100%;height:100%;background-color:#333333;text-align:center;z-index:199;">
	<iframe frameborder="0" src="/admin" style="width:100%;height:100%;"></iframe>
	<div style="position:absolute;top:1em;right:1em;z-index:100;color:white;" id="closeOverlay2">
		<strong>X</strong>
	</div>
</div>

<div id="overlay-top-3" class="overlay" style="position:absolute;top:0px;display:none;left:0;width:100%;height:100%;background-color:#333333;z-index:199;">
	<iframe frameborder="0" src="http://www.web-kanal.ch" style="width:100%;height:100%;"></iframe>
	<div style="position:absolute;top:1em;right:3em;z-index:100;color:white;" id="closeOverlay3">
		<strong>X</strong>
	</div>
</div>

<div id="overlay-top-4" class="overlay" style="position:absolute;top:0px;display:none;left:0;width:100%;height:100%;background-color:#333333;z-index:199;">
	<div id="map" style="height:100%;"></div>
	<div style="position:absolute;padding:1em;border-radius:5px;background:red;top:1em;right:3em;z-index:99999;color:white;" id="closeOverlay4">
		<strong>X</strong>
	</div>
</div>

<div id="lightbox" class="hidden">
	<div style="height:100%;"></div>
	<span style="display:block;position:absolute;top:0.3em;right:0.2em;z-index:1001;padding:0.2em;font-size:1em;">
		<button class="large" onClick="closeLightbox();" style="display:block;padding:1em;border:0;background-color:#8d2a03;color:#fff;cursor:pointer;">close</button>
	</span>
</div>
 
<div id="menu" data-position="bottom" style="position:fixed;top:0;left:0;right:0;-webkit-transform:translateY(-52px);-moz-transform:translateY(-52px);transform:translateY(-52px);z-index:3;">
	<!--- <div style="height:50px;overflow:hidden;background:#e5e5e5;color:grey;padding-top:10px;">
		<ul>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="slidey.jumpto(0,0);hideInfoWindow();$('.overlay').hide();closeLeftNav()" title="">
					Home
				</a>
			</li>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="toggleOverviewMode();" title="">
					Übersicht
				</a>
			</li>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="showOverlay('overlay-top-2');" title="">
					Menü 2
				</a>
			</li>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="showOverlay('overlay-top-3');" title="">
					Menü 3
				</a>
			</li>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="showOverlay('overlay-top-4');" title="">
					Menü 4
				</a>
			</li>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="showInfoWindow('Hallo Welt');" title="">
					InfoWindow
				</a>
			</li>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="toggleLeftNav();" title="">
					Linke Navig
				</a>
			</li>
			<li style="float:left;padding-right:2em;">
				<a href="javascript:void(0);" onClick="showOverlay('overlay-bottom');" title="">
					Kontakt / Feedback
				</a>
			</li>
		</ul>
		<div style="clear:both;"></div>
	</div> --->
	
	<script>
	function showMap(){
		showOverlay('overlay-top-4');
		setTimeout(function(){
			map = new GMaps({
				div: '#map',
				lat: -12.043333,
				lng: -77.028333,
				height: '100%',
				width:'100%'
			  });
		},150)
	}
	</script>
	
	<nav class="navbar navbar-default" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
			  <a class="navbar-brand" href="#">FS Dia</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li>
						<a href="#">Home</a>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Auswahl <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="javascript:void(0);" onclick="showOverlay('overlay-top-3');">Meine Website</a></li>
							<li><a href="javascript:void(0);" onclick="showOverlay('overlay-top-2');">Futurescreen CMS</a></li>
							<li><a href="javascript:void(0);" onclick="showMap();">Karte</a></li>
						</ul>
					</li>
					<li>
						<a href="javascript:location.reload()">Refresh</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>	
</div>

<div id="menuhandle" style="position:absolute;right:1em;top:1em;z-index:4;">
	<img src="/dia/img/handle.png">
</div>	

<cfoutput>
	<nav class="footer ftScrollerlHorizontal" id="footerslider" style="background:white;bottom:-310px;height:320px;border-top:1px solid silver;position:fixed;z-index:3;left:0;width:100%;overflow:hidden;">
		<div style="height:100%;width:#chapters*325#px;display:table;">
		<cfloop from="1" to="#chapters#" index="i">
			<div style="height:200px;display:inline-block;width:300px;background:##ddd;margin-right:20px;overflow:hidden;position:relative;"> 
				<div style="margin-top:1em;text-align:center;">
					<h1 style="font-weight:800;font-size:3em;">#i#</h1>
					#listGetAt(chapterTitles,i)#<br/><br/>
					<button class="btn" onclick="slidey.jumpto(0,#fs.getTopChapterSlides(chapterID=listGetAt(chapterIDs,i)).id#);toggleTopMenu();$('##dimmer2').hide();">Go</button>
				</div>
			</div>
		</cfloop>
		</div>
	</nav>
</cfoutput>