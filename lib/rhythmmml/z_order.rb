module Rhythmmml
  module ZOrder
    [
      :BACK,
      :FIGURE,
      :OBJECT,
      :TEXT,
    ].each_with_index do |type, i|
      const_set(type, i)
    end
  end
end
