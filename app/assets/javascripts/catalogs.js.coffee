# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".folder").hover (->
    @src = @src.replace("folder-close.png", "folder-open.png")
  ), ->
    @src = @src.replace("folder-open.png", "folder-close.png")

  $("img[rel=tooltip]").tooltip()

