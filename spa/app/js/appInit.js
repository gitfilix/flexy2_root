/**
 * Created by FLX on 05.06.2015.
 */

// pre-init app tests on document ready
$(document).ready(function(){
    // check if features of client is eq essential fpix gallery features
    for (i=0;i<featurerequired.length;i++){
        // compare if featuretest pushed in html by modernizer are same as we need
        if ($('html').hasClass(featurerequired[i])){
            featurestest.push(true);
            //console.log("featuretests is currently: " +featurestest);

            //console.log(features[i]);
            essentialfeatures = true;
        }else{
            essentialfeatures = false;
            console.log("essentialfeatures check failed !!");
            break;
        }
    }

    // it is a touch -device ?
    if(Modernizr.touch){
        //alert("touch supported");
        touchdev = true;
    }
    // it is a Apple device?
    if (navigator.userAgent.match(/(iPad|iPhone|iPod)/g)){
        iosdev = true;
        console.log("iOS device detection is: "+iosdev);
    }

    // make a new instance is javascript CLASS Object object "app()"
    application = app();

    // Launch app in filixpix-app.js
    application.init()
});


// general helper special sauce function from outer scope (link teaser-module)
function goTo(x){
    application.goToAlbum(x);
}