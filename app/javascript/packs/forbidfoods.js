$(document).on('turbolinks:load', function(){
  $('#forbid-foods').tagit
    fieldName:   'forbid_list'
    singleField: true
  $('#forbid-foods').tagit()
  forbid_string = $("#forbid_hidden").val()
  try
    forbid_list = forbid_string.split(',')
    for tag in forbid_list
      $('#forbid-foods').tagit 'createTag', tag
  catch error
});