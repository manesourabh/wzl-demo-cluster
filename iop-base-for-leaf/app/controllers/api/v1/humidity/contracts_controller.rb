class Api::V1::Humidity::ContractsController < Api::V1::Humidity::HumidityController
  def create
    begin
      Contract.create!(params.permit(:contract_id, :name, :fvalue, :alarm, :email))
      render json: {message: "Your record has been created"}
    rescue ActiveRecord::RecordInvalid => e
        render json: {data: e.record.errors, old_params: params}, status: 406
    end
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.update(params.permit(:contract_id, :name, :fvalue, :alarm, :email))
    render json: {message: "Your record has been updated"}
  end

  def index
    data = Contract.all
    render json: {data: data}
  end

  def show
    @contract = Contract.find(params[:id])
    @assigned_sensors = @contract.assigned_sensors
    render json: {data: {contract: @contract, assign_sensors: @assigned_sensors}}
  end

  def assign_sensor
    @sensor = ActiveSensor.where(sensor_name: params[:sensor_name]).last
    @contract = Contract.where(contract_id: params[:contract_id]).last
    # if ActiveSensor.where(sensor_name: params[:sensor_name], contract_id: params[:contract_id]).exists?
    if @sensor.contract_id == params[:contract_id] && !@contract.assigned_sensors.where(sensor_name: @sensor.sensor_name).last.end_time.nil?
      render json: {message: "Sensor #{params[:sensor_name]} is already assigned to #{params[:contract_id]} and it is active"}
    else
      unless @sensor.contract_id.blank?
        @old_contract = Contract.where(contract_id: @sensor.contract_id).last
        @old_assign_sensor = @contract.assign_sensors.where(sensor_name: params[:sensor_name]).last
        @old_assign_sensor.update(end_time: Time.now)
      end
      @sensor.update(params.permit(:contract_id))
      @contract.update(end_date: nil) #flagging that contract is still active
      @contract.assigned_sensors.create(sensor_name: @sensor.sensor_name, start_time: Time.now)
      render json: {message: "Your record has been updated"}
    end
  end

  def remove_sensor
    @sensor = ActiveSensor.where(sensor_name: params[:sensor_name]).last
    @contract = Contract.where(contract_id: @sensor.contract_id).last
    @old_assign_sensor = @contract.assigned_sensors.where(sensor_name: params[:sensor_name]).last
    @old_assign_sensor.update(end_time: Time.now)
    @sensor.update(contract_id: nil)
    if ActiveSensor.where(contract_id: @contract.contract_id).count == 0
      @contract.update(end_date: Time.now)
    end
    render json: {message: "Sensor #{@sensor.sensor_name} has been removed from contract #{@contract.contract_id}"}
  end
end
