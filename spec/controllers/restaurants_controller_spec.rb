describe RestaurantsController do

  describe "#show" do
    let(:restaurant) { create :restaurant }
    before { session[:address] = 'M4G 1A8' }
    before { get :show, { id: restaurant.id } }
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
