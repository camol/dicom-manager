# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".folder").hover (->
    @src = @src.replace("folder-close.png", "folder-open.png")
  ), ->
    @src = @src.replace("folder-open.png", "folder-close.png")

  $("img[rel=tooltip]").tooltip()

  $(".catalog").draggable(
    containment: '#dir-cont'
    opacity: 0.60
    revert: true
    revertDuration: 200
  )

  $(".catalog").droppable(
    drop: (ev, ui)->
      $("#catalog_target_catalog").attr('value', $(this).data('catalog-id'))
      $("#catalog_moved_catalog").attr('value', $(ui.draggable).data('catalog-id'))
      $('form#move-form').submit()
  )

  $(".move-up").click(->
    $('form#move-form').submit()
  )

  $(".select-target-resource").change(->
    alert "changed"
  )

