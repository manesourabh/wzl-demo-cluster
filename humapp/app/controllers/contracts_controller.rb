class ContractsController < ApplicationController
  before_action :auth_user
  require 'json'
  def index
    @data = doorkeeper_access_token.get("/api/humidity/contracts").parsed if doorkeeper_access_token
    @data = @data["data"].to_json
  end

  def new
  end

  def create
    doorkeeper_access_token.post("/api/humidity/contracts/", params: params.permit(:contract_id, :name, :fvalue, :alarm, :email ))
    redirect_to contracts_path
  end

  def show
    @data = doorkeeper_access_token.get("/api/humidity/contracts/"+params[:id]).parsed if doorkeeper_access_token
    @contract = @data["data"]["contract"]
    @assigned_sensor = @data["data"]["assign_sensors"]
    @inactive_sensors = doorkeeper_access_token.get("/api/humidity/active_sensors/sensors").parsed if doorkeeper_access_token
    # finding duration
    if @contract["end_date"].blank?
      et = Time.new.utc
    else
      et = DateTime.iso8601(@contract["end_date"])
    end
    ft = DateTime.iso8601(@contract["created_at"])
    # puts @assigned_sensor
    # puts @data
    # ft = Time.new.utc
    # et = Time.new.utc - 1.year
    # @assigned_sensor.each do |s|
    #   if ft > DateTime.iso8601(s["start_time"])
    #     ft = DateTime.iso8601(s["start_time"])
    #   end
    #   if s["end_time"].blank?
    #     et = Time.new.utc
    #   else
    #     if et < DateTime.iso8601(s["end_time"])
    #       et = DateTime.iso8601(s["end_time"])
    #     end
    #   end
    # end
    td = et - ft
    td_days = (td/1.day).floor
    td_hours = ((td/1.hour) - td_days*24).floor
    @contract_duration = "#{td_days} days, #{td_hours} hours"
    # @contract_duration = TimeDifference.between(ft, et).humanize
    # puts @contract_duration
    # @sensors = doorkeeper_access_token.get("/api/humidity/active_sensors").parsed if doorkeeper_access_token
    # @sensors = @sensors["data"]
    # @sensors = @data2["data"]
  end

  def edit
    @data = doorkeeper_access_token.get("/api/humidity/contracts/"+params[:id]).parsed if doorkeeper_access_token
    @contract = @data["data"]["contract"]
  end

  def update
    doorkeeper_access_token.put("/api/humidity/contracts/"+params[:id], params: params.permit(:contract_id, :name, :fvalue, :alarm, :email ))
    redirect_to "/contracts/"+params[:id]
  end

  def assign_sensor
    puts "Hello assign sensor"
    puts params
    doorkeeper_access_token.post("/api/humidity/contracts/assign_sensor", params: params.permit(:contract_id, :sensor_name))
    redirect_to "/contracts/"+params[:id]
  end

  def remove_sensor
    doorkeeper_access_token.post("/api/humidity/contracts/remove_sensor", params: params.permit(:sensor_name))
    # redirect_to "/contracts/"+params[:id]
    redirect_back(fallback_location:"/")
  end
end
