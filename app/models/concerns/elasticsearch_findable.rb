module ElasticsearchFindable
  extend ActiveSupport::Concern
  included do
    # find_or_create_by(name: 'myroom', created_by: "a_user")
    def self.find_or_create_by(options = {})
      options = HashWithIndifferentAccess.new(options)
      matchers = options.collect do |k, v|
        {match: {k => v}}
      end
      _room = search(query: {
        bool: {
          must: [matchers]
        }
      }).first
      if _room
        return _room
      else
        room = create(name: options[:name], created_by: options[:created_by])
        if room.errors.any?
          raise ArgumentError.new(room.errors.messages.to_s)
        end
      end
    end

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