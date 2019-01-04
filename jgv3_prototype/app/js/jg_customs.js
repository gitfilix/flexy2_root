/**
 * Created by FLX on 17.09.2015.
 */

$(document).ready(function(){
    console.log("dom is ready now");
        // Closes the sidebar menu
    $("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
        $(".nav-icon-open").css('display', 'block');
    });

    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
        $(".nav-icon-open").css('display', 'none');
    });


    // swiper
    var mySwiper = new Swiper ('.swiper1' , {
        directioin : 'horizontal',
        loop: true,
        spaceBetween: 150,
        speed: 600,
        effect: 'coverflow',
        // Navigation arrows
        nextButton: '.swiper-button-next1',
        prevButton: '.swiper-button-prev1'


    })

    // swiper
    var mySwiper2 = new Swiper ('.swiper2' , {
        directioin : 'horizontal',
        loop: true,
        spaceBetween: 150,
        speed: 200,
        effect: 'slide',
        // Navigation arrows
        nextButton: '.swiper-button-next2',
        prevButton: '.swiper-button-prev2'

    })


});
// may be needed some day
// Scrolls to the selected menu item on the page
$(function() {
    $('a[href*=#]:not([href=#])').click(function() {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {

            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: target.offset().top
                }, 1000);
                return false;
            }
        }
    });
});