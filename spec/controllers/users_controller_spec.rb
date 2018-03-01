describe UsersController do
  describe '#set_location', :vcr do
    context 'valid location' do
      let(:address) { '2 Harewood Place, London' }
      let(:expect_addr) { "2 Harewood Pl, Mayfair, London W1S 1BX, UK" }
      before { @request.env["devise.mapping"] = Devise.mappings[:user] }
      before { post :set_location, { user: { address: address } } }

      it do
        expect(response.body).to include_json address: expect_addr
        expect(session[:lat]).to  be_within(0.0001).of(51.5147524)
        expect(session[:lng]).to be_within(0.0001).of(-0.1439794)
      end
    end

    context 'invalid location' do
      let(:address) { 'etetetetetete' }
      before { @request.env["devise.mapping"] = Devise.mappings[:user] }
      before { post :set_location, { user: { address: address } } }

      it do
        expect(response.body).to include_json error: I18n.t('location.cant_set')
      end
    end
  end
end
