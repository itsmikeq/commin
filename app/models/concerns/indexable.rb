module Indexable
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    # include ElasticsearchSearchable
    __elasticsearch__.client = Elasticsearch::Client.new host: Settings.elasticsearch.urls

    settings index: { number_of_shards: 3 } do
      mappings dynamic: 'true'
    end

    def self.search(query_or_definition, options={})
      options.merge!({size: 100})
      __elasticsearch__.search(query_or_definition, options)
    end

    after_save ->(klass) { IndexerJob.perform_later(klass) }
    after_update ->(klass) { IndexUpdaterJob.perform_later(klass) }
    after_destroy ->(klass) { UnindexerJob.perform_later(klass) }
  end

end
