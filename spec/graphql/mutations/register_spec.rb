# frozen_string_literal: true

RSpec.describe Mutations::Register, type: :request do
  let(:username) { Faker::Movies::PrincessBride.character }
  let(:password) { Faker::Internet.unique.password }
  let(:result) { response_body.dig('data', 'register', 'user') }

  context 'when payload is fully correct' do
    let(:email) { Faker::Internet.unique.email }

    it 'creates a new user' do
      post '/graphql', params: { query: query, variables: variables }

      expect(mutation_errors).to be_empty
      expect(User.last.attributes.slice('email', 'username'))
        .to eq(result.slice(:email, :username))
    end
  end

  context 'when payload is wrong' do
    let(:email) { 'toto is not a valid email' }

    it 'returns a validation error' do # rubocop:disable RSpec/ExampleLength
      post '/graphql', params: { query: query, variables: variables }

      expect(result).to be nil
      expect(mutation_errors.first[:attribute]).to eq('email')
      expect(mutation_errors.first[:error]).to eq('invalid')

      # following method is a simple helper defined in spec/support/graphql_helper.rb
      expect_string_locale_equality(
        mutation_errors.first[:message],
        'activerecord.errors.models.user.attributes.email.invalid'
      )
    end
  end

  def query
    <<~GRAPHQL
      mutation register(
        $email: String!
        $password: String!
        $username: String!
      ) {
        register(input: {
          email: $email
          password: $password
          username: $username
        }) {
            user {
              id
              email
              username
            }
          errors {
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
      username: username,
      email: email,
      password: password
    }
  end
end
