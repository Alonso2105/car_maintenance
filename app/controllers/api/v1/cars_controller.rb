module Api
  module V1
    class CarsController < ApiController
      before_action :set_car, only: %i[ show update destroy ]

      # GET api/v1/cars or /cars.json
      def index
        @cars = Car.all
        render :index
      end

      # GET api/v1/cars/1 or /cars/1.json
      def show
        render :show
      end

      # POST api/v1/cars or /cars.json
      def create
        @car = Car.new(car_params)

        if @car.save
          render :show, status: :created
        else
          render json: { errors: @car.errors.full_messages}, status: :unprocessable_entity 
        end
      end

      # PATCH/PUT /cars/1 or /cars/1.json
      def update
        if @car.update(car_params)
          render :show
        else
          render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /cars/1 or /cars/1.json
      def destroy
        @car.destroy!
        head :no_content
      rescue StandardError => e
        render json: { success: false, errors: e.message }, status: :unprocessable_entity
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_car
          @car = Car.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def car_params
          params.require(:car).permit(:plate_number, :model, :year)
        end
    end
  end
end
