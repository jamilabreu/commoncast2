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

  # $('.learn-more a').on 'click', (e) ->
  #   e.preventDefault()
  #   $('.learn-more a i').toggleClass('icon-caret-right icon-caret-down')
  #   $('.learn-more-hidden').toggle()