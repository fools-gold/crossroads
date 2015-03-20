 $ ->
   $('#search_input').typeahead
     remote: "/search/autocomplete?query=%QUERY"
     hint: $('.form-control')
