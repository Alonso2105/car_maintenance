module Api
  module V1
    class MaintenanceServicesController < ApiController
      before_action :set_maintenance_service, only: %i[ show edit update destroy ]

      # GET /maintenance_services or /maintenance_services.json
      def index
        @maintenance_services = MaintenanceService.all
        render :index
      end

      # GET /maintenance_services/1 or /maintenance_services/1.json
      def show
        render :show
      end

      # POST /maintenance_services or /maintenance_services.json
      def create
        @maintenance_service = MaintenanceService.new(maintenance_service_params)
      
        if Car.exists?(params[:maintenance_service][:car_id])
          if @maintenance_service.save
            render :show, status: :created
          else
            render json: { errors: @maintenance_service.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: ["El coche especificado no existe"] }, status: :unprocessable_entity
        end
      end
      

      # PATCH/PUT /maintenance_services/1 or /maintenance_services/1.json
      def update
        if Car.exists?(maintenance_service_params[:car_id])
          if @maintenance_service.update(maintenance_service_params)
            render :show, status: :ok
          else
            render json: { errors: @maintenance_service.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: ["El coche especificado no existe"] }, status: :unprocessable_entity
        end
      end

      # DELETE /maintenance_services/1 or /maintenance_services/1.json
      def destroy
        @maintenance_service.destroy!
        head :no_content
      rescue StandardError => e
        render json: { success: false, errors: e.message }, status: :unprocessable_entity
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_maintenance_service
          @maintenance_service = MaintenanceService.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def maintenance_service_params
          params.require(:maintenance_service).permit(:car_id, :description, :status, :date)
        end
    end
  end
end