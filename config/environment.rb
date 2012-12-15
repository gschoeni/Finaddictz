# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Finaddictz::Application.initialize!

#Date format default
Date::DATE_FORMATS.merge!(:default => "%B %d, %Y")
