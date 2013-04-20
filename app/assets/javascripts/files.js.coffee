$ ->
  $(".items-dropdown").click ->
    $(this).parent().parent().next().toggle()
    false
