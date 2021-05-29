class Api::V1::Leaf::LeafFailureTypesController < Api::V1::Leaf::LeafBaseController


  def create
    LeafFailureType.create(params.permit(:activity, :failure, :cause, :admin_approval))
    render json: {message: "Your record has been created"}
  end

  def index
    render json: {data: LeafFailureType.all}
  end

  def show
    @failure_type = LeafFailureType.find(params[:id])
    render json: {data: @failure_type}
  end

  def update
    @failure_type = LeafFailureType.find(params[:id])
    @failure_type.update(params.permit(:activity, :failure, :cause, :admin_approval))
    render json: {message: "Your record has been updated"}
  end

  def all_measures
    if params.has_key?(:failure_type_id)
      @failure_type = LeafFailureType.find(params[:failure_type_id])
      @measures = @failure_type.measure_types
      if params.has_key?(:except_id)
        @measures = @measures.where.not(id: params[:except_id].split(","))
      end
      render json: {data: @measures.all}
    else
      render json: {data: "Please give the correct parameter ('failure_type_id') while calling the api"}
    end
  end

  def top_three_measures
    if params.has_key?(:failure_type_id)
      @failure_type = LeafFailureType.find(params[:failure_type_id])
      @measures = @failure_type.measure_types
      if params.has_key?(:except_id)
        @measures = @measures.where.not(id: params[:except_id].split(","))
      end
      render json: {data: @measures.order(:success_percent).last(3)}
    else
      render json: {data: "Please give the correct parameter ('failure_type_id') while calling the api"}
    end
  end

  def activities
    render json: {data: LeafFailureType.distinct.pluck(:activity)}
  end

  def failure
    @data = LeafFailureType
    if params.has_key?(:activity)
      @data = @data.where(activity: params[:activity])
    end
    render json: {data: @data.distinct.pluck(:failure)}
  end

  def cause
    @data = LeafFailureType
    if params.has_key?(:activity)
      @data = @data.where(params.permit(:activity))
    end
    if params.has_key?(:failure)
      @data = @data.where(params.permit(:failure))
    end
    render json: {data: @data.distinct.pluck(:cause)}
  end

end
