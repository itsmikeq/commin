class UserMention
  include Elasticsearch::Persistence::Model
  attr_accessor :id

  #
  # Created by (username)
  #
  attribute :username, String, mapping: {fields: {
    username: {type: 'string'},
    raw:      {type: 'string', analyzer: 'keyword'}
  }}
  attribute :message_id, String, mapping: {fields: {
    message_id: {type: 'string'}
  }}

  def self.find_by_username(_username)
    search(
      query: {
        match: {username: "@#{_username}"}
      },
      sort:  [{
                created_at: {order: 'desc'}
              }]
    )
  end

  def initialize(options = {})
    super(options)
    @id = options[:id] || SecureRandom.uuid
  end

  # Has Many messages
  def messages
    Message.all(
      query: {
        bool: {
          should: [{match: {body: "@#{username}"}}]
        }
      },
      sort:  [{
                created_at: {order: 'desc'}
              }]
    )
  end


end