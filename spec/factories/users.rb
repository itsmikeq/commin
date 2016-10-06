# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  username                       :string(255)      not null
#  display_title                  :string(255)
#  name                           :string(255)
#  sex                            :string(1)
#  birthday                       :date
#  location                       :string(255)
#  about                          :text(65535)
#  occupation                     :string(255)
#  twitter_handle                 :string(255)
#  gamertag_xbox                  :string(255)
#  gamertag_psn                   :string(255)
#  gamertag_steam                 :string(255)
#  profile_picture_id             :integer
#  timezone                       :string(255)
#  stripe_customer_id             :string(255)
#  notify_forum                   :boolean
#  notify_friend_requests         :boolean
#  notify_image_comments          :boolean
#  notify_personal_comments       :boolean
#  notify_tagged_photos           :boolean
#  notify_messages                :boolean
#  notify_journal_comments        :boolean
#  hide_birthday                  :boolean
#  hide_personal_comments         :boolean
#  allow_direct_messages          :boolean
#  allow_group_invites            :boolean
#  allow_profile_comments         :boolean
#  allow_friend_requests          :boolean
#  global_request_token           :string(255)
#  global_session_key             :string(255)
#  global_login_token             :string(255)
#  global_enc_iv                  :string(255)
#  remember_token                 :string(255)
#  username_updated_at            :datetime
#  sponsorship_starts_at          :datetime
#  sponsorship_ends_at            :datetime
#  deleted_at                     :datetime
#  store_region                   :string(255)
#  used_trial                     :boolean
#  deleted_by                     :integer
#  sponsor_type                   :string(255)
#  itunes_original_transaction_id :integer
#  email                          :string(255)      default(""), not null
#  encrypted_password             :string(255)      default(""), not null
#  reset_password_token           :string(255)
#  reset_password_sent_at         :datetime
#  remember_created_at            :datetime
#  sign_in_count                  :integer          default("0"), not null
#  current_sign_in_at             :datetime
#  last_sign_in_at                :datetime
#  ipaddress                      :string(255)
#  confirmation_token             :string(255)
#  confirmed_at                   :datetime
#  confirmation_sent_at           :datetime
#  unconfirmed_email              :string(255)
#  failed_attempts                :integer          default("0"), not null
#  unlock_token                   :string(255)
#  locked_at                      :datetime
#  roles                          :integer          default("0")
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token     (confirmation_token) UNIQUE
#  index_users_on_deleted_at             (deleted_at)
#  index_users_on_email                  (email)
#  index_users_on_gamertag_psn           (gamertag_psn)
#  index_users_on_gamertag_steam         (gamertag_steam)
#  index_users_on_gamertag_xbox          (gamertag_xbox)
#  index_users_on_global_enc_iv          (global_enc_iv)
#  index_users_on_global_login_token     (global_login_token)
#  index_users_on_global_request_token   (global_request_token)
#  index_users_on_global_session_key     (global_session_key)
#  index_users_on_id_and_deleted_at      (id,deleted_at) UNIQUE
#  index_users_on_remember_token         (remember_token)
#  index_users_on_reset_password_token   (reset_password_token) UNIQUE
#  index_users_on_sponsorship_ends_at    (sponsorship_ends_at)
#  index_users_on_sponsorship_starts_at  (sponsorship_starts_at)
#  index_users_on_twitter_handle         (twitter_handle)
#  index_users_on_unlock_token           (unlock_token) UNIQUE
#

FactoryGirl.define do
  factory :user do
    username FFaker::Internet.user_name
    name FFaker::Internet.name
    email FFaker::Internet.email
    password 'password'
    password_confirmation 'password'

    trait :the_hand do
      username "THE_HAND"
      name "THE HAND"
      global_request_token "my-token"
      email "the_hand@rtaustin.com"
    end

    trait :with_comments do
      after(:create) do |user|
        user.comments << create(:comment)
      end
    end
    trait :with_comments_on_posts do
      after(:create) do |user|
        user.comments << create(:comment, :post)
      end
    end
  end
end
