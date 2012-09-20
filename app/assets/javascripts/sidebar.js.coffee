jQuery.fn.exists = ->
  jQuery(this).length > 0

$ ->
  $("a.side-link").click ->
    $("a.side-link i").toggleClass "icon-chevron-right icon-chevron-left"
    $("#arrow").toggleClass "side-off side-on", 400
    $("#sidebar-menu").animate
      width: "toggle"
    , 100
    $("div.sidebar").toggleClass "show"

  $("#new_cat_btn").popover(
    html: true
    trigger: 'manual'
    content: ->
      $("#cat_form").html()
  ).click((e) ->
    e.preventDefault()
    e.stopPropagation()
    if $("div.popover-inner").exists()
      $(this).popover "hide" 
    else
      $(this).popover "show"
  )

  ###
  $("html").click (e) ->
    if $("div.popover-inner").exists()
      alert "popover exists"
      if $(e.target).not("div")
        alert $(e.target).html()
      else
        $("#new_cat_btn").popover "hide"
        alert "hide"
  ###
