module Api
  module V1
    class BaseController < ActionController::Base
      respond_to :json

      protected

      def authenticate!
        authenticate_with_token || render_unauthorized
      end

      def authenticate_with_token
        authenticate_with_http_token do |token, options|
          User.find_by(auth_token: token)
        end
      end

      def render_unauthorized
        render json: 'Bad credentials', status: 401
      end
    end
  end
end
