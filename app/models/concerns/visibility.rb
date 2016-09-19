module Visibility
  extend ActiveSupport::Concern

  included do
    PUBLIC  = 0x01.freeze
    PRIVATE = 0x02.freeze
    DIRECT  = 0x04.freeze

    def self.visibility_levels
      {
        public:  PUBLIC,
        private: PRIVATE,
        direct:  DIRECT
      }
    end

    def self.levels_visibility
      visibility_levels.invert
    end

  end

  def visibility_level
    self.class.levels_visibility[visibility]
  end

end