$(document).ready(function () {

    var owl = $("#owl-example");

    owl.owlCarousel({
        navigation: true,
        autoPlay: true,
        singleItem: true,
        slideSpeed: 10000,
        paginationSpeed: 1000,
        pagination: false,
        transitionStyle: "fade"
    });

    $(".owl-prev").html("<i class='fa fa-chevron-left' style='font-size:22px'></i>");
    $(".owl-next").html("<i class='fa fa-chevron-right' style='font-size:22px'></i>");

    var owl2 = $("#owl-example2");

    owl2.owlCarousel({
        navigation: true,
        autoPlay: false,
        singleItem: true,
        slideSpeed: 10000,
        paginationSpeed: 1000,
        pagination: false,
        transitionStyle: "fade"

    });

    $(".owl-prev").html("<i class='fa fa-chevron-left' style='font-size:26px'></i>");
    $(".owl-next").html("<i class='fa fa-chevron-right' style='font-size:26px'></i>");

});