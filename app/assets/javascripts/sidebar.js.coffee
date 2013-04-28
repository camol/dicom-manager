jQuery.fn.exists = ->
  jQuery(this).length > 0

$ ->
  $("a.side-link").click ->
    $("a.side-link i").toggleClass "icon-chevron-right icon-chevron-left"
    if $(this).parent().hasClass('side-on') && $('.switched-on').exists()
      $('.switched-on').popover('toggle')
      $('.switched-on').removeClass 'active'
      $('.switched-on').removeClass 'switched-on'
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
      $('.btn-popover').each (index, element) ->

        $(element).popover
          trigger: 'manual'
          content: => $($(element).data('popover_content_selector')).html()

        $(element).bind 'click', (e) ->
          e.preventDefault()
          e.stopPropagation()

          $btn = $(e.target)

          if $('.switched-on').exists()
            $('.switched-on').each (index, element) ->
              if !$btn.is($(element))
                $(element).popover('toggle')
                $(element).toggleClass "switched-on"
                $(element).toggleClass "active"

          $btn.popover('toggle')
          $btn.toggleClass "switched-on"
          $btn.toggleClass "active"

          true

  if $('.btnModal').exists()
    $('.btnModal').bind 'click', ->
      $modal = $('#myModal')
      fadeTime = 1000
      modalCustomClass = $(this).data('modal_content_selector').substring(1)
      $modal.removeClass(modalCustomClass).addClass(modalCustomClass)
      $('.modal-body').html($($(this).data('modal_content_selector') + ':last').html())
      $modal.animate
        top: 'toggle'
        opacity: 'toggle'
      , fadeTime


