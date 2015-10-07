require 'calabash-android/abase'

class HomePage < Calabash::ABase

  def trait
    "android.widget.TextView id:'uk.sky.atlas:id/toolbar_title'
  end

  def print_something
    puts "printing something from native app"
  end

end