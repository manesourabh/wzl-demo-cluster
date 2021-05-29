class SensorValuesController < ApplicationController
  before_action :auth_user
  require 'date'
  def index
    @sensors = doorkeeper_access_token.get("/api/humidity/active_sensors").parsed if doorkeeper_access_token
    @sensors = @sensors["data"]
    @points = if params.has_key?(:points) then params[:points] else "20" end
  end

  def latest_value_batch
    puts params
    @data = doorkeeper_access_token.get("/api/humidity/sensor_values", params: params.permit(:sensor_name, :last, :from, :to)).parsed if doorkeeper_access_token
    # puts "Hello"
    chartData = []
    @data["data"].each do |d|
      temp = []
      temp << DateTime.iso8601(d["created_at"]).strftime('%Q').to_i
      temp << d["sensor_value"]
      chartData << temp
    end
    # puts chartData
    render json: {data: chartData}
  end

  def updated_data
    puts params
    @data = doorkeeper_access_token.get("/api/humidity/sensor_values", params: params.permit(:sensor_name, :last)).parsed if doorkeeper_access_token

  end
end
