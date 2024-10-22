# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/cars', type: :request do
  # Atributos válidos para crear un registro de Car
  let(:valid_attributes) do
    {
      plate_number: 'XYZ123',
      model: 'Sedan',
      year: 2020
    }
  end

  # Atributos inválidos para probar validaciones
  let(:invalid_attributes) do
    {
      plate_number: nil, # El número de placa es obligatorio
      model: 'Sedan',
      year: 2020
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Car.create! valid_attributes
      get cars_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      car = Car.create! valid_attributes
      get car_url(car)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_car_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      car = Car.create! valid_attributes
      get edit_car_url(car)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Car' do
        expect do
          post cars_url, params: { car: valid_attributes }
        end.to change(Car, :count).by(1)
      end

      it 'redirects to the created car' do
        post cars_url, params: { car: valid_attributes }
        expect(response).to redirect_to(car_url(Car.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Car' do
        expect do
          post cars_url, params: { car: invalid_attributes }
        end.to change(Car, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post cars_url, params: { car: invalid_attributes }
        expect(response).to have_http_status(422) # Cambié :unprocessable_entity por 422
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested car' do
        car = Car.create! valid_attributes
        new_attributes = { plate_number: 'ABC123' } # Cambia el número de placa
        patch car_url(car), params: { car: new_attributes }
        car.reload
        expect(car.plate_number).to eq('ABC123')
      end

      it 'redirects to the car' do
        car = Car.create! valid_attributes
        patch car_url(car), params: { car: valid_attributes }
        car.reload
        expect(response).to redirect_to(car_url(car))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        car = Car.create! valid_attributes
        patch car_url(car), params: { car: invalid_attributes }
        expect(response).to have_http_status(422) # Cambié :unprocessable_entity por 422
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested car' do
      car = Car.create! valid_attributes
      expect do
        delete car_url(car)
      end.to change(Car, :count).by(-1)
    end

    it 'redirects to the cars list' do
      car = Car.create! valid_attributes
      delete car_url(car)
      expect(response).to redirect_to(cars_url)
    end
  end
end
