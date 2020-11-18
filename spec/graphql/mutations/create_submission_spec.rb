# frozen_string_literal: true

RSpec.describe Mutations::CreateSubmission, type: :request do # rubocop:disable Metrics/BlockLength,RSpec/MultipleMemoizedHelpers
  let(:current_user) { Fabricate(:user) }
  let(:club) { Fabricate(:club, users: [current_user]) }
  let(:session) { Fabricate(:session, club: club) }

  let(:title) { 'toto' }
  let(:authors) { %w[Riri Fifi Loulou] }
  let(:google_book_id) { '123AZERTY' }

  let(:result) { json.dig('data', 'createSubmission', 'submission') }

  it 'creates a new session' do
    do_graphql_request
    expect(mutation_errors).to be_empty
    expect(result.dig('book', 'googleBookId')).to eq(google_book_id)
  end

  def query
    <<-GRAPHQL
      mutation createSubmission($input: CreateSubmissionInput!) {
        createSubmission(input: $input) {
          submission {
            id
            book {
              id
              title
              googleBookId
              authors {
                edges {
                  node {
                    id
                    name
                  }
                }
              }
            }
          }
          errors {
            path
            message
            attribute
            error
          }
        }
      }
    GRAPHQL
  end

  def variables
    {
      input: {
        sessionId: session.uuid,
        bookAttributes: {
          title: title,
          googleBookId: google_book_id,
          authors: authors
        }
      }
    }
  end
end
