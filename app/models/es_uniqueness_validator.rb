class EsUniquenessValidator < ActiveModel::Validator
  class RecordNotUnique < StandardError
  end
  include ElasticsearchHelpers
  def validate(record)
    klass = record.class.name.constantize
    if klass.search_by(name: sanitize_string(record.name)).any?
      raise RecordNotUnique.new("name '#{record.name}' has already been used")
    end

  end
end