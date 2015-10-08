require 'calabash-android/abase'

class MenuItemPage < Calabash::ABase
  include CommonPageActions

  def trait
    "* id:'toolbar_title'"
  end

  def wait_for_packshot_to_load
    wait_for_element_exists("* id:'img_packshot'")
  end

  def get_all_packshot_titles
    query("* id:'text'", :text)
  end

  def compare_page_with_feed page
    number_titles_to_compare = 2

    case page
      when "Home"
        feed_titles = helper.get_home_content_from_feed
      else
        feed_titles = helper.get_menu_selection_content_from_feed page
    end

    feed_titles = feed_titles.first(number_titles_to_compare)
    app_titles = get_all_packshot_titles.first(number_titles_to_compare)

    puts "Movie Feed:"
    puts feed_titles
    puts "App:"
    puts app_titles

    feed_titles.eql?(app_titles).should == true
  end

  def go_to_submenu nav_item
    nav_item = nav_item.split(/(\W)/).map(&:capitalize).join
    scroll_to_submenu(nav_item)
    touch("* marked:'#{nav_item}'")
    sleep(2)
    self.await(timeout:60)
  end

  def scroll_to_submenu (nav_item)
    wait_for_element_exists("* id:'toolbar_title' text:'Catch Up'")
    wait_poll(:until_exists => "* marked:'#{nav_item}'", :timeout => 120) do
      pan("android.support.design.widget.TabLayout$TabView", :right, from: {x: 50, y: 180}, to: {x: 100000, y:180})
    end
  end
end


