# frozen_string_literal: true

class Service < Mutations::Command
  def run # rubocop:disable Metrics/MethodLength
    outcome = nil
    ApplicationRecord.transaction do
      outcome = super
      raise ActiveRecord::Rollback unless outcome.success?
    end
    after if outcome.success? && outcome.result
    outcome
  rescue ActiveRecord::RecordInvalid => e
    add_validation_error(e.record)
    validation_outcome
  rescue ActiveRecord::RecordNotFound => e
    add_error(e.model, :required, e.message)
    validation_outcome
  end

  protected

  def add_validation_error(resource) # rubocop:disable Metrics/MethodLength
    resource.errors.details.each do |attribute, errors|
      errors.each do |error|
        kind = error[:error]
        description = generate_description(resource, attribute, kind)
        add_error(
          attribute,
          kind,
          description
        )
      end
    end
  end

  # Run code outside of ActiveRecord transaction
  # For example, mailer job
  def after; end

  private

  def merge_outcomes(outcomes)
    outcomes.each do |o|
      o.errors&.symbolic&.each do |e1, e2|
        add_error(e1, e2)
      end
    end
    outcomes.map(&:result)
  end

  def generate_description(resource, attribute, kind)
    resource.errors.generate_message(attribute, kind)
  rescue NoMethodError
    nil
  end
end
