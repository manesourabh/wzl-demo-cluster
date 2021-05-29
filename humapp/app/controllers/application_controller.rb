class ApplicationController < ActionController::Base

  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      flash[:error] = "You token has been expired. Please login again"
      sign_out_and_redirect(current_user)
    end
  end

private
  def doorkeeper_oauth_client
    @doorkeeper_oauth_client ||= OAuth2::Client.new(
      Rails.application.credentials.dig(:DOORKEEPER_APP_ID) || ENV['DOORKEEPER_APP_ID'],
      Rails.application.credentials.dig(:DOORKEEPER_APP_SECRET) || ENV['DOORKEEPER_APP_SECRET'],
      site: Rails.application.credentials.dig(:DOORKEEPER_APP_URL) || ENV['DOORKEEPER_APP_URL']
    )
  end

  def doorkeeper_access_token
    @doorkeeper_access_token ||=
      if current_user
        OAuth2::AccessToken.new(
          doorkeeper_oauth_client, current_user.doorkeeper_access_token
        )
      end
  end

  def auth_user
    redirect_to user_doorkeeper_omniauth_authorize_path unless user_signed_in?
  end
end
