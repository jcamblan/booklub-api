# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :uuid             not null, primary key
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :uuid             not null
#  session_id :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_notes_on_book_id                             (book_id)
#  index_notes_on_book_id_and_session_id_and_user_id  (book_id,session_id,user_id) UNIQUE
#  index_notes_on_session_id                          (session_id)
#  index_notes_on_user_id                             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (session_id => sessions.id)
#  fk_rails_...  (user_id => users.id)
#
Fabricator(:note) do
  session nil
  book    nil
  value   1
  user    nil
end
