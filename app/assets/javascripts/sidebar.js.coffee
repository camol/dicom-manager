jQuery.fn.exists = ->
  jQuery(this).length > 0
  ###
popover_form = 
  if $('.btn-popover').exists()
    alert 'po ifie'
    $('.btn-popover').bind 'click', (e) =>
      form_to_display = $($(e.target).data('popover_content_selector'))

    $(".btn-popover").popover(
        html: true
        trigger: 'manual'
        content: ->
          form_to_display
      ).click((e) ->
        e.preventDefault()
        e.stopPropagation()
        if $("div.popover-inner").exists()
          $(this).popover "hide" 
        else
          $(this).popover "show"
      )
      ###
$ ->
  $("a.side-link").click ->
    $("a.side-link i").toggleClass "icon-chevron-right icon-chevron-left"
    $("#arrow").toggleClass "side-off side-on", 400
    $("#sidebar-menu").animate
      width: "toggle"
    , 100
    $("div.sidebar").toggleClass "show"
  
  if $('.btn-popover').exists()
    form_to_display = $('.btn-popover').bind 'click', (e) ->
      $($(e.target).data('popover_content_selector'))

      $(".btn-popover").popover(
          html: true
          trigger: 'manual'
          content: ->
            form_to_display.html()
        ).click((e) ->
          e.preventDefault()
          e.stopPropagation()
          if $("div.popover-inner").exists()
            $(this).popover "hide" 
          else
            $(this).popover "show"
        )

