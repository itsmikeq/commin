module ElasticsearchFindable
  extend ActiveSupport::Concern
  included do
    def self.find_by(**options)
      matchers = options.collect do |k, v|
        {match: {k => v}}
      end
      search(
        query: {
          bool: {
            must: [matchers]
          }
        },
        sort:  [{
                  created_at: {order: 'desc'}
                }]
      )
    end

  end


end