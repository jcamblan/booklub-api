# frozen_string_literal: true

namespace :sessions do
  task update_states: :environment do
    Session.where(state: :submission)
           .where('submission_due_date < ?', Time.zone.now)
           .find_each(&:start_draw!)

    Session.where(state: :reading)
           .where('read_due_date < ?', Time.zone.now)
           .find_each(&:conclude!)
  end
end
