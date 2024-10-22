# spec/request/api/v1/car_spec.rb

require 'rails_helper'

RSpec.describe "/api/v1/maintenance_services", type: :request do
  let(:valid_attributes) do
    {
      car_id: car.id,
      description: "Cambio de llantas Honda Accord",
      status: "pending",
      date: "13-10-2024"
    }
  end

  let(:invalid_attributes) do
    {
      plate_number: nil,
      model: 'Sedan',
      year: 2020
    }
  end

  let(:car) do
    Car.create(
      plate_number: '1232sdasdwer',
      model: 'Sedan',
      year: 2020
    )
  end

  let(:maintenance_service) do
    MaintenanceService.create! valid_attributes
  end

  before do
    maintenance_service
  end

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_maintenance_services_path, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_maintenance_service_path(maintenance_service.id), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new maintenance service" do
        expect {
          post api_v1_maintenance_services_path, params: { maintenance_service: valid_attributes }, as: :json
        }.to change(MaintenanceService, :count).by(1)
      end

      it "renders a JSON response with the new maintenance" do
        post api_v1_maintenance_services_path, params: { maintenance_service: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new maintenance" do
        expect {
          post api_v1_maintenance_services_path, params: { maintenance_service: invalid_attributes }, as: :json
        }.to change(MaintenanceService, :count).by(0)
      end

      it "renders a JSON response with errors for the new maintenance" do
        post api_v1_maintenance_services_path, params: { maintenance_service: invalid_attributes }, as: :json
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          car_id: car.id,
          description: "Cambio de llantas Honda Accord 2",
          status: "pending",
          date: "13-10-2024"
        }
      end

      it "updates the requested maintenance" do
        patch api_v1_maintenance_service_path(maintenance_service), params: { maintenance_service: new_attributes }, as: :json
        maintenance_service.reload
        expect(maintenance_service.description).to eq("Cambio de llantas Honda Accord 2")
      end

      it "renders a JSON response with the maintenance" do
        patch api_v1_maintenance_service_path(maintenance_service), params: { maintenance_service: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the maintenance" do
        patch api_v1_maintenance_service_path(maintenance_service), params: { maintenance_service: invalid_attributes }, as: :json
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested maintenance" do
      expect {
        delete api_v1_maintenance_service_path(maintenance_service), as: :json
      }.to change(MaintenanceService, :count).by(-1)
    end

    it "renders a successful response" do
      delete api_v1_maintenance_service_path(maintenance_service), as: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
