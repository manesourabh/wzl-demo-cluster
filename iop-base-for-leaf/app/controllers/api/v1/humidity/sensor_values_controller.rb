class Api::V1::Humidity::SensorValuesController < Api::V1::Humidity::HumidityController

  def create
    # TODO: only allow sensors with security code
    # TODO: match the key values with the ardiuno keys
    if params["apikey"] != "MQWZLIOPPCSM"
      render json: {message: "Your api key does not match"}
    else
      SensorValue.create(params.permit(:sensor_name, :sensor_value))
      render json: {message: "Your record has been created"}
    end
  end

  def index
    @data = SensorValue
    # returns all valies if no filter is given,
    if params.has_key?(:sensor_name)
      @data = @data.where(sensor_name: params['sensor_name'])
    end
    if params.has_key?(:from)
      @data = @data.where("created_at > ?", params['from'])
    end
    if params.has_key?(:to)
      @data = @data.where("created_at < ?", params['to'])
    end
    if params.has_key?(:last)
      @data = @data.last(params['last'])
    end
    render json: {data: @data}
  end

end
