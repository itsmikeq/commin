class Search
  def self.search(q, option={}, limit=100, offset=0)
    client = Elasticsearch::Client.new hosts: Settings.elasticsearch.urls, adapter: :net_http
    res        = client.search q, [Post]
    OpenStruct.new(total: res.count, data: res, total: res.response.hits.total)
  end

  def self.autocomplete(q, limit=100)
    limit  = limit || 100
    client = Elasticsearch::Model.client

    body = {
      auto_complete: {
        text:       q,
        completion: {
          field: 'auto_complete',
          size:  limit,
        }
      }
    }

    res   = client.suggest index: [Post.__elasticsearch__.index_name], body: body
    terms = []

    if res.present? and res['auto_complete'].present?
      res   = res['auto_complete'].first
      terms = res['options'].map do |option|
        option['text']
      end
    end

    terms
  end
end
