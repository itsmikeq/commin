class Room
  include Elasticsearch::Persistence::Model
  include ElasticsearchSearchable
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
  # validates :name, presence: true, uniqueness: true
  validates_with EsUniquenessValidator
  validates_presence_of :created_by


  # find_or_create_by(name: 'myroom', created_by: "a_user")
  def self.search_or_create_by(options = {})
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
      room
    end
  end

  def initialize(options = {})
    @id = self.id || SecureRandom.uuid
    super(options)
  end

  def messages(options = {})
    options.merge!(room: name)
    Message.search_by(options)
  end
end