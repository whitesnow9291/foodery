describe OrderCreator do
  let(:result) { service.perform }
  let(:service) { OrderCreator.new session, menu_item, nil }
  let(:menu_item) { create :menu_item, menu: menu, price: 10.99 }
  let(:menu) { create :menu, restaurant: restaurant }
  let(:restaurant) { create :restaurant, delivery_fee: 10 }

  context 'create order' do
    let(:session) { {} }

    it do
      order = result.first
      expect(order.order_items.count).to eq 1
      expect(order.order_items.first.total_price).to be_within(0.01).of 10.99
      expect(order.order_items.first.qty).to eq 1
    end
  end

  context 'append to order same menu_item' do
    let(:order) { create :order }
    let(:session) { {order_id: order.id} }
    let!(:order_item) { create :order_item, order: order, menu_item: menu_item }

    it do
      order = result.first
      expect(order.order_items.count).to eq 1
      expect(order.order_items.first.total_price).to be_within(0.01).of 21.98
      expect(order.order_items.first.qty).to eq 2
    end
  end

  context 'append to order different menu_item' do
    let(:order) { create :order }
    let(:session) { {order_id: order.id} }
    let(:menu_item_2) { create :menu_item, menu: menu_2 }
    let(:menu_2) { create :menu, restaurant: restaurant }

    let!(:order_item) { create :order_item, order: order, menu_item: menu_item }
    let(:service) { OrderCreator.new session, menu_item_2, nil }

    it do
      order = result.first
      expect(order.order_items.count).to eq 2
      expect(order.total_price).to be_within(0.01).of 31.98
    end
  end

  context 'create with options' do
    let(:session) { {} }
    let(:option) { create :option, menu_item: menu_item, price: 2.5 }
    let(:qty) { 2 }
    let(:option_hash) { [{id: option.id, qty: qty}] }
    let(:service) { OrderCreator.new session, menu_item, option_hash }

    it do
      order = result.first
      expect(order.order_items.count).to eq 1
      expect(order.total_price).to be_within(0.01).of 25.99
      expect(order.order_items.first.qty).to eq 1
    end
  end
end

