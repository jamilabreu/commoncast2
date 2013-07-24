jQuery ->
  $('#user_community_ids').select2
    multiple: true
    ajax:
      url: '/communities/search.json'
      dataType: 'jsonp'
      data: (term) ->
        query: term
      results: (data) ->
        results: data
    formatResult: (community) ->
      name = "<div class='select2-community-name'>" + community.hashtag + "</div>"
      if community.type && community.description
        name += "<div class='select2-community-type'>" + community.type + " - " + community.description + "</div>"
      else if community.type
        name += "<div class='select2-community-type'>" + community.type + "</div>"
      else
        name += "<div class='select2-community-type'>Custom</div>"
    formatSelection: (community) ->
      community.hashtag

  if $('#user_community_ids').data("communities")
    $.ajax
      url: "/communities/remember.json?query=" + $('#user_community_ids').data("communities")
      dataType: 'jsonp'
      success: (response) ->
        if response.length
          $('#user_community_ids').select2('data', response)