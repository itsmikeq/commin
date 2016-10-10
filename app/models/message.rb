class Message
  include Elasticsearch::Persistence::Model
  include Visibility
  attr_accessor :id

  #
  # Message body
  #
  attribute :body, String, mapping: {fields: {
    sent_to: {type: 'string'},
    raw:     {type: 'string', analyzer: 'keyword'}
  }}

  #
  # This is an optional room tag that will allow messages to be funneled
  # to specific users
  # Room
  #
  attribute :room, String, mapping: {fields: {
    room: {type: 'string'},
    raw:  {type: 'string', analyzer: 'keyword'}
  }}

  #
  # Message tags/hashtags
  #
  attribute :tags, Array, mapping: {fields: {
    tags: {type: 'string'},
    raw:  {type: 'string', analyzer: 'keyword'}
  }}

  #
  # Created by (username)
  #
  attribute :created_by, String, mapping: {fields: {
    created_by: {type: 'string'},
    raw:        {type: 'string', analyzer: 'keyword'}
  }}

  #
  # Optional sent-to if the message is tagged to a user
  # TODO: Work out how to communicate directly to a user
  #
  attribute :sent_to, String, mapping: {fields: {
    sent_to: {type: 'string'},
    raw:     {type: 'string', analyzer: 'keyword'}
  }}

  #
  # permission
  attribute :visibility, Integer, default: 0, mapping: {type: 'integer'}
  #
  # Define a `views` attribute, with default value
  attribute :views, Integer, default: 0, mapping: {type: 'integer'}
  #
  # Define a `likes` attribute, with default value
  # Will be used to increment a like counter
  attribute :likes, Integer, default: 0, mapping: {type: 'integer'}
  #
  # TODO: Need to add reactions, which will be a counter by reaction type
  # Will be a has_many relationship

  # Validations
  validates :body, presence: true
  validates :created_by, presence: true

  before_save do
    create_tags
  end

  # TODO: Create hashtags and user mentions
  # TODO: Create notifications per watches on hashtags and user mentions
  after_save do
    puts "TODO: Create mentions, hashtags, and notifications"
    create_user_mentions
  end

  #
  # END SETUP
  #

  def self.find_by_tag(tags = [])
    tags = tags.kind_of?(Array) ? tags : [tags]
    search(
      query:        {match: {tags: tags.join(' ')}},
      sort:         [{
                       created_at: {order: 'desc'}
                     }],
      aggregations: {tags: {terms: {field: 'tags'}}},
    )
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

  def initialize(options = {})
    super(options)
    @id = options[:id] || SecureRandom.uuid
  end

  def like
    # #increment does not work
    self.likes += 1
    save
  end

  def unlike
    return true unless likes > 0
    self.likes -= 1
    save
  end

  def view
    self.views += 1
    save
  end

  def mentions
    UserMention.search(query: {match: {mentions: mention_usernames}})
  end

  private if Rails.env.production?

  def mention_usernames
    body.scan(/(^|\s)@([a-z\d.-]+)/).map(&:last)
  end

  def create_user_mentions
    body.scan(/(^|\s)@([a-z\d.-]+)/).map(&:last).each do |word|
      UserMention.create(message_id: id, username: word)
    end

  end

  def create_tags
    body.scan(/(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/).each do |words|
      words.each do |word|
        tags.push(word.strip)
      end
    end
  end

end