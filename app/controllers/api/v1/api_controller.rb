module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

      def render_not_found_response
        render json: { message: 'Recurso no encontrado' }, status:  :not_found
      end
    end
  end
end