// Created by FLX on 05.05.2015
// DO NOT minify and uglify this Code due to presentation reasons

// start our function in a Singleton 
var app = function() {

    //--------RenderVIEW for DYNAMIC Content --- private method from template-7 ----------------------------
    // View:id of script blocks, model = object/array, destinationDivID = container to publish rendered view
    function renderView(view, model, destinationDivID, callback) {
        // Read the particular template View
        // ajax call from view-folder: load file with view-name
        $.get('view/' + view + '.html', function (data) {
            var template = data;
            // Compile it through template7-compiler
            var compiledTemplate = Template7.compile(template);
            // read this particular Model (JSON-ojbect)
            var context = model;
            // from argument: compiled VIEW -ready to inject
            var fullyRenderedView = compiledTemplate(context);
            // inject into DOM  (argument: destinationDivID)
            $('#' + destinationDivID).html(fullyRenderedView);
            if (callback && typeof(callback) === "function") {
                callback();
            }
        });
    }

    // IncludeView: Load Partial-Views for STATIC content HTML snippets
    function includeView(partialViewID, viewContainerID, callback) {
        $.get('view/' + partialViewID + '.html', function (data) {
            $('#' + viewContainerID).html(data);
            if (callback && typeof(callback) === "function") {
                callback();
            }
        });
    }

    // include Titlebar into dom
    function includeTitleBar() {
        includeView('TitleNavBar', 'ContainerMenuBar', function(){
            initState++;
            console.log('TitleMenuBar loaded - InitState : ' +initState);
        });
    }


    // include ThemeToggler Content to Wrapper
    function includeThemeToggler() {
        includeView('ThemeTogglerContent', 'ContainerThemeToggler', function(){
            initState++;
            if(iosdev == true){
                doNotShowonios();
                console.log("do not show FS menu on ios");
            }
            console.log('ThemeTogglerMenuBar loaded - InitState: ' +initState);
        });
    }

    // include Footer Content into wrapper
    function includeFooter() {
        includeView('FooterBarContent', 'ContainerFooter', function(){
            initState++;
            console.log('FooterBar loaded - InitState: ' +initState);
        });
    }

    //------------------ View specific Sub Application Functions ---------------------------------

    // load all images from 1 clicked album
    function loadGalleryDetail(albumIdx) {
        // actual Gallery choosen by user
        //console.log(albums.gallery[albumIdx]);

        var actGallery = albums.gallery[albumIdx];
        //console.log(actGallery);
        //render view: Gallery detail to galleryDetailContainer
        renderView('galleryDetail', actGallery, 'galleryDetailContainer', function(){
            // show Container
            $('#galleryDetailContainer').show();
            // hide overview container
            $('#galleryOverviewContainer').hide();
            // initialize holy Swiper-plugin in swiper container
            $('#galleryDetailContainer .swiper-container').swiper({
                loop: true,
                speed: 250,
                keyboardControl: true,
                nextButton: '.swiper-button-next',
                prevButton: '.swiper-button-prev',
                effect: 'slide'
            });

            // attach info button for info-layer
            $('.info').on('click', function () {
                viewInfoToggler();
            });

            // hide footer when possible in Gallery view mode
            hideFooterandDimm();
            // attach close button and empty gallery container on exit
            $('#galleryDetailContainer .close').css('cursor', 'pointer').on('click', function () {
                //call function to reset gallery-overview settings
                showFooterAndLighten();
                $('#galleryDetailContainer').hide().empty();
                $('#galleryOverviewContainer').show();
            })
        });
    }

    // On StartView Light up bg-image for fancyness reason only
    function lightup(){
        // 1. dimm up h-containers
        $('.center').delay(2800).queue(function (goNext) {
            $(this).animate({
                'opacity': '1'
            },500);
            goNext();
        });
        // 2. do fancy letterspacing after delay
        $('.center h2').delay(3200).queue(function (NextStep){
            $(this).animate({
                'letter-spacing':'5px'
            });
            NextStep();
        });
    }

    // works on Desktop Browsers and Android mobile devices - I got this script from HTML5Rocks http://www.html5rocks.com/en/mobile/fullscreen/
    // therfore: display only on desktop browser and not-apple-IOS-devices
    function goFullScreen() {
        var doc = window.document;
        var docEl = doc.documentElement;
        var requestFullScreen = docEl.requestFullscreen || docEl.mozRequestFullScreen || docEl.webkitRequestFullScreen || docEl.msRequestFullscreen;
        var cancelFullScreen = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen || doc.msExitFullscreen;
            if(!doc.fullscreenElement && !doc.mozFullScreenElement && !doc.webkitFullscreenElement && !doc.msFullscreenElement) {
                 requestFullScreen.call(docEl);
            }else{
                cancelFullScreen.call(doc);
            }
    }

    // Render and attach Click events on Navigation
    function createMenu() {
        // render navigation to containerNav
        renderView('navig', pages, 'ContainerNav', function(){
        // attach Events on Navigation list Elements
        attachNavigEvents();
        // show only on ios-touch device
            if(touchdev == true && iosdev == true){
                showOnlyOnAppleTouch();
                console.log("it is a apple and a touch dev");
            }else{
                hideATHSapple();
            }
        });
    }

    // function viewInfoToggler in gallery detail view
    function viewInfoToggler() {
        // hide it if shown
        if ($('#imgdetails').hasClass('show')) {
            $('.img-caption').css({
                'visibility': 'hidden'
            });
            $('#imgdetails').removeClass('show');
        } else {
            // show it -if hidden
            $('.img-caption').css({
                'visibility': 'visible'
            });
            $('#imgdetails').addClass('show');
        }
    }

    // ------------Attaching events to rendered Views --------------------------------------

    // attach click-events to Navigation after Redering to generate internal links (class: menulink)
    var attachNavigEvents = function () {
        $('#ContainerNav a.menulink').on('click', function (e) {
            e.preventDefault();

            // click event auf navig- elemente with hashNavigation / fragment for backbutton behavior
            location.hash = $(this).data('index');
           // changePage($(this).data('index'));
            //close Navigation Container
            closeNav();
        })
    };

    //click-event auf Navigation menu-toggler button
    function attachMenuToggler() {
        $('#BtnMenuToggler').on('click', function (e) {
            e.preventDefault();
            MenuToggler();
        })
    }

    // click event auf Theme Toggler attachen
    function attachThemeToggler() {
        $('#themetoggler a').on('click', function (e) {
            e.preventDefault();
            // execute Theme toggler
            ThemeToggler();
            //console.log('themeToggler was clicked, very nice')
        })
    }

    // clickfunction ThemeChoser
    function attachThemeChooserEvent() {
        $('.themelink').on('click', function (e) {
            e.preventDefault();
            //console.log('clicked on a themechooser, well done ');
            changeTheme($(this).attr('data-themepath'));
        })
    }

    // clickfunction Fullscreen and back again
    function attachEventFullscreen(){
        $('#goFS').on('click', function (e){
            e.preventDefault();
            goFullScreen();
        })
    }

    // click events auf albums in gallery overview
    function attachAlbumEvents() {
        $('#galleryOverviewContainer tr').css('cursor', 'pointer').on('click', function (e) {
            e.preventDefault();
            loadGalleryDetail($(this).data('idx'));
        })
    }


    // change href attibut with themepath
    function changeTheme(themepath) {
        //  apply another style-sheet
        $('#themeCss').attr('href', themepath);
        closeTTmenu();
    }
    ///??
    function getPageIdxByNavTitel(navTitel) {
        // iterate over array of pages
        var idx = 0;
        $.each(pages.seiten, function (i, el) { // i represents the iteration-index, el represents the element
            // now iterate over the individual page-obejct
            for (var key in pages.seiten[i]) {
                if (key == 'titelNav' && pages.seiten[i][key].toLowerCase() == navTitel.toLowerCase()) {
                    idx = i
                }
            }
        });

        return idx;
    }

    function closeBubble() {
        $('#bubble').fadeOut(function () {
            $(this).remove()
        })
    }

    // do not show item on ios -device - do not confuse simple-minded apple- prayers
    function doNotShowonios(){
        $('.fullscreenmenu').hide();
    }

    // if client is a apple and a touch device - show the ats- menu point
    function showOnlyOnAppleTouch(){
        $('.menulink:contains(Apple)').show();
    }

    // if it is not a apple-touch device then hide this menue item and without touching the model-or rendering logic - sweet!
    function hideATHSapple(){
        $('.menulink:contains(Apple)').parent('li').hide();
    }

    // uploading bubble screen render n resizing
    function setBubble(text) {
        $('#bubble').remove();
        var newBubble = $('<div>', {id: 'bubble'}).css({
            position: 'absolute',
            top: parseInt(($(window).height() - 50) / 2),
            left: parseInt(($(window).width() - 300) / 2)
        }).html(text).appendTo('body').fadeIn()
    }

    //---------------------------------------- PUBLIC methods -------------------------------------/
    // functions with call in variable notation. return an object
    // change page
    var changePage = function (pageIdx) {
        // get page from pages model (with object seiten)
        actPage = pages.seiten[pageIdx];
        // actPageIdx = Index from argument
        actPageIdx = pageIdx;
        //1: renderView Content: Model,  home,  div-container
        renderView(actPage.template, actPage, 'ContainerContent', function(){
            if (actPage.template == 'default') {
                renderTeaser();
            }
            // check for sub-apps
            if (actPage.app != '') {
                switch (actPage.app) {
                    // if the subapp is galleryOverview, render the partialview
                    case 'galleryOverviewApp':
                    {
                        // render album overview into "galleryoverviewcontainer"
                        listGalleries();
                    }
                    case 'upload':
                    {
                        // get albums from Model
                        includeView('uploaderForm', 'upload', function(){
                            populateSelectBox();
                        });
                    }
                    case 'home':
                    {
                        // fancy lightup shit with wow factor-flx-style
                        lightup();
                    }
                    // the 'app' login is just an include without model, therefore i created a function "includeView"
                    //case 'login': includeView('login','appContainer') // appContainer is a global conatiner for addional apps in standard default-pages
                    //case 'upload' : includeView('upload','appContainer') // appContainer is a global conatiner for addional apps in standard default-pages
                }
            }
        });
    };


    // Adapted from Stackoverflow -convert-data-uri-to-file-then-append-to-formdata binary
    // Convert data-URI into Binary object
    function dataURItoBlob(dataURI) {
        // convert base64 to raw binary data held in a string
        var byteString = atob(dataURI.split(',')[1]);
        // separate out the mime component
        var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
        // write the bytes of the string to an ArrayBuffer
        var arrayBuffer = new ArrayBuffer(byteString.length);
        var _ia = new Uint8Array(arrayBuffer);
        for (var i = 0; i < byteString.length; i++) {
            _ia[i] = byteString.charCodeAt(i);
        }

        var dataView = new DataView(arrayBuffer);
        var blob = new Blob([dataView.buffer], {type: mimeString});
        return blob;
    }
    // check if there are any Albums, and put them into select-option and append to albumlist
    function populateSelectBox() {
        $.each(albums.gallery, function (i) {
            var newOption = $('<option>', {value: albums.gallery[i].albumID}).text(albums.gallery[i].albumtitel).appendTo('#albumList');
        });
        // toggle new Album field based on selection of existing albums (or a new one)
        // if existing album is selected hide New album to avoid very-dummy-user confusion.
        $('#albumList').on('change', function (e) {
            if (isNaN($(this).val())) {
                // jagern es eigets album
                $('#newAlbumOnUpload').show();
            }
            else {
                // neidanke bruuchinoed
                $('#newAlbumOnUpload').hide();
            }
        });

        // on change of upload field, do PREVIEW - works almost on all devices exept some phones.
        $('input[type=file]').on('change', function (evt) {
            // FileList object from evt-callback
            var files = evt.target.files;
            // new FormData obj
            formData = new FormData();
            var previewModel = {};
            previewModel['images'] = [];


            // Loop through the FileList [array] and render image files as thumbnails.
            for (var i = 0, f; f = files[i]; i++) {
                // Only process image files.
                if (!f.type.match('image.*')) {
                    continue;
                }
                // start new fileReaderAPI as base64
                var reader = new FileReader();
                // Closure to capture the file information.
                /*reader.onload = (function(theFile) {
                 return function(e) {
                 //return dom for image of "theFile"
                 previewModel['images'].push({imgpath:e.target.result})
                 //var span = $('<span>').html('<img class="thumb" src="' + e.target.result + '" title="' + escape(theFile.name) + '" />').appendTo('#upload')
                 };
                 })(f);*/
                //

                reader.onloadend = (function(f) {
                    return function(e) {
                        base64data = e.target.result;
                        var image = new Image();
                        image.src = URL.createObjectURL(f);
                        image.onload = function() {
                            var resized = resizeMe(image); // send it to canvas
                            var resizeBase64 = resized.replace(/^data:image\/(png|jpg);base64,/, "")
                            previewModel['images'].push({imgpath:resized})

                            var blob = dataURItoBlob(resized);
                            formData.append("bilder", resizeBase64);
                        }

                    };
                })(f);

                // Load files into file reader
                reader.readAsDataURL(f);
                // add image to formData object under property "bilder"
                //formData.append('uploadFotos', f);
            }

            //temp preview model a
            a = previewModel;

            setTimeout(function(){
                renderView('uploaderPreviewSlider',a,'previewUploadImages>div')
            },50)
        });


        $('#uploadSubmit').click(function(e){
            // bubble box to user to be patient
            setBubble('Resizing Images on Client \n & Uploading to Server... ');

            e.preventDefault();
            // append elements to formData Obj.
            formData.append('albumTitle',$('#newAlbumTitle').val());
            formData.append('albumList',$('#albumList').val());
            // post the data to the flx CF Server and put it there to the corresponding album
            $.ajax( {
                url: 'http://www.flx-media.ch/spa/api/spa-api.cfm',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    // when post successful, then reload the gallery-model
                    getPixModelFromServer();
                    // Close Upload Bubble
                    closeBubble();
                    // show thanks screen
                    showUploadThanksScreen();
                }
            });
        })
    }
    // still needed?
    function hideUploadThanksScreen() {
        alert("hideUploadThankscreen function ");
        $('#uploadThanks').fadeOut(function() {
            $(this).empty();
        })
    }

    // After upload of Pictures: Show Thank screen and include Button to gallery-overvview albums
    function showUploadThanksScreen() {
        renderView('uploaderThanksScreen', {
            h1titel: 'Thank you!',
            h2titel: 'Pictures have been uploaded'
        }, 'uploadThanks', function(){
            $('#uploadThanks').fadeIn();
            $('#toTheGaleriesBtn').on('click', function (e) {
                // jump to the album page.
                // because we dont know the index at this time, i added a function which allows us, to search within the pages-model for navTitles.
                // the function returns the index of the page within the pages-model.
                actPageIdx = getPageIdxByNavTitel('albums');
                // page no 3 in hash navigation
                changePage(3);
            })
        });

    }

    // list all galleries
    function listGalleries(actAlbumIdx) {
        //1: renderView Content: Model(JSON Albums: gallery-Array), div-container and wait for callback
        renderView('galleryOverview', albums, 'galleryOverviewContainer', function(){
            attachAlbumEvents();
        });
    }

    function convertDataURIToBinary(dataURI) {
        var base64Index = dataURI.indexOf(BASE64_MARKER) + BASE64_MARKER.length;
        var base64 = dataURI.substring(base64Index);
        var raw = window.atob(base64);
        var rawLength = raw.length;
        var array = new Uint8Array(new ArrayBuffer(rawLength));

        for (i = 0; i < rawLength; i++) {
            array[i] = raw.charCodeAt(i);
        }
        return array;
    }


    //funktion resize images
    function resizeMe(img) {
        var canvas = document.createElement('canvas');
        var width = img.width;
        var height = img.height;
        // calculate the width and height, constraining the proportions
        // landscape
        if (width > height) {
            if (width > 1200) {
                //height *= max_width / width;
                height = Math.round(height *= 1200 / width);
                width = 1200;
            }
        }
        //portrait
        else {
            if (height > 1024) {
                //width *= max_height / height;
                width = Math.round(width *= 1024 / height);
                height = 1024;
            }
        }
        // resize the canvas and draw the image data into it
        canvas.width = width;
        canvas.height = height;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, width, height);
        //preview.appendChild(canvas); // do the actual resized preview
        return canvas.toDataURL("image/jpg", 0.8); // get the data from canvas as 80% JPG (can be also PNG, etc.)
    }


    // function: is menu is open or closed
    function MenuToggler() {
        if ($('#navWrapper').hasClass('open')) {
            closeNav()
        } else {
            openNav()
        }
    }

    //JQuery navigation show-hide functions
    function openNav() {
        //move ContainerContent with css-translate
        $('#ContainerContent').css({
            'transform': 'translate3d(300px,0,0)'
        });

        // add class open & set visible
        $('#navWrapper').delay(350)
            .addClass('open')
            .queue(function (openNavWr) {
                $(this).css({
                    'visibility': 'visible'
                });
                openNavWr();
            }
        );

        // open the navigation content after delay
        $('#navContent').delay(300)
            .queue(function (gonext) {
                $(this).css({
                    'opacity': '1',
                    'transform': "translate3d(0,0,0)"
                });
                gonext()
            }
        );
        animateMenuHeader();
        useless();
    }

    function closeNav() {
        // fade back and CLOSING Menu bar
        $('#navContent').css({
            'opacity': '0.5',
            'transform': "scale(0.5) translate3d(0,0,0)"
        },200);

        // navWrapper: set visibility hidden after delay-function
        $('#navWrapper').delay(251)
            .queue(function (goNext) {
                $(this).css({
                    'visibility': 'hidden'
                });
                //remove class open after execution
                goNext()
            }
        );

        //remove class open
        $('#navWrapper').removeClass('open');

        // move back ContainerContent
        $('#ContainerContent').delay(400)
            .queue(function (closeCC) {
                $(this).css({
                    'transform': 'translate3d(0,0,0)'
                });
                closeCC()
            }
        );
        // put menu-in origin position- for animation fun again
        $('.animMe').css({
            'padding-right':'0'
        });

    }


    // function is ThemeToggler menu is open or closed ?
    function ThemeToggler() {
        if ($('#ContainerThemeToggler').hasClass('open')) {
            closeTTmenu()
        } else {
            openTTmenu()
        }
    }


    // function theme-Toggler open
    function openTTmenu() {
        // move main container to the left
        $('#ContainerContent').css({
            'transform': 'translate3d(-300px,0,0)'
        }, 300);

        // set Container TT to visible
        $('#ContainerThemeToggler').css({
            'visibility': 'visible'
            //add class to container
        }).addClass('open');

        // animate and show menu
        $('#ttwrapper').delay(1000).css({
            'margin-top': '0',
            'opacity': '1'
        }, 1200);

        animateMenuTTHeader();
    };

    //function theme Toggler close
    function closeTTmenu() {
        // animate and show menu
        $('#ttwrapper').css({
            'margin-top': '-300px',
            'opacity': '0.4'
        }, 200);

        // set container TT to invisible -visible
        $('#ContainerThemeToggler').css({
            'visibility': 'hidden'
            //remove class from container
        }).removeClass('open');

        // delayed continer move back into place
        $('#ContainerContent').delay(500)
            .queue(function (gonext) {
                $(this).css({
                    'transform': 'translate3d(0,0,0)'
                }, 250);
                gonext()
            }
        );
        // reset animation header
        $('.animMeTT').css({
            'margin-left': '12rem'
        });
        console.log('done');
    }


    // execute listGalleries
    listGalleries();
    function getPixModelFromServer() {
        $.get('http://flx-media.ch/spa/api/spa-api.cfm?callback=', function (data) {
            //property gallery add and fill with callback from get-JSON request.
            albums.gallery = JSON.parse(data);
        })
    }



    //animate the Menu left-header-font - for fun and ressource-wasting
    function animateMenuHeader() {
        $('.animMe').delay(400)
            .queue(function (goNext) {
                $(this).css({
                    'padding-right':'4rem'

                });
                goNext()
            }
        );
    }
    // clic funktion for logo. until now useless... -but what the hell..
    function useless(){
        $('#flx-logo').click(function(){
            alert("It is a funny, silly Logo; and rotating is COMPLETELY useless...\n  - but FUNNY! \n JavaScript Alerts ARE annoying, arent they? \n and Clicking it is completely useless too... ;-) \n  \n OK ?");
        });
    }

    //animate Menu -right header TT
    function animateMenuTTHeader(){
        $('.animMeTT').delay(700)
            .queue(function (goNext){
               $(this).css({
                   'margin-left': '2rem'
               });
                goNext()
            }
        );
    }
    // it's Show-Time: when entering in Gallery Detail Mode: Hide Footer, if any, and darken titlebar for Fokus on the picture
    function hideFooterandDimm(){
        $('#ContainerFooter').css({
            'height':'0px',
            ' visibility': 'hidden'
        });
        $('#ContainerContent').css({
            'padding-bottom': '0px'
        });
        $('.titlebar').css({
            'background' :"#111"
        });
    }
    // reset footer and titlebar - when leaving Gallery Pix.
    function showFooterAndLighten(){
        $('#ContainerContent').css({
            'padding-bottom': '70px',
            'visibility': 'visible'
        });

        $('#ContainerFooter').css({
            'height':'70px'
        });
        $('.titlebar').css({
            'background' :"none"
        });
    }

    // render Partial View Teasers
    function renderTeaser() {
        //1: renderView teasers
        renderView('teaserWrapper', teasers, 'teasercontainer');
    }

    // execute ListTeasers
    function getTeasersFromServer() {
        $.get('http://flx-media.ch/spa/api/spa-api-tea.cfm?callback=', function (datateaser) {
            // property teasers from JSON teasers
            teasers.singleentry = JSON.parse(datateaser);
            //console.log(teasers.singleentry);// renderTeaser();
        })
    }

    // get data Model (pages) from server
    function goToAlbum(idx){
        console.log("hey you clicked idx"+idx+" so cool! now wait 500ms");
        // erwartet page-index (3= album)
        changePage(3);
        setTimeout(function(){
            loadGalleryDetail(idx);
        },500)
    }
    

    // show browser tests ok
    function showOKfeatures(){
        $('#showTests').css({
            'color': '#1FF'
        }).fadeIn(250).delay(10000).fadeOut(200);
    }

    // show browser tests failed
    function showFailedfeatures(){
        $('#featureList').fadeIn(250).delay(10000).fadeOut(200);

        $('.nef').css({
            'color': '#F11'
        });
    }

    // browser tests not passed: abort loading, show failback screen - and exit
    function abortloading(){
        console.log("aboartloading function");
        //alert(1);
        $('#failback-content').show();
        // show the needed features for debugging
        $('#featureList').show();
        showFailedfeatures();
        // remove loading splash view
        $('.splash-content').hide();
    }
  
    // Start Procedere 1
    // init stage 1 function Start splash screen and browser-feature-tests - do this once
    var initStage1 = function (){
        //0. launch splash viewer first
        includeView('splashView', 'splash', function (){
            $.getScript('js/splashanimation.js');
            // load splash.js now
            $.getScript('js/TweenMax.min.js');
            // check if client browser meets the need -
            browserfeaturetest();
        });
    };

    // Start Procedere 1.1
    // if all essential browserfeatures are true - continue loading
    function browserfeaturetest(){
        if(essentialfeatures){
            $('#showTests').html("<li>Browser Support Detection</li>");
            $.each(featurerequired, function(i){
                $('#showTests').append('<li class="fea-list">'+featurerequired[i]+' check : <span>' + featurestest[i]+'</span></li>')
            });
            showOKfeatures();
            // all tests passed - lets fireup stage 2
            initStage2();
        }else{
            // abort loading and show failback screen and Errordetection   
            $('#showTests').html("<li>Browser Error Detection</li>");
            $.each(featurerequired, function(i){
                $('#showTests').append('<li class="fea-list">'+featurerequired[i]+' check : <span class="nef">' + featurestest[i]+'</span></li>')
            });
            abortloading();
            showFailedfeatures();
            console.log("featureTest NOT passed");
        }
    }
    
    // Start Procedere 2
    // init stage 2: load content and include them into DOM 
    function initStage2(){
        // get All pages from server with callback 2.1 -then continue
        getPagesfromServer(function(){
            //  get Photo Galleries from server
            getPixModelFromServer();
            //  function to get teasers from server
            getTeasersFromServer();
            // do  initial tasks and do it with variable actPageIDX (declared start page = 0)
            changePage(actPageIdx);
            console.log('start-page is now rendered.');
            // 2. render Menu and attach events
            //One-timer: if content of containerNav == empty.. (Only true on PAGELOAD )
            createMenu();
            // includeTitleBar
            includeTitleBar();
            // include Footer
            includeFooter();
            // include ThemeToggler
            includeThemeToggler();
            //global var checker: ask if initState ===3, every 100ms, if so, start Init-3 function
            checker = setInterval(function(){
                if(initState==3){
                    // init stage function: final stage
                    initStage3()
                }
            },100);
        });
    }

    // 2.1 get data Model (pages in JSON format) from server
    function getPagesfromServer(callback) {
        // $.get('http://flx-media.ch/spa/api/spa-api-pages.cfm?callback=', function (data){
        //working with getJSON
        $.getJSON('../model/pages.json', function (data){
            //fill the data object
            pages = data;
            // is there an argument callback and is it a function, then
            if (callback && typeof(callback) === "function") {
                // execute callback function : continue with init function -tasks
                callback();
                console.log('getPages fromServer finished. DOM ready. all Pages loaded');
            }
        });
        // if callback ok - continue
    }

    // 3. DOM is ready now - attach Events to components in initStage3-function
    function initStage3(){
        // global variable initState reset and clear Interval
        initState = 0;
        clearInterval(checker);
        // attach menuToggler to MenuBar link
        attachMenuToggler();
        // attach ThemeToggler to MenuBar link
        attachThemeToggler();
        // attach ThemeChooserEvent
        attachThemeChooserEvent();
        // attach GalleryClick Events
        attachEventFullscreen();
        // fade out function splash-screen after 330 milissec
        console.log('all events attached. init-stage 3 finished.');
        setTimeout(function () {
            $('#splash').fadeOut(350, function () {
                // and remove it from DOM - we dont need it anymore
                $('#splash').remove()
            });
        },3050);
        console.log('splash screen removed. App content ready - have fun!')
    }




    // add a hash-change function tu url to enable back button navigation
    $(window).on('hashchange', function() {
        var getHashFromURL = location.hash;
        console.log(getHashFromURL);
        changePage(getHashFromURL.replace('#',''));
    });

    // return instance RETURN OBJECT an expose PUBLIC methods
    // 1. Name of private Function (after instantiation)
    // 2. Name of Public Function
    return {
        changePage: changePage,
        goToAlbum: goToAlbum,
        init: initStage1

    }; // return the instantiated app-object
};