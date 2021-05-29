class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin_only, only: [:add_dataset, :destroy_dataset]
  before_action :check_group_owner, except: [:showall, :add_group,]

  def showall
    @gps = Group.all
  end

  def show
    # params[:id]
    @group_id = params[:group_id]
    @group = Group.find_by(id: @group_id)
    @members = @group.users
    @table_names = @group.tables
    @group_roles = @group.group_roles
    # @group.tables.each do |t|
    #   @table_names << t.dataset_name
    # end
    # @datasets = table_names.join(", ")
  end

  def add_group
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:danger] = "User with email " + params[:email] + " does not exist!"
    elsif Group.exists?(name: "AWK20")
      flash[:danger] = "The given group name ('#{params[:name]}') already exits! Please try another name!"
    else
      group = Group.create(name: params[:name], owner_id: user.id)
      group.users << user
    end
    redirect_back(fallback_location: root_path)
  end


  def add_member
    # puts params
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:danger] = "User with email " + params[:email] + " does not exist!"
    else                #TODO implement logic in elsif to check if the given user is already in the group.
      group = Group.find_by(id: params[:group_id])
      GroupMember.create(user: user, group: group)
      # or
      # group.users << user
    end
    redirect_to "/groups/show/#{params[:group_id]}"
  end

  def destroy_member
    user = User.find_by(email: params[:email])
    group = Group.find(params[:id])
    # puts params
    if user.id == group.owner_id
      flash[:warning] = "Group owner can not be removed from the group"
    else
      group.users.destroy(user)
    end
    redirect_to "/groups/show/#{params[:id]}"
  end

  def add_dataset
    gid = params[:group_id]
    role = params[:role]
    dsn = params[:dataset_name]
    group = Group.find_by(id: gid)
    # existing_datasets = group.tables.pluck(:dataset_name)
    # if existing_datasets.include?(params[:dataset_name])
    if DataOwner.where(group_id: group.id, role: role, dataset_name: dsn).exists?
      flash[:warning] = "Dataset you are trying to add is already added"
    else
      group.tables.create(dataset_name: params[:dataset_name], role: params[:role])
      flash[:success] = "Dataset access successfully added..."
    end
    redirect_to "/groups/show/#{params[:group_id]}"
  end

  def destroy_dataset
    group = Group.find(params[:group_id])
    group.tables.destroy(params[:id])
    flash[:success] = "Dataset access removed successfully"

    redirect_to "/groups/show/#{params[:group_id]}"
  end

  def add_group_role
    group = Group.find_by(id: params[:group_id])
    group.group_roles.create(name: params[:role_name].downcase)
    redirect_to "/groups/show/#{params[:group_id]}"
  end

  def destroy_group_role
    group = Group.find(params[:group_id])
    group.group_roles.destroy(params[:id])
    flash[:success] = "Group role removed successfully"
    redirect_to "/groups/show/#{params[:group_id]}"
  end

  def group_member_roles
    user = User.find(params[:user_id])
    roles = user.roles.where(resource_id: params[:group_id]).pluck(:name)
    render json: {roles: roles, user_name: user.firstname}
  end

  def add_group_member_role
    user = User.find(params[:user_id])
    group = Group.find(params[:group_id])
    user.add_role params[:Role].to_sym, group
    redirect_to "/groups/show/#{params[:group_id]}"
  end

  def destroy_group_member_role
    user = User.find(params[:user_id])
    group = Group.find(params[:group_id])
    user.remove_role params[:role].to_sym, group
    redirect_to "/groups/show/#{params[:group_id]}"
  end

  private
    def check_admin_only
      unless current_user.admin?
        flash[:danger] = "You do not have sufficient permissions to view this content"
        redirect_to root_path
      end
    end

    def check_group_owner
      unless current_user.owned_groups.where(id: params[:group_id]).exists? or current_user.admin?
        flash[:danger] = "You do not have sufficient permissions to view this content"
        redirect_to root_path
      end
    end
end
