module Indexable
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model
    after_save ->(klass) { IndexerJob.perform_later(klass) }
    after_update ->(klass) { IndexUpdaterJob.perform_later(klass) }
    after_destroy ->(klass) { UnIndexerJob.perform_later(klass) }
  end

end