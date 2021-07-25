require 'stripe'

class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  # Create and return Stripe session for purchasing subscription
  def create
    return unauthorised_response unless user_auth?

    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]

    price_id = params[:pricingId]

    customer = Stripe::Customer.create

    @user.create_stripe_customer_id!({ customer_id: customer.id })

    session = Stripe::Checkout::Session.create({
                                                 success_url: "#{Rails.application.credentials.app[:url]}",
                                                 cancel_url: "#{Rails.application.credentials.app[:url]}",
                                                 payment_method_types: ['card'],
                                                 mode: 'subscription',
                                                 line_items: [{
                                                   quantity: 1,
                                                   price: price_id
                                                 }],
                                                 customer: customer.id
                                               })

    render json: { StripeSessionURL: session.url }, status: :ok
  end

  # Create and return Stripe portal for managing customer subscription
  def update; end
end
