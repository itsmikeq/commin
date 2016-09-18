module Roleable
  extend ActiveSupport::Concern
  included do
    # ROLES
    ROLE_ADMIN                  = 0x1.freeze
    ROLE_CAST_AND_CREW_ADMIN    = 0x2.freeze
    ROLE_GLOBAL_GROUP_ADMIN     = 0x4.freeze
    ROLE_GLOBAL_FORUM_ADMIN     = 0x8.freeze
    ROLE_NEWS_ADMIN             = 0x10.freeze
    ROLE_PODCAST_ADMIN          = 0x20.freeze
    ROLE_PRESS_ADMIN            = 0x40.freeze
    ROLE_SHOWS_ADMIN            = 0x80.freeze
    ROLE_SITE_INFORMATION_ADMIN = 0x100.freeze
    ROLE_STORE_ADMIN            = 0x200.freeze
    ROLE_USER_ADMIN             = 0x400.freeze
    ROLE_USER_SUPER_ADMIN       = 0x800.freeze
    ROLE_BUSINESS_ADMIN         = 0x1000.freeze
    ROLE_COMMUNITY_ADMIN        = 0x2000.freeze
    ROLE_DEV_ADMIN              = 0x4000.freeze
  end
end