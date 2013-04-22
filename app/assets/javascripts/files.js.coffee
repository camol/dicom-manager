$ ->
  $(".items-dropdown").click ->
    $(this).parent().parent().next().toggle()
    false

  $("#dicom_files_target_catalog").live 'change', (e) ->
    $move = $(".move-files")

    if $(this).val() == ''
      $move.val('Delete')
      $move.removeClass('btn-primary').addClass('btn-danger')
    else
      $move.val('Move')
      $move.addClass('btn-primary').removeClass('btn-danger')
