$ ->
  $("a.side-link").click ->
    $("a.side-link i").toggleClass "icon-chevron-right icon-chevron-left"
    $("#arrow").toggleClass "side-off side-on", 400
    $("#sidebar-menu").animate
      width: "toggle"
    , 100
    $("div.sidebar").toggleClass "show"

  $("#edit").popover(trigger: 'click')
