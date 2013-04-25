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

    setFilesConfirmation()

  $('#files-all').live 'change', (e) ->
    if $(this).attr('checked')
      $('.file-checkbox').attr('checked', 'checked')
    else
      $('input.file-checkbox').removeAttr('checked')

    setFilesConfirmation()

  $('form#manage-files-form').live 'submit', (e) ->
    files_ids = []
    $('.file-checkbox').filter(':checked').each ->
      files_ids.push($(this).val())

    if files_ids.length == 0
      alert 'No files selected'
      return false
    else
      $('input[id=dicom_files_files]').val(files_ids)


  $('.file-checkbox').change ->
    setFilesConfirmation()

  $('a#move-files-btn').bind 'click', (e) ->
    if !$(this).hasClass('active') && $('.file-checkbox').filter(':checked').length == $('.file-checkbox').length
      $('input#files-all').attr('checked', 'checked')

  setFilesConfirmation = ->
    checked_files = $('.file-checkbox').filter(':checked').length

    if $("#dicom_files_target_catalog option").filter(":selected").last().val() == ''
      $('.move-files').data('confirm', checked_files + ' files to remove. Are you sure?')
    else
      $('.move-files').data('confirm', checked_files + ' files move to ' + $("#dicom_files_target_catalog option").filter(":selected").last().text() + '(Catalog).' + ' Are you sure?')
