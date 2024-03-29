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
         "<div class='select2-community-name'>" + name + "</div>" + "<div class='select2-community-type'>" + community.type + "</div>"
      else
        "<div class='select2-community-name'>" + name + "</div>" + "<div class='select2-community-type'>Custom</div>"
    formatSelection: (community) ->
      community.hashtag

  if $('#post_community_ids').data("communities")
    $.ajax
      url: "/communities/remember.json?query=" + $('#post_community_ids').data("communities")
      dataType: 'jsonp'
      success: (response) ->
        if response.length
          $('#post_community_ids').select2('data', response)