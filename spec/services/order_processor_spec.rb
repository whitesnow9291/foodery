describe OrderProcessor, :vcr do
  let(:order) { create :order }
  let!(:order_item) { create :order_item, order: order, menu_item: menu_item }
  let(:menu_item) { create :menu_item, menu: menu }
  let(:menu) { create :menu, restaurant: restaurant }
  let(:restaurant) { create :restaurant }

  let(:service) { OrderProcessor.new user, order }

  before { order.save_with_calculation! }

  describe '#without_user' do
    context 'success charge' do
      let(:user) { nil }
      let(:card_token) { "tok_18gvkDAnIETEalxPiOvmVu87" }
      let(:result) { service.process :without_user, card_token }

      it do
        expect(result.first.status).to eq 'checkout'
      end
    end
  end

  describe '#with_user_and_card' do
    context 'success charge' do
      let(:card_token) { "tok_18m6VKAnIETEalxPUkUr3zg2" }
      let(:user) { create :user, email: 'test@test.com' }
      let(:result) { service.process :with_user_and_card, card_token }

      it do
        user.reload
        expect(result.first.status).to eq 'checkout'
        expect(user.last4).to eq '4242'
        expect(user.stripe_customer_id).to eq 'cus_94F2QWAh0SL27N'
      end
    end
  end

  describe '#with_user' do
    context 'success charge' do
      let(:user) { create :user, email: 'test@test.com', stripe_customer_id: 'cus_94CowVRGL3HTHH'  }
      let(:result) { service.process :with_user }

      it do
        user.reload
        expect(result.first.status).to eq 'checkout'
      end
    end
  end

  describe '#with_user_and_card_update' do
    context 'success charge' do
      let(:user) { create :user, email: 'test@test.com', stripe_customer_id: 'cus_94CowVRGL3HTHH'  }
      let(:card_token) { "tok_18m7X2AnIETEalxP796YvkzW" }
      let(:result) { service.process :with_user_and_card_update, card_token }

      it do
        user.reload
        expect(result.first.status).to eq 'checkout'
      end
    end
  end
end
