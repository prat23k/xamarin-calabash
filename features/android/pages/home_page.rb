require 'calabash-android/abase'

class HomePage < Calabash::ABase

  def trait
    "* id:'toolbar_title' text:'Home'"
  end

  def print_something
    puts "printing something from native app"
  end

  def go_to_menu_page page
    open_menu
    open_menu_page page
  end

  def open_menu
    touch("android.widget.ImageButton contentDescription:'Navigate up'")
    wait_for_elements_exist( "* id:'menu_logo'", :timeout => 10)
  end

  def open_menu_page page

    if !page.eql?("Home")
      tap_when_element_exists("* id:'txt_title' text:'#{page}'")
    end

    wait_for(:timeout => 60) { element_exists("* id:'toolbar_title' text:'#{page}'")}

    menu_item_page = page(MenuItemPage)

    if menu_item_page.current_page?
      menu_item_page.await
    else
      self
    end

  end

  def assert_nowtv_logo
    check_element_exists("* id:'menu_logo'")
  end

  def get_menu_titles
    query("* id:'txt_title'", :text)
  end

  def compare_menu_content_with_feed
    feed_menu_titles = helper.get_menu_titles_from_feed
    app_menu_titles =  get_menu_titles

    puts "Feed:"
    puts feed_menu_titles
    puts "App:"
    puts app_menu_titles

    feed_menu_titles.eql?(app_menu_titles).should == true
  end

  def go_to_search

    touch("* id:'action_search'")

    wait_for_element_does_not_exist("* id:'toolbar_title' text:'Home'", :timeout => 5)

    search_page = page(SearchPage)

    if search_page.current_page?
      search_page.await
    else
      self
    end

  end


  def search_for search_term
    go_to_search
  end

  def action_bar_check_home
    check_element_exists(trait)
  end

end