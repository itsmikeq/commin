class IndexerJob < ApplicationJob
  queue_as :indexer

  def perform(klass_record)
    klass_record.__elasticsearch__.index_document
  end
end
