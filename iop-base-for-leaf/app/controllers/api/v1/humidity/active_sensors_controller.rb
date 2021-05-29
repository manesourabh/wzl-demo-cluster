class Api::V1::Humidity::ActiveSensorsController < Api::V1::Humidity::HumidityController
  def create
    begin
      ActiveSensor.create!(params.permit(:sensor_name))
      render json: {message: "Your record has been created"}
    rescue ActiveRecord::RecordInvalid => e
      render json: {data: e.record.errors, old_params: params}, status: 406
    end
  end

  def index
    render json: {data: ActiveSensor.order(:id).all}
  end

  def show
    render json: {data: ActiveSensor.find(params["id"])}
  end

  def update
    as = ActiveSensor.find(params[:id])
    as.update(params.permit(:sensor_name))
    render json: {message: "Your record has been updated"}
  end

  def sensors
    render json: {data: ActiveSensor.where(contract_id: nil).order(:id).pluck(:sensor_name)}
  end
end
