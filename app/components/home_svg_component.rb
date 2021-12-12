# frozen_string_literal: true

class HomeSvgComponent < ViewComponent::Base
  def initialize(color1: '#6C63FF', color2: '#E6E6E6')
    @color1 = color1
    @color2 = color2
  end
end
