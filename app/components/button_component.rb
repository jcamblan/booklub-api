# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(variant: 1)
    @variant = variant
  end
end
