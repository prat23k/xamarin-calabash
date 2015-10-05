require 'calabash-android/abase'

class HomePage < Calabash::ABase

  def trait
    "android.widget.TextView text:'Atlas3'"
  end

  def print_something
    puts "printing something from native app"
  end

end