/**
 * Created by FLX on 14.09.2015.
 */

$(document).ready(function (){

    //alert("ready");
  /* var controller = new ScrollMagic.Controller();


    new ScrollMagic.Scene({
        duration: 100,
        offset: 50
    })
    .setPin("#myfirstPin")
    .addIndicators({name: "1 (duration:300)"})
    .addTo(controller);
    */
    var controller = new ScrollMagic.Controller();

    //build tween
    var tween = TweenMax.to("#animate", 0.8, {scale: 1.3, repeat: 3, yoyo: true});

    // build scene
    var scene = new ScrollMagic.Scene({triggerElement: "#trigger0", duration: "100%"})
        .setTween(tween)
        .addIndicators()
        .addTo(controller);

   /* var scene2 = new ScrollMagic.Scene({triggerElement: "#trigger1", duration: "1600"})
        .setPin("#pin1")
        .addIndicators({name: "1 (duration: 1600)"})
        .addTo(controller);
*/
    //var tween2 = TweenMax.to("#animateme", 0.5, {repeat: 2, yoyo: true});

    var scene3 = new ScrollMagic.Scene({triggerElement: "#trigger1"})
        //.setTween(tween2)
        .setClassToggle("#animateme", "zap")
        .addIndicators({name: "1 - add a class"})
        .addTo(controller);
});
