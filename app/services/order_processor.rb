class OrderProcessor
  DEFAULT_CURRENCY = "cad"

  def initialize user, order
    @user, @order = user, order
  end

  def process *args
    raise OrderProcessError.new 'No active order found' unless @order
    raise OrderProcessError.new 'Order not reach minimal price' unless @order.can_checkout?
    send args.shift, *args
    @order.checkout
    @order.user = @user if @user
    @order.save!
    [@order, nil]
  rescue OrderProcessError => e
    [@order, e.message]
  end

  def without_user card_token
    charge, err = stripe_charge_with_token card_token, @order.total_price
    raise OrderProcessError.new err if err
  end

  def with_user
    raise OrderProcessError.new 'No active order found' unless @order
    charge, err = stripe_charge_with_customer @user.stripe_customer_id, @order.total_price
    raise OrderProcessError.new err if err
  end

  def with_user_and_card card_token
    raise OrderProcessError.new 'No active order found' unless @order
    customer, err = stripe_create_customer @user.email, card_token
    raise OrderProcessError.new err if err
    @user.update! stripe_customer_id: customer.id, last4: customer.sources.first.last4
    charge, err = stripe_charge_with_customer @user.stripe_customer_id, @order.total_price
    raise OrderProcessError.new err if err
  end

  def with_user_and_card_update card_token
    card, err = attach_card_to_customer card_token, @user.stripe_customer_id
    raise OrderProcessError.new err if err
    @user.update last4: card.last4
    charge, err = stripe_charge_with_customer @user.stripe_customer_id, @order.total_price
    raise OrderProcessError.new err if err
  end

  private

  def stripe_create_customer email, card_token
    customer = customer = Stripe::Customer.create email: email, source: card_token
    [customer, nil]
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    [nil, e.message]
  end

  def attach_card_to_customer card_token, stripe_customer_id
    customer = Stripe::Customer.retrieve stripe_customer_id
    card = customer.sources.create source: card_token
    card.save
    customer.default_source = card.id
    customer.save
    [card, nil]
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    [nil, e.message]
  end

  def stripe_charge_with_customer customer_id, amount, currency = nil
    charge amount, { customer: customer_id }, currency
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    [nil, e.message]
  end

  def stripe_charge_with_token token, amount, currency = nil
    charge amount, { source: token }, currency
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    [nil, e.message]
  end

  def charge amount, hash, currency = nil
    currency = DEFAULT_CURRENCY unless currency
    fee = (amount * @order.restaurant.fee * 100).to_i
    stripe_uid = @order.restaurant.user.stripe_uid
    amount_with_tax = @order.total_price_with_tax.round(2)

    hash = { amount: (amount_with_tax * 100).to_i, currency: currency, destination: stripe_uid, application_fee: fee}.merge hash

    charge = Stripe::Charge.create hash
    [charge, nil]
  end


end

class OrderProcessError < StandardError
end