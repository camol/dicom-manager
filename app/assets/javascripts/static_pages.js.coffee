# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  autodrop = (drop_type) ->  
    $dropdowns = $(drop_type)
    $dropdowns.on("mouseover", ->
      $this = $(this)
      $this.prop "hoverTimeout", clearTimeout($this.prop("hoverTimeout"))  if $this.prop("hoverTimeout")
      $this.prop "hoverIntent", setTimeout(->
        $this.addClass "hover"
        , 250)
    ).on "mouseleave", ->
      $this = $(this)
      $this.prop "hoverIntent", clearTimeout($this.prop("hoverIntent"))  if $this.prop("hoverIntent")
      $this.prop "hoverTimeout", setTimeout(->
        $this.removeClass "hover"
        , 250)


        #autodrop("ul.dropdown")

