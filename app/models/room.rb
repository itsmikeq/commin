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

  def initialize(options = {})
    @id = self.id || SecureRandom.uuid
    super(options)
  end

  def messages
    Message.search_by(room: name)
  end
end