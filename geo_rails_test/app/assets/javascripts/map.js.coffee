# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ -> 
    $.ajax({
        type: "GET",
        url: "/zcta/getPolygon",
        data: {zip: 91030},
        success:(data) -> 
            json_geo = JSON.stringify(data['91030'].polygon)
            console.log(json_geo)
            $('input#geo').val(json_geo)
            return false
        error:(data) ->
            return false
    })
