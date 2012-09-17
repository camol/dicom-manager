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
