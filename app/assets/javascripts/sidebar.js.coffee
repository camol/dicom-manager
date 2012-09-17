$ ->
  $("a.side-link").click ->
    $("a.side-link i").toggleClass "icon-chevron-right icon-chevron-left"
    $("#arrow").toggleClass "side-off side-on", 170
    $("#sidebar-menu").animate
      width: "toggle"
    , 150
    $("div.sidebar").toggleClass "show"
