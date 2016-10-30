class UserImage
  include Elasticsearch::Persistence::Model
  include ElasticsearchSearchable

  attribute :url, String, mapping: {fields: {
    url: {type: 'string'},
    raw: {type: 'string', analyzer: 'keyword'}
  }}
  attribute :user_id, Integer, mapping: {fields: {
    username: {type: 'integer'}
  }}
  attribute :size, String, mapping: {fields: {
    size: {type: 'string'}
  }}

  # This should be limited to "needed" stuff
  attribute :purpose, String, mapping: {fields: {
    purpose: {type: 'string'}
  }}

  validates_inclusion_of :purpose, in: %w(profile), message: "purpose %{value} is not included in the list"

  # belongs_to :user equivalent
  def user
    User.find_by(id: user_id)
  end

end
