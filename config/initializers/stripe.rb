Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_TEST_PUBLISHABLE_KEY_ID'],
  :secret_key      => ENV['STRIPE_TEST_SECRET_KEY_ID']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
