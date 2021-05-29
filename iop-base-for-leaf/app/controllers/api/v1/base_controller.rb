class Api::V1::BaseController  < ApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :verify_authenticity_token
  private
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
