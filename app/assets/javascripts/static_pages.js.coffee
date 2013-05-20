# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Opens dropdowns on mouseover event
$ ->
  $("li.dropdown").mouseover(->
    $(this).toggleClass "open"
  ).mouseout ->
    $(this).toggleClass "open"

# Disables the default bootstrap behaviour for dropdown
  $("a.dropdown-toggle").click (event) ->
    event.preventDefault()
    false

$(window).scroll ->
  if $(window).scrollTop() + $(window).height() is getDocHeight()
    $('.footer').fadeOut('fast')
  else
    $('.footer').fadeIn('fast')


getDocHeight = ->
  D = document
  Math.max Math.max(D.body.scrollHeight, D.documentElement.scrollHeight), Math.max(D.body.offsetHeight, D.documentElement.offsetHeight), Math.max(D.body.clientHeight, D.documentElement.clientHeight)
