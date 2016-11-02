# == Schema Information
#
# Table name: profiles
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  photo_url       :string(255)
#  intro           :text(65535)
#  sex             :string(255)
#  religion        :string(255)
#  political_party :string(255)
#  language        :string(255)
#  nickname        :string(255)
#  visibility      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_e424190865  (user_id => users.id)
#

class Profile < ApplicationRecord
  include Indexable

  belongs_to :user
end
