# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permission :integer
#  owned_by   :string(255)
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# owned by is a string because groups can be owned by groups
class Group < ApplicationRecord
  include Indexable

  has_many :personas
  has_many :users, through: :personas

  # TODO: something with permissions
  def owner
    GlobalID::Locator.locate owned_by
  end
end
