class IndexController < ApplicationController
  before_action :authenticate_user!, only: [:admin]
  before_action :check_admin_only, only: [:admin]
  def home

  end

  def docs

  end

  def test
    # Delete this action before going to production.
  end

  private
    def check_admin_only
      unless current_user.admin?
        flash[:danger] = "You do not have sufficient permissions to view this content"
        redirect_to root_path
      end
    end
end
