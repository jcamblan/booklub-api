# frozen_string_literal: true

class SessionDrawJob < ApplicationJob
  queue_as :default

  def perform(session)
    # Do something later
  end
end
