# frozen_string_literal: true

class Types::Connections::BaseConnection < GraphQL::Types::Relay::BaseConnection
  field :total_count, Integer, null: false, description: "Connection's nodes count"

  def total_count
    return @total_count if @total_count.present?

    skipped = object.items.offset_value || 0
    @total_count = object.items.size + skipped
  end

  field :total_pages, Integer, null: false,
                               description: "Connection's pages count, depends of arguments passeds"

  def total_pages
    page_size = object.first if object.respond_to?(:first)
    page_size ||= object.max_page_size
    (total_count / page_size.to_f).ceil
  end

  field :current_page, Integer, null: false, description: 'Current page number'

  def current_page
    page_size = object.first if object.respond_to?(:first)
    page_size ||= object.max_page_size
    skipped = object.items.offset_value || 0
    (skipped / page_size) + 1
  end

  field :next_id, ID,
        null: true,
        description: 'Allow you to find the ID following the given ID' do
    argument :id, ID, required: true
  end

  def next_id(id:)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    item_index = ordered_sql_ids.index(item_id.to_i)
    next_sql_id = ordered_sql_ids[item_index + 1]
    return nil unless next_sql_id

    GraphQL::Schema::UniqueWithinType.encode(
      type_name,
      next_sql_id
    )
  end

  field :previous_id, ID,
        null: true,
        description: 'Allow you to find the ID preceding the given ID' do
    argument :id, ID, required: true
  end

  def previous_id(id:)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    item_index = ordered_sql_ids.index(item_id.to_i)
    return nil if item_index.zero?

    GraphQL::Schema::UniqueWithinType.encode(
      type_name,
      ordered_sql_ids[item_index - 1]
    )
  end

  field :position, Int, null: true do
    argument :id, ID, required: true
  end

  def position(id:)
    _type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    item_index = ordered_sql_ids.index(item_id.to_i)
    return nil unless item_index

    item_index + 1
  end

  private

  def ordered_sql_ids
    @ordered_sql_ids ||= object.items.pluck(:id)
  end
end
