document.addEventListener("turbolinks:load", () => {
  $('.product-slider').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: false,
    autoplaySpeed: 2000,
    centerMode: true,
    centerPadding: '10%'
  });
})