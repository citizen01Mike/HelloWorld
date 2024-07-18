# spec/controllers/home_controller_spec.rb
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful # response.successful? is deprecated in RSpec 4
      expect(response).to have_http_status(:ok) # preferred way from Rails 5+ onwards
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    # If there's specific content expected in the response, you could test that too:
    # it "includes some expected content in the response body" do
    #   get :index
    #   expect(response.body).to include("Some expected content")
    # end
  end
end
