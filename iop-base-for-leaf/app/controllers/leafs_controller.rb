class LeafsController < ApplicationController
  before_action :authenticate_user!, :authorize_access
  def index
    @data = LeafFailure.all
    @col = LeafFailure.column_names
    @count = LeafFailure.count()
  end

  def import
    LeafFailure.spc_import(params[:file])
    flash[:success] = "New data has been imported!"
    redirect_back(fallback_location: root_path)
  end

  private
  def authorize_access
    t = false
    current_user.groups.each do |g|
      roles = current_user.roles.where(resource_type: "Group", resource_id: g.id).pluck(:name)
      if g.tables.where(role: roles, dataset_name: "LeafFailure").exists?
        t = true
        break
      end
    end
    unless t
      flash[:danger] = "You do not have enough permissions to access this content!"
      redirect_back(fallback_location: root_path)
    end
  end

end
