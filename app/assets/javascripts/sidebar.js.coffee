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
    $("div.sidebar-title").animate
      left: "toggle"
    , 100
    $("div.sidebar-title").toggleClass "hide" 


    if $('.btn-popover').exists()
      $('.btn-popover').each (index, element) =>

        $(element).popover
          trigger: 'manual'
          content: => $($(element).data('popover_content_selector')).html()

        $(element).bind 'click', (e) =>
          e.preventDefault()
          e.stopPropagation()

          $btn = $(e.target)
          
          if $('.switched-on').exists()
            $('.switched-on').each (index, element) =>
              if !$btn.is($(element))
                $(element).popover('toggle')
                $(element).toggleClass "switched-on"
                $(element).toggleClass "active"

          $btn.popover('toggle')
          $btn.toggleClass "switched-on"
          $btn.toggleClass "active"
          
          true

    $('#myModal').modal

    ###
  $('#btnModal').bind 'click', =>
    $('#myModal').toggleClass 'hide'  
    true
    ###
