class IndexController < ApplicationController

  def home
    # @user = doorkeeper_access_token.get("/api/user").parsed if doorkeeper_access_token
    @hello = "hello"
    @current_user = current_user
    # access_token = OAuth2::AccessToken.new(doorkeeper_oauth_client, current_user.doorkeeper_access_token)
    # @user = access_token.get("/api/user").parsed
  end

  def out
    flash[:error] = "You token has been expired. Please login again"
    sign_out_and_redirect(current_user)
  end
end
