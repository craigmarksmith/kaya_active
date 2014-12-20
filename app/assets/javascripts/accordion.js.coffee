$(document).ready ->
  $(".panel-collapse").on "show.bs.collapse", ->
    $(this).parent().find("span.right.glyphicon").removeClass "glyphicon-chevron-right"
    $(this).parent().find("span.right.glyphicon").addClass "glyphicon-chevron-down"
    return

  $(".panel-collapse").on "hide.bs.collapse", ->
    $(this).parent().find("span.right.glyphicon").removeClass "glyphicon-chevron-down"
    $(this).parent().find("span.right.glyphicon").addClass "glyphicon-chevron-right"
    return
