class Api::V1::Leaf::LeafBaseController < Api::V1::BaseController

  # before_action :doorkeeper_authorize!, :authorize_access


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
