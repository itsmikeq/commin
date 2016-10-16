module ElasticsearchSearchable
  extend ActiveSupport::Concern
  included do

    def self.search_by(**options)
      tmp_matchers = {}
      full_query   = {}
      result_size  = options.delete(:result_size)
      aggregations = options.delete(:aggregations)
      matchers     = options.collect do |k, v|
        tmp_matchers.merge!({match: {k => v}})
      end
      query        = {
        bool: {
          must: [matchers]
        }
      }
      if aggregations
        full_query.merge!({aggregations: aggregations})
      end
      full_query.merge!({query: query})
      full_query.merge!({size: result_size || 50})

      search(
        full_query
      )
    end

  end


end