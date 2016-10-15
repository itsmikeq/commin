module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      # Tag the user making the connection
      logger.add_tags 'ActionCable', current_user.name
    end

    def session
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end

    def ability
      # TODO: build out an abilities hash or whatever
    end

    protected
    def find_verified_user
      if verified_user = User.find_by(id: cookies.signed['user.id'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
