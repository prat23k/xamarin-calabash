def helper
  @helper ||= Helper.new
end

class Helper
  include Helpers

  def initialize
    super
  end
end