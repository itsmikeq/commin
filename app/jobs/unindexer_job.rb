class UnindexerJob < ApplicationJob
  queue_as :unindexer

  def perform(klass_record)
    klass_record.__elasticsearch__.delete_document
  end
end
