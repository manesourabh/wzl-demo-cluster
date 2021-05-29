class Api::V1::UsersController < ApplicationController
  # respond_to :json
  before_action :doorkeeper_authorize!
  def show
    data =  eval(current_resource_owner.to_json)
    role_data = {}
    current_resource_owner.groups.each do |g|
      role_data[g.name] = current_resource_owner.roles.where(resource_id: g.id).pluck(:name)
    end
    data[:role_data] = role_data
    render json: data
  end

  private
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
