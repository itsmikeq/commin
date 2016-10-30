class EsUniquenessValidator < ActiveModel::Validator
  include ElasticsearchHelpers
  class RecordNotUnique < StandardError

  end
  def validate(record)
    klass = record.class.name.constantize
    if klass.search_by(name: sanitize_string(record.name)).any?
      raise RecordNotUnique.new("name has already been used")
    end

  end
end