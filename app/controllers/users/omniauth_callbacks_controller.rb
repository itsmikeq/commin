class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.create_with_omniauth(request.env["omniauth.auth"])


    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end

  end

  def after_sign_in_path_for(resource)
    redirect_to root_path
  end

  def failure
    error_description = env['omniauth.error'].error_reason
    flash[:alert] = error_description
    render 'users/sessions/new'
  end

  def passthru
  end

  def add_headers
    session.headers['X-Frame-Options'] = 'SAMEORIGIN'
  end

end