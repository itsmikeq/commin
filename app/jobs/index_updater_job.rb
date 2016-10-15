class IndexUpdaterJob < ApplicationJob
  queue_as :index_updater

  def perform(klass_record)
    klass_record.__elasticsearch__.update_document
  end
end
