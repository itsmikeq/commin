class My::ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.json {
        render json: profile
      }
      format.html {
        render 'index'
      }

    end
  end

  def edit
  end

  def create
  end

  def destroy
  end

  def profile
    @profile ||= current_user.profile
  end

end
