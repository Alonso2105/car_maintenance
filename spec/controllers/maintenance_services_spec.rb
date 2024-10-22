# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/maintenance_services', type: :request do
  let(:car) { Car.create!(plate_number: 'XYZ123', model: 'Sedan', year: 2020) }

  let(:valid_attributes) do
    {
      car_id: car.id,
      description: 'Cambio de aceite',
      status: 'completed',  # Usar un valor válido definido en el modelo
      date: Date.today
    }
  end

  let(:invalid_attributes) do
    {
      car_id: nil,  # Omite el car_id para hacerlo inválido
      description: 'Cambio de aceite',
      status: 'completed',  # Usar un valor válido definido en el modelo
      date: Date.today
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      MaintenanceService.create! valid_attributes
      get maintenance_services_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      maintenance_service = MaintenanceService.create! valid_attributes
      get maintenance_service_url(maintenance_service)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_maintenance_service_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      maintenance_service = MaintenanceService.create! valid_attributes
      get edit_maintenance_service_url(maintenance_service)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new MaintenanceService' do
        expect do
          post maintenance_services_url, params: { maintenance_service: valid_attributes }
        end.to change(MaintenanceService, :count).by(1)
      end

      it 'redirects to the created maintenance service' do
        post maintenance_services_url, params: { maintenance_service: valid_attributes }
        expect(response).to redirect_to(maintenance_service_url(MaintenanceService.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new MaintenanceService' do
        expect do
          post maintenance_services_url, params: { maintenance_service: invalid_attributes }
        end.to change(MaintenanceService, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post maintenance_services_url, params: { maintenance_service: invalid_attributes }
        expect(response).to have_http_status(422) # Cambié :unprocessable_entity por 422
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested maintenance service' do
        maintenance_service = MaintenanceService.create! valid_attributes
        new_attributes = { description: 'Cambio de llantas' }
        patch maintenance_service_url(maintenance_service), params: { maintenance_service: new_attributes }
        maintenance_service.reload
        expect(maintenance_service.description).to eq('Cambio de llantas')
      end

      it 'redirects to the maintenance service' do
        maintenance_service = MaintenanceService.create! valid_attributes
        patch maintenance_service_url(maintenance_service), params: { maintenance_service: valid_attributes }
        maintenance_service.reload
        expect(response).to redirect_to(maintenance_service_url(maintenance_service))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        maintenance_service = MaintenanceService.create! valid_attributes
        patch maintenance_service_url(maintenance_service), params: { maintenance_service: invalid_attributes }
        expect(response).to have_http_status(422) # Cambié :unprocessable_entity por 422
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested maintenance service' do
      maintenance_service = MaintenanceService.create! valid_attributes
      expect do
        delete maintenance_service_url(maintenance_service)
      end.to change(MaintenanceService, :count).by(-1)
    end

    it 'redirects to the maintenance services list' do
      maintenance_service = MaintenanceService.create! valid_attributes
      delete maintenance_service_url(maintenance_service)
      expect(response).to redirect_to(maintenance_services_url)
    end
  end
end
