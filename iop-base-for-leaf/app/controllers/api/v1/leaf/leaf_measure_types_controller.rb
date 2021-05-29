class Api::V1::Leaf::LeafMeasureTypesController < Api::V1::Leaf::LeafBaseController

  def create
    @failure_type = LeafFailureType.find(params[:failure_type_id])
    new_measure = @failure_type.measure_types.create(params.permit(:name, :success_percent, :admin_approval))
    render json: {  message: "Your record has been created",
                    new_measure: new_measure
                  }
  end

  def single_measure
    if params.has_key?(:id) then
      @measure_type = LeafMeasureType.find(params[:id])
      render json: {
        data: @measure_type
      }
    else
      render json: {
        message: "Please pass the parameter 'id' with get request"
      }
    end
  end

  def update
    # @failure_type = LeafFailureType.where(params.permit(:activity, :failure, :cause)).last
    @measure = LeafMeasureType.find(params[:id])
    @measure.measure_types(params.permit(:name, :admin_approval))
    render json: {message: "Your record has been updated"}
  end


  def approve
    @measure = LeafFailureType.find(params[:id])
    @measure.measure_types(admin_approval: true)
    render json: {message: "Your measure has been approved"}
  end

  def update_success_rates
    @failure_types = LeafFailureType.all
    @failure_types.each do |ft|
    	@recorded_failures = LeafFailure.where(leaf_failure_type_id: ft.id, status: "geschlossen").all
    	measure_count = {}
    	ft.measure_types.map{|m| measure_count[m.id]=0}
    	@recorded_failures.each do |f|
    		m = f.applied_measures.order('leaf_measures.created_at ASC').last
    		measure_count[m.id] = measure_count[m.id] + 1
    	end
    	total_measures = @recorded_failures.count
    	success_rate = {}
    	measure_count.each{|k, v| success_rate[k]=(v*100.0/total_measures).round(2)}
    	ft.measure_types.each do |m|
    		m.update(success_percent: success_rate[m.id])
    	end
    end
    render json: {
      message: "The success rate for all measure types have been updated successfully!!!"
    }
  end

end
