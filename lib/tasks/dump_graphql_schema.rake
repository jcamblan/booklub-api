# frozen_string_literal: true

task dump_graphql_schema: :environment do
  schema_definition = BooklubApiSchema.to_definition
  schema_path = 'app/graphql/schema.graphql'
  File.write(Rails.root.join(schema_path), schema_definition)
  puts "Updated #{schema_path}"
end
