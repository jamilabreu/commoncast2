#= require jquery
#= require jquery_ujs

jQuery ->

  $(".post-actions ul li a i.icon-unchecked").parent("a").hover(
    ->
      $(this).children("i").toggleClass('icon-unchecked icon-check')
  )