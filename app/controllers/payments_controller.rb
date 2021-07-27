require 'stripe'

class PaymentsController < ApplicationController
  # Authenticate and identify user with JWT.
  before_action :authenticate_user!
  before_action :set_user

  # Initialise a Stripe session based on the pricingId received from the request.
  # Assign the Stripe customer id to the user so a billing portal can be retrieved for that user in the future.
  # Respond with the Stripe session URL for redirecting the user.
  def create
    return unauthorised_response unless user_auth?

    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]

    price_id = params[:pricingId]

    customer = Stripe::Customer.create

    @user.create_stripe_customer_id!({ customer_id: customer.id })

    session = Stripe::Checkout::Session.create({
                                                 success_url: Rails.application.credentials.app[:url].to_s,
                                                 cancel_url: Rails.application.credentials.app[:url].to_s,
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
end
