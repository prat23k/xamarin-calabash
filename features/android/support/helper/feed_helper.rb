module Helpers

  FEED_MENU_URL = "http://content.ott.sky.com/v3/brands/go/devices/pc?represent=(navigation/node)"
  FEED_HOME_CONTENT_URL = "http://content.ott.sky.com/v3/brands/go/devices/pc/navigation/nodes/fdac73efb76a7410VgnVCM1000000b43150a____/pages/ede0db1f9d9e7410VgnVCM1000000b43150a____?represent=(item-group/item-group(item/item-summary))"
  FEED_CATCHUP_CONTENT_URL = "http://content.ott.sky.com/v3/brands/go/devices/pc/navigation/nodes/f7a417234b5a7410VgnVCM1000000b43150a____?represent=(child/page(item-group/item-group(item/item-summary)))"
  FEED_COMEDYCENTRAL_URL = "http://content.ott.sky.com/v3/brands/go/devices/pc/navigation/nodes/0419345e2c5a7410VgnVCM1000000b43150a____?represent=(child/page(item-group/item-group(item/item-summary)))"

  SEARCH_URL = "http://api.search.sky.com/query.json?category=sky-go-web&term={}&page=1&items=50&summaryLength=140&group=true&sid=true&uid=14433909945820.qgsc7q1uu3anhfr&editoriallayer=true"

  def get_menu_titles_from_feed
    content = JSON.parse(open(FEED_MENU_URL).read)
    menu_links = content['_links'][1]['node']['_links']
    menu_items = menu_links.select { |item| item['_rel'] == 'child/node' }
    menu_items.map { |item| item['_title']}
  end

  def get_home_content_from_feed
    content = JSON.parse(open(FEED_HOME_CONTENT_URL).read)
    movie_group = content['_links'][2]['itemGroup']['_links']
    movies_to_display = movie_group.select { |item| item['_rel'] == 'item/item-summary' }
    menu_titles = movies_to_display.map { |item| item['itemSummary']['title']}
  end

  def get_menu_selection_content_from_feed selection

    case selection
      when "Catch Up"
        url = FEED_CATCHUP_CONTENT_URL
      when "COMEDY CENTRAL"
        url = FEED_COMEDYCENTRAL_URL
    end

    content = JSON.parse(open(url).read)
    movie_group = content['_links'][2]['page']['_links'][2]['itemGroup']['_links']
    movies_to_display = movie_group.select { |item| item['_rel'] == 'item/item-summary' }
    menu_titles = movies_to_display.map { |item| item['itemSummary']['title']}
  end

  def get_search_results search_term
    search_url = SEARCH_URL.gsub(/{}/, search_term)
    api_search_results = JSON.parse(open(search_url).read)
    api_search_results['searchResults'].map { |result| result['title'] }
  end

end