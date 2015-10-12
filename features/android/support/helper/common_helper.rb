module Helpers

  def array_includes_all?( array, comparision_array )
    contains = true
    for i in comparision_array do
      unless array.include? i
        contains = false
      end
    end
    return contains
  end

end