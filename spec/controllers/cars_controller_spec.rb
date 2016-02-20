require 'rails_helper'

RSpec.describe CarsController, type: :controller do

  describe "GET #new_car" do
    it "returns http success" do
      get :new_car
      expect(response).to have_http_status(:success)
    end
  end

end
