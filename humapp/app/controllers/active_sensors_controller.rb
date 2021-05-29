class ActiveSensorsController < ApplicationController
  before_action :auth_user
  require 'json'
  def index
    @data = doorkeeper_access_token.get("/api/humidity/active_sensors").parsed if doorkeeper_access_token
    @data = @data["data"].to_json
  end

  def new

  end

  def edit
    @data = doorkeeper_access_token.get("/api/humidity/active_sensors/"+params[:id]).parsed if doorkeeper_access_token
    @data = @data["data"]
  end

  def create
    # puts "Hello"
    @data = doorkeeper_access_token.post("/api/humidity/active_sensors", params: params.permit(:sensor_name)).parsed if doorkeeper_access_token
    redirect_to active_sensors_path
  end

  # def active
  #   @data = doorkeeper_access_token.get("/api/humidity/active_sensors").parsed if doorkeeper_access_token
  #   @data = @data["data"].to_json
  # end
end
