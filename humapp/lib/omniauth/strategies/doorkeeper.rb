module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper

      option :client_options,
             site: Rails.application.credentials.dig(:DOORKEEPER_APP_URL) || ENV["DOORKEEPER_APP_URL"],
             authorize_path: "/oauth/authorize"

      uid do
        raw_info["id"]
      end

      info do
        {
          email: raw_info["email"],
          firstname: raw_info["firstname"],
          lastname: raw_info["lastname"],
          roledata: raw_info["role_data"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/api/user").parsed
      end
    end
  end
end
