$ ->
  hashtags = new Bloodhound({
    name: 'hashtags',
    limit: 10,
    remote: "/search/autocomplete?query=%QUERY",
    datumTokenizer: (d) ->
      console.log(d)
      d
    queryTokenizer: Bloodhound.tokenizers.whitespace
  })

  hashtags.initialize()

  $('#search_input').typeahead(
    {
      highlight: true
    },
    {
      name: 'hashtags'
      source: hashtags.ttAdapter()
    }
  )
