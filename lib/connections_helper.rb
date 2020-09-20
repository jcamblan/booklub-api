# frozen_string_literal: true

module ConnectionsHelper
  def connection_with_arguments(res, **args)
    res = res.search(args[:search]) if args[:search]
    order(res, args)
  end

  def order(res, **args)
    order = args[:order] || { by: :id, direction: :desc }
    unless res.model.column_names.include?(order[:by].to_s)
      raise GraphQL::ExecutionError, "OrderBy '#{order[:by]}' cannot be use here"
    end

    # must include table_name on ORDER to prevent PG AmbiguousColumn errors
    res.order("#{res.model.table_name}.#{order[:by]} #{order[:direction]}")
  end

  def apply_filter(res, filters)
    return res unless filters

    filters.keys.each do |filter_key| # rubocop:disable Style/HashEachMethods
      filters[filter_key].keys.each do |arg_key| # rubocop:disable Style/HashEachMethods
        value = sqlize_ids(filters, filter_key, arg_key)

        res = apply_where(res, filter_key, arg_key, value)
      end
    end
    res
  end

  # we receive uuids from queries & mutation, lets convert them into sql ids
  def sqlize_ids(filters, filter_key, arg_key)
    value = filters[filter_key][arg_key]
    return value unless filter_key.match?(/([a-z])_id/) || filter_key == :id

    [filters[filter_key][arg_key]].flatten.map do |id|
      klass = if filter_key == :id
                res.klass.name
              else
                filter_key.to_s.split('_').first.capitalize
              end
      get_id(id, klass)
    end
  end

  # translate GraphQL operators into good old ActiveRecord where
  def apply_where(res, filter_key, arg_key, value)
    case arg_key
    when :eq, :in
      res.where(filter_key => value)
    when :ne, :nin
      res.where.not(filter_key => value)
    when :ilike
      res.where("#{filter_key} ILIKE ?", "%#{value}%")
    else
      res
    end
  end
end
