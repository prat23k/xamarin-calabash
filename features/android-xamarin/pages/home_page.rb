require 'calabash-android/abase'

class HomePage < Calabash::ABase

  def trait
    "android.widget.TextView text:'HomePageActivity'"
  end

  def print_something
    puts "printing something from xamarin app"
  end

end