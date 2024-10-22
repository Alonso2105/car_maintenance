# spec/request/api/v1/car_spec.rb

require 'rails_helper'

RSpec.describe "/api/v1/cars", type: :request do
  let(:valid_attributes) do
    {
      plate_number: 'ABC123',
      model: 'Sedan',
      year: 2020
    }
  end

  let(:invalid_attributes) do
    {
      plate_number: nil,
      model: 'Sedan',
      year: 2020
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Car.create! valid_attributes
      get api_v1_cars_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      car = Car.create! valid_attributes
      get api_v1_car_url(car), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Car" do
        expect {
          post api_v1_cars_url, params: { car: valid_attributes }, as: :json
        }.to change(Car, :count).by(1)
      end

      it "renders a JSON response with the new car" do
        post api_v1_cars_url, params: { car: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Car" do
        expect {
          post api_v1_cars_url, params: { car: invalid_attributes }, as: :json
        }.to change(Car, :count).by(0)
      end

      it "renders a JSON response with errors for the new car" do
        post api_v1_cars_url, params: { car: invalid_attributes }, as: :json
        expect(response).to have_http_status(422) # Cambiado a 422
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          plate_number: 'XYZ789',
          model: 'SUV',
          year: 2021
        }
      end

      it "updates the requested car" do
        car = Car.create! valid_attributes
        patch api_v1_car_url(car), params: { car: new_attributes }, as: :json
        car.reload
        expect(car.plate_number).to eq('XYZ789')
        expect(car.model).to eq('SUV')
        expect(car.year).to eq(2021)
      end

      it "renders a JSON response with the car" do
        car = Car.create! valid_attributes
        patch api_v1_car_url(car), params: { car: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the car" do
        car = Car.create! valid_attributes
        patch api_v1_car_url(car), params: { car: invalid_attributes }, as: :json
        expect(response).to have_http_status(422) # Cambiado a 422
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested car" do
      car = Car.create! valid_attributes
      expect {
        delete api_v1_car_url(car), as: :json
      }.to change(Car, :count).by(-1)
    end

    it "renders a successful response" do
      car = Car.create! valid_attributes
      delete api_v1_car_url(car), as: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
