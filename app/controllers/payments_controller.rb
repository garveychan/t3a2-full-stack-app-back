class PaymentsController < ApplicationController
  before_action :authenticate_user!

  # Create and return Stripe session for purchasing subscription
  def new
    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]

    render json: { StripeSession: '12jl3kj1l2k4hl1k2h4lk12j' }, status: :ok
  end

  # Create and return Stripe portal for managing customer subscription
  def edit; end
end
