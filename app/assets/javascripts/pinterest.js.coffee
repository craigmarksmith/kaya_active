ready = ->
  $pinit = $('#pinit')
  $('.pinable').mouseover (event) ->
    $(this).height()
    $(this).width()
    top = $(this).offset()['top'] + $(this).height() - 3
    left = $(this).offset()['left'] + $(this).width() - 20
    $pinit.css({top: top, left: left})

    postPath = window.location
    imagePath = $(this).attr('src')

    href = "https://www.pinterest.com/pin/create/button/?url=#{postPath}&media=#{imagePath}"
    $pinit.attr('href', href)
    $pinit.show()

  $('.pinable').mouseout ->
    if (!$pinit.is(":hover"))
      $pinit.hide()


$(document).ready(ready)
$(document).on('page:load', ready)
