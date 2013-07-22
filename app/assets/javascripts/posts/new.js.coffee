jQuery ->
  $('#post_community_ids').select2
    multiple: true
    ajax:
      url: '/communities/search.json'
      dataType: 'jsonp'
      data: (term) ->
        query: term
      results: (data) ->
        results: data
    formatResult: (community) ->
      name = community.hashtag
      if community.type
        "<div class='select2-community-type'>" + community.type + "</div>" + "<div class='select2-community-name'>" + name + "</div>"
      else
        name
    formatSelection: (community) ->
      community.hashtag