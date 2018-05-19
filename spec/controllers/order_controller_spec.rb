require 'rails_helper'

RSpec.describe OrdersController do
  describe "GET index" do
    it "assigns @orders" do
      order = create(:order)
      get :index
      expect(assigns(:orders)).to eq([order])
    end
  end
end
