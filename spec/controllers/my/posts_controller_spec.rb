require 'rails_helper'

RSpec.describe My::PostsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #direct" do
    it "returns http success" do
      get :direct
      expect(response).to have_http_status(:success)
    end
  end

end
