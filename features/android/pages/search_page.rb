require 'calabash-android/abase'

class SearchPage < BasePage
  def trait
    "* id:'edtSearch'"
  end

  def search_enter_search search_term
    keyboard_enter_text search_term
    submit_search
  end

  def submit_search
    press_enter_button
  end

  def search_verify_results search_term
    number_titles_to_compare = 5

    feed_results = helper.get_search_results(search_term)
    app_results = get_search_results_with_scroll number_titles_to_compare

    puts "Search Feed:"
    puts feed_results.first(number_titles_to_compare*2)
    puts "App:"
    puts app_results

    helper.array_includes_all?( feed_results, app_results ).should == true

  end

  def get_search_results_with_scroll minimum_number_of_results_to_collect
    results = search_get_visibile_results
    while results.length < minimum_number_of_results_to_collect
      perform_action('drag',50,50,50,20,8)
      results = results | search_get_visibile_results
    end
    results.first(minimum_number_of_results_to_collect) # In case we collect more results than requested
  end

  def search_get_visibile_results
    wait_for_elements_exist( "* id:'txt_title'", :timeout => 60)
    query("* id:'txt_title'", :text)
  end

  def action_bar_navigate_up
    touch("android.widget.ImageButton contentDescription:'Navigate up'")
    wait_for_elements_exist( "* marked:'Home'", :timeout => 10)

    home_page = page(HomePage)

    if home_page.current_page?
      home_page.await
    else
      self
    end
  end

end