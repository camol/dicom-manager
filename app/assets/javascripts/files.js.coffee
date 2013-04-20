$ ->
  $(".items-dropdown").click ->
    $(this).parent().next().toggle()
    false
