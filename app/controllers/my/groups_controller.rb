class My::GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.json {
        render json: groups
      }
      format.html {
        render 'index'
      }

    end
  end

  def show
  end

  def edit
  end

  def create
  end

  def destroy
  end

  def groups
    @groups ||= current_user.groups
  end
end
