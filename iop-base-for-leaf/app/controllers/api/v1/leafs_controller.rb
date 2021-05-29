class Api::V1::LeafsController < Api::V1::BaseController
  # skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!, :authorize_access
  def all
    @group = Group.find_by(name: "LeaF")
    if current_resource_owner.has_role? :admin, @group
      render json: {data: LeafFailure.all}
    elsif current_resource_owner.has_role? :werker, @group
      data = LeafFailure.where(status: "offen").or(LeafFailure.where(user_id: current_resource_owner.id))
      render json: {data: data}
    elsif current_resource_owner.has_role? :vorarbeiter, @group
      data = LeafFailure.where(status: "offen")
      render json: {data: data}
    else
      render json: {
                message: "Your role/s does not have sufficient permissions to access this data!",
              }, status: 401
    end
  end

  def add_record
    allowed_roles = ['werker', 'vorarbeiter', 'admin']
    assigned_roles = current_resource_owner.roles.where(resource_type: "Group", resource_id: @current_group.id).pluck(:name)
    if (allowed_roles & assigned_roles).empty?
      render json: {
                message: "Your role/s do not have sufficient permissions to add new record!",
              }, status: 401
    else
      uid = current_resource_owner.id
      e_datetime = DateTime.strptime(params[:error_datetime], '%Y-%m-%dT%H:%M:%S')
      failure_type = LeafFailureType.where(params.permit(:activity, :failure, :cause)).last
      new_record = LeafFailure.create(user_id: uid, error_datetime: e_datetime, status: params[:status], description: params[:description], activity: params[:activity], failure: params[:failure], cause: params[:cause], recoverable: params[:recoverable], measures: params[:measures], leaf_failure_type_id: failure_type.id)
      render json: {  message: "Your record has been created",
                      failure: new_record
                    }
    end
  end

  def get_single_record
    @group = Group.find_by(name: "LeaF")
    @single_record = LeafFailure.find(params[:id])
    @measures = @single_record.applied_measures.order('leaf_measures.created_at ASC')
    render json: {record: @single_record, taken_measures: @measures}
  end

  def update_recrod
    @group = Group.find_by(name: "LeaF")
    if current_resource_owner.has_role? :admin, @group
      @single_record = LeafFailure.find(params[:id])
      @single_record.update(params.permit(:error_datetime, :status, :description, :activity, :failure, :cause, :recoverable, :measures))
      render json: {message: "Successfully updated the record!"}
    else
      render json: {
          message: "You do not have sufficient permissions to edit the records"
        }, status: 401\
    end
  end

  def add_measure
    if params.has_key?(:failure_id) and params.has_key?(:measure_id)
      @failure = LeafFailure.find(params[:failure_id])
      @measure = LeafMeasureType.find(params[:measure_id])
      @failure.applied_measures << @measure
      render json: {message: "Measure has been added"}
    else
      render json: {message: "Please send the keys-values for 'failure_id' and 'measure_id'"}
    end
  end

  private
  def authorize_access
    t = false
    current_resource_owner.groups.each do |g|
      roles = current_resource_owner.roles.where(resource_type: "Group", resource_id: g.id).pluck(:name)
      if g.tables.where(role: roles, dataset_name: "LeafFailure").exists?
        @current_group = g
        t = true
        break
      end
    end
    unless t
      render json: {
                message: "You do not have sufficient permissions to access this data!",
              }, status: 401
    end
  end
end
