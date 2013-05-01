$ ->
  $('.request').children().bind 'click', (e) ->
    $parent = $(this).parent()
    $.post $parent.data('path'), decision: $(this).data('decision'), ->
      $parent.hide()
