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
      name = community.hashtag
      if community.type
        "<div class='select2-community-name'>" + name + "</div>" + "<div class='select2-community-type'>" + community.type + "</div>"
      else
        "<div class='select2-community-name'>" + name + "</div>" + "<div class='select2-community-type'>Custom</div>"
    formatSelection: (community) ->
      community.hashtag

  $.ajax
    url: "/communities/preload.json"
    dataType: 'jsonp'
    success: (response) ->
      if response.length
        $('#user_community_ids').select2('data', response)