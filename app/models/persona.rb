# == Schema Information
#
# Table name: personas
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  screen_name :string(255)
#  group_id    :integer
#  default     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_personas_on_group_id  (group_id)
#  index_personas_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_d7c27ad90e  (group_id => groups.id)
#  fk_rails_ff69b46a04  (user_id => users.id)
#

class Persona < ApplicationRecord
  include Indexable
  belongs_to :user
  belongs_to :group
  validates_presence_of :user

  before_commit do |persona|
    persona.default = true unless user.default_persona
  end
  after_commit on: [:create] do
    __elasticsearch__.index_document
  end

  after_commit on: [:update] do
    __elasticsearch__.update_document
  end

  after_commit on: [:destroy] do
    __elasticsearch__.delete_document
  end

end
