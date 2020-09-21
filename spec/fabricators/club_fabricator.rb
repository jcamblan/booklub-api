# frozen_string_literal: true

# == Schema Information
#
# Table name: clubs
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  manager_id :uuid
#
# Indexes
#
#  index_clubs_on_name  (name)
#
# Foreign Keys
#
#  fk_rails_...  (manager_id => users.id)
#
Fabricator(:club) do
  name { Faker::Company.name }
  manager { Fabricate(:user) }
end
