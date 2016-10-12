class Room
  include Elasticsearch::Persistence::Model
  include ElasticsearchFindable
  include Visibility

  # Room name
  attribute :name, String, mapping: {fields: {
    name: {type: 'string'}
  }}

  # User who created the room
  attribute :created_by, String, mapping: {fields: {
    created_by: {type: 'string'}
  }}

  #
  # permission
  attribute :visibility, Integer, default: 0, mapping: {type: 'integer'}

  validates_presence_of :name
  validates_presence_of :created_by

  # find_or_create_by(name: 'myroom', created_by: "a_user")
  def self.find_or_create_by(args = {})
    args = HashWithIndifferentAccess.new(args)
    _room = search(query: {
      match: {
        name: args[:name]
      }
    }).first
    if _room
      return _room
    else
      create(name: args[:name], created_by: args[:created_by])
    end
  end

  def initialize(options = {})
    @id = self.id || SecureRandom.uuid
    super(options)
  end

  def messages
    Message.find_by(room: name)
  end
end