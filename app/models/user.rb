# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  name                   :string(255)      default(""), not null
#  username               :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  roles                  :integer          default(0), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  banned                 :boolean          default(FALSE)
#  private                :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_banned                (banned)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_private               (private)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

# TODO: Send all users to ES
class User < ApplicationRecord
  include Roleable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :identities
  # Users @user is friends with
  has_many :friendships
  has_many :friends, -> { where(banned: false) }, :through => :friendships
  has_many :banned_friends, -> { where(banned: true) }, :through => :friendships, source: :user
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  # users who are friends with @user
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  # topics @user has created
  has_many :topics
  # posts @user has created
  has_many :posts
  after_destroy :remove_messages

  validates_presence_of :username
  validates_uniqueness_of :username

  scope :public_users, -> { where(public: true) }

  # TODO: Abstract into auth hash builder
  def self.create_with_omniauth(info)
    create(name: info['name'])
  end

  def remove_messages
    messages.map(&:destroy)
  end

  # Has Many relationship for messages
  def messages
    Message.all(
      query:        {
        match: {created_by: username}
      },
      sort:         [{
                       created_at: {order: 'desc'}
                     }],
      aggregations: {tags: {terms: {field: 'tags'}}},
    )
  end

  def mentions

  end

  # TODO: move to ES search, this will be really slow
  def all_posts
    @friends_posts ||= begin
      pp = []
      pp.push *Post.public_posts.where(user_id: friends.pluck(:user_id)).pluck(:id)
      pp.push *posts.pluck(:id)
      pp.push *sent_messages.pluck(:id)
      pp.push *received_messages.pluck(:id)
      Post.where(id: pp).order("posts.updated_at desc")
    end
  end

  def received_messages
    Post.where(sent_to_user: self)
  end

  def sent_messages
    posts.where.not(sent_to_user_id: nil)
  end

  def private_posts
    posts.private_posts
  end

  def public_posts
    posts.public_posts
  end

  # TODO: Unstub and allow for image uploads
  def image_url
    "https://dummyimage.com/52x52/000/fff.png"
  end

  def to_param
    username
  end

end
