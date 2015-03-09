remove_status_photo = ()->
  $("#remove_status_photo").on "click", ->
    $('.status-photo > img').toggle()

$(document).on 'ready page:load', remove_status_photo
