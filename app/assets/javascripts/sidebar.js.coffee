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
      alert modalCustomClass
      alert $($(this).data('modal_content_selector')).html()
      alert $(this).data('modal_content_selector')
      $('.modal-body').html($($(this).data('modal_content_selector')).html())
      #$modal.addClass 'modal-on'
      $modal.animate
        top: 'toggle'
        opacity: 'toggle'
      , fadeTime
      
      
      ###  
      $('html').bind 'click', (e) ->
      alert $(e.target).is('.modal-backdrop')

      if $modal.hasClass 'modal-on'
        alert 'modal jest'
        $('.modal-backdrop').bind 'click', (e)->
          alert 'tlo'
          $modal.animate
            top: 'toggle'
            opacity: 'toggle'
          , fadeTime
          ### 
