# Load the rails application
require File.expand_path('../application', __FILE__)

#Turn off heroku deprecation warnings on server startup
ActiveSupport::Deprecation.silenced = true   

# Initialize the rails application
Omrails::Application.initialize!
