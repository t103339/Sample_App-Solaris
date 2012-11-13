class ApplicationController < ActionController::Base
  protect_from_forgery

  # Allows SessionHelper functions to be used in all controllers.
  # Note: By default, all the helpers are available in the views
  #       but not in the controllers. We have to include it explicitly
  #       to use methods from both places.
  include SessionsHelper
end
